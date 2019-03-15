struct OSMNetwork
    g::LightGraphs.DiGraph
    data::OSMData
    distmx::SparseArrays.SparseMatrixCSC{Float64, Int}
    nodeid::Dict{Int,Int} # osm_id -> node_id
    connectednodes::Vector{Int}
    wayids::Vector{Int} # [osm_id, ... osm_id]
    # edgeid::Dict{Tuple{Int,Int},Int}
end

function osmnetwork(osmdata::OSMData, access::Dict{String,Symbol}=ACCESS["all"])
    tags(w::Int) = get(osmdata.tags, w, Dict{String,String}())
    lookup(tags::Dict{String,String}, k::String) = get(tags, k, "")
    hasaccess(w::Int) = get(access, lookup(tags(w),"highway"), :no) != :no
    ishighway(w::Int) = haskey(tags(w), "highway")
    isreverse(w::Int) = lookup(tags(w),"oneway") == "-1"
    function isoneway(w::Int)
        v = lookup(tags(w),"oneway")
        if v == "false" || v == "no" || v == "0"
            return false
        elseif v == "-1" || v == "true" || v == "yes" || v == "1"
            return true
        end
        highway = lookup(tags(w),"highway")
        junction = lookup(tags(w),"junction")
        return (highway == "motorway" ||
                highway == "motorway_link" ||
                junction == "roundabout")
    end
    "distance between the two points in kilometres"
    function distance(n1::Int, n2::Int)
        toradians(degree::Float64) = degree * π / 180.0
        lat1 = osmdata.nodes.lat[n1]; lon1 = osmdata.nodes.lon[n1]
        lat2 = osmdata.nodes.lat[n2]; lon2 = osmdata.nodes.lon[n2]
        dlat = toradians(lat2 - lat1); dlon = toradians(lon2 - lon1)
        a = sin(dlat/2)^2+sin(dlon/2)^2*cos(toradians(lat1))*cos(toradians(lat2))
        2.0 * atan(sqrt(a), sqrt(1-a)) * 6373.0
    end
    
    wayids = filter(hasaccess, filter(ishighway, collect(keys(osmdata.ways))))
    numnodes = length(osmdata.nodes.id)
    nodeid = Dict(zip(osmdata.nodes.id, 1:numnodes))

    edgeset = Set{Tuple{Int,Int}}()
    nodeset = Set{Int}()
    for w in wayids
        way = osmdata.ways[w]
        rev, nrev = isreverse(w), !isreverse(w)
        for n in 2:length(osmdata.ways[w])
            n0 = nodeid[way[n-1]] # map osm_id -> node_id
            n1 = nodeid[way[n]]
            startnode = n0*nrev + n1*rev # reverse the direction if need be
            endnode = n0*rev + n1*nrev

            push!(nodeset, n0); push!(nodeset, n1)
            push!(edgeset, (startnode, endnode))
            isoneway(w) || push!(edgeset, (endnode, startnode))
        end
    end
    connectednodes = collect(nodeset)
    edges = reinterpret(Int,collect(edgeset))
    I = edges[1:2:end] # collect all start nodes
    J = edges[2:2:end] # collect all end nodes
    distances = [distance(i,j) for (i,j) in zip(I,J)]
    distmx = SparseArrays.sparse(I, J, distances, numnodes, numnodes)

    OSMNetwork(LightGraphs.DiGraph(distmx), osmdata, distmx, nodeid, connectednodes, wayids)
end

osmnetwork(osmdata::OSMData, access::String) = osmnetwork(osmdata, ACCESS[access])
