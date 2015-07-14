<?php
/*********************************************************************** 
* Filename: ReportsController.php  :  access name: ReportsController.php 
* Original Author: Vipul Oab 
* File Creation Date: Jan 07 2015 
* Development Group: OAB
* 
* Description:  All report related to missions will go here
***********************************************************************/
ob_start();

class ReportsController extends Controller
{
	public function __construct()
	{
		if(Yii::app()->session['admin_id'] == '' &&  Yii::app()->session['admin_name'] == '')
			$this->redirect(Yii::app()->baseUrl.'/cmsAdmin/login'); //Load login view
		
		$this->setPageTitle(Yii::app()->name.' - Reports'); //Set the custom page title
		
		// To active Sidebar's menu tab
		Yii::app()->session['activetab'] = 'reports';
		$this->globalFunction();
		
  	}
	
	/***
	 * Function to load the dashboard page
	 ***/
	public function actionIndex()
	{
		$m ='';
		$userId= '';
		
		if(@$_GET['m'] !='')
		{
			$m = $_GET['m'];
		}
		if(@$_GET['userId'] !='')
		{
			$userId = base64_decode($_GET['userId']);
		}
		$data = array();
		$data['missionModel'] = $missionModel = new missionModel;
		$adminModel = $data['adminModel'] =  new adminModel;
		 
		 $missionArray1 = $missionModel->getAllMissions($m,'','',$userId);
		//print_r($_GET);
		
		
		$k=0;
		foreach($missionArray1 as $msarry)
		{
			$missionArray1[$k]->parent = $adminModel->getUserDetailsByUserId($msarry->parentId);
			$missionArray1[$k]->child = $adminModel->getUserDetailsByUserId($msarry->childId);
		$k++;
		}
		$data['missionArray'] = $missionArray1;		
		$data['userList'] = $userList = $adminModel->getAllUserList('');
		
		
		
		//echo '<pre>';print_r($data);exit;
		$this->render('cmsAdmin/reports/report_main_view',$data);
		
		
	}
	public function actionAjaxlist()
	{
	
	  $m ='';
		$userId= '';
		
		if(@$_POST['m'] !='')
		{
			$m = $_POST['m'];
		}
		
	$fromdate = date("Y-m-d", strtotime($_POST['fromdate']));
	$todate = date("Y-m-d", strtotime($_POST['todate']));
	
		$data = array();
		$data['missionModel'] = $missionModel = new missionModel;
		$adminModel = $data['adminModel'] =  new adminModel;
		 
		 $missionArray1 = $missionModel->getAllMissions($m,$fromdate,$todate,'');
		 //echo '<pre>';print_r($missionArray1);exit;
		$k=0;//
		foreach($missionArray1 as $msarry)
		{
			$missionArray1[$k]->parent = $adminModel->getUserDetailsByUserId($msarry->parentId);
			$missionArray1[$k]->child = $adminModel->getUserDetailsByUserId($msarry->childId);
		$k++;
		}
		$data['missionArray'] = $missionArray1;	
		//$this->render('cmsAdmin/reports/report_date_ajax_view',$data);
		 echo $this->renderPartial('cmsAdmin/reports/report_date_ajax_view',$data,true);
		 
		 	
	}
	public function actionAjaxReportsByDates()
	{
		
	$fromdate = date("Y-m-d", strtotime($_POST['fromdate']));
	$todate = date("Y-m-d", strtotime($_POST['todate']));
	
		$data = array();
		$data['missionModel'] = $missionModel = new missionModel;
		$adminModel = $data['adminModel'] =  new adminModel;
		 
		 $missionArray1 = $missionModel->getAllMissions('',$fromdate,$todate);
		 //echo '<pre>';print_r($missionArray1);exit;
		$k=0;//
		foreach($missionArray1 as $msarry)
		{
			$missionArray1[$k]->parent = $adminModel->getUserDetailsByUserId($msarry->parentId);
			$missionArray1[$k]->child = $adminModel->getUserDetailsByUserId($msarry->childId);
		$k++;
		}
		$data['missionArray'] = $missionArray1;	
		//$this->render('cmsAdmin/reports/report_date_ajax_view',$data);
		 echo $this->renderPartial('cmsAdmin/reports/report_date_ajax_view',$data,true);
		 	
	}
	
	public function actionSearchusers()
	{
		$searchtext  = @$_GET['q'];
		$data = array();
		$adminModel = $data['adminModel'] =  new adminModel;
		$data['userList'] = $userList = $adminModel->getAllUserList($searchtext);
		//echo "<pre>";print_r($userList);exit;
		$k=0;
		$newlist = array();
		foreach($userList as $ulist)
		{
			$newlist[$k]['id'] = $ulist->userId;
			$newlist[$k]['name'] = $ulist->username;
		}
		# JSON-encode the response
$json_response = json_encode($newlist);



# Return the response
echo $json_response;



		//echo '<pre>';print_r($data);exit;
		// echo $this->renderPartial('cmsAdmin/reports/search_users_ajax_view',$data,true);
	}

}
ob_clean();
?>
