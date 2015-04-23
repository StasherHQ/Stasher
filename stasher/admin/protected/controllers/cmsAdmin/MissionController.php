<?php
/*********************************************************************** 
* Filename: MissionController.php  :  access name: UserController 
* Original Author: Vipul Oab 
* File Creation Date: April 14 , 2015  
* Development Group: OAB
* 
* Description:  Mission stuff will go here
***********************************************************************/
ob_start();
class MissionController extends Controller
{
	public function __construct()
	{
		if(Yii::app()->session['admin_id'] == '' &&  Yii::app()->session['admin_name'] == '')
			$this->redirect('/login/'); //Load login view
		
		$this->setPageTitle(Yii::app()->name.' - User'); //Set the custom page title
		
		// To active Sidebar's menu tab
		Yii::app()->session['activetab'] = 'user';
		$this->globalFunction();	
  	}
	
	
	public function actionUser()
	{
		 $userId = base64_decode($_GET['id']);
		//Get the list of Active / Inactive / Guest
		$missionModel = $data['missionModel'] =  new missionModel; 
		$adminModel = $data['adminModel'] =  new adminModel; 
		$search_txt =  "";
		
		$data['userArray'] = $userArray = $adminModel->getUserDetailsByUserId($userId);
		//print_r($userArray);
				
		$missionArray1 =  $missionModel->getAllMissionsByUserId($userId,$userArray->usertype);
		$k=0;
		foreach($missionArray1 as $msarry)
		{
			$missionArray1[$k]->parent = $adminModel->getUserDetailsByUserId($msarry->parentId);
			$missionArray1[$k]->child = $adminModel->getUserDetailsByUserId($msarry->childId);
		$k++;
		}
		
		
		$data['missionArray'] = $missionArray1;
		//echo "<pre>";print_r($data);exit;
		
		$this->render('cmsAdmin/user_missions_view',$data);
	}
	
} //end MissionController class
ob_clean();
