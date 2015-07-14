<?php	
	include("config.php");
	require_once 'inc/MCAPI.class.php';
	$api = new MCAPI('73ec5c077a2c4c70065272b3bd9099e6-us10');	
	
	$date = date("Y-m-d H:i:s");
	$fullname = $_POST['fullname'];
	$email = $_POST['email'];
	if(is_array($fullname))
	{
	$name = explode(' ',$fullname);	
	$fname = $name[0];
	$lname = $name[1];
	}
	else
	{
	$fname = $fullname;
	$lname = '';
	}
	$merge_vars = array('FNAME'=>$fname, 'LNAME'=>$lname);
	
 $sql = "INSERT INTO tbl_subscribers (name, email,inserted_date,status)
VALUES ('".$fullname."', '".$email."', '".$date."','2')";

$conn->query($sql);

$conn->close();


	
	// Submit subscriber data to MailChimp
	// For parameters doc, refer to: http://apidocs.mailchimp.com/api/1.3/listsubscribe.func.php
	$retval = $api->listSubscribe( '04590ee9f0', $email, $merge_vars, 'html', false, true );
	
	if ($api->errorCode){
		echo "Please try again.";
	} else {
		echo "Thank you, you have been added to our mailing list.";
	}
?>
