# Developer Docs

taken from http://wiki.openstreetmap.org/wiki/PBF_Format

## Encoding OSM Entities

There are currently two fileblock types for OSM data. These textual type strings are stored in the type field in the `BlobHeader`:

- `OSMHeader`: The Blob Contains a serialized `HeaderBlock` message (See `osmformat.proto`). Every fileblock must have one of these blocks before the first 'OSMData' block.
- `OSMData`: Contains a serialized `PrimitiveBlock` message. (See `osmformat.proto`). These contain the entities.
This design lets other software extend the format to include fileblocks of additional types for their own purposes. Parsers should ignore and skip fileblock types that they do not recognize.

### OSMHeader
Definition of the OSMHeader fileblock:
```
message HeaderBlock {
  optional HeaderBBox bbox = 1;
  /* Additional tags to aid in parsing this dataset */
  repeated string required_features = 4;
  repeated string optional_features = 5;

  optional string writingprogram = 16;
  optional string source = 17; // From the bbox field.

  /* Tags that allow continuing an Osmosis replication */

  // replication timestamp, expressed in seconds since the epoch,
  // otherwise the same value as in the "timestamp=..." field
  // in the state.txt file used by Osmosis
  optional int64 osmosis_replication_timestamp = 32;

  // replication sequence number (sequenceNumber in state.txt)
  optional int64 osmosis_replication_sequence_number = 33;

  // replication base URL (from Osmosis' configuration.txt file)
  optional string osmosis_replication_base_url = 34;
}
```

### OSMData
To encode OSM entities into protocol buffers, I collect 8k entities to form a PrimitiveBlock, which is serialized into the Blob portion of an 'OsmData' fileblock.
```
message PrimitiveBlock {
  required StringTable stringtable = 1;
  repeated PrimitiveGroup primitivegroup = 2;

  // Granularity, units of nanodegrees, used to store coordinates in this block
  optional int32 granularity = 17 [default=100]; 

  // Offset value between the output coordinates coordinates and the granularity grid, in units of nanodegrees.
  optional int64 lat_offset = 19 [default=0];
  optional int64 lon_offset = 20 [default=0]; 

  // Granularity of dates, normally represented in units of milliseconds since the 1970 epoch.
  optional int32 date_granularity = 18 [default=1000]; 


  // Proposed extension:
  //optional BBox bbox = XX;
}
```
Within each primitiveblock, I then divide entities into groups that contain consecutive messages all of the same type (node/way/relation).
```
message PrimitiveGroup {
  repeated Node     nodes = 1;
  optional DenseNodes dense = 2;
  repeated Way      ways = 3;
  repeated Relation relations = 4;
  repeated ChangeSet changesets = 5;
}
```
A PrimitiveGroup MUST NEVER contain different types of objects. So either it contains many Node messages, or a DenseNode message, or many Way messages, or many Relation messages, or many ChangeSet messages. But it can never contain any mixture of those.

## File format
A file contains a header followed by a sequence of fileblocks. The design is intended to allow future random-access to the contents of the file and skipping past not-understood or unwanted data.

The format is a repeating sequence of:

```
int4: length of the BlobHeader message in network byte order
serialized BlobHeader message
serialized Blob message (size is given in the header)
```

### BlobHeader

A BlobHeader is currently defined as:

```
 message BlobHeader {
   required string type = 1;
   optional bytes indexdata = 2;
   required int32 datasize = 3;
 }
```

where
- `type` contains the type of data in this block message.
- `indexdata` is some arbitrary blob that may include metadata about the following blob, (e.g., for OSM data, it might contain a bounding box.) This is a stub intended to enable the future design of indexed *.osm.pbf files.
- `datasize` contains the serialized size of the subsequent Blob message.

### Blob

Blob is currently used to store an arbitrary blob of data, either uncompressed or in zlib/deflate compressed format.

```
message Blob {
  optional bytes raw = 1; // No compression
  optional int32 raw_size = 2; // When compressed, the uncompressed size

  // Possible compressed versions of the data.
  optional bytes zlib_data = 3;

  // PROPOSED feature for LZMA compressed data. SUPPORT IS NOT REQUIRED.
  optional bytes lzma_data = 4;

  // Formerly used for bzip2 compressed data. Depreciated in 2010.
  optional bytes OBSOLETE_bzip2_data = 5 [deprecated=true]; // Don't reuse this tag number.
}
```
