<?php
include('model/users.php');
include('model/badges.php');
$usrObj = new Model_Users();
$badgeObj = new Model_Badges();

		
$marray = array();
if($_POST['username'] != '' && $_POST['password'] != '' && $_POST['parentemail'] != ''  && $_POST['underage'] != '' )
//if(count($_GET) > 1)
{
		
		$username = $_POST['username'];
		$password = $_POST['password'];
		$parentemail = $_POST['parentemail'];
		$underage = $_POST['underage'];
		
                
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
                    $array['registered_date'] = date("Y-m-d H:i:s");
                    $userId = $usrObj->addUser($array);

                    $parray = array();
                    $parray['userId'] = $userId;
                    $usrObj->addUserInformation($parray);
                                
                    
                    
                    $barray = array();
                    $barray['badgeId'] = 1;
		$barray['childId'] = $userArray['userId'];
						$barray['parentId'] = 1;
						$barray['inserted_date'] = date("Y-m-d H:i:s");

						$userbadge = $badgeObj->addUserBadge($barray);
                                                
                                                
                    $userArray = $usrObj->checkEmailExists($parentemail);
                    
                    if($userArray['email'] != $parentemail)
                    {
                        include(DOC_ROOT.'/model/email.php');
				$emailObj= new Model_Email();
				
				$emailArray = $emailObj->getEmaildetailsByEmailId(1);
				$to = $parentemail;
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
                    }
                    else
                    {
                                                        $relation = 'Parent';
							
							
							$userpArray = array();	
							$userpArray['childId'] = $childId;	
							$userpArray['parentId'] = $parentId;	                                                                                                                                                            
							$userpArray['parent_type'] = $relation_type;	
							$userpArray['relation_name'] = $relation;	
							$userpArray['inserted_date'] = date("Y-m-d H:i:s");	
							$userpArray['status'] = 2;	
							$Id = $usrObj->addRelation($userArray);
                        
                    }
                    
                    $marray['success']['code'] = "100";
                    $marray['success']['message'] = "An invitation has been sent to your parent!";	
                }
		else
		{
			$marray['error']['code'] = "103";
                        $marray['error']['message'] = "Username already exist.Please use different.";
		}
                        
		//echo "<pre>";print_r($userArray);exit;
		
			



}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);
?>
