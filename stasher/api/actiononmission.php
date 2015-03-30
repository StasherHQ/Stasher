<?php
include('model/missions.php');
include('model/badges.php');
$msnObj = new Model_Mission();
$badgeObj = new Model_Badges();
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
	
// check how many mission child has been completed 

$totalcompletedmissions = $msnObj->getCountOfCompletedMissionByChildId($missionArray['childId']);

// if first mission is completed then child will getfirst mission badge
if($totalcompletedmissions == '1')
{

$barray = array();
$barray['badgeId'] = 3;
$barray['childId'] = $missionArray['childId'];
$barray['inserted_date'] = date("Y-m-d H:i:s");
$userbadge = $badgeObj->addUserBadge($barray);
}
// if 3 missions are completed then child will get master stasher badge
if($totalcompletedmissions == '3')
{

$barray = array();
$barray['badgeId'] = 4;
$barray['childId'] = $missionArray['childId'];
$barray['inserted_date'] = date("Y-m-d H:i:s");
$userbadge = $badgeObj->addUserBadge($barray);
}
// if 25 missions are completed then child will get busy bee badge
if($totalcompletedmissions == '25')
{

$barray = array();
$barray['badgeId'] = 5;
$barray['childId'] = $missionArray['childId'];
$barray['inserted_date'] = date("Y-m-d H:i:s");
$userbadge = $badgeObj->addUserBadge($barray);
}


							$parentDetails = $usrObj->getUserInformationByUserId($parentId);
 							$childDetails = $usrObj->getUserDetailsByUserId($missionArray['childId']);
							$missionInfoArray = $msnObj->getMissionDetailsById($missionId);
                                                        




							$description ="Your mission completion request has been accepted by ".$parentDetails['fname']." ".$parentDetails['lname'];
							$activityArray1 = array();
							$activityArray2 = array();
							$activityArray2['userId'] = $missionArray['childId'];	
							$activityArray1['userId'] = $missionArray['childId'];	
							$activityArray1['description'] = $description;	
							$activityArray1['activity_type'] = '2';
							$activityArray1['inserted_date'] = date("Y-m-d H:i:s");	
							$usrObj->addActivity($activityArray1);

							if($missionInfoArray['rewardtype'] == 'cash')
{

 $description = $missionInfoArray['rewards']." amount of Money is transfered by ".$parentDetails['fname']." ".$parentDetails['lname'];
} 
else
{
 $description = "Please check with   ".$parentDetails['fname']." ".$parentDetails['lname']." fr your rewards." ;
	
}
							
$activityArray2['description'] = $description;	
							$activityArray2['activity_type'] = '2';
							$activityArray2['inserted_date'] = date("Y-m-d H:i:s");	
							$usrObj->addActivity($activityArray2);


                                                       
if($missionInfoArray['rewardtype'] == 'cash')
{

 $paymentmessage = $missionInfoArray['rewards']." amount of Money is transfered by ".$parentDetails['fname']." ".$parentDetails['lname'];
} 
else
{
 $paymentmessage = "Please check with   ".$parentDetails['fname']." ".$parentDetails['lname']." fr your rewards." ;
	
}





							// send ios push  notification to the child.
                                                        $devicetoken = $childDetails['devicetoken'];
                                                        $message = "Your mission completion request has been accepted by ".$parentDetails['fname']." ".$parentDetails['lname'];
                                                        sendPushNotificationToIOSDevice($devicetoken,$message);	


                                                        sendPushNotificationToIOSDevice($devicetoken,$paymentmessage);	





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
