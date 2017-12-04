module OpenStreetMap2

    import ProtoBuf, CodecZlib, LightGraphs, DataStructures

    include("types.jl")
    include("io.jl")
    include("access.jl")
    include("network.jl")
    include("routing.jl")

end
