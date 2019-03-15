using OpenStreetMap2; const OSM = OpenStreetMap2
using LightGraphs; const LG = LightGraphs
using Test

@testset "Testing Maldives OSM PBF" begin
        
    @time maldives_osm = OSM.readpbf("pbf/maldives.osm.pbf")
    
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
            "type" => [:way, :way]
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

    @testset "Testing OSMNetwork (all)" begin
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
            @test isapprox(sum(network.distmx), 2613.10385)
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

@testset "Testing Maldives OSH PBF" begin
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
end

# @testset "Testing Maldives OSM XML" begin
    
#     @time maldives_osm = OSM.readxmlfile("xml/maldives.osm")
    
#     @testset "Testing Nodes" begin
#         @test length(maldives_osm.nodes.id) == length(maldives_osm.nodes.lon)
#         @test length(maldives_osm.nodes.lon) == length(maldives_osm.nodes.lat)
#     end

#     @testset "Testing Ways" begin
#         @test length(maldives_osm.ways) == 20196
#     end

#     @testset "Testing Relations" begin
#         @test length(maldives_osm.relations) == 842
#         @test maldives_osm.relations[7095131] == Dict(
#             "role" => ["inner", "outer"],
#             "id"   => [19879255, 481850745],
#             "type" => [:way, :way]
#         )
#         @test length(maldives_osm.ways[19879255]) == 63
#         @test length(maldives_osm.ways[481850745]) == 16
#     end

#     @testset "Testing Tags" begin
#         @test length(maldives_osm.tags) == 39081
#         @test maldives_osm.tags[7095131] == Dict(
#             "natural" => "reef",
#             "type"    => "multipolygon"
#         )
#     end

#     @testset "Testing OSMNetwork (all)" begin
#         network = OSM.osmnetwork(maldives_osm)
#         numnodes = length(maldives_osm.nodes.id)
        
#         @testset "Testing Construction" begin
#             @test numnodes == 160473
#             @test sort(collect(values(network.nodeid)))==collect(1:numnodes)
#             @test length(network.wayids) == 6048
#             @test LG.nv(network.g) == numnodes
#             @test LG.ne(network.g) == 56585
#             @test isapprox(sum(network.distmx), 2646.3259)
#             scc = LG.strongly_connected_components(network.g)
#             @test length(scc) == 136943
#             @test sum(map(length, scc)) == 160473
#         end

#         @testset "Testing Routing" begin
#             ds = OSM.shortestpath(network, [18854,41972,41956,18855,41864])
#             @test length(ds.dists) == numnodes
#             @test isapprox(sum(ds.dists[ds.dists .< Inf]), 6999.276457)
#             @test sum(ds.dists .< Inf) == 1209
#             @test sum(ds.dists[ds.dists .< Inf] .< 10) == 1056
#             @test sum(ds.dists[ds.dists .< Inf] .< 5) == 506
#             @test sum(ds.dists[ds.dists .< Inf] .< 1) == 182
#             @test sum(ds.parents .!== 0) == 1204 # difference of 5
#             @test length(unique(ds.parents)) == 985
#         end
#     end
# end

@testset "Testing OSM Overpass Query" begin
    
    @testset "Testing BoundingBox Queries" begin
        @time overpass_osm = OSM.overpassquery((50.746,7.154,50.748,7.157))
        
        @testset "Testing Nodes" begin
            @test length(overpass_osm.nodes.id) > 10
            @test length(overpass_osm.nodes.id) == length(overpass_osm.nodes.lon)
            @test length(overpass_osm.nodes.lon) == length(overpass_osm.nodes.lat)
        end

        @testset "Testing Ways" begin
            @test length(overpass_osm.ways) > 100
        end

        @testset "Testing Relations" begin
            @test length(overpass_osm.relations) > 0
        end

        @testset "Testing Tags" begin
            @test length(overpass_osm.tags) > 100
        end

        @testset "Testing OSMNetwork" begin
            network = OSM.osmnetwork(overpass_osm)
            @test LG.nv(network.g) == length(overpass_osm.nodes.id)
            @test length(network.nodeid) == length(unique(overpass_osm.nodes.id))
        end
    end

    @testset "Testing Around Filter" begin
        @time overpass_osm = OSM.overpassquery((50.747,7.1555), 120)
        
        @testset "Testing Nodes" begin
            @test length(overpass_osm.nodes.id) > 10
            @test length(overpass_osm.nodes.id) == length(overpass_osm.nodes.lon)
            @test length(overpass_osm.nodes.lon) == length(overpass_osm.nodes.lat)
        end

        @testset "Testing Ways" begin
            @test length(overpass_osm.ways) > 100
        end

        @testset "Testing Relations" begin
            @test length(overpass_osm.relations) > 0
        end

        @testset "Testing Tags" begin
            @test length(overpass_osm.tags) > 100
        end

        @testset "Testing OSMNetwork" begin
            network = OSM.osmnetwork(overpass_osm)
            @test LG.nv(network.g) == length(overpass_osm.nodes.id)
            @test length(network.nodeid) == length(unique(overpass_osm.nodes.id))
        end
    end
end
