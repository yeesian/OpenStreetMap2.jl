# OSM PBF

## Installation

1. Download `fileformat.proto` and `osmformat.proto` from https://github.com/openstreetmap/osmosis/tree/93065380e462b141e5c5733a092531bf43860526/osmosis-osm-binary/src/main/protobuf
2. Run the following at the commandline:

```bash
$ protoc --julia_out=. *.proto
```
