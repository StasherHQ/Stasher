<?php
include('model/users.php');
include('model/badges.php');
$usrObj = new Model_Users();
$badgeObj = new Model_Badges();

	
		
$marray = array();
if($_POST['childId'] != ''  && $_POST['email'] != ''   )
//if(count($_GET) > 1)
{
		
		$childId = $_POST['childId'];
		$email = $_POST['email'];

		$userArray = $usrObj->checkEmailExists($email);
		//echo "<pre>";print_r($userArray);exit;
		if($userArray['email'] != $email)
		{
			
			
		
	
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
					$marray['success']['message'] = "Invitation sent successfully!";				
					$userArray  = $usrObj->getUserDetailsByUserId($userId);	
	
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
					if($userArray['info']['avatar'])
					$marray['usedetails']['avatar'] = SITEURL.'/dynamicAssets/users/avatar/'.$userArray['info']['avatar'];
					else
					$marray['usedetails']['avatar'] = '';
		

				
			
		}
		else
		{
			$marray['error']['code'] = "102";
			$marray['error']['message'] = $userArray['username']." is already one of your commanders";
		}
}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);
?>