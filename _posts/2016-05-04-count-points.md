---
layout: post
title:  "Count points over polygons"
date:   2016-05-04 21:14:00 +0200
categories: r geojson choropleth
---

After [creating choropleth from the population]({{ site.baseurl }}{% post_url 2016-04-29-choropleth %}), now I wanted to color the polygons (now distrits) according to the number of the spatial points over them.

First I generated some (500) random points over Budapest with some random values (but this was not used at this time).

{% highlight r %}
data <- data.frame(
	"lon" = runif(500, 18.95, 19.3),
	"lat" = runif(500, 47.35, 47.6),
	"val" = sample(1:10, 500, replace=T) # replace=T means that repeats are allowed
)
{% endhighlight %}

The I had to convert this `data.frame` into a SpatialPointsDataFrame obejct.

{% highlight r %}
points <- data
coordinates(points) <- ~lon+lat
{% endhighlight %}

For the counting I used the `poly.counts` function of the [GISTools package](https://cran.r-project.org/web/packages/GISTools/). And added counts to the data slot of the read dataset with the name `counts` and made the choropleth.

{% highlight r %}
bp@data['counts'] <- poly.counts(points, bp)
{% endhighlight %}

# Full code

{% highlight r %}
library(rgdal)
library(rgeos)
library(ggplot2)
library(plyr)
library(GISTools)

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

# counts the number of the points in each polygon (from GISTools package) and add to the dataset
bp@data['counts'] <- poly.counts(points, bp)

# fortify with keeping metadata
bp@data$id <- rownames(bp@data)
bp.df     <- fortify(bp)
bp.df     <- join(bp.df, bp@data, by="id")

# plot it
plot = ggplot(bp.df, aes(x=long, y=lat, group=group)) +
       geom_polygon(aes(fill=counts)) + # to draw polygons 
       geom_path(color="black") # to draw boundaries

# as grouping is used for the geojson plotting, group parameter is necessary for points plotting as well
plot = plot + geom_point(data = data, aes(x = lon, y = lat, group = 42), color="red")

# then save to file
ggsave(plot, file = "output4.png",  width = 8, height = 7, type = "cairo-png")

{% endhighlight %}

# Result

![The output image]({{ site.baseurl }}/assets/bp_random_points_count.png)

# Resources
[Convert data.frame to SpatialPointsDataFrame][spdataframe]

[spdataframe]: http://stackoverflow.com/questions/32583606/create-spatialpointsdataframe
