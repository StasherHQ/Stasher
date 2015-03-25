<?php
include('model/users.php');

$usrObj = new Model_Users();

		
$marray = array();
if($_POST['username'] != ''  && $_POST['email'] != ''   )
{
		
		$username = $_POST['username'];
		$userId = $_POST['userId'];
		$email = $_POST['email'];
		$fname = $_POST['fname'];
		$lname = $_POST['lname'];
		$country = $_POST['country'];
		$dob = $_POST['dob'];
		$avatar = $_POST['avatar'];
		$userArray = $usrObj->checkEmailExists($email,$userId);
		//echo "<pre>";print_r($userArray);exit;
		if($userArray['email'] != $email)
		{
			
			$user1Array = $usrObj->checkUsernameExists($username,$userId);
			if($user1Array['username'] != $username)
			{
				
				$array = array();
				if($username != '')
				$array['username'] = $username;
				if($email != '')
				$array['email'] = $email;

				
				$usrObj->editUser($array,$userId);
				
				$avatar = str_replace(' ', '+', $avatar);
				if($avatar != '')
				{
					
					$newAvatar = base64_decode($avatar);
					$avatarname = time().'_'. uniqid().'_' .$userId.'.jpg';
					$file = APP_ROOT.'/dynamicAssets/users/avatar/' .$avatarname;
					$success = file_put_contents($file, $newAvatar);
					//echo $success ? $file : 'Unable to save the file.';
				}


				
				$parray = array();
				//$parray['realavatar'] = $avatar;
				if($fname != '')
				$parray['fname'] = $fname;
				if($lname != '')
				$parray['lname'] = $lname;
				if($dob != '')
				$parray['dob'] = $dob;
				if($country != '')
				$parray['country'] = $country;
				//$parray['isparent'] = $isparent;
				if($avatarname != '')
				$parray['avatar'] = $avatarname;
	
				$usrObj->editUserInformation($parray,$userId);
				
				
								
				$marray['success']['code'] = "100";
				$marray['success']['message'] = "Profile updated succesfully.";				
				//$marray['email'] = $statusemail;
				//$marray['email']['status'] = $emailstatus;

				
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