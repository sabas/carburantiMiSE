<?php
if(php_sapi_name()=="cli")
{
    $regione=$argv[1];
}

$json=json_decode(file_get_contents($regione),true);
$arr=$json['array'];

echo "Processing ".$regione."\n";

try{
    $file_db = new PDO('sqlite:db/scrape.sqlite');
    $file_db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $dis_sql='INSERT OR REPLACE INTO `distributori`(`id`, `name`, `bnd`, `lat`, `lon`, `addr`, `comune`, `provincia`) ';
    $dis_sql.='VALUES (:id,:name,:bnd,:lat,:lon,:addr,:comune,:provincia)';
    $dis_sth   = $file_db->prepare($dis_sql);

    $carb_sql='INSERT OR REPLACE INTO `prezzi`(`id_d`, `dIns`, `carb`, `isSelf`, `prezzo`) ';
    $carb_sql.='VALUES (:id_d,:dIns,:carb,:isSelf,:prezzo)';
    $carb_sth   = $file_db->prepare($carb_sql);

    $file_db->beginTransaction();
    foreach($arr as $entry){
	$addr=$entry['addr'];
	$r=preg_match('/.*#(.*)\s+\((.*)\)/',$addr, $matches);
	if($r==0||$r===NULL) $matches=['','',''];
	$dis_sth->execute(array(':id' => $entry['id'], ':name' => $entry['name'],':bnd' => $entry['bnd'],':lat' => $entry['lat'],':lon' => $entry['lon'],':addr' => $entry['addr'],':comune' => ucwords(strtolower(trim($matches[1]))),':provincia' => $matches[2]) );

        $carburanti=$entry['carburanti'];
        foreach ($carburanti as $carb){
            $carb_sth->execute(array(':id_d' => $entry['id'], ':dIns' => $entry['dIns'],':carb' => $carb['carb'],':isSelf' => $carb['isSelf'],':prezzo' => $carb['prezzo']) );
        }
    }
    $file_db->commit();

    $file_db = null;
    $memory_db = null;
  }
  catch(PDOException $e) {
    echo $e->getMessage();
  }

?>
