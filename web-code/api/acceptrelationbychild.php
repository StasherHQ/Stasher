<?php
include('model/users.php');

$usrObj = new Model_Users();

if($_POST['parentId'] != ''  &&  $_POST['childId'] != '')
{
		$parentId = $_POST['parentId'];
		$childId = $_POST['childId'];
		$relation_type = $_POST['relation_type'];
		$userArray1 = $usrObj->getUserDetailsByUserId($parentId);
		if($userArray1)
		{
			
			$userArray2 = $usrObj->getUserDetailsByUserId($childId);
			
					if($userArray2)
					{
						$userArray3 = $usrObj->checkRelationExistOrNot($childId,$parentId);
						if(count($userArray3) < 1)
						{
						
							if($relation_type == '2')
							$relation = 'Family';
							elseif($relation_type == '3')					
							$relation = 'Friend';
							else
							$relation = 'Parent';
							
							$userArray = array();	
							$userArray['childId'] = $childId;	
							$userArray['parentId'] = $parentId;	
							$userArray['parent_type'] = $relation_type;	
							$userArray['relation_name'] = $relation;	
							$userArray['inserted_date'] = date("Y-m-d H:i:s");	
							$userArray['status'] = 1;	
							$usrObj->addRelation($userArray);
							
							$childDetails = $usrObj->getUserInformationByUserId($childId);
							$description = ''.$childDetails['fname'].' '.$childDetails['lname'].'  a child is added to the list.';
							$activityArray = array();
							$activityArray['userId'] = $userId;	
$activityArray['title'] = "A child added ".$childDetails['fname'].' '.$childDetails['lname'];
							$activityArray['description'] = $description;
							$activityArray['requestfrom'] = $childId;		
							$activityArray['activity_type'] = '3';
							$activityArray['inserted_date'] = date("Y-m-d H:i:s");	
							$usrObj->addActivity($activityArray);
							
							$parentDetails = $usrObj->getUserInformationByUserId($parentId);
							$description = 'New parent request from '.$parentDetails['fname'].' '.$parentDetails['lname'];
							$activityArray1 = array();
							$activityArray1['userId'] = $parentId;	
$activityArray1['title'] = "Parent request by ".$parentDetails['fname'].' '.$parentDetails['lname'];
							$activityArray1['description'] = $description;
							$activityArray1['requestfrom'] = $parentId;	
							$activityArray1['activity_type'] = '3';
							$activityArray1['inserted_date'] = date("Y-m-d H:i:s");	
							$usrObj->addActivity($activityArray1);
							
							// send ios push  notification to the child.
                                                        $devicetoken = $userArray2['devicetoken'];
                                                        $message = "You are added as a child for the parent ".$parentDetails['fname']." ".$parentDetails['lname'];
                                                        sendPushNotificationToIOSDevice($devicetoken,$message);
                                                        
							
							$marray['success']['code'] = "102";
							$marray['success']['message'] = "A child request has been sent!";
						}
						else
						{
							$marray['error']['code'] = "102";
							$marray['error']['message'] = "A child is already added.";
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
