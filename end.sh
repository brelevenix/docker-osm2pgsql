#!/bin/sh

#main command
osm2pgsql --create --slim --cache 6000 --number-processes 4 --database gis --username osm --host pg --port 5432 /osm/import.osm.pbf

#command must be executed just once
touch initialized 
echo "touched the initialized file"

#inform renderd that osm2pgsql is finished
touch /var/lib/start/osm2pgsql-end
echo "osm2pgsql is finished"
