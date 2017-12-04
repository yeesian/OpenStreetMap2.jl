using OpenStreetMap2; const OSM = OpenStreetMap2
using LightGraphs; const LG = LightGraphs
using Base.Test

@testset "Testing Maldives OSM" begin

    @testset "Working with RawOSMData()" begin
        
        @time maldives_osm = OSM.readpbf("pbf/maldives.osm.pbf")
        
        @testset "Testing HeaderBlock" begin
            header = maldives_osm.header
            @test header.optional_features == []
            @test header.required_features == [
                "OsmSchema-V0.6",
                "DenseNodes"
            ]
            @test header.writingprogram == "osmium/1.5.1"
            @test header.osmosis_replication_timestamp == 1512078182
            @test header.osmosis_replication_base_url == "http://download.geofabrik.de/asia/maldives-updates"
        end

        @testset "Testing PrimitiveBlocks" begin
            primitives = maldives_osm.primitives
            @test length(primitives) == 24
            @test primitives[1].date_granularity == 1000
            @test primitives[1].granularity == 100
            @test primitives[1].lat_offset == 0
            @test primitives[1].lon_offset == 0
            @test length(primitives[1].primitivegroup) == 1
        end

        @testset "Testing PrimitiveGroups" begin
            pg = maldives_osm.primitives[1].primitivegroup[1]
            @test length(pg.nodes) == 0
            @test length(pg.relations) == 0
            @test length(pg.ways) == 0

            @test length(pg.dense.id) == 8000
            @test length(pg.dense.lat) == 8000
            @test length(pg.dense.lon) == 8000

            @test length(pg.dense.denseinfo.uid) == 8000
            @test length(pg.dense.denseinfo.changeset) == 8000
            @test length(pg.dense.denseinfo.version) == 8000
            @test length(pg.dense.denseinfo.timestamp) == 8000
            @test length(pg.dense.denseinfo.user_sid) == 8000
            @test length(pg.dense.keys_vals) == 22678
            @test sum(pg.dense.keys_vals .== 0) == 8000
        end
    end

    @testset "Working with OSMData" begin
        
        @time maldives_osm = OSM.readpbf("pbf/maldives.osm.pbf", OSM.OSMData())
        
        @testset "Testing Nodes" begin    
            @test length(maldives_osm.nodes.id) == length(maldives_osm.nodes.lon)
            @test length(maldives_osm.nodes.lon) == length(maldives_osm.nodes.lat)
        end

        @testset "Testing Ways" begin
            @test length(maldives_osm.ways) == 19955
        end

        @testset "Testing Relations" begin
            @test length(maldives_osm.relations) == 841
            @test maldives_osm.relations[7095131] == Dict(
                "role" => ["inner", "outer"],
                "id"   => [19879255, 481850745],
                "type" => [:Way, :Way]
            )
            @test length(maldives_osm.ways[19879255]) == 63
            @test length(maldives_osm.ways[481850745]) == 16
        end

        @testset "Testing Tags" begin
            @test length(maldives_osm.tags) == 39745
            @test maldives_osm.tags[7095131] == Dict(
                "natural" => "reef",
                "type"    => "multipolygon"
            )
        end

        @testset "Testing OSMNetwork (ALL)" begin
            network = OSM.osmnetwork(maldives_osm)
            numnodes = length(maldives_osm.nodes.id)
            
            @testset "Testing Construction" begin
                @test numnodes == 159046
                @test sort(collect(values(network.nodeid)))==collect(1:numnodes)
                @test length(network.wayids) == 5869
                @test LG.nv(network.g) == numnodes
                @test LG.ne(network.g) == 55057
                @test isapprox(sum(network.distmx), 2615.4896)
                scc = LG.strongly_connected_components(network.g)
                @test length(scc) == 136180
                @test sum(map(length, scc)) == 159046
            end

            @testset "Testing Routing" begin
                ds = OSM.shortestpath(network, [18854,41972,41956,18855,41864])
                @test length(ds.dists) == numnodes
                @test isapprox(sum(ds.dists[ds.dists .< Inf]), 10588.9966)
                @test sum(ds.dists .< Inf) == 1206
                @test sum(ds.dists[ds.dists .< Inf] .< 10) == 513
                @test sum(ds.dists[ds.dists .< Inf] .< 5) == 405
                @test sum(ds.dists[ds.dists .< Inf] .< 1) == 103
                @test sum(ds.parents .!== 0) == 1201 # difference of 5
                @test length(unique(ds.parents)) == 997

                ds = OSM.shortestpath(network, [18854,41972,41956,18855,41864], 10.)
                @test length(ds.dists) == numnodes
                @test sum(ds.dists .< Inf) == 513
                @test sum(ds.dists[ds.dists .< Inf] .< 5) == 405
                @test sum(ds.dists[ds.dists .< Inf] .< 1) == 103

                ds = OSM.shortestpath(network, [18854,41972,41956,18855,41864], 5.)
                @test length(ds.dists) == numnodes
                @test sum(ds.dists .< Inf) == 405
                @test sum(ds.dists[ds.dists .< Inf] .< 1) == 103

                ds = OSM.shortestpath(network, [18854,41972,41956,18855,41864], 1.)
                @test length(ds.dists) == numnodes
                @test sum(ds.dists .< Inf) == 103
            end
        end

        @testset "Testing OSMNetwork (foot)" begin
            network = OSM.osmnetwork(maldives_osm, "foot")
            numnodes = length(maldives_osm.nodes.id)
            
            @testset "Testing Construction" begin
                @test numnodes == 159046
                @test sort(collect(values(network.nodeid)))==collect(1:numnodes)
                @test length(network.wayids) == 5863
                @test LG.nv(network.g) == numnodes
                @test LG.ne(network.g) == 54891
                @test isapprox(sum(network.distmx), 2615.4896)
                scc = LG.strongly_connected_components(network.g)
                @test length(scc) == 136250
                @test sum(map(length, scc)) == 159046
            end
        end

        @testset "Testing OSMNetwork (motorcar)" begin
            network = OSM.osmnetwork(maldives_osm, "motorcar")
            numnodes = length(maldives_osm.nodes.id)
            
            @testset "Testing Construction" begin
                @test numnodes == 159046
                @test sort(collect(values(network.nodeid)))==collect(1:numnodes)
                @test length(network.wayids) == 4650
                @test LG.nv(network.g) == numnodes
                @test LG.ne(network.g) == 42229
                @test isapprox(sum(network.distmx), 2234.8697)
                scc = LG.strongly_connected_components(network.g)
                @test length(scc) == 142078
                @test sum(map(length, scc)) == 159046
            end

            @testset "Testing Routing" begin
                ds = OSM.shortestpath(network, [18854,41972,41956,18855,41864])
                @test length(ds.dists) == numnodes
                @test isapprox(sum(ds.dists[ds.dists .< Inf]), 9458.2279)
                @test sum(ds.dists .< Inf) == 1133
                @test sum(ds.dists[ds.dists .< Inf] .< 10) == 513
                @test sum(ds.dists[ds.dists .< Inf] .< 5) == 405
                @test sum(ds.dists[ds.dists .< Inf] .< 1) == 103
                @test sum(ds.parents .!== 0) == 1128 # difference of 5
                @test length(unique(ds.parents)) == 928

                ds = OSM.shortestpath(network, [18854,41972,41956,18855,41864], 10.)
                @test length(ds.dists) == numnodes
                @test sum(ds.dists .< Inf) == 513
                @test sum(ds.dists[ds.dists .< Inf] .< 5) == 405
                @test sum(ds.dists[ds.dists .< Inf] .< 1) == 103

                ds = OSM.shortestpath(network, [18854,41972,41956,18855,41864], 5.)
                @test length(ds.dists) == numnodes
                @test sum(ds.dists .< Inf) == 405
                @test sum(ds.dists[ds.dists .< Inf] .< 1) == 103

                ds = OSM.shortestpath(network, [18854,41972,41956,18855,41864], 1.)
                @test length(ds.dists) == numnodes
                @test sum(ds.dists .< Inf) == 103
            end
        end
    end
end

@testset "Testing Maldives OSH" begin
    @time maldives_osh = OSM.readpbf("pbf/maldives.osh.pbf")
    
    @testset "Testing HeaderBlock" begin
        header = maldives_osh.header
        @test header.optional_features == []
        @test header.required_features == [
            "OsmSchema-V0.6",
            "DenseNodes",
            "HistoricalInformation"
        ]
        @test header.writingprogram == "osmium/1.5.1"
        @test header.osmosis_replication_timestamp == 0
        @test header.osmosis_replication_base_url == ""
    end

    @testset "Testing PrimitiveBlocks" begin
        primitives = maldives_osh.primitives
        @test length(primitives) == 37
        @test primitives[1].date_granularity == 1000
        @test primitives[1].granularity == 100
        @test primitives[1].lat_offset == 0
        @test primitives[1].lon_offset == 0
        @test length(primitives[1].primitivegroup) == 1
    end

    @testset "Testing PrimitiveGroups" begin
        pg = maldives_osh.primitives[1].primitivegroup[1]
        @test length(pg.nodes) == 0
        @test length(pg.relations) == 0
        @test length(pg.ways) == 0

        @test length(pg.dense.id) == 8000
        @test length(pg.dense.lat) == 8000
        @test length(pg.dense.lon) == 8000

        @test length(pg.dense.denseinfo.uid) == 8000
        @test length(pg.dense.denseinfo.changeset) == 8000
        @test length(pg.dense.denseinfo.version) == 8000
        @test length(pg.dense.denseinfo.timestamp) == 8000
        @test length(pg.dense.denseinfo.user_sid) == 8000
        @test length(pg.dense.keys_vals) == 28716
        @test sum(pg.dense.keys_vals .== 0) == 8000
    end
end