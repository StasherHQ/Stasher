<?php
include('model/missions.php');
$msnObj = new Model_Mission();
include('model/users.php');
$missionObj = new Model_Mission();

//echo "<pre>";print_r($_POST);exit;
	
$transId = $_POST['transactionId'];
//$tokenresponce = createToken($transactionId,0.01);
//$transId = "f276e314954a0f1d8047130e64fc70a4d67744e5";
$pass = "7a383e494ac323569402b9f1fe591c1735906202";
$key = "4aa327f5ac661878d6178e2c2b44aa5a9a0708d2";
$limit = 300;
$url = "https://knoxpayments.com/json/token.php?PARTNER_KEY=".$key."&PARTNER_PASS=".$pass."&TRANS_ID=".$transId."&LIMIT_REQ=".$limit;
$ch = curl_init($url);


$tokenresponce = curl_exec($ch);
curl_close($ch);
fclose($fp);


echo $tokenresponce;exit;
?>
