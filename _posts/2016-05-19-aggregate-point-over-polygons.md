---
layout: post
title:  "Aggregate points over polygons by some value"
date:   2016-05-19 11:55:00 +0200
categories: r 
---

[In a post earlier]({{ site.baseurl }}{% post_url 2016-05-04-count-points %}) points over polygons were counted and the polygons were colored according to that count. Next I want to aggregate points by some property value grouped by the polygons.

# Preparations

First, read the geoJSON and create some random points over Budapest with random values from 1 to 10, like before.

{% highlight r %}
library(rgdal)
library(rgeos)
library(ggplot2)

# read the geojson file
bp <- readOGR("bp_districts.geojson", "OGRGeoJSON")

# generate random points to the map with some value from 1 to 10
data <- data.frame(
	"lon" = runif(500, 18.95, 19.3),
	"lat" = runif(500, 47.35, 47.6),
	"val" = sample(1:10, 500, replace=T) # replace=T means that repeats are allowed
)

# create SpatialPointsDataFrame from a data.frame
points <- data
coordinates(points) <- ~lon+lat
{% endhighlight %}

# Subsetting

Then, plot only that points, that are over Budapest. [rgeos::gIntersects](http://www.inside-r.org/packages/cran/rgeos/docs/gIntersection) returns a vector with boolean values: `TRUE` if in the polygon, `FALSE` if not, which is perfect for subsetting. 

{% highlight r %}
# using rgeos::gIntersects to subset points only to those that are over Budapest
points.over.bp <- points[apply(gIntersects(points, bp, byid=TRUE), 2, any),]
{% endhighlight %}

# Plot that points!

{% highlight r %}
# transform the geoJSON into a data frame so ggplot2 can plot it
bp.df <- fortify(bp)

# plot Budapest's districts
plot = ggplot(bp.df, aes(x=long, y=lat, group=group)) +
       geom_polygon(fill="white") + # to draw polygons 
       geom_path(color="black") # to draw boundaries

# plot points
plot = plot + geom_point(data = as.data.frame(points.over.bp), aes(x = lon, y = lat, group = 42), color="red")

# then save to file
ggsave(plot, file = "output.png",  width = 8, height = 7, type = "cairo-png")
{% endhighlight %}

# Result

![The output image]({{ site.baseurl }}/assets/points_over_bp.png)

# Match points to districts

Next step is to determine a point to which district belongs. So, I want a column in the points  `data.frame` with the district ids. [`sp::over`](http://www.inside-r.org/packages/cran/sp/docs/aggregate.Spatial) can do the first part. The geoJSON I use still contains my own district id (`did`) metadata. [See this post]({{ site.baseurl }}{% post_url 2016-04-22-get-administrative-bounderies-from-osm %})!

{% highlight r %}
# points has to use the same projection as my geo data from geoJSON
sp::proj4string(points) <- sp::proj4string(bp)

# match points to districts
rslt <- sp::over(points, bp)

# add the district identifiers to a new column, called `dist` to the original data data.frame
data["dist"] <- rslt[,2]
{% endhighlight %}

Check the data `data.frame`!
{% highlight r %}
data[1:10,]
{% endhighlight %}

The first ten row:

```
        lon      lat val dist
1  19.16696 47.35147   5 <NA>
2  18.95994 47.36791   2 <NA>
3  18.95671 47.37090   6 <NA>
4  19.00049 47.35162   1 <NA>
5  19.12143 47.56961   6   15
6  19.25754 47.39402   6 <NA>
7  19.04310 47.59562   3    3
8  19.00483 47.43743   3   11
9  19.18552 47.56312   1 <NA>
10 19.21871 47.59217   6 <NA>
```

Some points are in districts some are not, in the latter case the NA value is present.

# Aggregate the points by the value

Finally, group the points by the districts and sum the values.

{% highlight r %}
aggregate(data$val ~ data$dist, data, sum)
{% endhighlight %}

And the output:

```
   data$dist data$val
1          1       27
2         10      110
3         11      135
4         12      102
5         13       60
6         14      104
7         15      126
8         16      104
9         17      221
10        18      117
11        19       25
12         2      128
13        20       30
14        21       57
15        22      147
16        23       64
17         3      155
18         4       71
19         5        1
20         7        7
21         8       53
22         9       39
```

N.B.: districts 6 has no points at this time (it is pretty small)

# References

* [Learned using gIntersects from this][gintersects]
* [Learned using sp::over and sp::proj4string from this][determine-what-geojson-polygon-a-point-is-in]
* [Leaned using aggregate from this][data-frame-group-by-column]

[gintersects]: http://gis.stackexchange.com/questions/63793/how-to-overlay-a-polygon-over-spatialpointsdataframe-and-preserving-the-spdf-dat
[determine-what-geojson-polygon-a-point-is-in]: http://stackoverflow.com/questions/34077753/determine-what-geojson-polygon-a-point-is-in
[data-frame-group-by-column]: http://stackoverflow.com/questions/18799901/data-frame-group-by-column
