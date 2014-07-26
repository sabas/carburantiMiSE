# elimina i distributori con coordinate messe fuori dall'Italia (o su Null Island)
cp db/scrape.spatialite db/scrape_notclean.spatialite
echo "SELECT * FROM distributori WHERE (lat=0 AND lon=0) OR (lon<6 OR lon>18.75 OR lat<35 OR lat>47.5) ;" | spatialite db/scrape_notclean.spatialite > db/outofbounds.txt
echo "DELETE FROM distributori WHERE (lat=0 AND lon=0) OR (lon<6 OR lon>18.75)  OR (lat<35 OR lat>47.5) ;" | spatialite db/scrape.spatialite


