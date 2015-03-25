<?php
include('model/users.php');

$usrObj = new Model_Users();


if($_POST['username'] != '')
{
		$username = $_POST['username'];
		$userArray = $usrObj->getUserDetailsByUsernameOrEmail($username);
		//print_r($userArray);exit;
		if($userArray)
		{
	
				$password = randomPassword();
				$salt = genenrate_salt(); // save salt key into the databse
				$newpassword = genenrate_password($salt , $password);
				
				$newarray = array();
				
				$newarray['password'] = $newpassword; 
				$newarray['saltkey'] = $salt;
				
				$usrObj->editUser($newarray,$userArray['userId']);
				include(DOC_ROOT.'/model/email.php');
				$emailObj= new Model_Email();
				
				$emailArray = $emailObj->getEmaildetailsByEmailId(2);
				
				$userId = $userArray['userId'];
				$personalArray = $usrObj->getUserInformationByUserId($userId);
				$fname = $personalArray['fname'];
				$lname = $personalArray['lname'];
				$email = $userArray['email'];
				
				$to = $email;
				$toname = $fname.' '.$lname;
				$subject = $emailArray['email_subject'];
				$message = $emailArray['email_content'];
				$from  = $emailArray['email_from'];
				$fromname  = $emailArray['email_from_name'];
				
				

					
					$link = "";
					$subject = str_replace('[SITENAME]', SITENAME, $subject);
     				
					$message = str_replace('[NAME]', $fname.''.$lname, $message);
					$message = str_replace('[SITENAME]', SITENAME, $message);
					$message = str_replace('[EMAIL]',$email , $message);
					$message = str_replace('[PASSWORD]',$password , $message);

					//$template_msg = str_replace('[LOGO]','<img src="'.SITE_URL.'/siteAssets/images/logo.png">', $template_msg);
					$message = str_replace('[LOGO]','Stasher', $message);
					$message = str_replace('[SITELINK]',SITE_URL , $message);
					$message = str_replace('[SUBJECT]',$subject , $message);
					$message = str_replace('[SITEROOT]',SITE_URL , $message);					
					
					 
					  //echo $message;exit;
					
					$status = sendEmail($to,$toname,$from,$fromname,$message,$subject);
					$statusemail =  $status[0]['email'];
					 $emailstatus = $status[0]['status'];
				
			$marray['success']['code'] = "100";
			$marray['success']['message'] = "New password is sent to your email registered address.";
			
			
		}
		else
		{
			$marray['error']['code'] = "102";
			$marray['error']['message'] = "Email address does not exist.";
		}
	
}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);
?>