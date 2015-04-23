<?php
include('model/missions.php');

$msnObj = new Model_Mission();

//echo "<pre>";print_r($_POST);exit;

$marray = array();
if($_POST['missionId'] != '' && $_POST['childId'])
{
		
		//echo "<pre>";print_r($_POST);exit;
			$missionId = $_POST['missionId'];
			$childId= $_POST['childId'];
			
			// it will check this mission is assigned to child or not?
			$missionArray = $msnObj->checkTheAssignedMission($missionId,$childId);
			
			if($missionArray)
			{
				$array = array();
				$array['status'] = '5';	
				// change the status of mission
				$missionId = $msnObj->editMission($array,$missionId);
	
				$marray['success']['code'] = "100";
				$marray['success']['message'] = "Good work! You have marked your Mission complete. A confirmation request 
has been sent to your parent.";

$parentId = $missionArray['parentId'];

							$childDetails = $usrObj->getUserInformationByUserId($childId);
	$description = 'Congrats, '.$childDetails['fname'].' '.$childDetails['lname'].' completed their Mission! Approve now to send reward!'.$childDetails['fname'].' '.$childDetails['lname'];
							$activityArray1 = array();
							$activityArray1['userId'] = $parentId;	
$activityArray1['title'] = "Mission completed by ".$childDetails['fname'].' '.$childDetails['lname'];
							$activityArray1['description'] = $description;
							$activityArray1['requestfrom'] = $childId;		
							$activityArray1['activity_type'] = '7';
							$activityArray1['inserted_date'] = $inserted_date;	
							$usrObj->addActivity($activityArray1);

							
                                                        $parentDetails = $usrObj->getUserDetailsByUserId($parentId);
                                                          
							// send ios push  notification to the child.
                                                        $devicetoken = $parentDetails['devicetoken'];
                                                        $message = "Mission complete, ".$childDetails['fname']."".$childDetails['lname']."! On to the next one!";
                                                        sendPushNotificationToIOSDevice($devicetoken,$message);	


	
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
