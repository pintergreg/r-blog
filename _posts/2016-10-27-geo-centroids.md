---
layout: post
title:  "Calculate center points of polygons"
date:   2016-10-27 15:52:00 +0200
categories: centroid r ggplot2
---

Let's calculate the center points of some polygon, namely the centroids of the districts of Budapest. This is a pretty easy task with the `gCentroid` function fo the `rgeos` package. The used GeoJSON is [the same]({{ site.baseurl }}/assets/bp_districts.geojson).

{% highlight r %}
library(rgdal)
library(rgeos)
library(ggplot2)

# read the geojson file
bp <- readOGR("bp_districts.geojson", "OGRGeoJSON")

# calculate the center points of the polygons (districts)
centroids = gCentroid(bp, byid=TRUE)

# turn the map into a data frame so ggplot2 can plot it
bp.df <- fortify(bp)

# plot it
plot = ggplot(bp.df, aes(x=long, y=lat, group=group)) +
       geom_polygon(fill="white") + # to draw polygons
       geom_path(color="black") + # to draw boundaries
       geom_point(data = as.data.frame(centroids), aes(x = x, y = y, group = 42), color="red") # draw center points

# then save to file
ggsave(plot, file = "output.png", type = "cairo-png")

{% endhighlight %}

# Result 

And the result is...

![The output image]({{ site.baseurl }}/assets/district_centroids.png)

# Resources
[gCentroid][gcentroid]

[gcentroid]: https://www.rdocumentation.org/packages/rgeos/versions/0.3-20/topics/gCentroid
