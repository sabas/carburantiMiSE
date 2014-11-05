<?php
$post=array();
if(isset($_GET['r'])) $post['region']= $_GET['r'];
if(isset($_GET['p'])) $post['province']= $_GET['p'];
if(isset($_GET['t'])) $post['town']= $_GET['t'];

//open connection
$ch = curl_init();

//set the url, number of POST vars, POST data

curl_setopt($ch,CURLOPT_URL, "https://carburanti.mise.gov.it/OssPrezziSearch/ricerca/localita");
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_POST, true);

curl_setopt($ch, CURLOPT_POSTFIELDS, "region=".$post['region']."&province=".$post['province']."&town=".$post['town']);

$request= curl_exec($ch);

//close connection
curl_close($ch);
echo $request;

?>