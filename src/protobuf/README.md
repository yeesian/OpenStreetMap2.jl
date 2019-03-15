# OSM PBF

For updating the julia code generated from the proto files,

1. Download `fileformat.proto` and `osmformat.proto` from https://github.com/openstreetmap/osmosis/tree/93065380e462b141e5c5733a092531bf43860526/osmosis-osm-binary/src/main/protobuf
2. Add the [ProtoBuf.jl](https://github.com/JuliaIO/ProtoBuf.jl/blob/6ab0dba3dfb1e48a5de38c37bbcc553ba79c22af/PROTOC.md) package.
3. Run the following within a Julia session:
```julia
julia> using ProtoBuf

julia> run(ProtoBuf.protoc(`--julia_out=. fileformat.proto osmformat.proto`))
```

See https://github.com/JuliaIO/ProtoBuf.jl/blob/master/PROTOC.md for details.
