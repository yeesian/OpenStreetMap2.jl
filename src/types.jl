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
    relations::Dict{Int,Dict{String,Any}} # osm_id -> relations
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
