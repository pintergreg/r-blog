---
layout: post
titlle: "Generate grid with spatialite"
date: 2017-10-18 10:56:00 +0200
categories: spatialite grid
---

I have a GeoJSON with the border of Budapest and another with the district borders. I used QGIS to convert them to ERSI shapefile, the projection is 4326 (WSG84).

1. Load the districts intto the `budapest_districts` table

``` sql
.loadshp bp_districts budapest_districts UTF-8 4326
```

2. Add a column containing the [EPSG:23700](https://epsg.io/23700) geometry called `geom_23700`.

``` sql
ALTER TABLE 'budapest_districts' ADD COLUMN geom_23700 BLOB;
UPDATE 'budapest_districts' SET geom_23700 = TRANSFORM(Geometry, 23700);
```

3. Now, that I have a geomerty which unit is metre, I can easily define grids specified with metric dimensions. For example a 200m × 200m square grid over the 17th district.

``` sql
SELECT ST_SquareGrid(geom_23700, 200) FROM budapest_districts where did=17;
```

## Using the same method to generate a hexagonal grid over the whole city

``` sql
.loadshp budapest budapest UTF-8 4326
ALTER TABLE 'budapest' ADD COLUMN geom_23700 BLOB;
UPDATE 'budapest' SET geom_23700 = TRANSFORM(Geometry, 23700);
SELECT ST_HexagonalGrid(geom_23700, 200) FROM budapest;
```

## Or generate grid without the new column

Transform the geometry on the fly:

``` sql
SELECT ST_HexagonalGrid(Transform(geometry, 23700), 200) FROM budapest;
```

Create grid based on EPSG:23700 metric from an EPSG:4326 geometry and return the grid geometry in EPSG:4326

``` sql
SELECT Transform(ST_HexagonalGrid(Transform(geometry, 23700), 200), 4326) FROM budapest;
```

Return it as GeoJSON (N.B.: it will return a huge string):

``` sql
SELECT AsGeoJSON(Transform(ST_HexagonalGrid(Transform(geometry, 23700), 200), 4326)) FROM budapest;
```

## Reference

- https://pvanb.wordpress.com/2012/07/04/reprojecting-your-layer-with-spatialite/
- https://www.gaia-gis.it/fossil/libspatialite/wiki?name=tesselations-4.0
- https://www.gaia-gis.it/spatialite-2.0/spatialite2_sql.html