<?php
include('model/missions.php');
include('model/users.php');

$usrObj = new Model_Users();
$msnObj = new Model_Mission();

//echo json_encode($_POST);exit;
	
//echo json_encode($_POST['childId']);		
$marray = array();
if($_POST['title'] != ''  && $_POST['isTimebase'] != ''  && $_POST['parentId'] != '' )
{
		
				//echo "<pre>";print_r($_POST);exit;
				$title = $_POST['title'];
				$description = $_POST['description'];
				$isTimebase = $_POST['isTimebase'];
				$parentId = $_POST['parentId'];
				if($_POST['childId'])
				$childIdArray  = explode(',',$_POST['childId']);
				
				$totaltime = $_POST['totaltime'];
				$rewardtype = $_POST['rewardtype'];
				$rewards = $_POST['rewards'];
				$ispublic = $_POST['ispublic'];
				$isdraft = $_POST['isdraft'];
				$inserted_date = $_POST['inserted_date'];
				
				if($isdraft == 'yes' )
				$isdraft = '1';
				else
				$isdraft = '4';
				
				
				$totaltime = date("Y-m-d H:i:s", strtotime($totaltime));
				
				$inserted_date = date("Y-m-d H:i:s", strtotime($inserted_date));
				
				
				$k=0;
				while($k < count($childIdArray) )
				{
					$array = array();
					$array['title'] = $title;
					$array['description'] = $description;
					$array['isTimebase'] = $isTimebase;
					$array['parentId'] = $parentId;
					$array['childId'] = $childIdArray[$k];
					
					if($isTimebase == 'yes')
					$array['totaltime'] = $totaltime;
					
					$array['rewardtype'] = $rewardtype;
					$array['rewards'] = $rewards;
					$array['start_time'] = $inserted_date;
					$array['end_time'] = $totaltime;
					$array['isPublic'] = $ispublic;
					$array['inserted_date'] = $inserted_date;	
					$array['status'] = $isdraft;	
				
					//print_r($array);
					$missionId = $msnObj->addMission($array);
					
					
							$parentDetails = $usrObj->getUserInformationByUserId($parentId);
							$description = 'Heads up! You have a new Mission waiting to be tackled! Accept right now. '.$parentDetails['fname'].' '.$parentDetails['lname'];
							$activityArray1 = array();
							$activityArray1['userId'] = $childIdArray[$k];
							$activityArray1['title'] = "Heads up! You have a new Mission waiting to be tackled! Accept right now.".$parentDetails['fname'].' '.$parentDetails['lname'];;		
							$activityArray1['description'] = $description;	
							$activityArray1['requestfrom'] = $parentId;
							$activityArray1['activity_type'] = '3';
							$activityArray1['inserted_date'] = $inserted_date;	
							$usrObj->addActivity($activityArray1);

                                                        $childDetails = $usrObj->getUserDetailsByUserId($childIdArray[$k]);
                                                          
							// send ios push  notification to the child.
                                                        $devicetoken = $childDetails['devicetoken'];
                                                        $message = "New mission added by ".$parentDetails['fname']." ".$parentDetails['lname'];
                                                        sendPushNotificationToIOSDevice($devicetoken,$message);	
											
											

					
					$k++;
				}
				
			$marray['success']['code'] = "100";
			$marray['success']['message'] = "Standby, your Mission has been sent to Childs name";	
								
}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);
?>
