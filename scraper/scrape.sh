#!/bin/bash
for i in {1..20}
do
# echo $i
 sleep $[ ( $RANDOM % 10 )  + 1 ]s
 curl -o json/$i.json --data "region=$i" https://carburanti.mise.gov.it/OssPrezziSearch/ricerca/localita
done
echo "Start processing"
for i in {1..20}
do
 php scrape.php json/$i.json
done
