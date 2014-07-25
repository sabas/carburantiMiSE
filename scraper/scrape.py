#!/usr/bin/python

import sys
import json
import sqlite3
import re

with open(sys.argv[1]) as file:
	data=json.load(file)
	data=data['array']
	dbcon = sqlite3.connect('db/scrape.sqlite')
	dbcon.isolation_level = None
	cursor = dbcon.cursor()
	cursor.execute('begin')
	regex = re.compile(".*#(.*)\((.*)\)")
	for d in data:
		addr=d['addr']
		r = regex.search(addr)
		if r == None:
			grp= ['','']
		else:
			grp=r.groups()
		cursor.execute('''INSERT OR REPLACE INTO `distributori`(`id`, `name`, `bnd`, `lat`, `lon`, `addr`, `comune`, `provincia`) 
                  VALUES (:id,:name,:bnd,:lat,:lon,:addr,:comune,:provincia)''',
                  {'id':d['id'],'name':d['name'],'bnd':d['bnd'],'lat':d['lat'],'lon':d['lon'],'addr':d['addr'],'comune':grp[0].title(),'provincia':grp[1]})
                
                carb=d['carburanti']
                
                for c in carb:
 			cursor.execute('''INSERT OR REPLACE INTO `prezzi`(`id_d`, `dIns`, `carb`, `isSelf`, `prezzo`)  
                	  VALUES (:id_d,:dIns,:carb,:isSelf,:prezzo)''',
                	  {'id_d':d['id'],'dIns':d['dIns'],'carb':c['carb'],'isSelf':c['isSelf'],'prezzo':c['prezzo']})               	

	cursor.execute('end')
	dbcon.commit()
	dbcon.close()
