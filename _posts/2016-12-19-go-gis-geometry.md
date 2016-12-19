---
layout: post
title:  "GIS in Golang (part 1?)"
date:   2016-12-19 10:00:00 +0200
categories: go gis geometry
---

# GIS in Golang (part 1?)

There are some GIS related package in Go, [listed in GitHub](https://github.com/golang/go/wiki/Projects#gis) among other useful Go packages.

For now, I only needed the some geometry handling, which is provided by the [gogeos](https://github.com/paulsmith/gogeos) package. It can work with Well-known text format.

[From Wiki](https://en.wikipedia.org/wiki/Well-known_text): "Well-known text (WKT) is a text markup language for representing vector geometry objects on a map, spatial reference systems of spatial objects and transformations between spatial reference systems."

## WKT examples from Wiki

- to define a point: `POINT (30 10)` ![Point in WKT, image is from Wikipedia](https://upload.wikimedia.org/wikipedia/commons/thumb/c/c2/SFA_Point.svg/51px-SFA_Point.svg.png) 
- to define a polygon: `POLYGON ((30 10, 40 40, 20 40, 10 20, 30 10))` ![Polygon in WKT, image is from Wikipedia](https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/SFA_Polygon.svg/51px-SFA_Polygon.svg.png)

## define some test data

```
POINT (1 1)
POINT (1.5 2)
POINT (2.5 1)
POLYGON ((0 0, 0 2, 2 2, 2 0, 0 0))
```

![Test data]({{ site.baseurl }}/assets/go_gis/go_gis_v2.svg)

### usage in `gogeos`

``` go
var p1 = geos.Must(geos.FromWKT("POINT (1 1)"))
var p2 = geos.Must(geos.FromWKT("POINT (1.5 2)"))
var p3 = geos.Must(geos.FromWKT("POINT (2.5 1)"))
var poly = geos.Must(geos.FromWKT("POLYGON ((0 0, 0 2, 2 2, 2 0, 0 0))"))
```

### point - polygon intersection checking

Geometries has an `Intersencts` method that returns a `bool` and an *error* value.

``` go
var b, err = poly.Intersects(p1)
```

## Full code

As the `Intersencts` method returns two value I used the [Must template](https://golang.org/pkg/text/template/#Must) for "error checking" that returns the boolean value if no error is happened. N.B. `geos` has its own for Geometry parsing from WKT.

``` go
package main

import (
	"fmt"

	"github.com/paulsmith/gogeos/geos"
)

func main() {
	var p1 = geos.Must(geos.FromWKT("POINT (1 1)"))
	var p2 = geos.Must(geos.FromWKT("POINT (1.5 2)"))
	var p3 = geos.Must(geos.FromWKT("POINT (2.5 1)"))
	var poly = geos.Must(geos.FromWKT("POLYGON ((0 0, 0 2, 2 2, 2 0, 0 0))"))

	var r, _ = poly.Intersects(p1)
	fmt.Println(r)

	fmt.Println(Must(poly.Intersects(p1)))
	fmt.Println(Must(poly.Intersects(p2)))
	fmt.Println(Must(poly.Intersects(p3)))
}

func Must(i bool, err error) bool {
	if err != nil {
		panic(err)
	}
	return i
}
```

## Miscellaneous

- [Low-level 2D drawing library in Go](https://github.com/llgcode/draw2d)
	- [Plotting library based on it](https://github.com/gonum/plot)
- [Go package to easy and quick create datastructure which can be serialized to geojson format](https://github.com/kpawlik/geojson)
- [Implements a Polygon type, which contains a slice of Lat/Lng points and some useful utilities to operate on that data.](https://github.com/Ganners/gis-polygon)
	- seems not so full solution