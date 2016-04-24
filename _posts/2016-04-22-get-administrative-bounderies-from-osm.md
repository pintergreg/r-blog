---
layout: post
title:  "Get administrative boundaries from OSM"
date:   2016-04-22 19:20:00 +0200
categories: osm osmfilter qgis borders boundaries
---

# Get administrative boundaries from OSM

[Online service to get administrative boundaries from OSM][osm-boundaries-servise]

![Screenshot](/assets/osm_boundaries_map.png)

# Another method -- get boundaries from OSM file

# Get OSM file of Budapest

BBBike has a convenient service to get OSM files from OpenStreetMap.

[Online service for OSM extraction -- set for Budapest][bbbike]

![Screenshot](/assets/bbbike_bp.jpg)

## After that using osmfilter to extract districts from osm file

```
$ ./osmfilter32 Budapest.osm --keep="admin_level=9" -o=bp_districts.osm
```

The output osm file contained some unnecessary layers, I opened it in QGIS and kept only the "multipolygons" layer and saved as a geoJSON.

![Screenshot](/assets/qgis_layers.png)

# References

* [OSM wiki page about administrative boundaries][osm-admin-boundaries-summary]
* [Extracting tool for OSM][osmfilter]

[osmfilter]: http://wiki.openstreetmap.org/wiki/Osmfilter
[osm-admin-boundaries-summary]: http://wiki.openstreetmap.org/wiki/Tag:boundary%3Dadministrative
[osm-boundaries-servise]: https://osm.wno-edv-service.de/boundaries/
[bbbike]: http://download.bbbike.org/osm/bbbike/Budapest/
