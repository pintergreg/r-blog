---
layout: post
title:  "Leaflet choropleth"
date:   2017-04-20 16:09:00 +0200
categories: leaflet choropleth gis javascript
demo: leaflet_choropleth/leaflet.html
---

[Leaflet](http://leafletjs.com/) is an "an open-source JavaScript library
for mobile-friendly interactive maps", that can [plot GeoJSONs](http://leafletjs.com/examples/geojson/) onto an OSM map. Of course using this for creating choropleth is also [possible](http://leafletjs.com/examples/choropleth/), but I lack the automatic value scaling. I was not the only one, so a [very nice extension was created](https://github.com/timwis/leaflet-choropleth) for the task.

It has a [basic example](https://github.com/timwis/leaflet-choropleth/blob/gh-pages/examples/basic/demo.js), [one for legends](https://github.com/timwis/leaflet-choropleth/blob/gh-pages/examples/legend/demo.js) and [another one for data merging](https://github.com/timwis/leaflet-choropleth/blob/gh-pages/examples/fetch_join/demo.js), but I put this together.

First load the necessary libraries:

``` html
    <link rel="stylesheet" href="leaflet.css"/>
    <script src="leaflet.js"></script>
    <script src="jquery.min.js"></script>
    <script src="choropleth.js"></script>
```

Set the view, choose an [image tile provider](http://wiki.openstreetmap.org/wiki/Tile_servers), and add addribution data
``` javascript
var map = L.map("map").setView([47.5, 19.15], 11);

L.tileLayer("http://tile.stamen.com/toner/{z}/{x}/{y}.png", { // image provider
    maxZoom: 18,
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
        '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
        'Imagery © <a href="maps.stamen.com">stamen</a>',
    id: 'mapbox.light'
}).addTo(map);
```

Fetch GeoJSON and the data and merge them

``` javascript
$.when($.getJSON("bp_grid_1000.geo.json"), $.getJSON("data.json")).done(function (responseGeojson, responseData) {
    var data = responseData[0]
    var grid = responseGeojson[0]
    
    for (var i = 0; i < grid["features"].length; i++){
        cell_id = grid["features"][i]["properties"]["id"];
        if (data[cell_id]){
            grid["features"][i]["properties"]["value"] = data[cell_id];
        } else {
            grid["features"][i]["properties"]["value"] = 0;
        }
    }
```

Add the choropleth with automatic scaling into 7 categories

``` javascript
var choroplethLayer = L.choropleth(grid, {
    valueProperty: "value", // which property in the features to use
    scale: ["white", "yellow", "red", "black"], // chroma.js scale - include as many as you like
    steps: 7, // number of breaks or steps in range
    mode: "q", // q for quantile, e for equidistant, k for k-means
    style: {
        color: "#ffffff", // border color
        weight: 1,
        fillOpacity: 0.85
    },
    onEachFeature: function (feature, layer) {
        layer.bindPopup("Cell " + feature.properties.id + "<br>" + "value: " + feature.properties.value)
    }
}).addTo(map)
```

Add legend (don't forget to add the CSS from index.html), yeah that legend formatting should be much cleaner...

``` javascript
var legend = L.control({ position: "bottomright" })
legend.onAdd = function (map) {
    var div = L.DomUtil.create("div", "info legend")
    var limits = choroplethLayer.options.limits
    var colors = choroplethLayer.options.colors
    var labels = []

    div.innerHTML = "Legend";

    limits.forEach(function (limit, index) {
        var prev = index == 0 ? 0 : index - 1;
        labels.push('<li style="list-style-type: none;"><span style="background-color: ' + colors[index] + '; width: 1em; height: 1em; display:inline-block; margin-right: 1ex; border: 0.5px solid #444; padding: 1px;"></span><span style="vertical-align: top;">' + limits[prev].toFixed(6) + ' - ' +limit.toFixed(6) + '</span></li>')
    })

    div.innerHTML += '<ul style="padding: 2px; margin: 1em 0 0 0">' + labels.join("") + '</ul>'
    return div
}
legend.addTo(map)
})
```

## Test data generation

``` python
import json
import random
with open("data.json", "w") as file:
    print(str(json.dumps({str(i): random.random() for i in range(607)})), file=file)
```

## Demo

{% include {{ page.demo }} %}


## Misc

Before realizing that Leaflet is exactly what I need I was playing with [DataMaps](http://datamaps.github.io/), which is build upon [D3.js](https://d3js.org/). It uses TopoJSON (?) by default and a [projection system](https://github.com/d3/d3-geo/blob/master/README.md#projections) that allows one to create awesome interactive maps, but not really in that fashion I wanted.

I have my geodata in GeoJSON format, so I converted it to TopoJSON with a nice [online tool for converting between GeoJSON and TopoJSON](http://jeffpaine.github.io/geojson-topojson/).

A simple, "living" example can be found [here](http://jsbin.com/pufejajama/edit?html,output).

### A few tutorial about D3 mapping

- Mike Foster's D3 Workshop material about [*Mapping Data with D3*](http://duspviz.mit.edu/d3-workshop/mapping-data-with-d3/) with simple examples.
- [Another post](http://www.tnoda.com/blog/2013-12-07) about using D3 for interactive maps.

