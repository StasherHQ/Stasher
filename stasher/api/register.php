<?php
include('model/users.php');
include('model/badges.php');
$usrObj = new Model_Users();
$badgeObj = new Model_Badges();

		
$marray = array();
if($_POST['username'] != '' && $_POST['password'] != '' && $_POST['email'] != ''  && $_POST['isparent'] != '' )
//if(count($_GET) > 1)
{
		
		$username = $_POST['username'];
		$password = $_POST['password'];
		$email = $_POST['email'];
		$isparent = $_POST['isparent'];
		$fname = $_POST['fname'];
		$lname = $_POST['lname'];
		$country = $_POST['country'];
		$dob = $_POST['dob'];
                $uid = $_POST['uid'];
		$avatar = $_POST['avatar'];
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
				
				$array['devicetoken'] = $uid;
				if($isparent == 'yes')
				{
					$array['usertype'] = "4";
				}
				else
				{
					$array['usertype'] = "3";
				}
				$array['status'] = "2";
				$array['saltkey'] = $salt;
				$array['registered_date'] = date("Y-m-d H:i:s");
				//print_r($array);
				$userId = $usrObj->addUser($array);
				
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
				$parray['fname'] = $fname;
				$parray['lname'] = $lname;
				$parray['dob'] = $dob;
				//$parray['country'] = $country;
				//$parray['isparent'] = $isparent;
				$parray['avatar'] = $avatarname;
				$parray['userId'] = $userId;
				$usrObj->addUserInformation($parray);
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

					if($userArray['usertype'] == '4')
					{
						$childArray  = $usrObj->getAllChildrenOfParentByUserId($userArray['userId']);
						//echo "<pre>";print_r($childArray);exit;
						
						if($childArray)
						{
							$k=0;
							while($k < count($childArray))
							{
								$childuserarray  = $usrObj->getUserDetailsByUserId($childArray[$k]['childId']);							
								$childuserdetailsarray = $usrObj->getUserInformationByUserId($childArray[$k]['childId']);							
													
								$marray['child'][$k]['userId']= $childuserarray['userId'];							
								$marray['child'][$k]['username']= $childuserarray['username'];
								$marray['child'][$k]['email']= $childuserarray['email'];
								$marray['child'][$k]['usertype']= $childuserarray['usertype'];
								$marray['child'][$k]['registered_date']= $childuserarray['registered_date'];
								$marray['child'][$k]['fname']= $childuserdetailsarray['fname'];
								$marray['child'][$k]['lname']= $childuserdetailsarray['lname'];
								$marray['child'][$k]['gender']= $childuserdetailsarray['gender'];
								$marray['child'][$k]['country']= $childuserdetailsarray['country'];
								$marray['child'][$k]['dob']= $childuserdetailsarray['dob'];
								if($childuserdetailsarray['avatar'])
								$marray['child'][$k]['avatar']= SITEURL.'/dynamicAssets/users/avatar/'.$childuserdetailsarray['avatar'];
								$marray['child'][$k]['avatar'] ='';
								$childuserarray = '';
								$childuserdetailsarray = '';
					
								$k++;
							}
						}
						else
						{
							$marray['child'] = "No child added yet.";
						}
						
					}
					else
					{
					
						$barray = array();
						$barray['badgeId'] = 1;
						$barray['childId'] = $userArray['userId'];
						//$barray['parentId'] = 1;
						$barray['inserted_date'] = date("Y-m-d H:i:s");

						$userbadge = $badgeObj->addUserBadge($barray);
				
					
						$parentArray  = $usrObj->getAllParentdOfChildByUserId($userArray['userId']);
						if($parentArray)
						{

							$k=0;
							while($k < count($parentArray))
							{
								$parentuserarray  = $usrObj->getUserDetailsByUserId($parentArray[$k]['parentId']);							
								$parentuserdetailsarray = $usrObj->getUserInformationByUserId($parentArray[$k]['parentId']);							
													
								$marray['parent'][$k]['userId']= $parentuserarray['userId'];							
								$marray['parent'][$k]['username']= $parentuserarray['username'];
								$marray['parent'][$k]['email']= $parentuserarray['email'];
								$marray['parent'][$k]['usertype']= $parentuserarray['usertype'];
								$marray['parent'][$k]['registered_date']= $parentuserarray['registered_date'];
								$marray['parent'][$k]['fname']= $parentuserdetailsarray['fname'];
								$marray['parent'][$k]['lname']= $parentuserdetailsarray['lname'];
								$marray['parent'][$k]['gender']= $parentuserdetailsarray['gender'];
								$marray['parent'][$k]['country']= $parentuserdetailsarray['country'];
								$marray['parent'][$k]['dob']= $parentuserdetailsarray['dob'];
								if($parentuserdetailsarray['avatar'])
								$marray['parent'][$k]['avatar']= SITEURL.'/dynamicAssets/users/avatar/'.$parentuserdetailsarray['avatar'];
								else
								$marray['parent'][$k]['avatar'] ='';
								$parentuserarray = '';
								$parentuserdetailsarray = '';
					
								$k++;
							}
						}
						else
						{
							$marray['parent'] = "No parent added yet.";
						}
						
					}

				
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
