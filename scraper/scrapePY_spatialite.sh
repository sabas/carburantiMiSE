#Per creare se non l'avete il template scrape_template_sl.sqlite eseguire nella dir scraper/db
#spatialite scrape_template_sl.spatialite < scrape_template.sql
echo "Copio db spaziale scrape_template_sl.sqlite spatialite in scrape.spatialite"
cp db/scrape_template.spatialite db/scrape.spatialite
echo "Start processing"
for i in {1..20}
do
 echo "Processing file $i"
 python scrape.py json/$i.json
done
echo "Start processing"
echo "SELECT AddGeometryColumn('distributori' , 'the_geom', 4326, 'POINT', 'XY');" | spatialite db/scrape.spatialite
echo "UPDATE distributori SET the_geom=MakePoint(lon,lat, 4326);" | spatialite db/scrape.spatialite
