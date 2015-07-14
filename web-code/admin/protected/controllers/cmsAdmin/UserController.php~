<?php
/*********************************************************************** 
* Filename: UserController.php  :  access name: UserController 
* Original Author: Vipul Oab 
* File Creation Date: Mar 8 , 2015  
* Development Group: OAB
* 
* Description:  User stuff will go here
***********************************************************************/
ob_start();
class UserController extends Controller
{
	public function __construct()
	{
		if(Yii::app()->session['admin_id'] == '' &&  Yii::app()->session['admin_name'] == '')
			$this->redirect(Yii::app()->baseUrl.'/cmsAdmin/login'); //Load login view
		
		$this->setPageTitle(Yii::app()->name.' - User'); //Set the custom page title
		
		// To active Sidebar's menu tab
		Yii::app()->session['activetab'] = 'user';
		$this->globalFunction();	
  	}
	
	/***
	 * Function to load the dashboard page
	 ***/
	public function actionIndex()
	{
		
		//Get the list of Active / Inactive / Guest
		$adminModel = $data['adminModel'] =  new adminModel; //we need to use this model in view to get user device information do passing in data
		
		$search_txt =  "";
		$usertype_txt =  "";
		
		$data['q'] = '';
		$data['usertype'] = '';
		
		if(isset($_GET['q']) && !empty($_GET['q']))
		{
			$data['q'] = $search_txt = $_GET['q'];								
		}
		if(isset($_GET['usertype']) && !empty($_GET['usertype']))
		{
			$data['usertype'] = $usertype_txt = $_GET['usertype'];								
		}	
				
		$data['all_user_list'] =  $adminModel->get_user_list($search_txt,$usertype_txt);
		
		//echo "<pre>";print_r($data);exit;
		
		$this->render('cmsAdmin/user_view',$data);
	}
	
	public function actionSendpassword()
	{
		// this will be the new random password for requested user.
		$password =  CommonHelper::randomPassword();
		$salt =  CommonHelper::genenrate_salt(); // save salt key into the databse
		$newpassword =  CommonHelper::genenrate_password($salt , $password);
		$userId = base64_decode($_POST['userId']);
		$newarray = array();
				
		$newarray['password'] = $newpassword; 
		$newarray['saltkey'] = $salt;
		$adminModel = $data['adminModel'] =  new adminModel; //we need to use this model in view to get user device information do passing in data
	
	//echo $password;exit;			
	//$adminModel->changePasswordOfUser($newarray,$userId);
				
				$emailModel = $data['emailModel'] = new emailModel;
				//echo 'hi';	
				$emailArray = $emailModel->getEmaildetailsByEmailId(3);
				//print_r($emailArray);exit;
				
				$personalArray = $adminModel->getUserDetailsByUserId($userId);
				
				//print_r($personalArray);exit;
				$fname = $personalArray->fname;
				$lname = $personalArray->lname;
				$email = $personalArray->email;
				
				$to = $email;
				$toname = $fname.' '.$lname;
				$subject = $emailArray->email_subject;
				$message = $emailArray->email_content;
				$from  = $emailArray->email_from;
				$fromname  = $emailArray->email_from_name;
				
				

					
					$link = "";
					$subject = str_replace('[SITENAME]', SITENAME, $subject);
     				
					$message = str_replace('[NAME]', $fname.''.$lname, $message);
					$message = str_replace('[SITENAME]', SITENAME, $message);
					$message = str_replace('[EMAIL]',$email , $message);
					$message = str_replace('[PASSWORD]',$password , $message);
					$message = str_replace('[LOGO]','Stasher', $message);
					$message = str_replace('[SITELINK]',SITEURL , $message);
					$message = str_replace('[SUBJECT]',$subject , $message);
					$message = str_replace('[SITEROOT]',SITEURL , $message);					
					
					 
					  //echo $message;exit;
					
					$status =  $emailModel->sendEmailNotification($to,$toname,$from,$fromname,$message,$subject);
					
					echo '<p id= "msg" class="bg-success">New password sent successfuly!</p>';
					
					
	}
	
	/**
	 * Function to edit user view
	 ***/
	 
	
	public function actionedit()
	{
		$adminModel = $data['adminModel'] =  new adminModel;
		
		$user_id = base64_decode($_GET['id']);
		$data['userdetails'] =  $adminModel->getUserDetailsByUserId($user_id);if($data['userdetails']->usertype == '3')
		{
			$data['relativedetails'] =  $adminModel->getParentListByChildId($user_id);	
		}
else if($data['userdetails']->usertype == '4')
		{
			$data['relativedetails'] =  $adminModel->getChildListByParentId($user_id);	
		}	
		$data['saveuserdet'] = '1';
		 $this->render('cmsAdmin/user_edit',$data);
		Yii::app()->end();
	}
	
	
	public function actiondelete()
	{
		//echo "hi";
		$adminModel = $data['adminModel'] =  new adminModel;
		$user_id = base64_decode($_GET['id']);
		$adminModel->deleteUser($user_id);
		$_SESSION['msg'] = "User has been removed successfully.";
		$this->redirect(Yii::app()->baseUrl.'/cmsAdmin/user?msg=success');
	}
	
	public function actionRemoveuserrelation()
	{
		$adminModel = $data['adminModel'] =  new adminModel;
		$user_id = ($_POST['id']);
		$adminModel->deleteUserRelation($user_id);
		echo  "User relation has been removed successfully.";
		//$this->redirect(Yii::app()->baseUrl.'/cmsAdmin/user?msg=success');
		
	}
	
	/**
	 * Function to view user details
	 **/
	public function actionDetails()
	{
		
		//echo SITENAME;
		//print_r($ew);exit;
		$adminModel = $data['adminModel'] =  new adminModel;
		//error_reporting(E_ALL);
		$user_id = base64_decode($_GET['id']);
		$data['userdetails'] =  $adminModel->getUserDetailsByUserId($user_id);	
//echo "<pre>";print_r($data);exit;
//echo $data['userdetails']->usertype;exit;
		if($data['userdetails']->usertype == '3')
		{
			$data['relativedetails'] =  $adminModel->getParentListByChildId($user_id);	
		}
else if($data['userdetails']->usertype == '4')
		{
			$data['relativedetails'] =  $adminModel->getChildListByParentId($user_id);	
		}
		//echo "<pre>";print_r($data);exit;	
		$data['saveuserdet'] = '1';
		 $this->render('cmsAdmin/user_profile_view',$data);
		//Yii::app()->end();		
	}
	
	/**
	 * Function to update user details
	 **/
	public function actionupdate()
	{		
		$adminModel = $data['adminModel'] =  new adminModel;
		//$user_id = $_POST['user_id'];
		
		if(isset($_POST['fname']))
		{
			
		if(isset($_POST['fname']) && !empty($_POST['fname']))
			$upd_data['fname'] = $_POST['fname'];
		if(isset($_POST['lname']) && !empty($_POST['lname']))
			$upd_data['lname'] = $_POST['lname'];
			if(isset($_POST['gender']) && !empty($_POST['gender']))
			$upd_data['gender'] = $_POST['gender'];
			if(isset($_POST['dob']) && !empty($_POST['dob']))
			$upd_data['dob'] = $_POST['dob'];
		//if(isset($_POST['email']) && !empty($_POST['email']))
			//$upd_data['email'] = $_POST['emai'];
		
		//if(isset($_POST['user_status']) && !empty($_POST['user_status']))
		//	$upd_data['user_status'] = $_POST['user_status'];
			
		$userId = base64_decode($_POST['userId']);
		if($_FILES["avatar"]["name"])
		{
		$avatarname = time().'_'. uniqid().'_' .$userId.'.jpg';
		$target_file = '../dynamicAssets/users/avatar/' .$avatarname;
		
		
			if (move_uploaded_file($_FILES["avatar"]["tmp_name"], $target_file)) {
	       			$upd_data['avatar'] = $avatarname;
	   		 } 
    
    		}
    
		if(isset($_POST['userId'])  && !empty($_POST['userId'])) 
		{
			$adminModel->updateUserInformation($upd_data,base64_decode($_POST['userId']));
			//Yii::app()->user->setFlash('user','User has been updated successfully.');
			//	$this->refresh();
		}
		}
		
		$_SESSION['msg'] = "User information has been updated successfully.";
		//$this->render('cmsAdmin/user_view',$data);
		
		$this->redirect(Yii::app()->baseUrl.'/cmsAdmin/user?msg=success');
		
	}
	
	public function actionchangeUserStatus()
	{
		$commonModel = new commonModel;
		$adminModel = $data['adminModel'] =  new adminModel;
		//$user_id = $_REQUEST['user_id'];
		
		$user_id =  $arr['user_id'] = $_POST['user_id'];
		$user_detail = $adminModel->get_user_detailbyId($user_id);
		$status = $btncolor = "";			
		$status = $_POST['user_status'];
			
			if($status == 'active')
			{	$upd_array['user_status'] = 'inactive';
				$st = "deactivated";
				$btncolor = "btn-danger";
				//------- EMAIL NOTIFICATION FUNCTIONALITY START ---------------------//
					$body = '';					
					$email_temp = $commonModel->getEmailTemplate('user_status');
					$subject = $email_temp->subject;
					$contect = $email_temp->contect;					
					//Place the data in the content				
					$full_name = $user_detail->full_name;
					$email_id = $user_detail->email_id;
					$user_full_name = rtrim($full_name, ".");
					$pattern = array('/{USER_NAME}/','/{APP_NAME}/','/{STATUS}/');
					$replacement = array( $user_full_name , Yii::app()->name ,$st );
					$email_body_array['content'] = preg_replace($pattern,$replacement,$contect);
					$body = $this->renderPartial('email_header_view', $email_body_array , true);
						
					//Place the data in the subject
					$pattern = array('/{APP_NAME}/','/{USER_NAME}/');
					$replacement = array(Yii::app()->name,$user_full_name);
				  $email['subject'] = preg_replace($pattern,$replacement,$subject);
							
					$email['body']    = $body;
					$email['fromName'] =  Yii::app()->name;
			    $email['fromEmail'] = $email_temp->from_email; 
			    $email['toEmail'] =  $email_id;
					$email['toName'] = $full_name;		
					$commonModel->sendEmailNotification($email);			
					//------- EMAIL NITIFICATION FUNCTIONALITY ENDS---------------------//
			}else
			{
				$upd_array['user_status'] = 'active';
				$st = "activated";
				$btncolor = "btn-primary";
				//------- EMAIL NOTIFICATION FUNCTIONALITY START ---------------------//
					$body = '';					
					$email_temp = $commonModel->getEmailTemplate('user_status');
					$subject = $email_temp->subject;
					$contect = $email_temp->contect;					
					//Place the data in the content
					$full_name = $user_detail->full_name;
					$email_id = $user_detail->email_id;
					$user_full_name = rtrim($full_name, ".");
					$pattern = array('/{USER_NAME}/','/{APP_NAME}/','/{STATUS}/');
					$replacement = array( $user_full_name , Yii::app()->name ,$st );
					$email_body_array['content'] = preg_replace($pattern,$replacement,$contect);
					$body = $this->renderPartial('email_header_view', $email_body_array , true);
						
					//Place the data in the subject
					$pattern = array('/{APP_NAME}/','/{USER_NAME}/');
					$replacement = array(Yii::app()->name,$user_full_name);
				  $email['subject'] = preg_replace($pattern,$replacement,$subject);
							
					$email['body']    = $body;
					$email['fromName'] =  Yii::app()->name;
			    $email['fromEmail'] = $email_temp->from_email; 
			    $email['toEmail'] =  $email_id;
					$email['toName'] = $full_name;		
					$commonModel->sendEmailNotification($email);			
					//------- EMAIL NITIFICATION FUNCTIONALITY ENDS---------------------//
			}
			//Update the user information
			$where_string = 'user_id = :user_id';
			$where_array[':user_id'] = $user_id;
			
			$commonModel->updateData('user', $upd_array , $where_string , $where_array);
			
			$adminModel = $data['adminModel'] =  new adminModel; 
			
			$profile_detail = $adminModel->get_user_detailbyId($user_id);
			
		//	echo "<pre>";print_r($profile_detail);echo "<pre />";
			
				Yii::app()->user->setFlash('user','User has been '.$st.' successfully.');
				
				$str = '<a href="javascript:;" class="btn btn-small '.$btncolor.'" onclick="change_status('.$user_id.',';
					$str .= "'".$profile_detail->user_status."'";
					$str .= ');">';
					$str .=  ucfirst($profile_detail->user_status).'</a>';
					echo $str;	
	}
	public function actionview_user_share()
	{
		$adminModel = $data['adminModel'] =  new adminModel;
		$user_id = $_POST['user_id'];
		$data['share_details'] = $adminModel->user_share_details($user_id);
		echo $this->renderPartial('cmsAdmin/user_share_view',$data,true);
	}
	public function actionview_user_setting()
	{
		$adminModel = $data['adminModel'] =  new adminModel;
		$data['user_id'] = $user_id = $_POST['user_id'];
		$data['setting_details'] = $adminModel->get_user_detailbyId($user_id);
		echo $this->renderPartial('cmsAdmin/setting_view',$data,true);
	}
	public function actionsave_setting_view()
	{
		$adminModel = $data['adminModel'] =  new adminModel;
		$user_id = $_POST['user_id'];
		$upd_data['push_notification'] = $_POST['notification'];
		$upd_data['stay_sign_in'] = $_POST['stay_sign'];
		$upd_data['receive_email'] = $_POST['receive_email'];
		Yii::app()->user->setFlash('user','Setting has been Updated successfully.');
		$promo_update = $adminModel->updateSetting($upd_data,$user_id);
		echo "success";
	}
	
} //end UserController class
ob_clean();
