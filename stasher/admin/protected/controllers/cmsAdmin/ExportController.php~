<?php
/*********************************************************************** 
* Filename: ExportController.php  :  access name: UserController 
* Original Author: Vipul Oab 
* File Creation Date: April 17 , 2015  
* Development Group: OAB
* 
* Description:  Mission stuff will go here with export 
***********************************************************************/
ob_start();
class ExportController extends Controller
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
	
	
	public function actionIndex()
	{
		$m ='';
		$userIds= '';
		$fromdate= '';
		$todate = '';
		if(@$_POST['m'] !='')
		{
			$m = $_POST['m'];
		}
		if(@$_POST['sortingfield'] !='')
		{
			$sortingfield = $_POST['sortingfield'];
		}
		else
		{
			$sortingfield = "inserted_date";	
		}
		
		if(@$_POST['sortingby'] !='')
		{
			$sortingby = $_POST['sortingby'];
		}
		else
		{
			$sortingby = " asc";	
		}
		if(@$_POST['userIds'] !='')
		{
			$userIds = base64_decode($_POST['userIds']);
		}
		
		if(@$_POST['fromdate'] !='')
		{
	$fromdate = date("Y-m-d", strtotime($_POST['fromdate']));
	$todate = date("Y-m-d", strtotime($_POST['todate']));
	}
		$data = array();
		$data['missionModel'] = $missionModel = new missionModel;
		$adminModel = $data['adminModel'] =  new adminModel;
		 
		 $missionArray = $missionModel->getAllMissions($m,$fromdate,$todate,$userIds,$sortingfield,$sortingby,$sortingby);
		 
		$k=0;
		foreach($missionArray as $msarry)
		{
			$missionArray[$k]->parentdetails = $adminModel->getUserDetailsByUserId($msarry->parentId);
			$missionArray[$k]->childdetails = $adminModel->getUserDetailsByUserId($msarry->childId);
		$k++;
		}
		//echo $missionArray[0]->parentdetails->lname;
		//echo "<pre>";print_r($missionArray);exit;
		
		
$list = 
    array('Sr No', 'Mission Title','Mission Start Time','Mission End Time', 'Parent Name', 'Child Name');
$finalArray = array();
$k=0;
foreach($missionArray as $msarry)
{
$finalArray[$k]['srno']= $k+1;
$finalArray[$k]['title']= $msarry->title;
$finalArray[$k]['start_time']= $msarry->start_time;
$finalArray[$k]['end_time']= $msarry->end_time;
$finalArray[$k]['parentname']= $msarry->parentdetails->fname.' '.$msarry->parentdetails->lname;
$finalArray[$k]['childname']= $msarry->childdetails->fname.' '.$msarry->childdetails->lname;
$k++;		
}

$filename = SITEURL.'/dynamicAssets/reports/reports.csv';
$delimiter = ',';
$output_file_name = 'reports.csv';
$temp_memory = fopen('php://memory', 'w');
    /** loop through array  */
    $k=0;
    
    foreach ($finalArray as $line) {
        /** default php csv handler **/
        if($k == 0)
        {
        fputcsv($temp_memory, $list, $delimiter);
        
        }
        fputcsv($temp_memory, $line, $delimiter);
        $k++;
    }
    /** rewrind the "file" with the csv lines **/
    fseek($temp_memory, 0);
    /** modify header to be downloadable csv file **/
    header('Content-Type: application/csv');
    header('Content-Disposition: attachement; filename="' . $output_file_name . '";');
    /** Send file to browser for download */
    fpassthru($temp_memory);
    
    


	}
	
} //end MissionController class
ob_clean();
