<?php
include('model/missions.php');

$missionObj = new Model_Mission();
		
$marray = array();
if($_POST['q'] != '')
{
		
		$q = $_POST['q'];

			
			$missionArray = $missionObj->searchMissionsByQuery($q);
			if($missionArray)
			{
			//echo "<pre>";
			//print_r($missionArray);
			//exit;
			$k=0;
			$user = array();
			while($k < count($missionArray))
			{
				$user[$k]['userId']= $missionArray[$k]['userId'];
				$user[$k]['title']= $missionArray[$k]['title'];
				$user[$k]['description']= $missionArray[$k]['description'];
				$user[$k]['isTimebase']= $missionArray[$k]['isTimebase'];
				$user[$k]['totaltime']= $missionArray[$k]['totaltime'];
				$user[$k]['inserted_date']= $missionArray[$k]['inserted_date'];
				$user[$k]['isPublic']= $missionArray[$k]['isPublic'];
				$user[$k]['parent']['fname']= $missionArray[$k]['fname'];
				$user[$k]['parent']['lname']= $missionArray[$k]['lname'];
				$user[$k]['parent']['avatar']= $missionArray[$k]['avatar'];
			$marray = $user;
				$k++;
			}
			
			}
			else
				{
					$marray['error']['code'] = "102";
					$marray['error']['message'] = "No mission found.";
				}
}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);
?>
