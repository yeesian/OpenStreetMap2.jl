# taken from http://wiki.openstreetmap.org/wiki/OSM_tags_for_routing/Access-Restrictions
#
# Permission is granted to copy, distribute and/or modify Wikipedia's text
# under the terms of the Creative Commons Attribution-ShareAlike 3.0 Unported
# License and, unless otherwise noted, the GNU Free Documentation License.
# unversioned, with no invariant sections, front-cover texts, or back-cover texts.
# 
# https://en.wikipedia.org/wiki/Wikipedia:Copyrights

"""
Default-Access-Restriction for all countries

with "street", "track", and "service" introduced as `:yes` for all modes.
Individual regions can provide their own access restriction dictionaries.

### Interpretation
* `yes` - this kind of vehicle is allowed to drive on this kind of road unless
    tagged otherwise on the individual way (e.g. "motorcar=no").
* `designated` - same as yes but this road can optionally be preferred by some
    of your metrics.
* `no` - this kind of vehicle is not allowed to drive on this kind of road
    unless tagged otherwise on the individual way (e.g. "motorcar=yes").
"""
const ACCESS = Dict(
    "all" => Dict(
        "motorway" => :yes,
        "motorway_link" => :yes,
        "trunk" => :yes,
        "trunk_link" => :yes,
        "primary" => :yes,
        "primary_link" => :yes,
        "secondary" => :yes,
        "secondary_link" => :yes,
        "tertiary" => :yes,
        "tertiary_link" => :yes,
        "unclassified" => :yes,
        "residential" => :yes,
        "living_street" => :yes,
        "street" => :yes,
        "track" => :yes,
        "service" => :yes,
        "road" => :yes,
        "pedestrian" => :yes,
        "path" => :yes,
        "bridleway" => :yes,
        "cycleway" => :yes,
        "footway" => :yes
    ),
    "access" => Dict(
        "motorway" => :yes,
        "motorway_link" => :yes,
        "trunk" => :yes,
        "trunk_link" => :yes,
        "primary" => :yes,
        "primary_link" => :yes,
        "secondary" => :yes,
        "secondary_link" => :yes,
        "tertiary" => :yes,
        "tertiary_link" => :yes,
        "unclassified" => :yes,
        "residential" => :yes,
        "living_street" => :yes,
        "street" => :yes,
        "track" => :yes,
        "service" => :yes,
        "road" => :yes,
        "pedestrian" => :no,
        "path" => :no,
        "bridleway" => :no,
        "cycleway" => :no,
        "footway" => :no
    ),
    "motorcar" => Dict(
        "motorway" => :designated,
        "motorway_link" => :yes,
        "trunk" => :yes,
        "trunk_link" => :yes,
        "primary" => :yes,
        "primary_link" => :yes,
        "secondary" => :yes,
        "secondary_link" => :yes,
        "tertiary" => :yes,
        "tertiary_link" => :yes,
        "unclassified" => :yes,
        "residential" => :yes,
        "living_street" => :yes,
        "street" => :yes,
        "track" => :yes,
        "service" => :yes,
        "road" => :yes,
        "pedestrian" => :no,
        "path" => :no,
        "bridleway" => :no,
        "cycleway" => :no,
        "footway" => :no
    ),
    "motorcycle" => Dict(
        "motorway" => :designated,
        "motorway_link" => :yes,
        "trunk" => :yes,
        "trunk_link" => :yes,
        "primary" => :yes,
        "primary_link" => :yes,
        "secondary" => :yes,
        "secondary_link" => :yes,
        "tertiary" => :yes,
        "tertiary_link" => :yes,
        "unclassified" => :yes,
        "residential" => :yes,
        "living_street" => :yes,
        "street" => :yes,
        "track" => :yes,
        "service" => :yes,
        "road" => :yes,
        "pedestrian" => :no,
        "path" => :no,
        "bridleway" => :no,
        "cycleway" => :no,
        "footway" => :no
    ),
    "goods" => Dict(
        "motorway" => :designated,
        "motorway_link" => :yes,
        "trunk" => :yes,
        "trunk_link" => :yes,
        "primary" => :yes,
        "primary_link" => :yes,
        "secondary" => :yes,
        "secondary_link" => :yes,
        "tertiary" => :yes,
        "tertiary_link" => :yes,
        "unclassified" => :yes,
        "residential" => :yes,
        "living_street" => :yes,
        "street" => :yes,
        "track" => :yes,
        "service" => :yes,
        "road" => :yes,
        "pedestrian" => :no,
        "path" => :no,
        "bridleway" => :no,
        "cycleway" => :no,
        "footway" => :no
    ),
    "hgv" => Dict(
        "motorway" => :designated,
        "motorway_link" => :yes,
        "trunk" => :yes,
        "trunk_link" => :yes,
        "primary" => :yes,
        "primary_link" => :yes,
        "secondary" => :yes,
        "secondary_link" => :yes,
        "tertiary" => :yes,
        "tertiary_link" => :yes,
        "unclassified" => :yes,
        "residential" => :yes,
        "living_street" => :yes,
        "street" => :yes,
        "track" => :yes,
        "service" => :yes,
        "road" => :yes,
        "pedestrian" => :no,
        "path" => :no,
        "bridleway" => :no,
        "cycleway" => :no,
        "footway" => :no
    ),
    "psv" => Dict(
        "motorway" => :designated,
        "motorway_link" => :yes,
        "trunk" => :yes,
        "trunk_link" => :yes,
        "primary" => :yes,
        "primary_link" => :yes,
        "secondary" => :yes,
        "secondary_link" => :yes,
        "tertiary" => :yes,
        "tertiary_link" => :yes,
        "unclassified" => :yes,
        "residential" => :yes,
        "living_street" => :yes,
        "street" => :yes,
        "track" => :yes,
        "service" => :yes,
        "road" => :yes,
        "pedestrian" => :no,
        "path" => :no,
        "bridleway" => :no,
        "cycleway" => :no,
        "footway" => :no
    ),
    "moped" => Dict(
        "motorway" => :no,
        "motorway_link" => :yes,
        "trunk" => :yes,
        "trunk_link" => :yes,
        "primary" => :yes,
        "primary_link" => :yes,
        "secondary" => :yes,
        "secondary_link" => :yes,
        "tertiary" => :yes,
        "tertiary_link" => :yes,
        "unclassified" => :yes,
        "residential" => :yes,
        "living_street" => :yes,
        "street" => :yes,
        "track" => :yes,
        "service" => :yes,
        "road" => :yes,
        "pedestrian" => :no,
        "path" => :no,
        "bridleway" => :no,
        "cycleway" => :no,
        "footway" => :no
    ),
    "horse" => Dict(
        "motorway" => :no,
        "motorway_link" => :yes,
        "trunk" => :yes,
        "trunk_link" => :yes,
        "primary" => :yes,
        "primary_link" => :yes,
        "secondary" => :yes,
        "secondary_link" => :yes,
        "tertiary" => :yes,
        "tertiary_link" => :yes,
        "unclassified" => :yes,
        "residential" => :yes,
        "living_street" => :yes,
        "street" => :yes,
        "track" => :yes,
        "service" => :yes,
        "road" => :yes,
        "pedestrian" => :no,
        "path" => :yes,
        "bridleway" => :designated,
        "cycleway" => :no,
        "footway" => :no
    ),
    "bicycle" => Dict(
        "motorway" => :no,
        "motorway_link" => :yes,
        "trunk" => :yes,
        "trunk_link" => :yes,
        "primary" => :yes,
        "primary_link" => :yes,
        "secondary" => :yes,
        "secondary_link" => :yes,
        "tertiary" => :yes,
        "tertiary_link" => :yes,
        "unclassified" => :yes,
        "residential" => :yes,
        "living_street" => :yes,
        "street" => :yes,
        "track" => :yes,
        "service" => :yes,
        "road" => :yes,
        "pedestrian" => :no,
        "path" => :yes,
        "bridleway" => :no,
        "cycleway" => :designated,
        "footway" => :no
    ),
    "foot" => Dict(
        "motorway" => :no,
        "motorway_link" => :yes,
        "trunk" => :yes,
        "trunk_link" => :yes,
        "primary" => :yes,
        "primary_link" => :yes,
        "secondary" => :yes,
        "secondary_link" => :yes,
        "tertiary" => :yes,
        "tertiary_link" => :yes,
        "unclassified" => :yes,
        "residential" => :yes,
        "living_street" => :yes,
        "street" => :yes,
        "track" => :yes,
        "service" => :yes,
        "road" => :yes,
        "pedestrian" => :yes,
        "path" => :yes,
        "bridleway" => :no,
        "cycleway" => :no,
        "footway" => :designated
    )
)

### Julia OpenStreetMap Package ###
### MIT License                 ###
### Copyright 2014              ###

### Default Speed Limits in Kilometers Per Hour ###
# these values were taken from OpenStreetMap.jl v0.8.2
# (https://github.com/tedsteiner/OpenStreetMap.jl/blob/9102e36e4f8304ce2238f2d315589976c83d3d66/src/speeds.jl)
# tedsteiner said he hand-adjusted the values until they seem reasonable

# in practice these values are country-dependent, and the user might want to
# consult e.g. https://wiki.openstreetmap.org/wiki/OSM_tags_for_routing/Maxspeed
# and http://wiki.openstreetmap.org/wiki/Speed_limits for guidance

const SPEEDLIMIT_URBAN = Dict(
    :motorway       => 95,
    :trunk          => 72,
    :primary        => 48,
    :secondary      => 32,
    :tertiary       => 22,
    :residential    => 12,
    :service        => 8,
    :pedestrian     => 5
)

const SPEEDLIMIT_RURAL = Dict(
    :motorway       => 110,
    :trunk          => 90,
    :primary        => 80,
    :secondary      => 72,
    :tertiary       => 55,
    :residential    => 40,
    :service        => 15,
    :pedestrian     => 15
)

const ROADCLASSES = Dict(
    "motorway"          => :motorway,
    "motorway_link"     => :motorway,
    "trunk"             => :trunk,
    "trunk_link"        => :trunk,
    "primary"           => :primary,
    "primary_link"      => :primary,
    "secondary"         => :secondary,
    "secondary_link"    => :secondary,
    "tertiary"          => :tertiary,
    "tertiary_link"     => :tertiary,
    "unclassified"      => :residential,
    "residential"       => :residential,
    "road"              => :residential,
    "service"           => :service,
    "living_street"     => :livingstreet,
    "pedestrian"        => :livingstreet
)

# Level 1: Cycleways, walking paths, and pedestrian streets
# Level 2: Sidewalks
# Level 3: Pedestrians typically allowed but unspecified
# Level 4: Agricultural or horse paths, etc.
const PEDCLASSES = Dict(
    "cycleway"          => 1,
    "pedestrian"        => 1,
    "living_street"     => 1,
    "footway"           => 1,
    "sidewalk"          => 2,
    "sidewalk:yes"      => 2,
    "sidewalk:both"     => 2,
    "sidewalk:left"     => 2,
    "sidewalk:right"    => 2,
    "steps"             => 2,
    "path"              => 3,
    "residential"       => 3,
    "service"           => 3,
    "secondary"         => 4,
    "tertiary"          => 4,
    "primary"           => 4,
    "track"             => 4,
    "bridleway"         => 4,
    "unclassified"      => 4
)

# Level 1: Bike paths
# Level 2: Separated bike lanes (tracks)
# Level 3: Bike lanes
# Level 4: Bikes typically allowed but not specified
const CYCLECLASSES = Dict(
    "cycleway"                  => 1,
    "cycleway:track"            => 2,
    "cycleway:opposite_track"   => 2,
    "bicycle:use_sidepath"      => 2,
    "bicycle:designated"        => 2,
    "cycleway:lane"             => 3,
    "cycleway:opposite"         => 3,
    "cycleway:opposite_lane"    => 3,
    "cycleway:shared"           => 3,
    "cycleway:share_busway"     => 3,
    "cycleway:shared_lane"      => 3,
    "bicycle:permissive"        => 3,
    "bicycle:yes"               => 3,
    "bicycle:dismount"          => 4,
    "residential"               => 4,
    "pedestrian"                => 4,
    "living_street"             => 4,
    "service"                   => 4,
    "unclassified"              => 4
)

# Class 1: Residential/Accomodation
# Class 2: Commercial
# Class 3: Civic/Amenity
# Class 4: Other
# Class 5: Unclassified
const BUILDING_CLASSES = Dict(
    "accomodation"      => 1,
    "apartments"        => 1,
    "bungalow"          => 1,
    "detached"          => 1,
    "dormitory"         => 1,
    "dwelling_house"    => 1,
    "farm"              => 1,
    "ger"               => 1,
    "hotel"             => 1,
    "house"             => 1,
    "houseboat"         => 1,
    "residential"       => 1,
    "Residential"       => 1,
    "semidetached_house"=> 1,
    "static_caravan"    => 1,
    "terrace"           => 1,       
    
    "commercial"        => 2,
    "factory"           => 2,
    "industrial"        => 2,
    "manufacture"       => 2,
    "office"            => 2,
    "retail"            => 2,
    "supermarket"       => 2,
    "warehouse"         => 2,

    "administrative"    => 3,
    "cathedral"         => 3,
    "chapel"            => 3,
    "church"            => 3,
    "civic"             => 3,
    "kindergarten"      => 3,
    "hospital"          => 3,
    "mosque"            => 3,
    "pavilion"          => 3,
    "public"            => 3,
    "school"            => 3,
    "shrine"            => 3,
    "stadium"           => 3,
    "synagogue"         => 3,
    "temple"            => 3,
    "train_station"     => 3,
    "transportation"    => 3,
    "university"        => 3,

    "barn"              => 4,
    "bridge"            => 4,
    "bunker"            => 4,
    "cabin"             => 4,
    "collapsed"         => 4,
    "construction"      => 4,
    "cowshed"           => 4,
    "damaged"           => 4,
    "farm_auxiliary"    => 4,
    "garage"            => 4,
    "garages"           => 4,
    "greenhouse"        => 4,
    "hangar"            => 4,
    "hut"               => 4,
    "kiosk"             => 4,
    "roof"              => 4,
    "semi"              => 4,
    "service"           => 4,
    "shed"              => 4,
    "stable"            => 4,
    "storage_tank"      => 4,
    "sty"               => 4,
    "tank"              => 4,
    "transformer_tower" => 4,
    "ruins"             => 4,

    "yes"               => 5,
    "Yes"               => 5
)

const FEATURE_CLASSES = Dict(
    "aerialway"         => 1,
    "aeroway"           => 2,
    "amenity"           => 3,
    "barrier"           => 4,
    "boundary"          => 5,
    "building"          => 6,
    "craft"             => 7,
    "emergency"         => 8,
    "geological"        => 9,
    "highway"           => 10,
    "historic"          => 11,
    "landuse"           => 12,
    "leisure"           => 13,
    "man_made"          => 14,
    "military"          => 15,
    "natural"           => 16,
    "office"            => 17,
    "place"             => 18,
    "power"             => 19,
    "public_transport"  => 20,
    "railway"           => 21,
    "route"             => 22,
    "shop"              => 23,
    "sport"             => 24,
    "tourism"           => 25,
    "waterway"          => 26
)
