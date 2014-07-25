carburantiMiSE
==============

Interrogazione dell'[Osservatorio Carburanti del Ministero dello Sviluppo Economico](https://carburanti.mise.gov.it/OssPrezziSearch/ricerca/).

Live su http://toolserver.openstreetmap.it/carburantiMiSE/

Icone provenienti dal sito dell'Osservatorio.

Autori
------
- Stefano Sabatini
- Marco Braida
- Fabrizio Tambussa

Contenuto
---------

distributori.html sfrutta l'endpoint "position" per trovare i distributori nell'intorno di una posizione (con la geolocalizzazione si può cercare nella posizione attuale; altrimenti facendo doppio click sulla mappa si interroga tale posizione).

scraper: archivia tutti i dati dall'API in un certo punto temporale. C'è sia una versione PHP che una versione Python per la creazione del database, in più un terzo script prepara il database in versione Spatialite.

Note
-----

Regioni:
```
2: Abruzzo
3: Basilicata
7: Calabria
8: Campania
14: Emilia Romagna
15: Friuli Venezia Giulia
9: Lazio
18: Liguria
19: Lombardia
1: Marche
4: Molise
13: Piemonte
6: Puglia
10: Sardegna
11: Sicilia
12: Toscana
5: Trentino Alto Adige
20: Umbria
16: Valle d&#39;Aosta
17: Veneto
```

Carburanti
```
1-x: Benzina
1-1: Benzina (Self)
1-0: Benzina (Servito)
2-x: Gasolio
2-1: Gasolio (Self)
2-0: Gasolio (Servito)
3-x: Metano
4-x: GPL
```

Province nella regione
```
 curl --data "regioneId=18" https://carburanti.mise.gov.it/OssPrezziSearch/ricerca/province
```

Comuni nella regione
```
 curl --data "provinciaId=GE" https://carburanti.mise.gov.it/OssPrezziSearch/ricerca/comuni
```

Interrogazione località
```
 curl --data "region=18&province=GE&town=Cicagna&carb=" https://carburanti.mise.gov.it/OssPrezziSearch/ricerca/localita
```

Esempio interrogazione per località, parametri passati via POST:
```
region:18
province:GE
town:Arenzano
carb:2-x
ordPrice:desc
```

Ricerca per area o per punto (area max 100kmq o 10km2 di raggio)
```
 curl --data "pointsListStr=39.919216100221554-8.567276000976562#" https://carburanti.mise.gov.it/OssPrezziSearch/ricerca/position
```

Formato poligono lat-lon#[...]
