# syntax: proto2
using ProtoBuf
import ProtoBuf.meta

mutable struct Blob <: ProtoType
    raw::Array{UInt8,1}
    raw_size::Int32
    zlib_data::Array{UInt8,1}
    lzma_data::Array{UInt8,1}
    OBSOLETE_bzip2_data::Array{UInt8,1}
    Blob(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct Blob

mutable struct BlobHeader <: ProtoType
    _type::AbstractString
    indexdata::Array{UInt8,1}
    datasize::Int32
    BlobHeader(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct BlobHeader
const __req_BlobHeader = Symbol[:_type,:datasize]
meta(t::Type{BlobHeader}) = meta(t, __req_BlobHeader, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, true, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES, ProtoBuf.DEF_FIELD_TYPES)

export Blob, BlobHeader
