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

function processblock!(osmdata::RawOSMData, pb::OSMPBF.PrimitiveBlock)
    push!(osmdata.primitives, pb)
end

function processblock!(osmdata::OSMData, pb::OSMPBF.PrimitiveBlock)
    getstr(i) = transcode(String,pb.stringtable.s[i+1])
    membertype(i) = if i == 0; :Node elseif i == 1; :Way else; :Relation end
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
        merge!(osmdata.nodeid, Dict(zip(
            osmdata.nodes.id, 1:length(osmdata.nodes.id)
        )))
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
        osmdata::Union{RawOSMData,OSMData} = RawOSMData();
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
