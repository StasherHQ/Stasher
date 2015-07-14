<?php
error_reporting(E_ALL);
$key = "4aa327f5ac661878d6178e2c2b44aa5a9a0708d2";
$pass = "7a383e494ac323569402b9f1fe591c1735906202";
$salt = generate_random_string(); // it will return alphanumeric string 
$newstr = $salt.$pass;
$password = SHA1($newstr);

$data = array();
$data['api_key'] = $key;
$data['api_token'] = $password;
$data['salt'] = $salt;

$url_send ="https://api.knoxpayments.com/partner/v3/sessions";
$str_data = json_encode($data);

echo " " . sendPostData($url_send, $str_data); // curl request

?>
