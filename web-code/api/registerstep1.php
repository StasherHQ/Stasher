<?php
include('model/users.php');

$usrObj = new Model_Users();

	
		
$marray = array();
if($_POST['username'] != ''  && $_POST['email'] != '' )
//if(count($_GET) > 1)
{
		
		$username = $_POST['username'];
		$password = $_POST['password'];
		$email = $_POST['email'];
		$isparent = $_POST['isparent'];
		
		$userArray = $usrObj->checkEmailExists($email);
		//echo "<pre>";print_r($userArray);exit;
		if($userArray['email'] != $email)
		{
			
			$user1Array = $usrObj->checkUsernameExists($username);
			if($user1Array['username'] != $username)
			{
		
				$marray['success']['message'] = "User is available to  register";


				
			}
			else
			{
				$marray['error']['code'] = "103";
				$marray['error']['message'] = "Username already exist.Please use different.";
			}
		}
		else
		{
			$marray['error']['code'] = "102";
			$marray['error']['message'] = "Email address already exist.Please use different.";
		}
}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);
?>