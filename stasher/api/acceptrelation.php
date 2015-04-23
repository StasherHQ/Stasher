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
					

							$where = "childId = '".$childId."' AND parentId = '".$parentId."' ";
							$userArray = array();	
							$userArray['status'] = $status;	
							$usrObj->editRelation($userArray,$where);
						
						if($status == '2')
						{	
							$barray = array();
							$barray['badgeId'] = 2;
							$barray['childId'] = $userArray['userId'];
							//$barray['parentId'] = 1;
							$barray['inserted_date'] = date("Y-m-d H:i:s");

							$userbadge = $badgeObj->addUserBadge($barray);
						}


$activityArray = array();
							$childDetails = $usrObj->getUserInformationByUserId($childId);
							if($status = '2')
							{
							$description = 'Your request has been accepted by '.$childDetails['fname'].' '.$childDetails['lname'].' : a child is added to the list.';	
$activityArray['activity_type'] = '13';
							}
							if($status = '0')
							{
							$description = 'Your request has been rejected by '.$childDetails['fname'].' '.$childDetails['lname'].' : a child is added to the list.';
$activityArray['activity_type'] = '13';	
							}

							
							
							$activityArray['userId'] = $parentId;	
							$activityArray['description'] = $description;
							$activityArray['requestfrom'] = $childId;	
							
							$activityArray['inserted_date'] = date("Y-m-d H:i:s");	
							$usrObj->addActivity($activityArray);
							
							$parentDetails = $usrObj->getUserInformationByUserId($parentId);
							
							
							// send ios push  notification to the child.
                                                        $devicetoken = $parentDetails['devicetoken'];
                                                       
                                                        sendPushNotificationToIOSDevice($devicetoken,$description);
                                                        



							
							$marray['success']['code'] = "102";
							$marray['success']['message'] = $description;
						
								
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
