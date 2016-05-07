---
layout: post
title:  "Generate grid"
date:   2016-04-24 17:08:00 +0200
categories: spatialite geojson
---
I want to generate a 1km × 1km grid over Budapest. The [Spatialite tutorial][tesselations] shows  how to create a 10km × 10km grid over Tuscany, but using `1000` as a parameter Spatilite parsed it as longitude and latitude parameter and I got a single, but enormous one.

How to create the grid or save it as geoJSON:
{% highlight sql %}
spatialite> SELECT ST_SquareGrid(geometry, 1000) FROM budapest;

spatialite> SELECT asgeojson (ST_SquareGrid(geometry, 1000)) FROM budapest;
{% endhighlight %}

# miscellaneous

Creating a new databse:

```
$ spatialite bp_districts.splite
```
Loading shapefile:


```
spatialite> .loadshp bp_districts budapest CP1252 0 Geometry PRO_COM MULTIPOLYGON 
.loadshp Budapest_AL6 budapest UTF-8; 
```

# References

* [Tutorial about creating grid][tesselations]
* [SQL functions reference list][function-references]

[function-references]: http://www.gaia-gis.it/gaia-sins/spatialite-sql-4.2.0.html
[tesselations]: https://www.gaia-gis.it/fossil/libspatialite/wiki?name=tesselations-4.0
[changes-4-0-0]: https://www.gaia-gis.it/fossil/libspatialite/wiki?name=tools-4.0

