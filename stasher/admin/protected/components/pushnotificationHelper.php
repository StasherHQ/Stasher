<?php
ob_start();
/**
 * Write common function here
 */
class PushnotificationHelper
{
	/**
	  		$pushnotificationHelper = new pushnotificationHelper;
				$pushnotificationHelper->($msg,$device_token,$type,$order_id);
	 */
	
	/***
	 * Function to send the notification to the user
	 ***/
	function push_notification($device_token,$msg,$type, $target_id = '')
	{
    Yii::log('in pushnotification function', CLogger::LEVEL_ERROR , " Device Token  $device_token");
    $body = array();
    $alert = array();

    $body['aps']['alert']['body'] = $msg;        
    $body['aps']['alert']['targetId'] = $target_id; 
    $body['aps']['alert']['title'] = 'Thirst'; 
    $body['aps']['alert']['type'] = $type;       

    $apns_cert=dirname(__FILE__).'/CertificatesThirstProduction.pem';
    
    $ctx = stream_context_create();
    //Setup stream (connect to Apple Push Server)
    $ctx = stream_context_create();
    //stream_context_set_option($ctx, 'ssl', 'passphrase', 'password_for_apns.pem_file');
    stream_context_set_option($ctx, 'ssl', 'local_cert',$apns_cert);
   
   $fp = stream_socket_client('ssl://gateway.push.apple.com:2195', $err, $errstr, 60, STREAM_CLIENT_CONNECT, $ctx);
   
    // $fp = stream_socket_client('ssl://gateway.sandbox.push.apple.com:2195', $err, $errstr, 60, STREAM_CLIENT_CONNECT, $ctx);
    
     
     stream_set_blocking ($fp, 0); //This allows fread() to return right away when there are no errors. But it can also miss errors during last seconds of sending, as there is a delay before error is returned. Workaround is to pause briefly AFTER sending last notification, and then do one more fread() to see if anything else is there.

    if (!$fp) {
        //ERROR
        $er_log = "Failed to connect (stream_socket_client): $err $errstrn";        
        Yii::log('in pushnotification function', CLogger::LEVEL_ERROR , " in if condition  $er_log");
        return;
    }
    else
    {
        $apple_expiry = time() + (90 * 24 * 60 * 60); //Keep push alive (waiting for delivery) for 90 days

            $apple_identifier = 1;
            //$deviceToken = "ADD PURVIS DEVICE TOKEN HERE";            
            $payload = json_encode($body);
            $msg = pack("C", 1) . pack("N", $apple_identifier) . pack("N", $apple_expiry) . pack("n", 32) . pack('H*', str_replace(' ', '', $device_token)) . pack("n", strlen($payload)) . $payload; //Enhanced Notification
            
    
            fwrite($fp, $msg); //SEND PUSH
            $this->checkAppleErrorResponse($fp); //We can check if an error has been returned while we are sending, but we also need to check once more after we are done sending in case there was a delay with error response.
      

        //Workaround to check if there were any errors during the last seconds of sending.
        usleep(500000); //Pause for half a second. Note I tested this with up to a 5 minute pause, and the error message was still available to be retrieved        
        
        Yii::log('in pushnotification function', CLogger::LEVEL_ERROR , " Check error message=>");
        $this->checkAppleErrorResponse($fp);

        //echo 'DONE!';
        fclose($fp);
    }
	}
  
  /***
	 * Function to send the notification to the user
	 ***/
	function push_notification_test()
	{		
    $body = array();
    $alert = array();

    //Setup notification message
    $body = array();
    //$body['aps'] = array('alert' => 'Thirst Push Not to 123 dev.');
    $body['aps']['notifurl'] = 'http://52.6.12.154/thirst';
    $body['aps']['badge'] = 1;
    $body['aps']['alert']['body'] ='Thirst Push Notification to test.';        
    $body['aps']['alert']['orderId'] = 1; 
    $body['aps']['alert']['title'] = 'Thirst'; 
    $body['aps']['alert']['type'] = 4; 

    //$apns_cert=dirname(__FILE__).'/CertificatesThirstProduction.pem';
    $apns_cert=dirname(__FILE__).'/CertificatesThirstProduction.p12.pem';
    //$apns_cert=dirname(__FILE__).'/CertificatesThirst.p12.pem';


    $ctx = stream_context_create();
    //Setup stream (connect to Apple Push Server)
    $ctx = stream_context_create();
    //stream_context_set_option($ctx, 'ssl', 'passphrase', 'password_for_apns.pem_file');
    stream_context_set_option($ctx, 'ssl', 'local_cert',$apns_cert);
   
   $fp = stream_socket_client('ssl://gateway.push.apple.com:2195', $err, $errstr, 60, STREAM_CLIENT_CONNECT, $ctx);
   
    // $fp = stream_socket_client('ssl://gateway.sandbox.push.apple.com:2195', $err, $errstr, 60, STREAM_CLIENT_CONNECT, $ctx);
    
     
     stream_set_blocking ($fp, 0); //This allows fread() to return right away when there are no errors. But it can also miss errors during last seconds of sending, as there is a delay before error is returned. Workaround is to pause briefly AFTER sending last notification, and then do one more fread() to see if anything else is there.

    if (!$fp) {
        //ERROR
        echo "Failed to connect (stream_socket_client): $err $errstrn";

    } else {

        $apple_expiry = time() + (90 * 24 * 60 * 60); //Keep push alive (waiting for delivery) for 90 days

        //Loop thru tokens from database
       
            $apple_identifier = 1;
            //$deviceToken = "ADD PURVIS DEVICE TOKEN HERE";
            $deviceToken = "9ddb74fa 4bf75307 74362be8 22e66f42 bd09de5f 70f29036 7fa4a469 e949f605";//Sukesh personal
           // $deviceToken = "a4bbb163 955dc9b6 56ef6e48 73db8e23 5920c753 6cc1f46e db55d76c f323cccf";
            //$deviceToken = "3da0030a 4e408b00 7ec1fdf2 5b36f15b f80cf4e1 a5d7db0e ea833dfe 2adee9d6"; //Yellow dev
            //$deviceToken = "4a6abbb1 509cc15d 93456bb7 0abd833b 75a3e221 4b4eb67d a020a316 1efeacbb";//supreme dev            
            //$deviceToken = "951d13b9 07e81644 71392f84 b46391f8 b2052b45 e9d26c79 cb464cee 53fea291";
            //$deviceToken = "cb6e6a9f caf5ff49 f603b58d ab4c1194 a066b7f4 b15be5ef 461dc094 71f528c7";
            //$deviceToken = "dc50ca65 5031fd76 fb4ba6a1 0729d560 c3d6e8e5 4ca3ece5 0934a861 3371bd23"; //Gaurav Sir device
            $payload = json_encode($body);
            $msg = pack("C", 1) . pack("N", $apple_identifier) . pack("N", $apple_expiry) . pack("n", 32) . pack('H*', str_replace(' ', '', $deviceToken)) . pack("n", strlen($payload)) . $payload; //Enhanced Notification
            
    
            fwrite($fp, $msg); //SEND PUSH
            $this->checkAppleErrorResponse($fp); //We can check if an error has been returned while we are sending, but we also need to check once more after we are done sending in case there was a delay with error response.
      

        //Workaround to check if there were any errors during the last seconds of sending.
        usleep(500000); //Pause for half a second. Note I tested this with up to a 5 minute pause, and the error message was still available to be retrieved

        $this->checkAppleErrorResponse($fp);

        echo 'DONE!';

        
        fclose($fp);
    }
  }

    //FUNCTION to check if there is an error response from Apple
    //         Returns TRUE if there was and FALSE if there was not
    function checkAppleErrorResponse($fp)
    {
       $apple_error_response = fread($fp, 6); //byte1=always 8, byte2=StatusCode, bytes3,4,5,6=identifier(rowID). Should return nothing if OK.
       //NOTE: Make sure you set stream_set_blocking($fp, 0) or else fread will pause your script and wait forever when there is no response to be sent.

       if ($apple_error_response) {

            $error_response = unpack('Ccommand/Cstatus_code/Nidentifier', $apple_error_response); //unpack the error response (first byte 'command" should always be 8)

            if ($error_response['status_code'] == '0') {
                $error_response['status_code'] = '0-No errors encountered';

            } else if ($error_response['status_code'] == '1') {
                $error_response['status_code'] = '1-Processing error';

            } else if ($error_response['status_code'] == '2') {
                $error_response['status_code'] = '2-Missing device token';

            } else if ($error_response['status_code'] == '3') {
                $error_response['status_code'] = '3-Missing topic';

            } else if ($error_response['status_code'] == '4') {
                $error_response['status_code'] = '4-Missing payload';

            } else if ($error_response['status_code'] == '5') {
                $error_response['status_code'] = '5-Invalid token size';

            } else if ($error_response['status_code'] == '6') {
                $error_response['status_code'] = '6-Invalid topic size';

            } else if ($error_response['status_code'] == '7') {
                $error_response['status_code'] = '7-Invalid payload size';

            } else if ($error_response['status_code'] == '8') {
                $error_response['status_code'] = '8-Invalid token';

            } else if ($error_response['status_code'] == '255') {
                $error_response['status_code'] = '255-None (unknown)';

            } else {
                $error_response['status_code'] = $error_response['status_code'].'-Not listed';

            }

            //echo '<br><b>+ + + + + + ERROR</b> Response Command:<b>' . $error_response['command'] . '</b>&nbsp;&nbsp;&nbsp;Identifier:<b>' . $error_response['identifier'] . '</b>&nbsp;&nbsp;&nbsp;Status:<b>' . $error_response['status_code'] . '</b><br>';
           // echo 'Identifier is the rowID (index) in the database that caused the problem, and Apple will disconnect you from server. To continue sending Push Notifications, just start at the next rowID after this Identifier.<br>';
           
           Yii::log('in pushnotification Error function', CLogger::LEVEL_ERROR , " Response Command: ". $error_response['command'] ."\n Identifier :" . $error_response['identifier'] . " \n Status:" . $error_response['status_code']);

         return true;
       }
       return false;
    }
}
ob_clean();
?>