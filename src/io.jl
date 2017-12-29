function readnext!(f, blobheader::OSMPBF.BlobHeader, blob::OSMPBF.Blob)
    n = ntoh(read(f, UInt32))
    ProtoBuf.readproto(PipeBuffer(read(f,n)),blobheader)
    ProtoBuf.readproto(PipeBuffer(read(f,blobheader.datasize)),blob)
end

function readblock!(blob::OSMPBF.Blob, block::OSMPBFFileBlock)
    @assert xor(isempty(blob.raw), isempty(blob.zlib_data))
    if !isempty(blob.raw)
        ProtoBuf.readproto(PipeBuffer(blob.raw), block)
    elseif !isempty(blob.zlib_data)
        ProtoBuf.readproto(
            CodecZlib.ZlibDecompressorStream(IOBuffer(blob.zlib_data)),
            block
        )
    end
end

function processblock!(osmdata::OSMData, pb::OSMPBF.PrimitiveBlock)
    getstr(i) = transcode(String,pb.stringtable.s[i+1])
    membertype(i) = if i == 0; :node elseif i == 1; :way else; :relation end
    for pg in pb.primitivegroup
        # process dense
        if isdefined(pg, :dense)
            osmids = cumsum(pg.dense.id)
            append!(osmdata.nodes.id, osmids)
            append!(osmdata.nodes.lon,
                1e-9 * (pb.lon_offset .+ (pb.granularity .* cumsum(pg.dense.lon)))
            )
            append!(osmdata.nodes.lat,
                1e-9 * (pb.lat_offset .+ (pb.granularity .* cumsum(pg.dense.lat)))
            )
            let i = 1, j = 1
                @assert pg.dense.keys_vals[end] == 0
                while j <= length(pg.dense.keys_vals)
                    k = pg.dense.keys_vals[j]
                    if k == 0 # end of current node
                        i += 1; j += 1
                    else
                        @assert j < length(pg.dense.keys_vals)
                        v = pg.dense.keys_vals[j+1]
                        id = osmids[i]
                        osmdata.tags[id] = get(osmdata.tags, id, Dict())
                        osmdata.tags[id][getstr(k)] = getstr(v)
                        j += 2
                    end
                end
            end
        end
        # process nodes
        for n in pg.nodes
            push!(osmdata.nodes.id, n.id)
            push!(osmdata.nodes.lon, n.lon)
            push!(osmdata.nodes.lat, n.lat)
            @assert length(n.keys) == length(n.vals)
            osmdata.tags[n.id] = get(osmdata.tags, n.id, Dict())
            for (k,v) in zip(n.keys, n.vals)
                osmdata.tags[n.id][getstr(k)] = getstr(v)
            end
        end
        # process ways
        for w in pg.ways
            osmdata.ways[w.id] = cumsum(w.refs)
            osmdata.tags[w.id] = get(osmdata.tags, w.id, Dict())
            for (k,v) in zip(w.keys, w.vals)
                osmdata.tags[w.id][getstr(k)] = getstr(v)
            end
        end
        # process relations
        for r in pg.relations
            osmdata.relations[r.id] = Dict(
                "id" => cumsum(r.memids),
                "type" => membertype.(r.types),
                "role" => getstr.(r.roles_sid)
            )
            osmdata.tags[r.id] = get(osmdata.tags, r.id, Dict())
            for (k,v) in zip(r.keys, r.vals)
                osmdata.tags[r.id][getstr(k)] = getstr(v)
            end
        end
    end
end

function readpbf(
        filename::String,
        osmdata::OSMData = OSMData();
        blobheader::OSMPBF.BlobHeader = OSMPBF.BlobHeader(),
        blob::OSMPBF.Blob = OSMPBF.Blob()
    )
    open(filename, "r") do f
        readnext!(f, blobheader, blob)
        @assert blobheader._type == "OSMHeader"
        readblock!(blob, osmdata.header)
        while !eof(f)
            readnext!(f, blobheader, blob)
            @assert blobheader._type == "OSMData"
            processblock!(osmdata, readblock!(blob,OSMPBF.PrimitiveBlock()))
        end
    end
    osmdata
end

function readxmlstream(
        xmlstream::IO,
        osmdata::OSMData = OSMData()
    )
    currentelement = ""
    currentid = 0
    reader = EzXML.StreamReader(xmlstream)
    for typ in reader
        if typ == EzXML.READER_ELEMENT
            elname = EzXML.nodename(reader)
            if elname == "bounds"
                warn("we currently do not handle element: $elname")
            elseif elname == "member"
                @assert currentelement == "relation"
                push!(osmdata.relations[currentid]["role"], reader["role"])
                push!(osmdata.relations[currentid]["id"], parse(Int,reader["ref"]))
                push!(osmdata.relations[currentid]["type"], Symbol(reader["type"]))
            elseif elname == "nd"
                @assert currentelement == "way"
                push!(osmdata.ways[currentid], parse(Int,reader["ref"]))
            elseif elname == "node"
                currentelement = "node"
                currentid = parse(Int,reader["id"])
                push!(osmdata.nodes.id, parse(Int,reader["id"]))
                push!(osmdata.nodes.lat, parse(Float64, reader["lat"]))
                push!(osmdata.nodes.lon, parse(Float64, reader["lon"]))
            elseif elname == "osm"
                warn("we currently do not handle element: $elname")
            elseif elname == "relation"
                currentelement = "relation"
                currentid = parse(Int,reader["id"])
                osmdata.relations[currentid] = Dict{String,Any}(
                    "role" => Any[],
                    "id" => Int[],
                    "type" => Symbol[]
                )
            elseif elname == "tag"
                osmdata.tags[currentid] = get(osmdata.tags,currentid,Dict())
                osmdata.tags[currentid][reader["k"]] = reader["v"]
            elseif elname == "way"
                currentelement = "way"
                currentid = parse(Int,reader["id"])
                osmdata.ways[currentid] = Int[]
            else
                warn("unrecognized element: $elname")
            end
        end
    end
    close(reader)
    osmdata
end

readxmlfile(filename::String, osmdata::OSMData = OSMData()) =
    readxmlstream(open(filename, "r"), osmdata)

"Returns the overpass query within `bounds`"
function overpassquery(bounds::String; timeout::Int = 25)
    result = Requests.get(
        "https://overpass-api.de/api/interpreter",
        query = Dict("data" => """
        [out:xml][timeout:$timeout];
        (
          node($bounds);
          way($bounds);
          relation($bounds);
        );
        out body;
        >;
        out skel qt;
        """)
    )
    readxmlstream(IOBuffer(result.data))
end

"Returns the overpass query with `bbox = (minlon, minlat, maxlon, maxlat)`"
overpassquery(bbox::NTuple{4,Float64}; kwargs...) =
    overpassquery("$(bbox[1]),$(bbox[2]),$(bbox[3]),$(bbox[4])", kwargs...)

"Returns the overpass query within a `radius` (in meters) around `lonlat`"
overpassquery(lonlat::Tuple{Float64,Float64}, radius::Real; kwargs...) =
    overpassquery("around:$radius,$(lonlat[1]),$(lonlat[2])", kwargs...)
