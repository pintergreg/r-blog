#!/usr/bin/ruby
require 'json'

if ARGV.length < 1 then
	STDERR.puts "Specify a geoJSON to work with! ×_×"
	exit
else
	file = File.read(ARGV[0])
	data = JSON.parse(file)
end

r = Hash.new
r["type"] = "FeatureCollection"
r["crs"] = {"type" => "name", "properties" => {"name" => "urn:ogc:def:crs:OGC:1.3:CRS84"}}
r["features"] = Array.new

k = 0
for squares in data["coordinates"] do
	for square in squares do
		feature = Hash.new
		feature["type"] = "Feature"
		feature["properties"] = {"id" => k}
		feature["geometry"] = Hash.new
		feature["geometry"]["type"] = "MultiPolygon"
		feature["geometry"]["coordinates"] = Array.new.push Array.new.push Array.new
		for i in square do
			feature["geometry"]["coordinates"][0][0].push [i[0],i[1]]
		end
		k += 1
		r["features"].push feature
	end
end

puts r.to_json
