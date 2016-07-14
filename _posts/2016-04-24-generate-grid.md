---
layout: post
title:  "Generate grid (updated)"
date:   2016-04-24 17:08:00 +0200
update: 2016-05-21 08:06:00 +0200
categories: spatialite geojson
---
I want to generate a 1km × 1km grid over Budapest. The [Spatialite tutorial][tesselations] shows  how to create a 10km × 10km grid over Tuscany, but using `1000` as a parameter Spatilite parsed it as longitude and latitude parameter and I got a single, but enormous one.

How to create the grid or save it as geoJSON:
{% highlight sql %}
spatialite> SELECT ST_SquareGrid(geometry, 1000) FROM budapest;

spatialite> SELECT asgeojson (ST_SquareGrid(geometry, 1000)) FROM budapest;
{% endhighlight %}

So, I used the value 0.01, because [Wiki says](https://en.wikipedia.org/wiki/Decimal_degrees) it is about 1.11km (at the equator).

# GeoJSON with Spatialite GUI

After loading Budapest geodata into Spatialite (**TODO**: write about it), I ran a query to generate a `0.02 x 0.02` grid. The BLOB explorer shows that it is nicely generated.

![The output image]({{ site.baseurl }}/assets/spatialite_gui_grid.jpg)

The only problem was its geometry type, which is `multipolygon`. I would need a `feature collection` type geoJSON. As I did not found quickly a way to generate a proper geoJSON I wrote a simple [Ruby script]({{ site.baseurl }}/assets/convert_geojson.rb) to convert the geoJSON to a better format.

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

* [More than you ever wanted to know about GeoJSON][more-about-geojson]
* [Terraformer glossary][terraformer]

[more-about-geojson]: http://www.macwright.org/2015/03/23/geojson-second-bite.html
[terraformer]: http://terraformer.io/glossary/
