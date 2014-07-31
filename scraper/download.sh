#!/bin/bash
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