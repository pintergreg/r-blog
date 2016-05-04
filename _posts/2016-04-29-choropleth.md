---
layout: post
title:  "Choropleth"
date:   2016-04-29 16:45:00 +0200
categories: r geojson ggplot2 choropleth
---

Last time I managed to draw the districts of Budapest [using a GeoJSON]({{ site.baseurl }}{% post_url 2016-04-24-plot-geojson %}) [from OpenStreetMap]({{ site.baseurl }}{% post_url 2016-04-22-get-administrative-bounderies-from-osm %}). 

But it would be nice if the districts would be filled with color according to the population.
So I got the population data from the [Wikipedia](https://hu.wikipedia.org/wiki/Budapest_ker%C3%BCletei).

# Population data

First, I needed an id of the spatial data to attach the population data. One options was to use the osm_id from the geoJSON, and the second one was to add a new district id ("did") to the geoJSON. I chose the second one.

Lets create a data.frame for the population data. This district id is merely the number of the district from 1 to 23. Then, I created a vector where population data is in the order of the district numbers:

{% highlight r %}
population <- data.frame(
	"did" = c(1:23),
	"population" = c(24933, 89598, 128535, 101182, 26277, 38757, 54129, 76957, 59121, 78703, 152620, 58322, 120199, 124956, 80327, 72904, 87569, 101613, 60904, 65851, 76824, 54504, 22833)
)
{% endhighlight %}

With the first option using the osm id from the json:

{% highlight r %}
population <- data.frame(
	"osm_id" = c(221984, 221980, 221976, 367963, 1606103, 1606101, 1606102, 1606100, 1552462, 1552463, 221998, 221995, 1605916, 1606043, 1606009, 1552464, 1550599, 1550598, 1551290, 1551291, 215618, 215621),
	"population" = c(24933, 89598, 128535, 101182, 26277, 38757, 54129, 76957, 59121, 78703, 152620, 58322, 120199, 124956, 80327, 72904, 87569, 101613, 60904, 65851, 76824, 54504, 22833)
)
{% endhighlight %}

# Merging the the spatial and the population data

Though the geoJSON contains a lot of (meta)data, the `fortify` function removes everything that is unnecessary for the plotting. This is problem because I lost the ids (both osm_id and did). This snippet manages to keep them:

{% highlight r %}
# fortify with keeping metadata
bp <- readOGR("bp_districts.geojson", "OGRGeoJSON")
bp@data$id <- rownames(bp@data)
bp.df <- fortify(bp)
bp.df <- join(bp.df, bp@data, by="id")

# merge population data using district id (did)
bp.df <- merge(bp.df, population, by="did")
{% endhighlight %}

Using osm_id is analogous with this.

# Full code

{% highlight r %}
library(rgdal)
library(rgeos)
library(ggplot2)
library(plyr) 

# create data.frame for the population data
population<-data.frame(
	"did" = c(1:23),
	"population" = c(24933, 89598, 128535, 101182, 26277, 38757, 54129, 76957, 59121, 78703, 152620, 58322, 120199, 124956, 80327, 72904, 87569, 101613, 60904, 65851, 76824, 54504, 22833)
)

# read the geojson file
bp <- readOGR("bp_districts.geojson", "OGRGeoJSON")

# fortify with keeping metadata
bp@data$id <- rownames(bp@data)
bp.df     <- fortify(bp)
bp.df     <- join(bp.df, bp@data, by="id")

# merge population data using district id (did)
bp.df <- merge(bp.df, population, by="did")

# plot it
plot = ggplot(bp.df, aes(x=long, y=lat, group=group)) +
       geom_polygon(aes(fill=population)) + # to draw polygons 
       geom_path(color="black") # to draw boundaries

# then save to file
ggsave(plot, file = "output3.png",  width = 8, height = 7, type = "cairo-png")
{% endhighlight %}

# Result

![The output image]({{ site.baseurl }}/assets/bp_population.png)

# References

* [R ggplot2 merge with shapefile and csv data to fill polygons][fortify-keep-info]
* [A possibly simplier solution for keeping info at fortify-- untested][possibly-simple-solution]

[fortify-keep-info]: http://stackoverflow.com/questions/19791210/r-ggplot2-merge-with-shapefile-and-csv-data-to-fill-polygons
[possibly-simple-solution]: http://stackoverflow.com/a/33353561

# Other links

* [Create nice choropleth][nice-choropleth]
* [Static interactive maps][static-interactive-maps]
* [Introduction to Spatial Data and ggplot2][spatial-data-and-ggplot2]

[nice-choropleth]: http://www.r-bloggers.com/mapping-with-ggplot-create-a-nice-choropleth-map-in-r/
[static-interactive-maps]: http://www.r-bloggers.com/making-static-interactive-maps-with-ggvis-using-ggvis-maps-wshiny/
[spatial-data-and-ggplot2]: http://spatial.ly/2013/12/introduction-spatial-data-ggplot2/
