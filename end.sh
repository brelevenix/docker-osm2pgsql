#!/bin/sh

#main command

#get core
CORES=$(grep 'cpu cores' /proc/cpuinfo | perl -pe "s/.*: //")

#get RAM and keep 3/4 for cache
RAM=$(grep 'MemTotal' /proc/meminfo | perl -pe "s/.*: (.+) .*/\1/")
CACHE=$(($RAM * 3 / 4))

osm2pgsql --create --slim --cache $RAM --number-processes $CORES --database gis --username osm --host pg --flat-nodes node.cache --port 5432 /osm/import.osm.pbf

#command must be executed just once
touch initialized 
echo "touched the initialized file"

#inform renderd that osm2pgsql is finished
touch /var/lib/start/osm2pgsql-end
echo "osm2pgsql is finished"
