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
							$description = $childDetails['fname'].' '.$childDetails['lname'].' has canceled your Mission! Start another? ';
							$activityArray1 = array();
							$activityArray1['userId'] = $childId;	
$activityArray1['title'] = "Mission canceled by ".$childDetails['fname'].' '.$childDetails['lname'];	
							$activityArray1['description'] = $description;	
							$activityArray1['activity_type'] = '5';
							$activityArray1['requestfrom'] = $parentId;	
							$activityArray1['inserted_date'] = $inserted_date;	
							$usrObj->addActivity($activityArray1);

							
                                                        $parentDetails = $usrObj->getUserDetailsByUserId($childId);
                                                          
							// send ios push  notification to the child.
                                                        $devicetoken = $parentDetails['devicetoken'];
                                                        $message = $childDetails['fname'].' '.$childDetails['lname'].' has canceled your Mission! Start another? ';
                                                        sendPushNotificationToIOSDevice($devicetoken,$message);	


								
				$marray['success']['code'] = "100";
				$marray['success']['message'] = "Oh no, ".$childDetails['fname']." ".$childDetails['lname'].". You’ve canceled Parents name’s Mission! Start another?";	
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
