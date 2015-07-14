<?php
include('model/users.php');

$usrObj = new Model_Users();

	
		
$marray = array();
if($_POST['userId'] != '')
//if(count($_GET) > 1)
{
		
		$userId = $_POST['userId'];
	
					$userArray  = $usrObj->getUserDetailsByUserId($userId);	
	
					$userArray['info']= $usrObj->getUserInformationByUserId($userArray['userId']);
					$marray['usedetails']['userId'] = $userArray['userId'];
					$marray['usedetails']['email'] = $userArray['email'];
					$marray['usedetails']['username'] = $userArray['username'];
					$marray['usedetails']['registered_date'] = $userArray['registered_date'];
					$marray['usedetails']['usertype'] = $userArray['usertype'];
					$marray['usedetails']['fname'] = $userArray['info']['fname'];
					$marray['usedetails']['lname'] = $userArray['info']['lname'];
					$marray['usedetails']['gender'] = $userArray['info']['gender'];
					$marray['usedetails']['country'] = $userArray['info']['country'];
					$marray['usedetails']['dob'] = $userArray['info']['dob'];
					$marray['usedetails']['avatar'] = SITEURL.'/dynamicAssets/users/avatar/'.$userArray['info']['avatar'];
					
					if($userArray[$k]['info']['avatar']!='')
						$marray['usedetails']['avatar'] = SITEURL.'/dynamicAssets/users/avatar/'.$userArray['info']['avatar'];
						else
						$marray['usedetails']['avatar'] = '';
						
						

					if($userArray['usertype'] == '4')
					{
						$childArray  = $usrObj->getAllChildrenOfParentByUserId($userArray['userId']);
						//echo "<pre>";print_r($childArray);exit;
						
						if($childArray)
						{
							$k=0;
							while($k < count($childArray))
							{
								$childuserarray  = $usrObj->getUserDetailsByUserId($childArray[$k]['childId']);							
								$childuserdetailsarray = $usrObj->getUserInformationByUserId($childArray[$k]['childId']);							
													
								$marray['child'][$k]['userId']= $childuserarray['userId'];							
								$marray['child'][$k]['username']= $childuserarray['username'];
								$marray['child'][$k]['email']= $childuserarray['email'];
								$marray['child'][$k]['usertype']= $childuserarray['usertype'];
								$marray['child'][$k]['registered_date']= $childuserarray['registered_date'];
								$marray['child'][$k]['fname']= $childuserdetailsarray['fname'];
								$marray['child'][$k]['lname']= $childuserdetailsarray['lname'];
								$marray['child'][$k]['gender']= $childuserdetailsarray['gender'];
								$marray['child'][$k]['country']= $childuserdetailsarray['country'];
								$marray['child'][$k]['dob']= $childuserdetailsarray['dob'];
								if($childuserdetailsarray['avatar'] != '')
								$marray['child'][$k]['avatar']= SITEURL.'/dynamicAssets/users/avatar/'.$childuserdetailsarray['avatar'];
								else
								$marray['child'][$k]['avatar'] ='';
								
								$childuserarray = '';
								$childuserdetailsarray = '';
					
								$k++;
							}
						}
						else
						{
							$marray['child'] = "No child added yet.";
						}
						
					}
					else
					{
					
						$parentArray  = $usrObj->getAllParentdOfChildByUserId($userArray['userId']);
						if($parentArray)
						{

							$k=0;
							while($k < count($parentArray))
							{
								$parentuserarray  = $usrObj->getUserDetailsByUserId($parentArray[$k]['parentId']);							
								$parentuserdetailsarray = $usrObj->getUserInformationByUserId($parentArray[$k]['parentId']);							
													
								$marray['parent'][$k]['userId']= $parentuserarray['userId'];							
								$marray['parent'][$k]['username']= $parentuserarray['username'];
								$marray['parent'][$k]['email']= $parentuserarray['email'];
								$marray['parent'][$k]['usertype']= $parentuserarray['usertype'];
								$marray['parent'][$k]['registered_date']= $parentuserarray['registered_date'];
								$marray['parent'][$k]['fname']= $parentuserdetailsarray['fname'];
								$marray['parent'][$k]['lname']= $parentuserdetailsarray['lname'];
								$marray['parent'][$k]['gender']= $parentuserdetailsarray['gender'];
								$marray['parent'][$k]['country']= $parentuserdetailsarray['country'];
								$marray['parent'][$k]['dob']= $parentuserdetailsarray['dob'];
								if($parentuserdetailsarray['avatar']!='')
								$marray['parent'][$k]['avatar']= SITEURL.'/dynamicAssets/users/avatar/'.$parentuserdetailsarray['avatar'];
								else
								$marray['parent'][$k]['avatar'] ='';
								$parentuserarray = '';
								$parentuserdetailsarray = '';
					
								$k++;
							}
						}
						else
						{
							$marray['parent'] = "No parent added yet.";
						}
						
					}

				
			
}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);
?>