<?php
 header("Access-Control-Allow-Origin: *");
 
//open connection
$ch = curl_init();

//set the url, number of POST vars, POST data

curl_setopt($ch,CURLOPT_URL, "https://carburanti.mise.gov.it/OssPrezziSearch/ricerca/position");
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_POST, true);

curl_setopt($ch, CURLOPT_POSTFIELDS, "pointsListStr=".$_GET['pointsListStr']);

$request= curl_exec($ch);

//close connection
curl_close($ch);
echo $request;

?>