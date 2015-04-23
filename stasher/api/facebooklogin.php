<?php
include('model/users.php');

$usrObj = new Model_Users();

	
		
$marray = array();
if($_POST['fname'] != '' && $_POST['lname'] != '' && $_POST['email'] != '' )
//if(count($_GET) > 1)
{
		
		$username = $_POST['username'];
		
		$email = $_POST['email'];
		$isparent = $_POST['isparent'];
		$fname = $_POST['fname'];
		$lname = $_POST['lname'];
		$country = $_POST['country'];
		$dob = $_POST['dob'];
		$avatar = $_POST['avatar'];
		$userArray = $usrObj->checkEmailExists($email);
		//echo "<pre>";print_r($userArray);exit;
		if($username == '')
		{
			$usernameArray = explode("@",$email);
			$username = $usernameArray[0];
		}
		
		if($userArray['email'] != $email)
		{
                                $marray['error']['code'] = "102";
				$marray['error']['message'] = "Please try to register using facebook.";
		}
		else
		{
					$userArray['info']= $usrObj->getUserInformationByUserId($userArray['userId']);
					$marray['usedetails']['userId'] = $userArray['userId'];
					$marray['usedetails']['email'] = $userArray['email'];
					$marray['usedetails']['username'] = $userArray['username'];
					$marray['usedetails']['registered_date'] = $userArray['registered_date'];
					$marray['usedetails']['usertype'] = $userArray['usertype'];
					$marray['usedetails']['fname'] = $userArray['info']['fname'];
					$marray['usedetails']['lname'] = $userArray['info']['lname'];
					$marray['usedetails']['gender'] = $userArray['info']['gender'];
					$marray['usedetails']['country'] = $userArray['info']['country'];
					$marray['usedetails']['dob'] = $userArray['info']['dob'];
					$marray['usedetails']['avatar'] = SITEURL.'/dynamicAssets/users/avatar/'.$userArray['info']['avatar'];

		
		}
}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);
?>
