<?php
include('model/missions.php');
include('model/users.php');

$usrObj = new Model_Users();
$msnObj = new Model_Mission();

//echo "<pre>";print_r($_POST);exit;

$marray = array();
if($_POST['missionId'] != '' && $_POST['childId'])
{
		
		//echo "<pre>";print_r($_POST);exit;
			$missionId = $_POST['missionId'];
			$childId = $_POST['childId'];
			
			
			$missionArray = $msnObj->checkTheAssignedMission($missionId,$childId);
			
			if($missionArray)
			{
				$array = array();
				$array['status'] = '2';	
	
				$missionId = $msnObj->editMission($array,$missionId);
	
	
				$missionDetails = $msnObj->getMissionDetailsById($missionId);
				
				
							$childDetails = $usrObj->getUserInformationByUserId($childId);
							$description = 'Mission is accepted by'.$childDetails['fname'].' '.$childDetails['lname'].' :'.$missionDetails['title'];
							$activityArray = array();
							$activityArray['userId'] = $missionDetails['parentId'];	
							$activityArray['description'] = $description;	
							$activityArray['activity_type'] = '2';
							$activityArray['inserted_date'] = date("Y-m-d H:i:s");	
							$usrObj->addActivity($activityArray);




     $parentDetails = $usrObj->getUserDetailsByUserId($missionDetails['parentId']);
                                                          
							// send ios push  notification to the parent.
                                                        $devicetoken = $parentDetails['devicetoken'];
                                                        $message =  'Mission is accepted by'.$childDetails['fname'].' '.$childDetails['lname'].' :'.$missionDetails['title'];
                                                        sendPushNotificationToIOSDevice($devicetoken,$message)






				$marray['success']['code'] = "100";
				$marray['success']['message'] = "Mission has been accepted. Your mission has begun!";	
			}
			else
			{
				$marray['error']['code'] = "102";
				$marray['error']['message'] = "This mission is not asigned to you.";
			}
								
}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);
?>
