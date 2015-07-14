<?php
include('model/users.php');

$usrObj = new Model_Users();

	
		
$marray = array();
if($_POST['username'] != '' && $_POST['password'] != '' && $_POST['email'] != ''   )
//if(count($_GET) > 1)
{
		$userId = $_POST['userId'];
		$username = $_POST['username'];
		$password = $_POST['password'];
		$email = $_POST['email'];
		$fname = $_POST['fname'];
		$lname = $_POST['lname'];
		$country = $_POST['country'];
		$dob = $_POST['dob'];
		$avatar = $_POST['avatar'];
		$relation_type = $_POST['relation_type'];

		$userArray = $usrObj->checkEmailExists($email);
		//echo "<pre>";print_r($userArray);exit;
		if($userArray['email'] != $email)
		{
			
			$user1Array = $usrObj->checkUsernameExists($username);
			if($user1Array['username'] != $username)
			{
		
				$salt = genenrate_salt(); // save salt key into the databse
				$newpassword = genenrate_password($salt , $password);				
				
				$array = array();
				$array['username'] = $username;
				$array['password'] = $newpassword;
				$array['email'] = $email;	
			
				$array['usertype'] = "3";
				$array['status'] = "2";
				$array['saltkey'] = $salt;
				//print_r($array);
				$childId = $usrObj->addUser($array);
				
				
				if($avatar != '')
				{
					
					$newAvatar = base64_decode($avatar);
					$avatarname = time().'_'. uniqid().'_' .$userId.'.jpg';
					$file = APP_ROOT.'/dynamicAssets/users/avatar/' .$avatarname;
					$success = file_put_contents($file, $newAvatar);
					//echo $success ? $file : 'Unable to save the file.';
				}



				$parray = array();
				$parray['fname'] = $fname;
				$parray['lname'] = $lname;
				$parray['dob'] = $dob;
				$parray['country'] = $country;
				//$parray['isparent'] = $isparent;
				$parray['avatar'] = $avatarname;
				$parray['userId'] = $childId;
				$usrObj->addUserInformation($parray);
				
				// Add relation to this user
				if($relation_type == '2')
					$relation = 'Family';
					elseif($relation_type == '3')					
					$relation = 'Friend';
					else
					$relation = 'Parent';
					
	
					
					
					$userArray = array();	
							$userArray['childId'] = $childId;	
$userArray['parentId'] =$userId;	                                                                                                                                                            
$userArray['requestfrom'] = $childId;	
							$userArray['requestto'] = $userId;								
$userArray['parent_type'] = $relation_type;	
							$userArray['relation_name'] = $relation;	
							$userArray['inserted_date'] = date("Y-m-d H:i:s");	
							$userArray['status'] = 1;	
							$userArray = $usrObj->addRelation($userArray);
							
							
							
							
							
					
				include(DOC_ROOT.'/model/email.php');
				$emailObj= new Model_Email();
				
				$emailArray = $emailObj->getEmaildetailsByEmailId(1);
				$to = $email;
				$toname = $fname.' '.$lname;
				$subject = $emailArray['email_subject'];
				$message = $emailArray['email_content'];
				$from  = $emailArray['email_from'];
				$fromname  = $emailArray['email_from_name '];
				
					
					$subject = str_replace('[SITENAME]', SITENAME, $subject);
     				
					$message = str_replace('[NAME]', $fname.''.$lname, $message);
					$message = str_replace('[SITENAME]', SITENAME, $message);
					$message = str_replace('[EMAIL]',$email , $message);
					$message = str_replace('[PASSWORD]',$password , $message);
					$message = str_replace('[USERNAME]',$username , $message);
					$message = str_replace('[EMAIL]',$email , $message);
					$message = str_replace('[PASSWORD]',$password , $message);

					$message = str_replace('[LOGO]','<img src="'.SITEURL.'/assets/img/logo.png">', $message);
					//$message = str_replace('[LOGO]','Stasher', $message);
					$message = str_replace('[SITELINK]',SITE_URL , $message);
					$message = str_replace('[SUBJECT]',$subject , $message);
					$message = str_replace('[SITEROOT]',SITE_URL , $message);					
					
					
					
					$status = sendEmail($to,$toname,$from,$fromname,$message,$subject);
					$statusemail =  $status[0]['email'];
					 $emailstatus = $status[0]['status'];
					//echo "<pre>";print_r($status);exit;
				
				$marray['success']['code'] = "100";
				$marray['success']['message'] = "Registration is successful.Please check email address for details.";				
				$marray['email'] = $statusemail;
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
