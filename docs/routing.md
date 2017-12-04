# Routing
This is based on https://wiki.openstreetmap.org/wiki/OSM_tags_for_routing.

This section does not reflect real-world usage by popular routing software and should be taken with a very large pinch of salt. The tags used by routers are at the discretion of the software's authors and will vary from use to use.

## Roads
Only ways marked with the key `highway=*` or `junction=*`, and areas marked by `highway=*` and `area=yes` or `type=multipolygon`, are a road that a car, bike or pedestrian can navigate on.

When creating routes for motor-vehicles beware for the values "footway", "pedestrian", "steps", "gate", "stile", "cattle_grid", "viaduct" and limit the usage of "ford", "service". Also notice that [`highway=services`](https://wiki.openstreetmap.org/wiki/Tag:highway%3Dservices) does not represent a road.

## Oneway
A way is oneway if and only if it has:

- `oneway=yes` or
- `oneway=-1` (denotes opposite direction to node order) or
- `junction=roundabout` or
- `highway=motorway` or
- ~~`highway=motorway_link`~~

and

- `oneway ≠ no` (the tag `oneway=no` has precedence over `highway=motorway`)

Roads which are one-way and change direction depending on time (eg: flyover in direction of rush-hour traffic flow) are tagged with `oneway=reversible` and should probably be treated as no access.

## Name
The following tags may contain the name of a street:

- `name=*`: "name:<2digit-language-code>", int_name, ...
- `ref=*`: "nat_ref", "loc_ref", "int_ref"

See: [naming](https://wiki.openstreetmap.org/wiki/Template:Map_Features:name)

## Traffic signals
You should limit the expected speed when crossing nodes tagged `highway=traffic_signals`, `highway=stop` or `barrier=toll_booth` as well as `traffic_calming=*`.

## Access Restrictions
Access restrictions are documented on [Key:access](https://wiki.openstreetmap.org/wiki/Key:access), and [Conditional restrictions](https://wiki.openstreetmap.org/wiki/Conditional_restrictions) for more advanced cases.

The default access-restrictions for each vehicle- and highway-type are documented in [Access-Restrictions](https://wiki.openstreetmap.org/wiki/OSM_tags_for_routing/Access-Restrictions).

To compute access restrictions in the presence both of default values and explicit values, see [Computing access restrictions](https://wiki.openstreetmap.org/wiki/Computing_access_restrictions).

## Turn-Restrictions
Restrictions to prohibit certain kinds of turns at intersections are documented in [Relation:restriction](https://wiki.openstreetmap.org/wiki/Relation:restriction).

## Max speed
The default maximum-speed if not given by maxspeed=* is now documented on [on this page](https://wiki.openstreetmap.org/wiki/OSM_tags_for_routing/Maxspeed).