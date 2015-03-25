<?php
include('model/missions.php');

$msnObj = new Model_Mission();

//echo "<pre>";print_r($_POST);exit;

$marray = array();
if($_POST['missionId'] != '' && $_POST['parentId'])
{
		
		//echo "<pre>";print_r($_POST);exit;
			$missionId = $_POST['missionId'];
			$parentId = $_POST['parentId'];
			
			
			$missionArray = $msnObj->checkTheCreatorOfMission($missionId,$parentId);
			
			if($missionArray)
			{
				$array = array();
				$array['status'] = '3';	
	
				$missionId = $msnObj->editMission($array,$missionId);
	
				$marray['success']['code'] = "100";
				$marray['success']['message'] = "Mission is completed.";	
			}
			else
			{
				$marray['error']['code'] = "102";
				$marray['error']['message'] = "You are not the creator of this parent.So you cant take any action on it.";
			}
								
}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);
?>