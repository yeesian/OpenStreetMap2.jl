module OpenStreetMap2

    import ProtoBuf, CodecZlib

    include("protobuf/OSMPBF.jl")

    function readblock(
            blob::OSMPBF.Blob,
            block::Union{OSMPBF.HeaderBlock, OSMPBF.PrimitiveBlock}
        )
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

    # struct OSMData
    #     nodes::Vector{Node}
    #     ways::Vector{Way}
    #     relations::Vector{Relation}
    #     node_tags::Set{UTF8String}
    #     way_tags::Set{UTF8String}
    #     relation_tags::Set{UTF8String}
    # end

    struct RawOSMData
        header::OSMPBF.HeaderBlock
        primitives::Vector{OSMPBF.PrimitiveBlock}

        RawOSMData() = new(OSMPBF.HeaderBlock(), [])
    end

    function readpbf(filename::String, osmdata::RawOSMData = RawOSMData())
        blobheader = OSMPBF.BlobHeader()
        blob = OSMPBF.Blob()

        open(filename, "r") do f
            n = ntoh(read(f, UInt32))
            ProtoBuf.readproto(PipeBuffer(read(f,n)),blobheader)
            ProtoBuf.readproto(PipeBuffer(read(f,blobheader.datasize)),blob)
            @assert blobheader._type == "OSMHeader"
            readblock(blob, osmdata.header)

            while !eof(f)
                n = ntoh(read(f, UInt32))
                ProtoBuf.readproto(PipeBuffer(read(f,n)),blobheader)
                ProtoBuf.readproto(PipeBuffer(read(f,blobheader.datasize)),blob)
                @assert blobheader._type == "OSMData"
                push!(osmdata.primitives, readblock(blob, OSMPBF.PrimitiveBlock()))
            end
        end

        osmdata
    end

end # module
