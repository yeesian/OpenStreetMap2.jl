# syntax: proto2
using Compat
using ProtoBuf
import ProtoBuf.meta
import Base: hash, isequal, ==

type HeaderBBox
    left::Int64
    right::Int64
    top::Int64
    bottom::Int64
    HeaderBBox(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #type HeaderBBox
const __req_HeaderBBox = Symbol[:left,:right,:top,:bottom]
const __wtype_HeaderBBox = Dict(:left => :sint64, :right => :sint64, :top => :sint64, :bottom => :sint64)
meta(t::Type{HeaderBBox}) = meta(t, __req_HeaderBBox, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, true, ProtoBuf.DEF_PACK, __wtype_HeaderBBox, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
hash(v::HeaderBBox) = ProtoBuf.protohash(v)
isequal(v1::HeaderBBox, v2::HeaderBBox) = ProtoBuf.protoisequal(v1, v2)
==(v1::HeaderBBox, v2::HeaderBBox) = ProtoBuf.protoeq(v1, v2)

type HeaderBlock
    bbox::HeaderBBox
    required_features::Array{AbstractString,1}
    optional_features::Array{AbstractString,1}
    writingprogram::AbstractString
    source::AbstractString
    osmosis_replication_timestamp::Int64
    osmosis_replication_sequence_number::Int64
    osmosis_replication_base_url::AbstractString
    HeaderBlock(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #type HeaderBlock
const __fnum_HeaderBlock = Int[1,4,5,16,17,32,33,34]
meta(t::Type{HeaderBlock}) = meta(t, ProtoBuf.DEF_REQ, __fnum_HeaderBlock, ProtoBuf.DEF_VAL, true, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
hash(v::HeaderBlock) = ProtoBuf.protohash(v)
isequal(v1::HeaderBlock, v2::HeaderBlock) = ProtoBuf.protoisequal(v1, v2)
==(v1::HeaderBlock, v2::HeaderBlock) = ProtoBuf.protoeq(v1, v2)

type StringTable
    s::Array{Array{UInt8,1},1}
    StringTable(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #type StringTable
hash(v::StringTable) = ProtoBuf.protohash(v)
isequal(v1::StringTable, v2::StringTable) = ProtoBuf.protoisequal(v1, v2)
==(v1::StringTable, v2::StringTable) = ProtoBuf.protoeq(v1, v2)

type Info
    version::Int32
    timestamp::Int64
    changeset::Int64
    uid::Int32
    user_sid::UInt32
    visible::Bool
    Info(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #type Info
const __val_Info = Dict(:version => -1)
meta(t::Type{Info}) = meta(t, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, __val_Info, true, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
hash(v::Info) = ProtoBuf.protohash(v)
isequal(v1::Info, v2::Info) = ProtoBuf.protoisequal(v1, v2)
==(v1::Info, v2::Info) = ProtoBuf.protoeq(v1, v2)

type DenseInfo
    version::Array{Int32,1}
    timestamp::Array{Int64,1}
    changeset::Array{Int64,1}
    uid::Array{Int32,1}
    user_sid::Array{Int32,1}
    visible::Array{Bool,1}
    DenseInfo(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #type DenseInfo
const __pack_DenseInfo = Symbol[:version,:timestamp,:changeset,:uid,:user_sid,:visible]
const __wtype_DenseInfo = Dict(:timestamp => :sint64, :changeset => :sint64, :uid => :sint32, :user_sid => :sint32)
meta(t::Type{DenseInfo}) = meta(t, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, true, __pack_DenseInfo, __wtype_DenseInfo, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
hash(v::DenseInfo) = ProtoBuf.protohash(v)
isequal(v1::DenseInfo, v2::DenseInfo) = ProtoBuf.protoisequal(v1, v2)
==(v1::DenseInfo, v2::DenseInfo) = ProtoBuf.protoeq(v1, v2)

type ChangeSet
    id::Int64
    ChangeSet(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #type ChangeSet
const __req_ChangeSet = Symbol[:id]
meta(t::Type{ChangeSet}) = meta(t, __req_ChangeSet, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, true, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
hash(v::ChangeSet) = ProtoBuf.protohash(v)
isequal(v1::ChangeSet, v2::ChangeSet) = ProtoBuf.protoisequal(v1, v2)
==(v1::ChangeSet, v2::ChangeSet) = ProtoBuf.protoeq(v1, v2)

type Node
    id::Int64
    keys::Array{UInt32,1}
    vals::Array{UInt32,1}
    info::Info
    lat::Int64
    lon::Int64
    Node(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #type Node
const __req_Node = Symbol[:id,:lat,:lon]
const __fnum_Node = Int[1,2,3,4,8,9]
const __pack_Node = Symbol[:keys,:vals]
const __wtype_Node = Dict(:id => :sint64, :lat => :sint64, :lon => :sint64)
meta(t::Type{Node}) = meta(t, __req_Node, __fnum_Node, ProtoBuf.DEF_VAL, true, __pack_Node, __wtype_Node, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
hash(v::Node) = ProtoBuf.protohash(v)
isequal(v1::Node, v2::Node) = ProtoBuf.protoisequal(v1, v2)
==(v1::Node, v2::Node) = ProtoBuf.protoeq(v1, v2)

type DenseNodes
    id::Array{Int64,1}
    denseinfo::DenseInfo
    lat::Array{Int64,1}
    lon::Array{Int64,1}
    keys_vals::Array{Int32,1}
    DenseNodes(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #type DenseNodes
const __fnum_DenseNodes = Int[1,5,8,9,10]
const __pack_DenseNodes = Symbol[:id,:lat,:lon,:keys_vals]
const __wtype_DenseNodes = Dict(:id => :sint64, :lat => :sint64, :lon => :sint64)
meta(t::Type{DenseNodes}) = meta(t, ProtoBuf.DEF_REQ, __fnum_DenseNodes, ProtoBuf.DEF_VAL, true, __pack_DenseNodes, __wtype_DenseNodes, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
hash(v::DenseNodes) = ProtoBuf.protohash(v)
isequal(v1::DenseNodes, v2::DenseNodes) = ProtoBuf.protoisequal(v1, v2)
==(v1::DenseNodes, v2::DenseNodes) = ProtoBuf.protoeq(v1, v2)

type Way
    id::Int64
    keys::Array{UInt32,1}
    vals::Array{UInt32,1}
    info::Info
    refs::Array{Int64,1}
    Way(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #type Way
const __req_Way = Symbol[:id]
const __fnum_Way = Int[1,2,3,4,8]
const __pack_Way = Symbol[:keys,:vals,:refs]
const __wtype_Way = Dict(:refs => :sint64)
meta(t::Type{Way}) = meta(t, __req_Way, __fnum_Way, ProtoBuf.DEF_VAL, true, __pack_Way, __wtype_Way, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
hash(v::Way) = ProtoBuf.protohash(v)
isequal(v1::Way, v2::Way) = ProtoBuf.protoisequal(v1, v2)
==(v1::Way, v2::Way) = ProtoBuf.protoeq(v1, v2)

type __enum_Relation_MemberType <: ProtoEnum
    NODE::Int32
    WAY::Int32
    RELATION::Int32
    __enum_Relation_MemberType() = new(0,1,2)
end #type __enum_Relation_MemberType
const Relation_MemberType = __enum_Relation_MemberType()

type Relation
    id::Int64
    keys::Array{UInt32,1}
    vals::Array{UInt32,1}
    info::Info
    roles_sid::Array{Int32,1}
    memids::Array{Int64,1}
    types::Array{Int32,1}
    Relation(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #type Relation
const __req_Relation = Symbol[:id]
const __fnum_Relation = Int[1,2,3,4,8,9,10]
const __pack_Relation = Symbol[:keys,:vals,:roles_sid,:memids,:types]
const __wtype_Relation = Dict(:memids => :sint64)
meta(t::Type{Relation}) = meta(t, __req_Relation, __fnum_Relation, ProtoBuf.DEF_VAL, true, __pack_Relation, __wtype_Relation, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
hash(v::Relation) = ProtoBuf.protohash(v)
isequal(v1::Relation, v2::Relation) = ProtoBuf.protoisequal(v1, v2)
==(v1::Relation, v2::Relation) = ProtoBuf.protoeq(v1, v2)

type PrimitiveGroup
    nodes::Array{Node,1}
    dense::DenseNodes
    ways::Array{Way,1}
    relations::Array{Relation,1}
    changesets::Array{ChangeSet,1}
    PrimitiveGroup(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #type PrimitiveGroup
hash(v::PrimitiveGroup) = ProtoBuf.protohash(v)
isequal(v1::PrimitiveGroup, v2::PrimitiveGroup) = ProtoBuf.protoisequal(v1, v2)
==(v1::PrimitiveGroup, v2::PrimitiveGroup) = ProtoBuf.protoeq(v1, v2)

type PrimitiveBlock
    stringtable::StringTable
    primitivegroup::Array{PrimitiveGroup,1}
    granularity::Int32
    lat_offset::Int64
    lon_offset::Int64
    date_granularity::Int32
    PrimitiveBlock(; kwargs...) = (o=new(); fillunset(o); isempty(kwargs) || ProtoBuf._protobuild(o, kwargs); o)
end #type PrimitiveBlock
const __req_PrimitiveBlock = Symbol[:stringtable]
const __val_PrimitiveBlock = Dict(:granularity => 100, :lat_offset => 0, :lon_offset => 0, :date_granularity => 1000)
const __fnum_PrimitiveBlock = Int[1,2,17,19,20,18]
meta(t::Type{PrimitiveBlock}) = meta(t, __req_PrimitiveBlock, __fnum_PrimitiveBlock, __val_PrimitiveBlock, true, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
hash(v::PrimitiveBlock) = ProtoBuf.protohash(v)
isequal(v1::PrimitiveBlock, v2::PrimitiveBlock) = ProtoBuf.protoisequal(v1, v2)
==(v1::PrimitiveBlock, v2::PrimitiveBlock) = ProtoBuf.protoeq(v1, v2)

export HeaderBlock, HeaderBBox, PrimitiveBlock, PrimitiveGroup, StringTable, Info, DenseInfo, ChangeSet, Node, DenseNodes, Way, Relation_MemberType, Relation
