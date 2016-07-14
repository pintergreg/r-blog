---
layout: post
title:  "Choropleth from voronoi"
date:   2016-07-14 16:55:00 +0200
categories: choropleth voronoi r ggplot2
---

[In a post earlier]({{ site.baseurl }}{% post_url 2016-04-29-choropleth %}), I used a GeoJSON of the districts of Budapest for creating choropleth. Now, I use a voronoi diagram for choropleth.

First I generated some (100) random points over Budapest with some random values and every point got an id.

{% highlight r %}
data <- data.frame(
	"id"  = 1:100,
	"lon" = runif(100, 18.95, 19.3),
	"lat" = runif(100, 47.35, 47.6),
	"val" = sample(1:10, 100, replace=T) # replace=T means that repeats are allowed
)
{% endhighlight %}

Then calculate voronoi with the `deldir` package.

{% highlight r %}
voronoi <- deldir(data$lon, data$lat)
{% endhighlight %}

Create SpatialPointsDataFrame from the DataFrame containing the sample points using `rgdal` package.

{% highlight r %}
coords <- data
coordinates(coords) <- ~lon+lat
{% endhighlight %}

To use the same method for plotting as before, the data structure of the voronoi diagram has to be converted to SpatialPolygonsDataFrame. For this step I use Carson Farmer's conversion code[[1]][carson], that can be also found [directly here]({{ site.baseurl }}/assets/voronoipolygons.R).

{% highlight r %}
vp <- voronoipolygons(coords)
{% endhighlight %}

Then plot it. This code fragment is based on [[2]][voronoi_with_ggplot]

{% highlight r %}
plot <- ggplot(data=data, aes(x=lon,y=lat)) +
  # plot the voronoi lines
  geom_segment(
    aes(x = x1, y = y1, xend = x2, yend = y2),
    size = 1,
    data = voronoi$dirsgs,
    linetype = 1,
    color= "#FFB958") + 
  # plot the points
  geom_point(
    fill=rgb(70,130,180,255,maxColorValue=255),
    pch=21,
    size = 1,
    color="#333333")
    
# then save to file
ggsave(plot, file = "output_partial.png",  width = 8, height = 7, type = "cairo-png")
{% endhighlight %}

# Partial result

![The output image]({{ site.baseurl }}/assets/voronoi.png)

That is just a plotted Voronoi diagram, let's color it!
First convert the SpatialPolygonsDataFrame to DataFrame with `fortify` and keeping metadata.

{% highlight r %}
vp@data$id <- rownames(vp@data)
vp.df <- fortify(vp)
vp.df <- join(vp.df, vp@data, by="id")
{% endhighlight %}

Now merge random `val` data using the id column.

{% highlight r %}
vp.df <- join(vp.df, data[,c(1,4)], by="id")
{% endhighlight %}

And finally plot it!

{% highlight r %}
plot <- ggplot(vp.df, aes(x=long, y=lat, group=group)) +
		# to draw polygons 
        geom_polygon(aes(fill=val)) + 
        # color the polygons dynamically with the color palette from green (smallest) to red (biggest) via yellow
        scale_fill_distiller(name="values", palette = "RdYlGn") +
        # to draw boundaries
        geom_path(color="black")

# then save to file
ggsave(plot, file = "output.png",  width = 8, height = 7, type = "cairo-png")
{% endhighlight %}

# Result

![The output image]({{ site.baseurl }}/assets/voronoi_choropleth.png)

# Full code

{% highlight r %}
library(deldir)
library(ggplot2)
library(rgdal)
# from http://carsonfarmer.com/2009/09/voronoi-polygons-with-r/
source(file="voronoipolygons.R")
library(plyr)

# generate some test data
data <- data.frame(
	"id"  = 1:100,
	"lon" = runif(100, 18.95, 19.3),
	"lat" = runif(100, 47.35, 47.6),
	"val" = sample(1:10, 100, replace=T) # replace=T means that repeats are allowed
)

# generate voronoi
voronoi <- deldir(data$lon, data$lat)

# create SpatialPointsDataFrame from the data
coords <- data
coordinates(coords) <- ~lon+lat

# convert voronoi
vp <- voronoipolygons(coords)

plot <- ggplot(data=data, aes(x=lon,y=lat)) +
	# plot the voronoi lines
	geom_segment(
		aes(x = x1, y = y1, xend = x2, yend = y2),
		size = 1,
		data = voronoi$dirsgs,
		linetype = 1,
		color= "#FFB958") + 
	# plot the points
	geom_point(
		fill=rgb(70,130,180,255,maxColorValue=255),
		pch=21,
		size = 1,
		color="#333333")

# then save to file
ggsave(plot, file = "output_partial.png",  width = 8, height = 7, type = "cairo-png")

# fortify with keeping metadata
vp@data$id <- rownames(vp@data)
vp.df <- fortify(vp)
vp.df <- join(vp.df, vp@data, by="id")

# add values from the sample data to the voronoi data frame
vp.df <- join(vp.df, data[,c(1,4)], by="id")

# plot it
plot <- ggplot(vp.df, aes(x=long, y=lat, group=group)) +
		# to draw polygons 
        geom_polygon(aes(fill=val)) + 
        # color the polygons dynamically with the color palette from green (smallest) to red (biggest) via yellow
        scale_fill_distiller(name="values", palette = "RdYlGn") +
        # to draw boundaries
        geom_path(color="black") 

# then save to file
ggsave(plot, file = "output.png",  width = 8, height = 7, type = "cairo-png")
{% endhighlight %}

# References

1. [Carson Farmer's code  fot converting Voronoi diagram to SpatialPolygonsDataFrame][carson]
2. [Creating Voronoi Diagrams with ggplot][voronoi_with_ggplot]

## Other

* [http://gis.stackexchange.com/questions/190917/r-voronoi-tesselation-from-long-lat-data](http://gis.stackexchange.com/questions/190917/r-voronoi-tesselation-from-long-lat-data)
* [https://ropensci.org/tutorials/geojsonio_tutorial.html](https://ropensci.org/tutorials/geojsonio_tutorial.html)


[carson]: http://carsonfarmer.com/2009/09/voronoi-polygons-with-r/
[voronoi_with_ggplot]: http://letstalkdata.com/2014/05/creating-voronoi-diagrams-with-ggplot/
