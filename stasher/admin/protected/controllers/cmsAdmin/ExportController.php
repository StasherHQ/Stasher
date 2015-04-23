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
			$this->redirect('/login/'); //Load login view
		
		$this->setPageTitle(Yii::app()->name.' - User'); //Set the custom page title
		
		// To active Sidebar's menu tab
		Yii::app()->session['activetab'] = 'user';
		$this->globalFunction();	
  	}
	
	
	public function actionIndex()
	{
		$missionModel = new missionModel;
		$adminModel  =  new adminModel; 
		$missionArray = $missionModel->getAllMissions('');
		$k=0;
		foreach($missionArray as $msarry)
		{
			$missionArray[$k]->parentdetails = $adminModel->getUserDetailsByUserId($msarry->parentId);
			$missionArray[$k]->childdetails = $adminModel->getUserDetailsByUserId($msarry->childId);
		$k++;
		}
		//echo $missionArray[0]->parentdetails->lname;
	//	echo "<pre>";print_r($missionArray);exit;
		
		
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
$output_file_name = 'test.csv';
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
