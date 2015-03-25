<?php
include('model/users.php');

$usrObj = new Model_Users();



						
					
		
		
$marray = array();
if($_POST['q'] != '')
{
		
		$q = $_POST['q'];

			
			$userArray = $usrObj->searchParentByQuery($q);
			if($userArray)
			{
			//echo "<pre>";
			//print_r($userArray);
			//exit;
			$k=0;
			$user = array();
			while($k < count($userArray))
			{
				$user[$k]['userId']= $userArray[$k]['userId'];
				$user[$k]['username']= $userArray[$k]['username'];
				$user[$k]['email']= $userArray[$k]['email'];
				$user[$k]['usertype']= $userArray[$k]['usertype'];
				$user[$k]['registered_date']= $userArray[$k]['registered_date'];
				$user[$k]['fname']= $userArray[$k]['fname'];
				$user[$k]['lname']= $userArray[$k]['lname'];
				$user[$k]['gender']= $userArray[$k]['gender'];
				$user[$k]['country']= $userArray[$k]['country'];
				$user[$k]['dob']= $userArray[$k]['dob'];
				if($userArray[$k]['avatar'])
				$user[$k]['avatar']= SITEURL.'/dynamicAssets/users/avatar/'.$userArray[$k]['avatar'];
				else
				$user[$k]['avatar'] = '';
			$marray = $user;
				$k++;
			}
			
			}
			else
				{
					$marray['error']['code'] = "102";
					$marray['error']['message'] = "No commander found!";
				}
}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);
?>