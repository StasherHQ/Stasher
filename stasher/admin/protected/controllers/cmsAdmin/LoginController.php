<?php
/*********************************************************************** 
* Filename: LoginController.php  :  access name: LoginController 
* Original Author: Vipul Oab 
* File Creation Date: Aug 04 , 2014  
* Development Group: OAB
* 
* Description:  Login related functionality will goes here
***********************************************************************/

ob_start();
class LoginController extends Controller
{
	/***
	 * Function to load the login page and process it
	 ***/
	public function actionIndex()
	{
	
		
		 $this->renderPartial('index'); //Load normal view
		

	}//end function index
	
	public function actionLoginaction()
	{
	 	//echo "";print_r($_POST);exit;
	
	 
		if(isset($_POST['loginForm_email_id'])) //Form is submitted please check the further condition
		{
		 $email_id =  $_POST['loginForm_email_id'];
		 $password =  $_POST['loginForm_password'];
		 $adminModel = new adminModel;
		// echo "";print_r($_POST);exit;
		 $admin_email_details = $adminModel->getUserDetailsByEmail($email_id);

		//echo "";print_r($admin_email_details);exit;
		 $salt = $admin_email_details->saltkey;
		 
		$password = CommonHelper::genenrate_password($salt , $password);
		
		//echo $password;exit;	
		$admin_detail = $adminModel->chkAdminLogin($email_id,$password);
                
               // echo "";print_r($admin_detail);exit;
		 
			 if(!empty($admin_detail))
			 {
				 //-------- Store Value in session ----------//
				 Yii::app()->session['admin_userId'] = $admin_detail->userId;
				 Yii::app()->session['admin_name'] = $admin_detail->username;
				 Yii::app()->session['admin_email'] = $admin_detail->email;
				 Yii::app()->session['admin_type'] = $admin_detail->usertype;
				// Yii::app()->session['profile_pic'] = $admin_detail->avtar;
				 
			
				$this->redirect(Yii::app()->baseUrl.'/cmsAdmin/dashboard');
					
			 }
			 else
			 {
				 $data['error_msg'] = 'Invalid Credentials';
				 $this->renderPartial('index',$data);
			 }
		}
		
	
		

	}//end function index
	
	/***
	 * Function to  clear the session
	 ***/
	public function actionLogout()
	{
		unset(Yii::app()->session['admin_id']);
		unset(Yii::app()->session['admin_name']);
		unset(Yii::app()->session['admin_email']);
		unset(Yii::app()->session['admin_type']);
		$this->redirect(Yii::app()->baseUrl.'/cmsAdmin/login');
	}//end function logout
	
}//end class
ob_clean();
?>
