module OpenStreetMap2

    import ProtoBuf, CodecZlib

    include("protobuf/OSMPBF.jl")

    const OSMPBFFileBlock = Union{OSMPBF.HeaderBlock, OSMPBF.PrimitiveBlock}

    struct OSMNodes
        id::Vector{Int}
        lon::Vector{Float64}
        lat::Vector{Float64}

        OSMNodes() = new([],[],[])
    end

    struct OSMData
        header::OSMPBF.HeaderBlock
        nodeid::Dict{Int,Int} # osm_id -> node_id
        nodes::OSMNodes # Vector{(osm_id, lon, lat) ... (osm_id, lon, lat)}
        ways::Dict{Int,Vector{Int}} # osm_id -> way
        relations::Dict{Int,Vector{Dict{String,String}}} # osm_id -> relations
        tags::Dict{Int,Dict{String,String}} # osm_id -> tags

        OSMData() = new(
            OSMPBF.HeaderBlock(), Dict(), OSMNodes(), Dict(), Dict(), Dict()
        )
    end

    struct RawOSMData
        header::OSMPBF.HeaderBlock
        primitives::Vector{OSMPBF.PrimitiveBlock}

        RawOSMData() = new(OSMPBF.HeaderBlock(), [])
    end

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
        for pg in pb.primitivegroup
            if isdefined(pg, :dense)
                append!(osmdata.nodes.id, cumsum(pg.dense.id))
                append!(osmdata.nodes.lon,
                    1e-9 * (pb.lon_offset .+ (pb.granularity .* cumsum(pg.dense.lon)))
                )
                append!(osmdata.nodes.lat,
                    1e-9 * (pb.lat_offset .+ (pb.granularity .* cumsum(pg.dense.lat)))
                )
            end
            for n in pg.nodes
                push!(osmdata.nodes.id, n.id)
                push!(osmdata.nodes.lon, n.lon)
                push!(osmdata.nodes.lat, n.lat)
            end
            merge!(osmdata.nodeid, Dict(zip(
                osmdata.nodes.id, 1:length(osmdata.nodes.id)
            )))
            for w in pg.ways; osmdata.ways[w.id] = cumsum(w.refs) end
            for r in pg.relations
                # process r
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

end # module
