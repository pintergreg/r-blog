---
layout: post
title:  "Generate grid"
date:   2016-04-24 17:08:00 +0200
categories: spatialite geojson
---

$ spatialite bp_districts.splite

spatialite> .loadshp bp_districts budapest CP1252 0 Geometry PRO_COM MULTIPOLYGON 
.loadshp Budapest_AL6 budapest UTF-8; 


{% highlight sql %}

{% endhighlight %}

spatialite> SELECT ST_SquareGrid(geometry, 1000) FROM budapest;

select asgeojson (ST_SquareGrid(geometry, 1000)) FROM budapest;

http://www.gaia-gis.it/gaia-sins/spatialite-sql-4.2.0.html

https://www.gaia-gis.it/fossil/libspatialite/wiki?name=tesselations-4.0
https://www.gaia-gis.it/fossil/libspatialite/wiki?name=tools-4.0

