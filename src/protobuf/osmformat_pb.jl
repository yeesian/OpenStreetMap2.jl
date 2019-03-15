# syntax: proto2
using ProtoBuf
import ProtoBuf.meta

mutable struct HeaderBBox <: ProtoType
    left::Int64
    right::Int64
    top::Int64
    bottom::Int64
    HeaderBBox(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct HeaderBBox
const __req_HeaderBBox = Symbol[:left,:right,:top,:bottom]
const __wtype_HeaderBBox = Dict(:left => :sint64, :right => :sint64, :top => :sint64, :bottom => :sint64)
meta(t::Type{HeaderBBox}) = meta(t, __req_HeaderBBox, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, true, ProtoBuf.DEF_PACK, __wtype_HeaderBBox, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES, ProtoBuf.DEF_FIELD_TYPES)

mutable struct HeaderBlock <: ProtoType
    bbox::HeaderBBox
    required_features::Base.Vector{AbstractString}
    optional_features::Base.Vector{AbstractString}
    writingprogram::AbstractString
    source::AbstractString
    osmosis_replication_timestamp::Int64
    osmosis_replication_sequence_number::Int64
    osmosis_replication_base_url::AbstractString
    HeaderBlock(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct HeaderBlock
const __fnum_HeaderBlock = Int[1,4,5,16,17,32,33,34]
meta(t::Type{HeaderBlock}) = meta(t, ProtoBuf.DEF_REQ, __fnum_HeaderBlock, ProtoBuf.DEF_VAL, true, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES, ProtoBuf.DEF_FIELD_TYPES)

mutable struct StringTable <: ProtoType
    s::Base.Vector{Array{UInt8,1}}
    StringTable(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct StringTable

mutable struct Info <: ProtoType
    version::Int32
    timestamp::Int64
    changeset::Int64
    uid::Int32
    user_sid::UInt32
    visible::Bool
    Info(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct Info
const __val_Info = Dict(:version => -1)
meta(t::Type{Info}) = meta(t, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, __val_Info, true, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES, ProtoBuf.DEF_FIELD_TYPES)

mutable struct DenseInfo <: ProtoType
    version::Base.Vector{Int32}
    timestamp::Base.Vector{Int64}
    changeset::Base.Vector{Int64}
    uid::Base.Vector{Int32}
    user_sid::Base.Vector{Int32}
    visible::Base.Vector{Bool}
    DenseInfo(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct DenseInfo
const __pack_DenseInfo = Symbol[:version,:timestamp,:changeset,:uid,:user_sid,:visible]
const __wtype_DenseInfo = Dict(:timestamp => :sint64, :changeset => :sint64, :uid => :sint32, :user_sid => :sint32)
meta(t::Type{DenseInfo}) = meta(t, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, true, __pack_DenseInfo, __wtype_DenseInfo, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES, ProtoBuf.DEF_FIELD_TYPES)

mutable struct ChangeSet <: ProtoType
    id::Int64
    ChangeSet(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct ChangeSet
const __req_ChangeSet = Symbol[:id]
meta(t::Type{ChangeSet}) = meta(t, __req_ChangeSet, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, true, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES, ProtoBuf.DEF_FIELD_TYPES)

mutable struct Node <: ProtoType
    id::Int64
    keys::Base.Vector{UInt32}
    vals::Base.Vector{UInt32}
    info::Info
    lat::Int64
    lon::Int64
    Node(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct Node
const __req_Node = Symbol[:id,:lat,:lon]
const __fnum_Node = Int[1,2,3,4,8,9]
const __pack_Node = Symbol[:keys,:vals]
const __wtype_Node = Dict(:id => :sint64, :lat => :sint64, :lon => :sint64)
meta(t::Type{Node}) = meta(t, __req_Node, __fnum_Node, ProtoBuf.DEF_VAL, true, __pack_Node, __wtype_Node, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES, ProtoBuf.DEF_FIELD_TYPES)

mutable struct DenseNodes <: ProtoType
    id::Base.Vector{Int64}
    denseinfo::DenseInfo
    lat::Base.Vector{Int64}
    lon::Base.Vector{Int64}
    keys_vals::Base.Vector{Int32}
    DenseNodes(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct DenseNodes
const __fnum_DenseNodes = Int[1,5,8,9,10]
const __pack_DenseNodes = Symbol[:id,:lat,:lon,:keys_vals]
const __wtype_DenseNodes = Dict(:id => :sint64, :lat => :sint64, :lon => :sint64)
meta(t::Type{DenseNodes}) = meta(t, ProtoBuf.DEF_REQ, __fnum_DenseNodes, ProtoBuf.DEF_VAL, true, __pack_DenseNodes, __wtype_DenseNodes, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES, ProtoBuf.DEF_FIELD_TYPES)

mutable struct Way <: ProtoType
    id::Int64
    keys::Base.Vector{UInt32}
    vals::Base.Vector{UInt32}
    info::Info
    refs::Base.Vector{Int64}
    Way(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct Way
const __req_Way = Symbol[:id]
const __fnum_Way = Int[1,2,3,4,8]
const __pack_Way = Symbol[:keys,:vals,:refs]
const __wtype_Way = Dict(:refs => :sint64)
meta(t::Type{Way}) = meta(t, __req_Way, __fnum_Way, ProtoBuf.DEF_VAL, true, __pack_Way, __wtype_Way, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES, ProtoBuf.DEF_FIELD_TYPES)

struct __enum_Relation_MemberType <: ProtoEnum
    NODE::Int32
    WAY::Int32
    RELATION::Int32
    __enum_Relation_MemberType() = new(0,1,2)
end #struct __enum_Relation_MemberType
const Relation_MemberType = __enum_Relation_MemberType()

mutable struct Relation <: ProtoType
    id::Int64
    keys::Base.Vector{UInt32}
    vals::Base.Vector{UInt32}
    info::Info
    roles_sid::Base.Vector{Int32}
    memids::Base.Vector{Int64}
    types::Base.Vector{Int32}
    Relation(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct Relation
const __req_Relation = Symbol[:id]
const __fnum_Relation = Int[1,2,3,4,8,9,10]
const __pack_Relation = Symbol[:keys,:vals,:roles_sid,:memids,:types]
const __wtype_Relation = Dict(:memids => :sint64)
meta(t::Type{Relation}) = meta(t, __req_Relation, __fnum_Relation, ProtoBuf.DEF_VAL, true, __pack_Relation, __wtype_Relation, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES, ProtoBuf.DEF_FIELD_TYPES)

mutable struct PrimitiveGroup <: ProtoType
    nodes::Base.Vector{Node}
    dense::DenseNodes
    ways::Base.Vector{Way}
    relations::Base.Vector{Relation}
    changesets::Base.Vector{ChangeSet}
    PrimitiveGroup(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PrimitiveGroup

mutable struct PrimitiveBlock <: ProtoType
    stringtable::StringTable
    primitivegroup::Base.Vector{PrimitiveGroup}
    granularity::Int32
    lat_offset::Int64
    lon_offset::Int64
    date_granularity::Int32
    PrimitiveBlock(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #mutable struct PrimitiveBlock
const __req_PrimitiveBlock = Symbol[:stringtable]
const __val_PrimitiveBlock = Dict(:granularity => 100, :lat_offset => 0, :lon_offset => 0, :date_granularity => 1000)
const __fnum_PrimitiveBlock = Int[1,2,17,19,20,18]
meta(t::Type{PrimitiveBlock}) = meta(t, __req_PrimitiveBlock, __fnum_PrimitiveBlock, __val_PrimitiveBlock, true, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES, ProtoBuf.DEF_FIELD_TYPES)

export HeaderBlock, HeaderBBox, PrimitiveBlock, PrimitiveGroup, StringTable, Info, DenseInfo, ChangeSet, Node, DenseNodes, Way, Relation_MemberType, Relation
