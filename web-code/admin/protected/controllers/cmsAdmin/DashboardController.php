<?php
/*********************************************************************** 
* Filename: DashboardController.php  :  access name: DashboardController 
* Original Author: Vipul Oab 
* File Creation Date: Feb 08 , 2015  
* Development Group: OAB
* 
* Description:  Dashboard stuff will go here
***********************************************************************/
ob_start();
class DashboardController extends Controller
{
	public function __construct()
	{
		if(Yii::app()->session['admin_id'] == '' &&  Yii::app()->session['admin_name'] == '')
			$this->redirect('login'); //Load login view
		
		$this->setPageTitle(Yii::app()->name.' - Dashboard'); //Set the custom page title
		
		// To active Sidebar's menu tab
		Yii::app()->session['activetab'] = 'dashboard';	
  }
	
	/***
	 * Function to load the dashboard page
	 ***/
	public function actionIndex()
	{
	 
	 
	  $adminModel = $data['adminModel'] =  new adminModel;
	  $k=1;
	  $startdate = date('Y-m-d', strtotime('jan 1'));
	  $date = date("Y-m-d H:i:s");
		while($k < 13)
		{
		   
		   $toDate = date('Y-m-d', strtotime("+1 months", strtotime($startdate)));
		   $data['parentdata']['graph']['month'][$k] = $adminModel->getTotalRegisteredUserCountByTypeAndDate('4',$startdate,$toDate);
		   $data['childdata']['graph']['month'][$k] = $adminModel->getTotalRegisteredUserCountByTypeAndDate('3',$startdate,$toDate);
		   $startdate = $toDate;
		   $k++;
		}
		//print_r($data['parentdata']['graph']['month']);
		$data['parentmonthdata'] =  implode(",",$data['parentdata']['graph']['month']);
		$data['childmonthdata'] =  implode(",",$data['childdata']['graph']['month']);
		//echo "<pre>";print_r($data);echo "<pre />";exit;		
	  $this->render('cmsAdmin/dashboard_view',$data);
		
	}
}
ob_clean();
?>
