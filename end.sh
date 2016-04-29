#!/bin/sh

#main command

#get core
PROCS=$(grep --count ^processor /proc/cpuinfo)
echo $PROCS > /var/lib/start/procs.txt

#get RAM and keep 3/4 for cache
RAM=$(grep 'MemTotal' /proc/meminfo | perl -pe "s/.*: (.+) .*/\1/")
CACHE=$(($RAM * 3 / 4000))
echo $CACHE > /var/lib/start/ram.txt

osm2pgsql --create --slim --cache $CACHE --number-processes $PROCS --flat-nodes flat-nodes --database gis --username osm --host pg --port 5432 /osm/import.osm.pbf

#command must be executed just once
touch initialized 
echo "touched the initialized file"

#inform renderd that osm2pgsql is finished
touch /var/lib/start/osm2pgsql-end
echo "osm2pgsql is finished"
