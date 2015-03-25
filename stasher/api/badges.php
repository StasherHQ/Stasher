<?php
include('model/missions.php');

$msnObj = new Model_Mission();

//echo "<pre>";print_r($_POST);exit;
		
$marray = array();
if($_POST['parentId'] != '' )
{
			$parentId = $_POST['parentId'];
			$currentdate = date("Y-m-d H:i:s");
			$missionArray = $msnObj->getAllActiveMissionsByParentId($parentId,$currentdate);
		if($missionArray)
		{			
																																																	$k=0;
																																																	while($k < count($missionArray) )
																																																	{
																																																		$marray[$k]['missionId'] = $missionArray[$k]['id'];
																																																		$marray[$k]['title'] = $missionArray[$k]['title'];
																																																		$marray[$k]['description'] = $missionArray[$k]['description'];
																																																		$marray[$k]['parentId'] = $missionArray[$k]['parentId'];
																																																		$marray[$k]['childId'] = $missionArray[$k]['childId'];
																																																		$marray[$k]['isTimebase'] = $missionArray[$k]['isTimebase'];
																																																		$marray[$k]['totaltime'] = $missionArray[$k]['totaltime'];					
																																																		$marray[$k]['isPublic'] = $missionArray[$k]['isPublic'];
																																																		$marray[$k]['status'] = $missionArray[$k]['status'];
																																																		$marray[$k]['rewardtype'] = $missionArray[$k]['rewardtype'];
																																																		$marray[$k]['rewards'] = $missionArray[$k]['rewards'];
																																																		$marray[$k]['inserted_date'] = $missionArray[$k]['inserted_date'];
																																																		
																																																		$k++;
																																																	}
		}
		else
		{
			$marray['error']['code'] = "101";
			$marray['error']['message'] = "There is no active missions";
		}
}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);
?>