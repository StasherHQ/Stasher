<?php
include('model/users.php');

$usrObj = new Model_Users();

		
$marray = array();
if($_POST['userId'] != '')
{
		
		$tutorialshow = $_POST['tutorialshow'];
		$userId = $_POST['userId'];			
		$parray = array();
		$parray['tutorialshow'] = $tutorialshow;
		$usrObj->editUserInformation($parray,$userId);
				
				
								
		$marray['success']['code'] = "100";
		$marray['success']['message'] = "Tutorial show updated succesfully.";

			
		
}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);
?>
