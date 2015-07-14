<?php
include('model/users.php');
include('model/missions.php');

$msnObj = new Model_Mission();
$usrObj = new Model_Users();


if($_POST['parentId'] != ''  &&  $_POST['childId'] != '' &&  $_POST['missionId'] != '')
{
		$parentId = $_POST['parentId'];
		$childId = $_POST['childId'];
		$missionId = $_POST['missionId'];
		$message = $_POST['message'];
		
		$userArray1 = $usrObj->getUserDetailsByUserId($parentId);
		if($userArray1)
		{
			
			$userArray2 = $usrObj->getUserDetailsByUserId($childId);
			
					if($userArray2)
					{
						
						
							
							$userArray = array();	
							$userArray['childId'] = $childId;	
							$userArray['parentId'] = $parentId;	
							$userArray['message'] = $message;	
							$userArray['missionId'] = $missionId;	
							$userArray['inserted_date'] = date("Y-m-d H:i:s");	
							$userArray['status'] = 2;	
							$msnObj->addNoteToMission($userArray);
							
							$missionArray = $msnObj->getMissionDetailsById($missionId);
							$parentDetails = $usrObj->getUserInformationByUserId($parentId);
							$childDetails = $usrObj->getUserInformationByUserId($childId);
						
							$description = ' Don’t forget! You have Mission '.$missionArray['title'].' from '.$parentDetails['fname'].' '.$parentDetails['lname'].' waiting to be tackled!';
							$activityArray1 = array();
							$activityArray1['userId'] = $childId;	
							$activityArray1['title'] = $parentDetails['fname'].' '.$parentDetails['lname'];	
							$activityArray1['description'] = $description;	
							$activityArray['requestfrom'] = $parentId;
							$activityArray1['activity_type'] = '9';
							$activityArray1['inserted_date'] = date("Y-m-d H:i:s");	
							$usrObj->addActivity($activityArray1);
							
							
							
							$childDetails = $usrObj->getUserDetailsByUserId($childId);
                                                          
							// send ios push  notification to the child.
                                                        $devicetoken = $childDetails['devicetoken'];
                                                        $message = ' Don’t forget! You have Mission '.$missionArray['title'].' from '.$parentDetails['fname'].' '.$parentDetails['lname'].' waiting to be tackled!';
                                                        sendPushNotificationToIOSDevice($devicetoken,$message);	
							
							$marray['success']['code'] = "102";
							$marray['success']['message'] = "You’ve reminded ".$childDetails['fname'].' '.$childDetails['lname']." about Mission ".$missionArray['title'].".";
						
								
					}
					else
					{
						$marray['error']['code'] = "102";
						$marray['error']['message'] = "Invalid child";
					}
			
		}
		else
		{
			$marray['error']['code'] = "102";
			$marray['error']['message'] = "Invalid parent";
		}
	
}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);
?>
