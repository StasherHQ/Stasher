<?php
include('model/badges.php');

$badgeObj = new Model_Badges();

//echo "<pre>";print_r($_POST);exit;
		
$marray = array();
			
$badgeArray = $badgeObj->getAllBadges();
		if($badgeArray)
		{			
																																																	$k=0;
																																																	while($k < count($badgeArray) )
																																																	{
																																																		$marray[$k]['id'] = $badgeArray[$k]['id'];
																																																		$marray[$k]['title'] = $badgeArray[$k]['title'];
																																																		$marray[$k]['image'] = $badgeArray[$k]['image'];
																																																		
																																																		$marray[$k]['inserted_date'] = $badgeArray[$k]['inserted_date'];
																																																		
																																																		$k++;
																																																
}
}		
echo json_encode($marray);
?>
