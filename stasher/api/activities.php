<?php
include('model/users.php');

$usrObj = new Model_Users();

//echo "<pre>";print_r($_POST);exit;
	
	



		
$marray = array();
if($_POST['userId'] != '' )
{

			$userId = $_POST['userId'];
			
			$userArray = $usrObj->getUserDetailsByUserId($userId);
			$userRelationArray = $usrObj->getMyRelatives($userId,$userArray['usertype']);
			
			
			//echo "<pre>";print_r($userRelationArray);
			$newarray = array_values_recursive($userRelationArray);
			array_push($newarray,$userId);
			//print_r($newarray);
			//exit;
			
			$userIds = implode(',',$newarray);
			$activityArray = $usrObj->getGlobalActivities($userIds);
			//echo "<pre>";print_r($activityArray);
	
				if($activityArray)
				{			
					$k=0;
					while($k < count($activityArray) )
					{
						
						$activityuserdetails[$k] = $usrObj->getUserInformationByUserId($activityArray[$k]['userId']);
						
						
						$marray[$k]['userId'] = $activityArray[$k]['userId'];
						$marray[$k]['fname'] = $activityuserdetails[$k]['fname'];
						$marray[$k]['lname'] = $activityuserdetails[$k]['lname'];
						$marray[$k]['avatar'] = SITEURL.'/dynamicAssets/users/avatar/'.$activityuserdetails[$k]['avatar'];
						$marray[$k]['description'] = $activityArray[$k]['description'];
						$marray[$k]['inserted_date'] = $activityArray[$k]['inserted_date'];						
						$marray[$k]['activity_type'] = $activityArray[$k]['activity_type'];
						$marray[$k]['seenstatus'] = $activityArray[$k]['seenstatus'];
						
						$k++;
					}
				}
				else
				{
					$marray['error']['code'] = "404";
					$marray['error']['message'] = "There is no activity";
					
				}
				
		
								
}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);
?>
