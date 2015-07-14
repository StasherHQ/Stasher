<?php


function sendPostData($url, $post){
  $ch = curl_init($url);
  curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");  
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($ch, CURLOPT_POSTFIELDS,$post);
  curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1); 
  curl_setopt($ch, CURLOPT_HTTPHEADER, array(                                                                          
    'Content-Type: application/json',                                                                                
    'Content-Length: ' . strlen($post))                                                                       
);
  $result = curl_exec($ch);
  curl_close($ch);  // Seems like good practice
  return $result;
}

function getCURLdata($url) {
	$ch = curl_init();
	$timeout = 5;
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
	$data = curl_exec($ch);
	curl_close($ch);
	return $data;
}


	function sendPushNotificationToIOSDevice($deviceToken,$message)
	{
            
        // $deviceToken = 'b46bdbabb6c2856d71d99315e352f791ce3c86636dada3eafa025688a716bd63';  // masked for security reason
	// Passphrase for the private key (ck.pem file)
	// $pass = '';

	// Get the parameters from http get or from command line
	//$message = 'this is testing....';
	$badge = 1;
	$sound = 'default';

	// Construct the notification payload
	$body = array();
	$body['aps'] = array('alert' => $message);
	if ($badge)
	$body['aps']['badge'] = $badge;
	if ($sound)
	$body['aps']['sound'] = $sound;


	/* End of Configurable Items */

	$ctx = stream_context_create();
	stream_context_set_option($ctx, 'ssl', 'local_cert',DOC_ROOT.'/StasherDev.pem');
        
        
        //stream_context_set_option($ctx, 'ssl', 'local_cert',DOC_ROOT.'/entrust_ssl_ca.cer');
        
	// assume the private key passphase was removed.
	stream_context_set_option($ctx, 'ssl', 'passphrase', '');
        
 
        stream_context_set_option($ctx, 'ssl', 'allow_self_signed', true);
        stream_context_set_option($ctx, 'ssl', 'verify_peer', false);



	$fp = stream_socket_client('ssl://gateway.sandbox.push.apple.com:2195', $err, $errstr, 60, STREAM_CLIENT_CONNECT, $ctx);
	// for production change the server to ssl://gateway.push.apple.com:219
	if (!$fp) {
	// print "Failed to connect $err $errstr\n";
	 return;
	}
	else {
	//print "Connection OK\n";
	}

	$payload = json_encode($body);
	$msg = chr(0) . pack("n",32) . pack('H*', str_replace(' ', '', $deviceToken)) . pack("n",strlen($payload)) . $payload;
	//print "sending message :" . $payload . "\n";
	fwrite($fp, $msg);
	fclose($fp);
        
	}





function array_values_recursive($ary)  {


$lst = array();
foreach( array_keys($ary) as $k ) {


$v = $ary[$k];
if (is_scalar($v)) {


$lst[] = $v;


} elseif (is_array($v)) {


$lst = array_merge($lst,array_values_recursive($v));


}


}


return $lst;

}


 function generate_random_string($length = 10) {
    $alphabets = range('a','z');
    $numbers = range('0','9');
   // $additional_characters = array('_','.');
   // $final_array = array_merge($alphabets,$numbers,$additional_characters);
     $final_array = array_merge($alphabets,$numbers);
    $password = '';
  
    while($length--) {
      $key = array_rand($final_array);
      $password .= $final_array[$key];
    }
  
    return $password;
  }
  
  
	function randomPassword() {
    $alphabet = "abcdefghijklmnopqrstuwxyzABCDEFGHIJKLMNOPQRSTUWXYZ0123456789";
    $pass = array(); //remember to declare $pass as an array
    $alphaLength = strlen($alphabet) - 1; //put the length -1 in cache
    for ($i = 0; $i < 8; $i++) {
        $n = rand(0, $alphaLength);
        $pass[] = $alphabet[$n];
    }
    return implode($pass); //turn the array into a string
}


function genenrate_salt(){
$rndstring = "";
$length = 64;
$a = "";
$b = "";
$template = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
settype($length, "integer");
settype($rndstring, "string");
settype($a, "integer");
settype($b, "integer");

for ($a = 0; $a <= $length; $a++) {
$b = rand(0, strlen($template) - 1);
$rndstring .= $template[$b];
}

return $rndstring;
}

function genenrate_password($salt,$pass){
$password_hash = '';

$mysalt = $salt;
$password_hash= hash('SHA256', "-".$mysalt."-".$pass."-");

return $password_hash;
}


function sendEmail($to,$toname,$from,$fromname,$template,$subject)
{
require DOC_ROOT.'/model/Mandrill.php';

	
				try {
    $mandrill = new Mandrill('qjeXUI_DhB4IP8GmDfkbeA');
    
    $message = array(
        'html' => $template,
        'text' => 'Example text content',
        'subject' => $subject,
        'from_email' => $from,
        'from_name' => $fromname,
        'to' => array(
            array(
                'email' => $to,
                'name' => $toname,
                'type' => 'to'
            )
        ),
        'headers' => array('Reply-To' => $from)
    );
   
    $result = $mandrill->messages->send($message,  $async=false, $ip_pool=null, $send_at=null);    
    //print_r($result);
    /*
    Array
    (
        [0] => Array
            (
                [email] => recipient.email@example.com
                [status] => sent
                [reject_reason] => hard-bounce
                [_id] => abc123abc123abc123abc123abc123
            )
    
    )
    */
    return $result;
} catch(Mandrill_Error $e) {
    // Mandrill errors are thrown as exceptions
    return 'A mandrill error occurred: ' . get_class($e) . ' - ' . $e->getMessage();
    // A mandrill error occurred: Mandrill_Unknown_Subaccount - No subaccount exists with the id 'customer-123'
    throw $e;
}



}

?>
