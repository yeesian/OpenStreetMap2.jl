module OpenStreetMap2

    import ProtoBuf, CodecZlib, LightGraphs

    include("types.jl")
    include("io.jl")
    include("access.jl")
    include("network.jl")

end
