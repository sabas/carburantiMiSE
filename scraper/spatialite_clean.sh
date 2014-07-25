# elimina i distributori con coordinate messe fuori dall'Italia (o su Null Island)
#echo "select * from distributori where (lat=0 and lon=0) or (lon<6 or lon>18.75 or lat<35 or lat>47.5) ;" | spatialite db/scrape.spatialite
echo "DELETE FROM distributori WHERE (lat=0 AND lon=0) OR (lon<6 OR lon>18.75)  OR (lat<35 or lat>47.5) ;" | spatialite db/scrape.spatialite
