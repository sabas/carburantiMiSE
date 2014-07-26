#Per creare se non l'avete il template scrape_template_sl.sqlite eseguire nella dir scraper/db
#spatialite scrape_template_sl.spatialite < scrape_template.sql
echo "Copio db spaziale scrape_template_sl.sqlite spatialite in scrape.spatialite"
cp db/scrape_template.spatialite db/scrape.spatialite
echo "Start processing"
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


