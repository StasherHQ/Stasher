<?php

error_reporting(-1);

$deviceToken = 'b46bdbabb6c2856d71d99315e352f791ce3c86636dada3eafa025688a716bd63';  // masked for security reason
	// Passphrase for the private key (ck.pem file)
	// $pass = '';

	// Get the parameters from http get or from command line
	$message = 'this is testing....';
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
	 print "Failed to connect $err $errstr\n";
	 return;
	}
	else {
	print "Connection OK\n";
	}

	$payload = json_encode($body);
	$msg = chr(0) . pack("n",32) . pack('H*', str_replace(' ', '', $deviceToken)) . pack("n",strlen($payload)) . $payload;
	print "sending message :" . $payload . "\n";
	fwrite($fp, $msg);
	fclose($fp);
exit;

?>