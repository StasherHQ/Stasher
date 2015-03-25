<?php
include('model/missions.php');
$msnObj = new Model_Mission();
include('model/users.php');
$missionObj = new Model_Mission();

//echo "<pre>";print_r($_POST);exit;
	
$marray = array();
if($_POST['parentId'] != '' )
{
	$parentId = $_POST['parentId'];
	//$requestArray = $missionObj->getRequestListByParentId($parentId);	
			
	
        $requestArray = array();
        $requestArray[0]['date'] = '2015-03-15';
        $requestArray[0]['amount'] = '0';
        
          $requestArray[1]['date'] = '2015-03-14';
        $requestArray[1]['amount'] = '0';
        
          $requestArray[2]['date'] = '2015-03-13';
        $requestArray[2]['amount'] = '0';
          $requestArray[3]['date'] = '2015-03-12';
        $requestArray[3]['amount'] = '0';
          $requestArray[4]['date'] = '2015-03-11';
        $requestArray[4]['amount'] = '0';
          $requestArray[5]['date'] = '2015-03-10';
        $requestArray[5]['amount'] = '0';
          $requestArray[6]['date'] = '2015-03-09';
        $requestArray[6]['amount'] = '0';
        
        if($requestArray)
				{			
					$k=0;
					while($k < count($requestArray) )
					{
	
						$marray[$k]['amount'] = $requestArray[$k]['amount'];
					$marray[$k]['date'] = $requestArray[$k]['date'];
						
						$k++;
					}
				}
				else
				{
					$marray['error']['code'] = "101";
					$marray['error']['message'] = "No transactions yet.";
					
				}
				
}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);
?>
