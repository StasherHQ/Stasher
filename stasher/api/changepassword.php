<?php
include('model/users.php');

$usrObj = new Model_Users();


if($_POST['oldpassword'] != ''  &&  $_POST['newpassword'] != '')
{
		$oldpassword = $_POST['oldpassword'];
		$newpassword = $_POST['newpassword'];
		$userId = $_POST['userId'];
		if($_POST['comfirmpassword'] == $_POST['newpassword'] )
		{
		
				$userArray = $usrObj->getUserDetailsByUserId($userId);
				
				
				$salt = $userArray['saltkey'];
				$password = '';
				$new_password = genenrate_password($salt , $oldpassword);
			
				$oldUserArray = $usrObj->checkOldPasswordCorrectOrWrong($userId,$new_password);
				
				
				if($oldUserArray)
				{
					
					$salt = genenrate_salt(); // save salt key into the databse
					$newpassword1 = genenrate_password($salt , $newpassword);
		
					$newarray = array();
				
				$newarray['password'] = $newpassword1; 
				$newarray['saltkey'] = $salt;
				
				$usrObj->editUser($newarray,$userId);
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
					$message = str_replace('[PASSWORD]',$newpassword , $message);

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
					$marray['success']['message'] = "Password changed successfully.";
					
					
				}
				else
				{
					$marray['error']['code'] = "102";
					$marray['error']['message'] = "Old password doen not match with your database.";
				}
		}
		else
		{
			$marray['error']['code'] = "102";
			$marray['error']['message'] = "New password and confirm password does not match.";
		}
	
}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);
?>