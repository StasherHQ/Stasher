<?php
ini_set("display_errors", 1);
require_once 'src/Mandrill.php';

// $mandrill = new Mandrill('XXl9-u_8JLY5JXJl8NgAcw');
/* 
$message = array(
    'subject' => 'Test message',
    'from_email' => 'bhagwan@oabstudios.com',
    'html' => '<p>this is a test message with Mandrill\'s PHP wrapper!.</p>',
    'to' => array(array('email' => 'bhagwansdeore@gmail.com', 'name' => 'bhagwan')),
    'merge_vars' => array(array(
        'rcpt' => 'bhagwansdeore@gmail.com',
        'vars' =>
        array(
            array(
                'name' => 'FIRSTNAME',
                'content' => 'Recipient 1 first name'),
            array(
                'name' => 'LASTNAME',
                'content' => 'Last name')
    ))));

$template_name = 'Stationary';

$template_content = array(
    array(
        'name' => 'main',
        'content' => 'Hi *|FIRSTNAME|* *|LASTNAME|*, thanks for signing up.'),
    array(
        'name' => 'footer',
        'content' => 'Copyright 2012.')

);

print_r($mandrill->messages->sendTemplate($template_name, $template_content, $message)); 
 */

 
 
 $uri = 'https://mandrillapp.com/api/1.0/messages/send.json';
//$body='<body style=\"color:#000; font-family:Arial, Helvetica, sans-serif; font-size:12px; line-height:1.6;\"><div class=\"mainContainer\" style=\"width:550px; margin:0 auto;\"><div class=\"col_12\" style=\"width:100%\"><div class=\"col_12\" style=\"width:100%; background:#000; padding:5px 0;\"><a href=\"http://nightuplife.com/nightup/\" target=\"_blank\"><img src=\"http://50.19.244.20/nightup_version_1.2/BOOKING/nightuplogo.png\" class=\"col_12\"></a></div></div></div><div class=\"col_12\" style=\"width:97.2%; padding:15px 10px 10px; float:left;  border-bottom:1px dotted #999; background:#f6f6f6\"><div class=\"col_6\" style=\"width:60%; float:left;\"><strong>Booker: </strong>'.$receiver_name.'<br><div class=\"col_12\" style=\"width:97.2%; padding:10px; background:#f6f6f6; float:left;  border-bottom:1px dotted #999;\"><div class=\"col_6\" style=\"width:60%; float:left;\"><strong>Event Name: '.$event_name.'</strong><br /><em>Promoter Name: </em>'.$promo_name.' <br /><em>Promoter Phone: </em> <font style=\"color:#990066;\">'. $promo_phone.'</font></div><div class=\"col_6\" style=\"width:40%; float:left; text-align:right;\"><strong>Event Date: '. $event_date.'</strong><br /><strong>Event Time: '. $start_time.' to '.$end_time.'</strong><br /><em>Booking #: </em>'. $booking_id.'<br /><em>Booking Ordered: </em>'. $booking_date.'</div></div><div class=\"col_12\" style=\"width:100%; float:left; margin:0 0 10px 0; font-size:11px; color:#999; text-align:center;\"><a href=\"http://nightuplife.com/nightup/contact.php\" style=\"color:#999;\">Contact Us</a> <a href=\"http://nightuplife.com/nightup/privacy.php\" style=\"color:#999;\">Privacy Policy</a> &copy; 2013 NightUp. All rights reserved.</div></div></div></body>';
 $body='<body style="color:#000; font-family:Arial, Helvetica, sans-serif; font-size:12px; line-height:1.6;">
<div class="mainContainer" style="width:550px; margin:0 auto;">
<div class="col_12" style="width:100%">
<div class="col_12" style="width:100%; background:#000; padding:5px 0;"><a href="http://nightuplife.com/nightup/" target="_blank"><img src="http://50.19.244.20/nightup_version_1.2/BOOKING/nightuplogo.png" class="col_12"></a>
</div>
<div class="col_12" style="width:97.2%; padding:15px 10px 10px; float:left;  border-bottom:1px dotted #999; background:#f6f6f6;">
<div class="col_6" style="width:60%; float:left;"><strong>Booker: </strong> "'.$receiver_name.'" <br></div>	
</div>
</div> </div>
</body>';
/* "html": "' . str_replace('"','\\"',$content) . '",
 "text": "' . str_replace('"','\\"',$content_text) . '", 
  "html": "' . $content . '",
 "text": "' . $content_text . '",
 */
$to = 'bhagwan@oabstudios.com';
$content = 'this is the emails html <a href=\"www.oabstudios.com\">test url </a>';
$subject = 'this is the subject';
$from = 'bhagwan@oabstudios.com';


$api_key = 'XXl9-u_8JLY5JXJl8NgAcw';
$content_text = strip_tags($content);
$postString = '{
     "key": "' . $api_key . '",
     "message": {
     "html": "'.mysql_real_escape_string($body).'",
     "text": "'.$content_text.'",
     "subject": "' . $subject . '",
     "from_email": "' . $from . '",
     "from_name": "' . $from . '",
     "to": [
        {
            "email": "' . $to . '",
            "name": "' . $to . '"
        }
        ],
     "headers": {
	
      },
     "track_opens": true,
     "track_clicks": false,
     "auto_text": true,
     "url_strip_qs": true,
     "preserve_recipients": true,

     "merge": true,
     "global_merge_vars": [

      ],
     "merge_vars": [

     ],
     "tags": [

     ],
   
     "google_analytics_campaign": "...",
     "metadata": [

     ],
     "recipient_metadata": [  {
                       "body": "this is the emails body content"
					   }
     ],
     "attachments": [

     ]
},
"async": false
}';


 $ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $uri);
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true );
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true );
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, $postString);

$result = curl_exec($ch);

print_r($body);

echo $result;
?>

