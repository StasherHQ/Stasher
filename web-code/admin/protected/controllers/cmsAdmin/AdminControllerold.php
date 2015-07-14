<?php
/*********************************************************************** 
* Filename: AdminController.php  :  access name: AdminController 
* Original Author: Anuja Oab 
* File Creation Date: Sept 11 , 2014  
* Development Group: OAB
* 
* Description:  admin profile related functionality wil go in this file
***********************************************************************/

ob_start();
class AdminController extends Controller
{
	public function __construct()
	{
		if(Yii::app()->session['admin_id'] == '' &&  Yii::app()->session['admin_name'] == '')
			$this->redirect(Yii::app()->baseUrl.'/cmsAdmin/login');
		
		$this->setPageTitle(Yii::app()->name.' - Profile'); //Set the custom page title
		
		// To active Sidebar's menu tab
		Yii::app()->session['activetab'] = 'admin';	
		
  }
	
	/***
	 * Function to load the login page and process it
	 ***/
	public function actionIndex()
	{
   // echo "==>";
	 $this->redirect(Yii::app()->baseUrl.'/cmsAdmin/dashboard');
	}//end function index
	
	/***
	 * function to load the profile page for the admin user
	 ***/
  function actionProfile()
	{
		$admin_id = "";
		if(!empty($_REQUEST['id']))
		{
			$admin_id = $data['admin_id'] = $_REQUEST['id'];
		
			$adminModel =  new adminModel;
			//get the information from the admin Id
			$data['admin_info'] = $admin_info = $adminModel->getAdmininfo($admin_id);
		
			// get all admin user list to edit details
			$data['admin_users'] = $admin_users = $adminModel->getAdminUserslist();		
		
		//Display this admin information in the view
		if(!empty($admin_info) && Yii::app()->session['admin_id'] == $admin_id)
				$this->render('cmsAdmin/admin_profile_view',$data);
		else
				$this->redirect(Yii::app()->baseUrl.'/cmsAdmin/dashboard');
				
		}
		else{
			$this->redirect(Yii::app()->baseUrl.'/cmsAdmin/dashboard');
		}
	}
	
	function actionaddadminuser()
	{
		$adminModel = new adminModel;
		//get all parent category list
		$data['admin_info'] = "";
		$data['usertype'] = "superadmin";
		echo $this->renderPartial('cmsAdmin/addadminuser_view',$data,true);		
	}
	
	function actioneditadminuser()
	{
		$adminModel = new adminModel;
		$admin_id = $_POST['admin_id'];
		$usertype = $data['usertype'] = $_POST['usertype'];
		
		$data['admin_info'] = $adminModel->getAdmininfo($admin_id);
		
		echo $this->renderPartial('cmsAdmin/addadminuser_view',$data,true);
		
	}
	
	function actionCheckDuplicateEmail()
	{
		$adminModel = new adminModel;
		
		$email_id = $_POST['email_id'];
		
		$chk_duplicate = $adminModel->checkDuplicateEmail($email_id);
	  if(!empty($chk_duplicate))
		{
				echo '1';			
		}
				else echo '0';			
	}
	
	function actionCheckEmailExists()
	{
		$adminModel = new adminModel;
		
		$admin_id = $_POST['admin_id'];
		$email_id = $_POST['email_id'];
				
		$chk_duplicate = $adminModel->checkDuplicateEmail($email_id);
		
		$chk_exists = $adminModel->checkEmailExists($admin_id,$email_id);
		
	  if(!empty($chk_exists) && !empty($chk_duplicate))
		{
				echo '1';			
		}
				else echo '0';		
	}
	
	function actionCheckUsernameExists()
	{
		$adminModel = new adminModel;
		
		$admin_id = $_POST['admin_id'];
		$username = $_POST['admin_username'];
	
		$chk_duplicate = $adminModel->checkDuplicateUsername($username);
		
		$chk_exists = $adminModel->checkUsernameExists($admin_id,$username);
		
	  if(!empty($chk_exists) && !empty($chk_duplicate))
		{
				echo '1';			
		}
				else echo '0';		
	}
	
	function actionCheckDuplicateUsername()
	{
		$adminModel = new adminModel;
		
		$username = $_POST['admin_username'];
		
		$chk_duplicate = $adminModel->checkDuplicateUsername($username);
	  if(!empty($chk_duplicate))
		{
				echo '1';			
		}
				else echo '0';			
	}
	
	function actioncheckPasswordExists()
	{
		$adminModel = new adminModel;
		
		$admin_id = $_POST['admin_id'];
		$old_password = $_POST['old_password'];
		
		$chk_passwordexists = $adminModel->checkPasswordexists($admin_id,$old_password);
		
	  if(!empty($chk_passwordexists))
		{
				echo '1';			
		}
				else echo '0';		
	}
	
	function actionsaveadminuser()
	{
		$commonModel = new commonModel;
		$adminModel =  new adminModel;
		
		$admin_name = $ins_data['admin_name'] = $upd_data['admin_name'] = "";
		$admin_username = $ins_data['admin_username'] = $upd_data['admin_username'] = "";
		$email_id = $ins_data['email_id'] =  $upd_data['email_id'] = "";
		$password = $ins_data['password'] = $upd_data['password'] = "";
		$ins_data['profile_pic'] =  $upd_data['profile_pic']  = "";
		
		$admin_type = "";
		if(isset($_POST['admin_type']))
				$admin_type = $data['usertype'] = $_POST['admin_type'];
		
		$admin_id = "";
		$superadmin = "";
		
		if(isset($_POST['saveadminuser_submit']))
		{
			if (isset($_POST["admin_name"]) && !empty($_POST["admin_name"])) 
				$admin_name = $ins_data['admin_name'] = $upd_data['admin_name'] = $_POST['admin_name'];				
		 
		 if (isset($_POST["admin_username"]) && !empty($_POST["admin_username"])) 
				$admin_username = $ins_data['admin_username'] = $upd_data['admin_username'] = $_POST['admin_username'];
				
		 if (isset($_POST["email_id"]) && !empty($_POST["email_id"])) 
		   $email_id = $ins_data['email_id'] =  $upd_data['email_id'] = $_POST['email_id'];
			
		  if (isset($_POST["new_password"]) && !empty($_POST["new_password"])) 
		   $password = $ins_data['password'] =  $upd_data['password'] = md5($_POST['new_password']);
			 
		 if (isset($_POST["status"]) && !empty($_POST["status"])) 
		   $status = $ins_data['admin_status'] = $upd_data['admin_status'] =  $_POST['status'];
		else
		   $status = $ins_data['admin_status'] = $upd_data['admin_status'] = 'active';   
		   
		$ins_data['admin_type'] = 'admin';
		
		
		$old_profile_pic = "";
		 //--------------------------- IMAGE UPLOADING CODE START---------------------------//
						set_time_limit (0);
						$img_size = 0; 						
						if(isset($_FILES['profile_image']['name']))
						{
							$img_test_array = $_FILES['profile_image'];
							
							foreach ($img_test_array as $key => $value) {			
									if($key == 'size')
										$img_size = $value;
							}
							if($img_size != 0)
							{	
								$newpic = $image_name = $_FILES['profile_image']['name'];							
								Yii::log('In Signup Function', CLogger::LEVEL_ERROR , "Image Name == $image_name");
								$path_info = pathinfo($image_name);
								$ext =  $path_info['extension'];          
								$profile_image="profile_".time().".".$ext;
								$dest = './uploads/'.$profile_image;		
								if(move_uploaded_file($_FILES["profile_image"]["tmp_name"],$dest))
								{							 
								 Yii::log('In Signup Function', CLogger::LEVEL_ERROR , "Update profile section- File uploaded'.$profile_image");
								 $ins_data['profile_pic'] =  $upd_data['profile_pic']  = $profile_image;					
								}
								else
								{							 
								 Yii::log('In Signup Function', CLogger::LEVEL_ERROR , "File can not be uploaded");
								}
							}
							else
							{
							 $ins_data['profile_pic'] =  $profile_image  = 'default.png';
							 if(!empty($_POST['old_profile_pic']))
									 $upd_data['profile_pic'] = $_POST['old_profile_pic'];
								else
										$upd_data['profile_pic'] = 'default.png';
										
							 Yii::log('In Signup Function', CLogger::LEVEL_ERROR , 'File can not be uploaded. Error status = '.$_FILES['profile_image']['error']);
							}
						}
						else
							{
								Yii::log('In Signup Function', CLogger::LEVEL_ERROR , "Image is not given to upload");
							}		
					 //--------------------------- IMAGE UPLOADING CODE ENDS---------------------------//
		
		if(isset($_POST['admin_id']) && !empty($_POST['admin_id']))
		{
			if(empty($upd_data['password']))
				{
						$upd_data['password'] = $_POST['old_password'];
				}
		
			// Update admin user deatails
			$user_detail = $adminModel->updateAdminUser($upd_data,$_POST['admin_id']);
			
			// set super admin profile pic and admin name in session
			if (Yii::app()->session['admin_id'] == $_POST['admin_id']) 
			{
					Yii::app()->session['admin_name'] = $upd_data['admin_name'];
					Yii::app()->session['profile_pic'] = $upd_data['profile_pic'];
			}
			
			if(!empty($password))
			{
					// Get super admin details to send mail of updated password of admiin user type					
					$data['admin_info'] = $admin_info = $adminModel->getAdmininfo(1);
					
					//Modify this functionality to fetch the email template from the database
					$body = '';
					$email_body_array['password'] = $_POST['new_password'];
					$email_temp = $commonModel->getEmailTemplate('superadmin_adminusercreated');

					$subject = "You have changed Password of ".$admin_name;

					$contect = $email_temp->contect;					
					//Place the data in the content
					$pattern = array('/{FULLNAME}/', '/{USERNAME}/','/{PASSWORD}/');
					$replacement = array($admin_info->admin_name, $email_id, $_POST['new_password']);
					$email_body_array['content'] = preg_replace($pattern,$replacement,$contect);
					$body = $this->renderPartial('email_header_view', $email_body_array , true);
					
					//Place the data in the subject
					//$pattern = array('/{APP_NAME}/');
					//$replacement = array(Yii::app()->name);
					$email['subject'] =  $subject; // preg_replace($pattern,$replacement,$subject);
							
					$email['body'] = $body;
					$email['fromName'] =  Yii::app()->name;
					$email['fromEmail'] =  $email_temp->from_email;
					$email['toEmail'] =  $admin_info->email_id;
					$email['toName'] =  $admin_info->admin_name;
					
					$commonModel->sendEmailNotification($email);
					
					//Modify this functionality to fetch the email template from the database
					$body = '';
					$email_body_array['password'] = $_POST['new_password'];
					$email_temp = $commonModel->getEmailTemplate('admin_user_created');
					$subject = "Your password has been changed by super admin";
					$contect = $email_temp->contect;					
					//Place the data in the content
					$pattern = array('/{FULLNAME}/', '/{USERNAME}/','/{PASSWORD}/');
					$replacement = array($admin_name, $email_id, $_POST['new_password']);
					$email_body_array['content'] = preg_replace($pattern,$replacement,$contect);
					$body = $this->renderPartial('email_header_view', $email_body_array , true);
					
					//Place the data in the subject
					//$pattern = array('/{APP_NAME}/');
					//$replacement = array(Yii::app()->name);
					$email['subject'] =  $subject; // preg_replace($pattern,$replacement,$subject);
							
					$email['body'] = $body;
					$email['fromName'] =  Yii::app()->name;
					$email['fromEmail'] =  $email_temp->from_email;
					$email['toEmail'] =  $email_id;
					$email['toName'] =  $admin_name;
					
					$commonModel->sendEmailNotification($email);
			}
					 if($_POST['admin_id'] != '1' && $superadmin == '')							
						{
								$superadmin = "1";						
								Yii::app()->user->setFlash('adminuser','Admin user has been updated successfully.');							
						}
									Yii::app()->user->setFlash('user','You have updated details successfully.');
						
		}else
		{
			
			// Insert new user into database
			$ins_data['cretaed_timestamp'] = date('Y-m-d H:i:s');
			
			$user_detail = $commonModel->insertData('admin',$ins_data);
			Yii::app()->user->setFlash('adminuser','Admin user has been added successfully.');
			
			$superadmin = '1';
			
			if($user_detail)
			{
					//Modify this functionality to fetch the email template from the database
					$body = '';
					$email_body_array['password'] = $_POST['new_password'];
					$email_temp = $commonModel->getEmailTemplate('admin_user_created');
					$subject = $email_temp->subject;
					$contect = $email_temp->contect;					
					//Place the data in the content
					$pattern = array('/{FULLNAME}/', '/{USERNAME}/','/{PASSWORD}/');
					$replacement = array($admin_name, $email_id, $_POST['new_password']);
					$email_body_array['content'] = preg_replace($pattern,$replacement,$contect);
					$body = $this->renderPartial('email_header_view', $email_body_array , true);
					
					//Place the data in the subject
					//$pattern = array('/{APP_NAME}/');
					//$replacement = array(Yii::app()->name);
					$email['subject'] =  $subject; // preg_replace($pattern,$replacement,$subject);
							
					$email['body'] = $body;
					$email['fromName'] =  Yii::app()->name;
					$email['fromEmail'] =  $email_temp->from_email;
					$email['toEmail'] =  $email_id;
					$email['toName'] =  $admin_name;
					
					$commonModel->sendEmailNotification($email);
					
					// SEND Email to super admin
					
					// Get super admin details to send mail of updateed password of admiin user type					
					$admin_detail = $adminModel->getAdmininfo(1);
					
					//Modify this functionality to fetch the email template from the database
					$body = '';
					$email_body_array['password'] = $_POST['new_password'];
					$email_temp = $commonModel->getEmailTemplate('superadmin_adminusercreated');
					$subject = $email_temp->subject;
					$contect = $email_temp->contect;					
					//Place the data in the content
					$pattern = array('/{FULLNAME}/', '/{USERNAME}/','/{PASSWORD}/');
					$replacement = array($admin_detail->admin_name, $email_id, $_POST['new_password']);
					$email_body_array['content'] = preg_replace($pattern,$replacement,$contect);
					$body = $this->renderPartial('email_header_view', $email_body_array , true);
					
					//Place the data in the subject
					//$pattern = array('/{APP_NAME}/');
					//$replacement = array(Yii::app()->name);
					$email['subject'] =  $subject; // preg_replace($pattern,$replacement,$subject);
							
					$email['body'] = $body;
					$email['fromName'] =  Yii::app()->name;
					$email['fromEmail'] =  $email_temp->from_email;
					$email['toEmail'] =  $admin_detail->email_id;
					$email['toName'] =  $admin_detail->admin_name;
					
					$commonModel->sendEmailNotification($email);
			}
		}
			
		}
	
		if($admin_type == 'superadmin')
		{
				$admin_id = '1';
				$superadmin = '1';
			//	$data['admin_type'] = 'super_admin';
		}
		else
		{
			if(isset($_POST['admin_id']) && !empty($_POST['admin_id']))
			{
				$admin_id = $_POST['admin_id'];
				$superadmin = "";
			//	$data['admin_type'] = 'admin';
			}
			else{
						$this->redirect(Yii::app()->baseUrl.'/cmsAdmin/dashboard');					
			}
		}
		
		//get the information from the admin Id
		$data['admin_info'] = $adminModel->getAdmininfo($admin_id);
		
		// get all admin user list to edit details
		$data['admin_users'] = $adminModel->getAdminUserslist();
		
		//Display this admin information in the view
		//$this->render('cmsAdmin/admin_profile_view',$data);
		if($superadmin == '1')
				$this->render('cmsAdmin/admin_users_view',$data);
		else
			$this->redirect('profile/id/'.$admin_id,$data); 
			
	}
	
	function actionviewadminuserlist()
	{
		$adminModel =  new adminModel;
		
		// get all admin user list to edit details
		$data['admin_users'] = $adminModel->getAdminUserslist();
		
		$this->render('cmsAdmin/admin_users_view',$data);
	
	}
	
	/**
	 * Inactive Admin user 
	 **/
	
	function actiondeleteAdminUser()
	{
		$adminModel = new adminModel;
		$admin_id = $_REQUEST['admin_id'];
		
		$deleted = $adminModel->deleteAdminUser($admin_id);
		
		$data['admin_info'] = $adminModel->getAdmininfo($admin_id);
		
		// get all admin user list to edit details
		$data['admin_users'] = $adminModel->getAdminUserslist();
		
		Yii::app()->user->setFlash('adminuser','User has been deactivated successfully.');
		$this->redirect(Yii::app()->baseUrl.'/cmsAdmin/admin/profile/id/1',$data);
		
	}
	/****
	 * Test twillo account
	 ****/
	function actionTestTwillo()
	{
		echo "==>";
		require_once('/protected/extensions/twilio/Services/Twilio.php');
		
		$sid = "ACe0179f30af52221e40d35d16bbb10909"; // Your Account SID from www.twilio.com/user/account
		$token = "cd97ac2acfca5b320729ff5423094a5e"; // Your Auth Token from www.twilio.com/user/account
		 
		$client = new Services_Twilio($sid, $token);
		
//		 try {
//						$message = $client->account->sms_messages->create(
//							'+14842323061', // From a valid Twilio number
//							'+919657060683', // Text this number
//							"Hello, Anuja Oab has invited you to try Thirst!" //message
//						);
//						echo $twilioMessageResponse = $message->sid; 
//						//$receiver_count++;  
//        }
//    catch (Exception $e) {
//            //echo $e->getMessage();
//				}
		$message = $client->account->sms_messages->create(
			'+14842323061', // From a valid Twilio number
			'+917507975701', // Text this number
			"Hello world! This is admin, testing our twilio api"
		);
		if(!$message)
		{
		  echo "= Success";
		}
		else
		 echo "asaS";
		//require_once('././twilio-php-master/Services/Twilio.php');
		//$client = new Services_Twilio("ACe0179f30af52221e40d35d16bbb10909", "cd97ac2acfca5b320729ff5423094a5e");
		//$client->account->messages->sendMessage("+14842323061",
		//																				"+919975369937",
		//																				"There’s something strange in my neighborhood. I don’t know who to call. Send help!"); 
	}
	
}//end class AdminController
ob_clean();
?>