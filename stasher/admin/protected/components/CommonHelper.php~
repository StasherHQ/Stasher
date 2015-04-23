<?php
ob_start();
/**
 * Write common function here
 */
class CommonHelper
{
	/**
	 * Authenticates a user.
	 * The example implementation makes sure if the username and password
	 * are both 'demo'.
	 * In practical applications, this should be changed to authenticate
	 * against some persistent user identity storage (e.g. database).
	 * @return boolean whether authentication succeeds.
	 *
	 *
	 *
	  		$commonHelper = new commonHelper;
				$commonHelper->FUNCTION NAME($Param);		
				
	 */
	
	/***
	 * Function to send the notification to the user
	 ***/
	 
	 function isLogin()
	 {
		  if(!(Yii::app()->session['admin_id'] == '' &&  Yii::app()->session['admin_name'] == ''))
		  $this->redirect(Yii::app()->baseUrl.'/cmsAdmin/dashboard'); //if already logged in load dashboard view
		  
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

 function sendEmail($to,$toname,$from,$fromname,$template,$subject)
{
			//require 'Mandrill.php';

	
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

	function send_gift_notification($gift)
	{
		$friend_type = $gift['friend_type'];
		$friend_value = $gift['friend_value'];
		$user_id = $gift['gift_from_id'];
		$amount = $gift['amount'];
		$receiver_name = $gift['friend_name'];
		$note = base64_decode($gift['note']);
		
		$userModel = new userModel;		
		$userInfo = $userModel->getUserBasicInfo($user_id);
		$sender_name = $userInfo->full_name;
			
		if($friend_type == 1 )//Facebook
		{
			
		}
		elseif($friend_type  == 2) //Thirst
		{
			//Send push notificarion			
		  $commonModel = new commonModel;
		 // $thirst_msg = "You have got gift of $".$amount.".<br> Login to ".Yii::app()->name." and redeem your gift.";
		  $gift = "$ ".$amount." on ".Yii::app()->name;
			$thirst_msg = "$".$amount." has been added to your account. Enjoy your free credit at any ".Yii::app()->name." location";
			Yii::log('In share thirst function', CLogger::LEVEL_ERROR , "Friend_type :$friend_type \n Msg : $thirst_msg \n Amount : $amount");
			//Send the email notification
			$email_temp = $commonModel->getEmailTemplate('receiveGiftEmail');
			$subject = $email_temp->subject;
			$contect = $email_temp->contect;			
						
			//Place the data in the subject
			$pattern = array('/{APP_NAME}/','/{SENDER_NAME}/');
			$replacement = array(Yii::app()->name,$sender_name);
			$email['subject'] = preg_replace($pattern,$replacement,$subject);
			
			$userModel = new userModel;

			$user_info =	$userModel->getUserBasicInfo($friend_value);
			if(!empty($user_info))
			{
				$to_email = $user_info->email_id;
				$to_name = $user_info->full_name;
		  	if($receiver_name == '')
			   $receiver_name = rtrim($to_name, ".");				 
			}
			
			$download_link = $commonModel->get_app_download_link();
			//Place the data in the content
			$pattern = array('/{APP_NAME}/','/{SENDER_NAME}/','/{RECEIVER_NAME}/','/{GIFT}/','/{GIFT_DETAIL}/','/{APP_NAME}/','/{DOWNLOAD_LINK}/');
			$replacement = array(Yii::app()->name,$sender_name,$receiver_name,$gift,$thirst_msg,Yii::app()->name,$download_link);
			$email_body_array['content'] = preg_replace($pattern,$replacement,$contect);
			$body = Yii::app()->controller->renderPartial('email_header_view', $email_body_array , true);
			
			$email['body'] = $body;
			$email['fromName'] =  Yii::app()->name;
			$email['fromEmail'] =  $email_temp->from_email;
			$email['toEmail'] =  $to_email;
			$email['toName'] =  $to_name;
			
			$commonModel->log_array('send_gift_notification', 'In the helper', $email);
			$commonModel->sendEmailNotification($email);			
		}
		elseif($friend_type  == 3) //SMS
		{
			//Send SMS
			 Yii::log('In send_gift_notification function', CLogger::LEVEL_ERROR , "In friend_type = $friend_type Send SMS.");
			require_once('./protected/extensions/twilio/Services/Twilio.php');
	
			$thirst_msg = "Hello, $sender_name has sent you gift credit of \$$amount with message : $note";
			
			$twilio_id = Yii::app()->params['twilio_id']; // Your Account SID from www.twilio.com/user/account
			$token = Yii::app()->params['twilio_token']; // Your Auth Token from www.twilio.com/user/account
			$twilio_number = Yii::app()->params['twilio_number']; 
			
			$client = new Services_Twilio($twilio_id, $token);
			
			try {
			//remove some extra charchters from $friend_value
			Yii::log('In share thirst function', CLogger::LEVEL_ERROR , " Phone Number b4 => $friend_value ");
			//echo "Before $friend_value";
			$friend_value = str_replace('(','',$friend_value);
			$friend_value = str_replace(')','',$friend_value);
			$friend_value = str_replace('-','',$friend_value);
			$friend_value = str_replace(' ','',$friend_value);
			$friend_value = str_replace('+','',$friend_value);
			
			//echo "After $friend_value";
			Yii::log('In share thirst function', CLogger::LEVEL_ERROR ,"Phone Number After  => $friend_value ");
			
			Yii::log('In share thirst function', CLogger::LEVEL_ERROR , "In Try. $twilio_id === $twilio_number ====> $thirst_msg");
			$message = $client->account->sms_messages->create(
			$twilio_number, // From a valid Twilio number
			"+".trim($friend_value), // Text this number
			$thirst_msg //message
			);
			 $twilioMessageResponse = $message->sid; 
			//$receiver_count++;
			Yii::log('In send_gift_notification function', CLogger::LEVEL_ERROR , "SMS Sent to number : $friend_value | Msg : $twilioMessageResponse .");
			}
			catch (Exception $e)
			{
			$e_msg =  $e->getMessage();
			Yii::log('In send_gift_notification function', CLogger::LEVEL_ERROR , "SMS not getting sent to $e_msg.");
			}
		}
		elseif($friend_type  == 4) //Email
		{
			$commonModel = new commonModel;
		  $gift = "$ ".$amount." on ".Yii::app()->name;
			$thirst_msg = "You have got gift of $".$amount.".<br> Login to ".Yii::app()->name." and redeem your gift.";
			//Send the email notification
			$email_temp = $commonModel->getEmailTemplate('receiveGiftEmail');
			$subject = $email_temp->subject;
			$contect = $email_temp->contect;			
						
			//Place the data in the subject
			$pattern = array('/{APP_NAME}/','/{SENDER_NAME}/');
			$replacement = array(Yii::app()->name,$sender_name);
			$email['subject'] = preg_replace($pattern,$replacement,$subject);
			
			$download_link = $commonModel->get_app_download_link();
			//Place the data in the content
			$pattern = array('/{APP_NAME}/','/{SENDER_NAME}/','/{RECEIVER_NAME}/','/{GIFT}/','/{GIFT_DETAIL}/','/{APP_NAME}/','/{DOWNLOAD_LINK}/');
			$replacement = array(Yii::app()->name, $sender_name ,$receiver_name,$gift,$thirst_msg,Yii::app()->name,$download_link);
			$email_body_array['content'] = preg_replace($pattern,$replacement,$contect);
			$body = Yii::app()->controller->renderPartial('email_header_view', $email_body_array , true);

					
			$email['body'] = $body;
			$email['fromName'] =  Yii::app()->name;
			$email['fromEmail'] =  $email_temp->from_email;
			$email['toEmail'] =  $friend_value;
			$email['toName'] =  $receiver_name;
			
			$commonModel->log_array('send_gift_notification', 'In the helper', $email);
			$commonModel->sendEmailNotification($email);
		}
		return true;
	}//end of the function send_gift_notification
}//end of the class
ob_clean();
?>
