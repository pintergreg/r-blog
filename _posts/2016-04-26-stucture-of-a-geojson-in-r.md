---
layout: post
title:  "Structure of a geoJSON in R"
date:   2016-04-26 11:30:00 +0200
categories: r geojson sp
---

[Previous post]({{ site.baseurl }}{% post_url 2016-04-24-plot-geojson %}) 
After importing a geoJSON to R it will have a [SpatialPolygonsDataFrame](http://www.inside-r.org/packages/cran/sp/docs/as.data.frame.SpatialPolygonsDataFrame) object from package `sp` with a structure of this (str() fuction was used).

{% highlight r %}
str(bp)

{% endhighlight %}

# output

```
Formal class 'SpatialPolygonsDataFrame' [package "sp"] with 5 slots
  ..@ data       :'data.frame':	23 obs. of  25 variables:
  .. ..$ osm_id     : Factor w/ 23 levels "1550597","1550598",..: 16 17 18 19 20 21 22 23 1 2 ...
  .. ..$ osm_way_id : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
  .. ..$ name       : Factor w/ 23 levels "III. kerület",..: 22 21 1 2 3 11 12 4 20 16 ...
  .. ..$ type       : Factor w/ 1 level "boundary": 1 1 1 1 1 1 1 1 1 1 ...
  .. ..$ aeroway    : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
  .. ..$ amenity    : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
  .. ..$ admin_level: Factor w/ 1 level "9": 1 1 1 1 1 1 1 1 1 1 ...
  .. ..$ barrier    : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
  .. ..$ boundary   : Factor w/ 1 level "administrative": 1 1 1 1 1 1 1 1 1 1 ...
  .. ..$ building   : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
  .. ..$ craft      : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
  .. ..$ geological : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
  .. ..$ historic   : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
  .. ..$ land_area  : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
  .. ..$ landuse    : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
  .. ..$ leisure    : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
  .. ..$ man_made   : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
  .. ..$ military   : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
  .. ..$ natural    : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
  .. ..$ office     : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
  .. ..$ place      : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
  .. ..$ shop       : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
  .. ..$ sport      : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
  .. ..$ tourism    : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
  .. ..$ other_tags : Factor w/ 23 levels "\"name:de\"=>\"I. Bezirk\",\"name:en\"=>\"1st district\",\"alt_name\"=>\"Várkerület\",\"wikipedia\"=>\"hu:Budapest I. kerülete\"| __truncated__,..: 21 22 3 2 1 12 11 4 23 19 ...
  ..@ polygons   :List of 23
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19.1 47.4
  .. .. .. .. .. .. ..@ area   : num 0.00314
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:100, 1:2] 19.1 19.1 19.1 19.1 19.1 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19.1 47.4
  .. .. .. ..@ ID       : chr "0"
  .. .. .. ..@ area     : num 0.00314
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19 47.4
  .. .. .. .. .. .. ..@ area   : num 0.004
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:277, 1:2] 19 19 19 19 19 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19 47.4
  .. .. .. ..@ ID       : chr "1"
  .. .. .. ..@ area     : num 0.004
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19 47.6
  .. .. .. .. .. .. ..@ area   : num 0.00469
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:387, 1:2] 19 19 19 19 19 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19 47.6
  .. .. .. ..@ ID       : chr "2"
  .. .. .. ..@ area     : num 0.00469
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19 47.5
  .. .. .. .. .. .. ..@ area   : num 0.00436
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:517, 1:2] 19 19 19 19 19 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19 47.5
  .. .. .. ..@ ID       : chr "3"
  .. .. .. ..@ area     : num 0.00436
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19 47.5
  .. .. .. .. .. .. ..@ area   : num 0.000405
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:162, 1:2] 19 19 19 19 19 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19 47.5
  .. .. .. ..@ ID       : chr "4"
  .. .. .. ..@ area     : num 0.000405
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19 47.5
  .. .. .. .. .. .. ..@ area   : num 0.00319
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:663, 1:2] 19 19 19 19 19 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19 47.5
  .. .. .. ..@ ID       : chr "5"
  .. .. .. ..@ area     : num 0.00319
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19 47.5
  .. .. .. .. .. .. ..@ area   : num 0.00399
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:695, 1:2] 19 19 19 19 19 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19 47.5
  .. .. .. ..@ ID       : chr "6"
  .. .. .. ..@ area     : num 0.00399
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19.1 47.6
  .. .. .. .. .. .. ..@ area   : num 0.00235
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:84, 1:2] 19.1 19.1 19.1 19.1 19.1 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19.1 47.6
  .. .. .. ..@ ID       : chr "7"
  .. .. .. ..@ area     : num 0.00235
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19.1 47.4
  .. .. .. .. .. .. ..@ area   : num 0.00486
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:118, 1:2] 19.1 19.1 19.1 19.1 19.1 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19.1 47.4
  .. .. .. ..@ ID       : chr "8"
  .. .. .. ..@ area     : num 0.00486
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19.2 47.4
  .. .. .. .. .. .. ..@ area   : num 0.00464
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:159, 1:2] 19.2 19.2 19.2 19.2 19.2 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19.2 47.4
  .. .. .. ..@ ID       : chr "9"
  .. .. .. ..@ area     : num 0.00464
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19.3 47.5
  .. .. .. .. .. .. ..@ area   : num 0.00654
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:128, 1:2] 19.2 19.2 19.2 19.2 19.2 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19.3 47.5
  .. .. .. ..@ ID       : chr "10"
  .. .. .. ..@ area     : num 0.00654
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19.1 47.4
  .. .. .. .. .. .. ..@ area   : num 0.00112
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:112, 1:2] 19.1 19.1 19.1 19.1 19.1 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19.1 47.4
  .. .. .. ..@ ID       : chr "11"
  .. .. .. ..@ area     : num 0.00112
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19.1 47.4
  .. .. .. .. .. .. ..@ area   : num 0.00145
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:111, 1:2] 19.1 19.1 19.1 19.1 19.1 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19.1 47.4
  .. .. .. ..@ ID       : chr "12"
  .. .. .. ..@ area     : num 0.00145
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19.1 47.5
  .. .. .. .. .. .. ..@ area   : num 0.0015
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:144, 1:2] 19.1 19.1 19.1 19.1 19.1 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19.1 47.5
  .. .. .. ..@ ID       : chr "13"
  .. .. .. ..@ area     : num 0.0015
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19.2 47.5
  .. .. .. .. .. .. ..@ area   : num 0.00386
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:84, 1:2] 19.2 19.2 19.2 19.2 19.2 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19.2 47.5
  .. .. .. ..@ ID       : chr "14"
  .. .. .. ..@ area     : num 0.00386
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19.2 47.5
  .. .. .. .. .. .. ..@ area   : num 0.00402
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:71, 1:2] 19.2 19.2 19.2 19.2 19.2 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19.2 47.5
  .. .. .. ..@ ID       : chr "15"
  .. .. .. ..@ area     : num 0.00402
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19.1 47.5
  .. .. .. .. .. .. ..@ area   : num 0.00162
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:98, 1:2] 19.1 19.1 19.1 19.1 19.1 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19.1 47.5
  .. .. .. ..@ ID       : chr "16"
  .. .. .. ..@ area     : num 0.00162
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19.1 47.6
  .. .. .. .. .. .. ..@ area   : num 0.00323
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:90, 1:2] 19.1 19.1 19.1 19.1 19.1 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19.1 47.6
  .. .. .. ..@ ID       : chr "17"
  .. .. .. ..@ area     : num 0.00323
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19.1 47.5
  .. .. .. .. .. .. ..@ area   : num 0.00215
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:116, 1:2] 19.1 19.1 19.1 19.1 19.1 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19.1 47.5
  .. .. .. ..@ ID       : chr "18"
  .. .. .. ..@ area     : num 0.00215
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19.1 47.5
  .. .. .. .. .. .. ..@ area   : num 0.000823
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:133, 1:2] 19.1 19.1 19.1 19.1 19.1 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19.1 47.5
  .. .. .. ..@ ID       : chr "19"
  .. .. .. ..@ area     : num 0.000823
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19.1 47.5
  .. .. .. .. .. .. ..@ area   : num 0.000284
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:140, 1:2] 19.1 19.1 19.1 19.1 19.1 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19.1 47.5
  .. .. .. ..@ ID       : chr "20"
  .. .. .. ..@ area     : num 0.000284
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19.1 47.5
  .. .. .. .. .. .. ..@ area   : num 0.00025
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:112, 1:2] 19.1 19.1 19.1 19.1 19.1 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19.1 47.5
  .. .. .. ..@ ID       : chr "21"
  .. .. .. ..@ area     : num 0.00025
  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots
  .. .. .. ..@ Polygons :List of 1
  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. .. .. .. ..@ labpt  : num [1:2] 19.1 47.5
  .. .. .. .. .. .. ..@ area   : num 0.000314
  .. .. .. .. .. .. ..@ hole   : logi FALSE
  .. .. .. .. .. .. ..@ ringDir: int 1
  .. .. .. .. .. .. ..@ coords : num [1:93, 1:2] 19.1 19.1 19.1 19.1 19.1 ...
  .. .. .. ..@ plotOrder: int 1
  .. .. .. ..@ labpt    : num [1:2] 19.1 47.5
  .. .. .. ..@ ID       : chr "22"
  .. .. .. ..@ area     : num 0.000314
  ..@ plotOrder  : int [1:23] 11 9 3 10 4 16 2 7 15 18 ...
  ..@ bbox       : num [1:2, 1:2] 18.9 47.3 19.3 47.6
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:2] "x" "y"
  .. .. ..$ : chr [1:2] "min" "max"
  ..@ proj4string:Formal class 'CRS' [package "sp"] with 1 slot
  .. .. ..@ projargs: chr "+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +no_defs"

```

It contains the 23 districts of Budapest and some metadata. Now, get one of the districts (the 4th one of the list), where `bp` is the name of the variable and the `polygons` slot contains the polygon of the districts:

{% highlight r %}
str(bp@polygons[[4]])

{% endhighlight %}


# output:

```
Formal class 'Polygons' [package "sp"] with 5 slots
  ..@ Polygons :List of 1
  .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots
  .. .. .. ..@ labpt  : num [1:2] 19 47.5
  .. .. .. ..@ area   : num 0.00436
  .. .. .. ..@ hole   : logi FALSE
  .. .. .. ..@ ringDir: int 1
  .. .. .. ..@ coords : num [1:517, 1:2] 19 19 19 19 19 ...
  ..@ plotOrder: int 1
  ..@ labpt    : num [1:2] 19 47.5
  ..@ ID       : chr "3"
  ..@ area     : num 0.00436
```

After that, the `coords` can be get like this:

{% highlight r %}
bp@polygons[[4]]@Polygons[[1]]@coords

{% endhighlight %}

Is it also possible to plot only one disctrict:
{% highlight r %}
library(rgdal)
library(rgeos)
library(ggplot2)
 
# read the geojson file
bp <- readOGR("bp_districts.geojson", "OGRGeoJSON")

# turn the map into a data frame so ggplot2 can plot it
bp_map <- fortify(bp@polygons[[4]])
# plot it
plot = ggplot(data=bp_map, aes(map_id=id, x=long, y=lat)) + geom_map(map=bp_map, color="black", fill="white")

# then save to file
ggsave(plot, file = "output.png", type = "cairo-png")

{% endhighlight %}

![The output image]({{ site.baseurl }}/assets/bp_district_ii.png)


# References

[Rename a SpatialPolygon class object in R -- gis.stackexchange][gis-stackexchange]

[gis-stackexchange]: http://gis.stackexchange.com/questions/37503/rename-a-spatialpolygon-class-object-in-r
