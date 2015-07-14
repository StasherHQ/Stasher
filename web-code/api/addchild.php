<?php
include('model/users.php');

$usrObj = new Model_Users();

if($_POST['parentId'] != ''  &&  $_POST['childId'] != '')
{
	$parentId = $_POST['parentId'];
	$childId = $_POST['childId'];
	$userArray2 = $usrObj->getUserDetailsByUserId($childId);
		if($userArray2)
		{
			$userArray3 = $usrObj->checkRelationExistOrNot($childId,$parentId);
			$relation_type = $_POST['relation_type'];
			$userArray1 = $usrObj->getUserDetailsByUserId($parentId);
			if($userArray1)
			{
			
			if(count($userArray3) < 1)
			{
						
			if($relation_type == '2')
				$relation = 'Family'
			elseif($relation_type == '3')					
				$relation = 'Friend';
			else
				$relation = 'Parent';
	
			$userArray = array();	
			$userArray['childId'] = $childId;	
			$userArray['parentId'] = $parentId;
			$userArray['requestfrom'] = $parentId;	
			$userArray['requestto'] = $childId;	
			$userArray['parent_type'] = $relation_type;	
			$userArray['relation_name'] = $relation;	
			$userArray['inserted_date'] = date("Y-m-d H:i:s");	
			$userArray['status'] = 1;	
			$usrObj->addRelation($userArray);
			
			$childDetails = $usrObj->getUserInformationByUserId($childId);
			$parentDetails = $usrObj->getUserInformationByUserId($parentId);
			$description = 'New parent request from '.$parentDetails['fname'].' '.$parentDetails['lname'];
			
			$activityArray = array();
			$activityArray['userId'] = $childId;
			$activityArray['title'] = 'parent request from '.$parentDetails['fname'].' '.$parentDetails['lname'];
			$activityArray['description'] = $description;
			$activityArray['requestfrom'] = $parentId;	
			$activityArray['activity_type'] = '11';
			$activityArray['inserted_date'] = date("Y-m-d H:i:s");	
			$usrObj->addActivity($activityArray);
							
			// send ios push  notification to the child.
                        $devicetoken = $childDetails['devicetoken'];
                        sendPushNotificationToIOSDevice($devicetoken,$description);
                                                      
			$marray['success']['code'] = "102";
			$marray['success']['message'] = "A child request has been sent!";
			}
			else
			{
				$marray['error']['code'] = "102";
				$marray['error']['message'] = "A child is already added or request already sent!";
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
			$marray['error']['code'] = "102";
			$marray['error']['message'] = "Invalid child";
		}
	
}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);
?>
