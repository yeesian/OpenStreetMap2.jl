# syntax: proto2
using Compat
using ProtoBuf
import ProtoBuf.meta
import Base: hash, isequal, ==

type Blob
    raw::Array{UInt8,1}
    raw_size::Int32
    zlib_data::Array{UInt8,1}
    lzma_data::Array{UInt8,1}
    OBSOLETE_bzip2_data::Array{UInt8,1}
    Blob(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #type Blob
hash(v::Blob) = ProtoBuf.protohash(v)
isequal(v1::Blob, v2::Blob) = ProtoBuf.protoisequal(v1, v2)
==(v1::Blob, v2::Blob) = ProtoBuf.protoeq(v1, v2)

type BlobHeader
    _type::AbstractString
    indexdata::Array{UInt8,1}
    datasize::Int32
    BlobHeader(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #type BlobHeader
const __req_BlobHeader = Symbol[:_type,:datasize]
meta(t::Type{BlobHeader}) = meta(t, __req_BlobHeader, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, true, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
hash(v::BlobHeader) = ProtoBuf.protohash(v)
isequal(v1::BlobHeader, v2::BlobHeader) = ProtoBuf.protoisequal(v1, v2)
==(v1::BlobHeader, v2::BlobHeader) = ProtoBuf.protoeq(v1, v2)

export Blob, BlobHeader
