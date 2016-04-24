---
layout: post
title:  "Plot geoJSON"
date:   2016-04-24 10:23:00 +0200
categories: r geojson ggplot2
---

[A previous post]({% post_url 2016-04-22-get-administrative-bounderies-from-osm %}) tells how I got the districts of Budapest in geoJSON format, but can be also found [directly here](/assets/bp_districts.geojson).

# R code to plot geoJSON

{% highlight r %}
library(rgdal)
library(rgeos)
library(ggplot2)
 
# read the geojson file
bp <- readOGR("bp_districts.geojson", "OGRGeoJSON")

# turn the map into a data frame so ggplot2 can plot it
bp_map <- fortify(bp)
# plot it
plot = ggplot(data=bp_map, aes(map_id=id, x=long, y=lat)) + geom_map(map=bp_map, color="black", fill="white")

# then save to file
ggsave(plot, file = "output.png", type = "cairo-png")

{% endhighlight %}

# Result

![The output image]({{ site.baseurl }}/assets/bp_districts.png)

# Resources
[GeoJSON Hexagonal “Statebins” in R][rblog-geojson]

[rblog-geojson]: http://www.r-bloggers.com/geojson-hexagonal-statebins-in-r/
