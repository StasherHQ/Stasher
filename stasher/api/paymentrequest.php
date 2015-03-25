<?php
include('model/missions.php');

include('model/users.php');
$missionObj = new Model_Mission();

$usrObj = new Model_Users();
//echo "<pre>";print_r($_POST);exit;
	
$marray = array();
if($_POST['childId'] != '' )
{


			$childId = $_POST['childId'];
			$parentId = $_POST['parentId'];

		
			$price = $_POST['price'];
			$description = $_POST['comment'];			
			$currentdate = date("Y-m-d H:i:s");
						
			$paymentArray = array();	
			$paymentArray['childId'] = $childId;	
			$paymentArray['parentId'] = $parentId;	
			$paymentArray['price'] = $price;	
			$paymentArray['description'] = $description;	
			$paymentArray['inserted_date'] = date("Y-m-d H:i:s");	
			$paymentArray['status'] = 2;	
			$missionObj->newPaymentRequest($paymentArray);	
                        
                        
                        
                        $childDetails = $usrObj->getUserInformationByUserId($childId);
			$description = "New payment request from the secret agent  ".$childDetails['fname']." ".$childDetails['lname']." for the mission " ;
			$activityArray1 = array();
			$activityArray1['userId'] = $parentId;	
			$activityArray1['description'] = $description;	
			$activityArray1['activity_type'] = '3';
			$activityArray1['inserted_date'] = date("Y-m-d H:i:s");	
			$usrObj->addActivity($activityArray1);
			

$parentDetails = $usrObj->getUserDetailsByUserId($parentId);
                                                          
				
			// send ios push  notification to the child.
                        $devicetoken = $parentDetails2['devicetoken'];
                        $message = "New payment request from the secret agent  ".$childDetails['fname']." ".$childDetails['lname']." for the mission " ;
                        sendPushNotificationToIOSDevice($devicetoken,$message);
                                                        
                                                        
			
			$marray['success']['code'] = "102";
			$marray['success']['message'] = "Request sent successfully!";
								
}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);
?>
