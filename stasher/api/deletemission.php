<?php
include('model/missions.php');

$msnObj = new Model_Mission();
	
	
$marray = array();
if($_POST['missionId'] != ''  && $_POST['parentId'] != '' )
{
		
				//echo "<pre>";print_r($_POST);exit;
				
			$missionId = $_POST['missionId'];
			$parentId = $_POST['parentId'];	
			
			
			$missionArray = $msnObj->checkTheCreatorOfMission($missionId,$parentId);
			
			if($missionArray)
			{
				$array = array();			
				$array['status'] = 0;
				$missionId = $msnObj->editMission($array,$missionId);
				
$childId = $missionArray['childId'];

$childDetails = $usrObj->getUserInformationByUserId($childId);
							$description = 'Mission has been cancelled by '.$childDetails['fname'].' '.$childDetails['lname'];
							$activityArray1 = array();
							$activityArray1['userId'] = $childId;	
							$activityArray1['description'] = $description;	
							$activityArray1['activity_type'] = '2';
							$activityArray1['inserted_date'] = $inserted_date;	
							$usrObj->addActivity($activityArray1);

							
                                                        $parentDetails = $usrObj->getUserDetailsByUserId($childId);
                                                          
							// send ios push  notification to the child.
                                                        $devicetoken = $parentDetails['devicetoken'];
                                                        $message = 'Mission has been cancelled by '.$childDetails['fname'].' '.$childDetails['lname'];
                                                        sendPushNotificationToIOSDevice($devicetoken,$message);	


								
				$marray['success']['code'] = "100";
				$marray['success']['message'] = "Your Mission has been cancelled.";	
			}
			else
			{
				$marray['error']['code'] = "104";
				$marray['error']['message'] = "You are not authorized to delete this mission.";	
			}
								
}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);
?>
