<?php   


$pass = "7a383e494ac323569402b9f1fe591c1735906202";

$key = "4aa327f5ac661878d6178e2c2b44aa5a9a0708d2";
// get transactions details by transasction details.

$req = array();
    $req['api_key'] = $key;
      $req['api_pass'] = $pass;
 $req['bank_name'] = 'CHASUS';
  $req['user_name'] = 'ashoab2011';
   $req['user_pass'] = 'Oswaldburgess1';
   $newreq['JsonRequest'] = $req;
$url ="https://nativeapi.knoxpayments.com/link";
 
$data_string = json_encode($req);

$ch = curl_init();
	$timeout = 5;
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");   
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $data_string); 
	curl_setopt($ch, CURLOPT_HTTPHEADER, array(                                                                          
    'Content-Type: application/json',                                                                                
    'Content-Length: ' . strlen($data_string))                                                                       
);
	$data = curl_exec($ch);
	
	
$data = json_decode($data);


echo "<pre>";print_r($data);exit;
	



?>
