# Highways
A [**highway**](http://wiki.openstreetmap.org/wiki/Highways) in OpenStreetMap is any road, route, way, or thoroughfare on land which connects one location to another and has been paved or otherwise improved to allow travel by some conveyance, including motorised vehicles, cyclists, pedestrians, horse riders, and others (but not trains – see [Railways](http://wiki.openstreetmap.org/wiki/Railways) for further details).

## Classification
Around the world highways are classified in different ways using different terms. OpenStreetMap attempts to apply a single classification system to all local conditions. For reasons of origin, the terms used within OSM are British English, resulting in an interstate highway in the USA and an Autobahn in Germany being tagged as a 'motorway' along with it's British equivalent. [Highway tag usage](http://wiki.openstreetmap.org/wiki/Highway_tag_usage) provides more general information on how to interpret road classifications to local conditions and [Highway:International equivalence](http://wiki.openstreetmap.org/wiki/Highway:International_equivalence) provides guidance on mapping in different countries/territories.

- [**Roads**](http://wiki.openstreetmap.org/wiki/Key:highway#Roads): `motorway`, `trunk`, `primary`, `secondary`, `tertiary`, `unclassified`, `residential`, `service`
- [**Link Roads**](http://wiki.openstreetmap.org/wiki/Highway_link):   
`motorway_link`, `trunk_link`, `primary_link`, `secondary_link`, `motorway_junction`
- [**Special**](http://wiki.openstreetmap.org/wiki/Key:highway#Special_road_types): `living_street`, `pedestrian`, `bicycle_road`, `track`, `bus_guideway`, `raceway`, `road`, `construction`, `escape`
- [**Paths**](http://wiki.openstreetmap.org/wiki/Key:highway#Paths): `footway`, `cycleway`, `path`, `bridleway`, `steps`
- [**Sidewalks**](http://wiki.openstreetmap.org/wiki/Sidewalks): `sidewalk`

Most roads should be tagged with `highway=unclassified`. If a road has residences along both sides, it should be tagged `highway=residential`. Significant through roads should be tagged as `highway=tertiary` (Significance is subjective, and will vary with location). Service roads (roads which exist to provide access for trash collection or parking, and campground roads) should be tagged with `highway=service`. Other unimproved roads capable of use by 4 wheel vehicles should be tagged with `highway=track`. Roads for which the classification is not known should be temporarily tagged with `highway=road` until they are properly surveyed.

While some highway tags like `highway=cycleway` and `highway=bridleway` imply a particular kind of traffic other tags should be used to designate what traffic is legally allowed or may be appropriate. Use `access=*` to provide more information. Pedestrianized roads (roads which have been converted to pedestrian walkways either by physical barriers or by signage) should be tagged with `highway=pedestrian`. Additional tags can be used for cycle routes or trails.

## Tags

The following tags are all optional – please do not be intimidated as they are very rarely all populated by the initial mapper. If you are mapping a new area the you may wish to limit yourself to capturing the road geometry, junctions, the road classification and road names.

- [Highway tagging samples/urban](http://wiki.openstreetmap.org/wiki/Highway_tagging_samples/urban)
- [Highway tagging samples/out_of_town](http://wiki.openstreetmap.org/wiki/Highway_tagging_samples/out_of_town)

### Names and References
Use the `name=*` and/or the `ref=*` for each section of the road (way) which has a name or reference. If a stretch of highway has multiple reference numbers, they should be semicolon-delimited. (examples: `ref=I 39;US 51, ref=US 51;WI 54`). If a road has two names, the less common one can be put in `alt_name=*`; in addition, where a road is now much more generally known by its reference (for example the 'A1' in the UK), but that it also has a current legal name for historical reasons if it probably better to leave the name field blank and put the name in alt_name which means that it is much less likely to be rendered. A previous name which is no longer used but may be of interest for historical mapping can be put in `old_name=*`.

### Speed limits and other restrictions
`maxspeed=*`, `maxheight=*`, `maxwidth=*` and `maxweight=*` can be used to add detail about a road. Maxspeed generally applies to all public roads. Maxheight and maxwidth often apply to a road going under a bridge and maxweight to a road going over a bridge. Note that each tag should be associated with the way to which the restriction applies and can either be attached to the way itself or to a node along the way.

Use `foot=no` if pedestrians are not allowed and `bicycle=no` if bicycles are not allowed. If only buses are allowed then `access=no` together with `bus=yes` would be appropriate. See the [access](http://wiki.openstreetmap.org/wiki/Access) article for a much more detailed description of how o describe other restrictions relating to use of the road or path.

## Restrictions
See http://wiki.openstreetmap.org/wiki/Relation:restriction for details.
