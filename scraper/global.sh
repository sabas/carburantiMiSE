#!/bin/bash

#sezione download
R=1
done=0
retry=0
while [ $done == 0 ]
do
    if [ $R == 20 ];
    then
        done=1
    fi
    echo "$R"
    sleep 2s
    curl -o "json/$R.json" --data "region=$R" https://carburanti.mise.gov.it/OssPrezziSearch/ricerca/localita
    size=$( wc -c "json/$R.json" | awk '{print $1}' )
    if [ "$size" -lt 100 ];
    then
        ((retry++))
        ((R--))
    fi
    if [ "$retry" -gt 3 ];
    then
        exit -1
    fi 
    (( R++ ))
done

#scrape normale
echo "Start processing data"
for i in {1..20}
do
 python scrape.py json/$i.json db/scrape.sqlite
done

#scrape spaziale
cp db/scrape_template.spatialite db/scrape.spatialite
echo "Start processing spatialite"
for i in {1..20}
do
 echo "Processing file $i"
 python scrape.py json/$i.json db/scrape.spatialite
done
echo "Start processing"
echo "SELECT AddGeometryColumn('distributori' , 'the_geom', 4326, 'POINT', 'XY');" | spatialite db/scrape.spatialite
echo "UPDATE distributori SET the_geom=MakePoint(lon,lat, 4326);" | spatialite db/scrape.spatialite

# elimina i distributori con coordinate messe fuori dall'Italia (o su Null Island)
cp db/scrape.spatialite db/scrape_notclean.spatialite
echo "SELECT * FROM distributori WHERE (lat=0 AND lon=0) OR (lon<6 OR lon>18.75 OR lat<35 OR lat>47.5) ;" | spatialite db/scrape_notclean.spatialite > db/outofbounds.txt
echo "DELETE FROM distributori WHERE (lat=0 AND lon=0) OR (lon<6 OR lon>18.75)  OR (lat<35 OR lat>47.5) ;" | spatialite db/scrape.spatialite

# generazione TSV
sqlite3 db/scrape.sqlite < distributori.sql
sqlite3 db/scrape.sqlite < prezzi.sql

