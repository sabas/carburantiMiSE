echo "Start processing"
for i in {1..20}
do
 python scrape.py json/$i.json db/scrape.sqlite
done
