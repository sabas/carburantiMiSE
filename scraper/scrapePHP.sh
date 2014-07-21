echo "Start processing"
for i in {1..20}
do
 php scrape.php json/$i.json
done
