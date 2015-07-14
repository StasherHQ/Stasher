<?php
class mandrillwrap extends CApplicationComponent {
	
	public $mandrillKey;
	public $fromEmail;
	public $fromName;
	public $toEmail;
	public $toName;
	public $text;
	public $subject;
	public $content;
	public function init()
	{
		Yii::import('application.vendors.mandrill.src.Mandrill');
		define('MANDRILL_API_KEY','goJT1J6SBAmYfQLCgomr6w');
	}
	
	/* public function sendEmail() {
		
		$request_json = '{
						"type":"messages",
						"call":"send",
						"message": {
							"subject":"' . $this->subject . '",
							"to":[
								{
								"email": "' . $this->toEmail . '",
								"name": "' . $this->toName . '"
								}
							],
							"headers":
								{
									"...":"..."
							},
							"url_strip_qs":true,
							"from_email": "' . $this->fromEmail . '",
							"from_name": "' . $this->fromName . '",
							"text": "' . $this->text . '",
							"track_opens":false,
							"track_clicks":false,
							"auto_text":true,
							"tags":["fal"],
							"google_analytics_domains":["..."],
							"google_analytics_campaign":["..."],
							"metadata":["..."]
							}
						}';

		$ret = Mandrill::call((array) json_decode($request_json));
    } */
	
	public function sendEmail($subject,$fromName,$fromEmail,$toName,$toEmail,$body)
	{
        $uri = 'https://mandrillapp.com/api/1.0/messages/send.json';
		$subject =  $subject;
        $api_key = 'goJT1J6SBAmYfQLCgomr6w';
		//$api_key = 'XXl9-u_8JLY5JXJl8NgAcw';
		$content="";
		$content_text = strip_tags($content);
        $params = array(
		"key" =>$api_key,
		"message" => array(
		"html" => $body,
		"text" => $content_text,
		"to" => array(
		array("name" => $toName , "email" =>$toEmail)
		),
		"from_email" => $fromEmail,
		"from_name" => $fromName,
		"subject" => $subject,
		"track_opens" => true,
		"track_clicks" => true
		),
		"async" => false
		);
        $postString = json_encode($params);
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $uri);
		curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true );
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true );
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $postString);
         $result = curl_exec($ch);
		return  $result;
	} 	

}
