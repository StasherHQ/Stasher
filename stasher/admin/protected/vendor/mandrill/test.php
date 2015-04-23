<?php
require_once 'src/Mandrill.php'; //Not required with Composer

$uri = 'https://mandrillapp.com/api/1.0/messages/send.json';
$body="
<body style='color:#000; font-family:Arial, Helvetica, sans-serif; font-size:12px; line-height:1.6;'>
	<div class='mainContainer' style='width:550px; margin:0 auto;'>
	<div class='col_12' style='width:100%'>
		<div class='col_12' style='width:100%; background:#000; padding:5px 0;'><!-- logo -->
			<a href='http://nightuplife.com/nightup/' target='_blank'><img src='http://50.19.244.20/nightup_version_1.2/BOOKING/nightuplogo.png' class='col_12'></a>
		</div>
		<div class='col_12' style='width:97.2%; padding:15px 10px 10px; float:left;  border-bottom:1px dotted #999; background:#f6f6f6'>
			<div class='col_6' style='width:60%; float:left;'>
				<strong>Booker: </strong>". $receiver_name."<br>			
			</div>		
		</div>
		<div class='col_12' style='width:97.2%; padding:10px; background:#f6f6f6; float:left;  border-bottom:1px dotted #999;'>
			<div class='col_6' style='width:60%; float:left;'>
			<strong>Event Name: ".$event_name."</strong><br />
			<em>Promoter Name: </em>".$promo_name." <br />
			<em>Promoter Phone: </em> <font style='color:#990066;'>". $promo_phone."</font>
			</div>
			<div class='col_6' style='width:40%; float:left; text-align:right;'>
				<strong>Event Date: ". $event_date."</strong><br />
				<strong>Event Time: ". $start_time." to ".$end_time."</strong><br />
				<em>Booking #: </em>". $booking_id."<br />
				<em>Booking Ordered: </em>". $booking_date."
			</div>
		</div>		
		<div class='col_12' style='width:97.2%; padding:10px 10px 10px; float:left;  border-bottom:1px dotted #999; background:#f6f6f6'>
			<strong>Pin Code</strong>: ". $pin_code."
		</div>		
		<div class='col_12' style='width:97.2%; padding:15px 10px 10px; float:left;  border-bottom:1px dotted #999; background:#f6f6f6'>
			<div class='col_6' style='width:60%; float:left;'>
				<strong>Venue Name: ". $venue_name."</strong><br>
				". $address1."<br>
				".$address2."<br>
				".$city_name.",".$state_name."<br>
				".$zipcode."<br>
				". $venue_phone."
			</div>
			<div class='col_6' style='width:40%; float:left; text-align:right;'>
				<strong>Promoter Message:</strong><br>
				<em>".$bottle_message."</em>
			</div>
		</div>		
		<div class='col_12' style='width:97.2%; padding:15px 10px 10px; float:left;  background:#f6f6f6;'>
			<div class='col_6' style='width:50%; float:left;'>
			<strong>". $package_title."</strong><font style='color:#990066'><strong> for ".$attendies." people </strong></font><br>";
			if(!empty($drink_id1))
			{
				$drinksize=sizeof($drink_id1);
				for($j=0;$j<$drinksize;$j++)
				{
				   $body=$body.$drink_name[$j]." ".$drink_qtys[$j]."<br>";
				}
			}	
			$body=$body.$note1."<br>
			".$note2."<br>
			".$note3."<br>			
			</div>
			<div class='col_6' style=' width:50%; float:left; text-align:right;'>
				Total price = $".$purchase_amount."
			</div>
		</div>			
		<div class='col_12' style='width:97.2%; padding:15px 10px 10px; float:left; border-bottom:1px solid #ccc; background:#e6e6e6;'>
			<div class='col_6' style='width:50%; float:left;'>
			&nbsp;
			</div>
			<div class='col_6' style='width:50%; float:left; text-align:right;'>
				Product Total = $".$purchase_amount."<br>";
				if($promotion_discount>0)
				{
				$body=$body."Promotion Discount = $".$promotion_discount."<br>";
				}				
				$body=$body."Gratuity = $".$gratuity." <br>
				Sales Tax = $".$sales_tax." <br>
				Nightup_charge = $".$nightup_amount." <br>
				Card Processing = $".$card_amount." <br>
				<strong style='color:#990066;'>Grand Total</strong> = $".$total_amount." <br>
			</div>
		</div>		
		<div class='col_12' style='width:100%; float:left; border-bottom:1px dotted #999; margin-top:20px; padding-bottom:10px;'>
			<div class='col_6' style='width:50%; float:left;'>
			<strong>HOW TO CHECKIN:</strong><br>
			<ul style='margin-top:10px;'>
			<li>Show up at the venue at the time of the event</li>
			<li>Tell the doorman your NightUp PIN: ".$pin_code."</li>
			</ul>
			</div>
		</div>		
		<div class='col_12' style='width:100%; float:left; border-bottom:1px dotted #999; margin-top:20px; padding-bottom:10px;'>
			<div class='col_6' style='width:50%; float:left;'>
			<strong>Payment Information</strong><br>			
			<em>Card number </em> : ".$card_detail1."
			</div>			
			<div class='col_6' style='width:50%; float:left;'>
				<strong>Amount</strong><br>
				$".$total_amount."
			</div>
		</div>
		
		<div class='col_12' style='width:100%; float:left; margin:15px 0; border-bottom:1px dotted #999; padding-bottom:10px; font-size:11px;'>
			For event or purchase questions, please contact <font style='color:#990066;'>".$promo_name."</font> at <font style='color:#990066;'>".$promo_phone."</font>. 
For billing questions or support, contact NightUp at <font style='color:#990066;'>(212) 776-1022</font> or <font style='color:#990066;'>support@nightuplife.com</font>
		</div>
		
		<div class='col_12' style='width:100%; float:left; margin:0 0 10px 0; font-size:11px; color:#999; text-align:center;'>
			<a href='http://nightuplife.com/nightup/contact.php' style='color:#999;'>Contact Us</a> <a href='http://nightuplife.com/nightup/privacy.php' style='color:#999;'>Privacy Policy</a> &copy; 2013 NightUp. All rights reserved.
		</div>
		
		</div>
		</div>
</body>";

$content = '<p>this is the emails html <a href="www.google.co.uk">content</a></p>';
$content_text = strip_tags($content);
$postString = '{
"key": "XXl9-u_8JLY5JXJl8NgAcw",
"message": {
     "html": "gfhfghjhk",
    "text": "dgdhkjhl gjhjk",
    "subject": "this is the subject",
    "from_email": "bhagwan@oabstudios.com",
    "from_name": "John",
    "to": [
        {
            "email": "bhagwansdeore@gmail.com",
            "name": "Bob"
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

print_r($postString);
$result = curl_exec($ch);

echo $result;
?>
