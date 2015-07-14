<?php
include('model/cms.php');
$cmsObj = new Model_CMS();

	
		


						$pageId = 2;
						// Page Details
						$pageArray  = $cmsObj->getCMSPageDetailsById($pageId);	
						//echo '<pre>';print_r($pageArray);
						$marray = array();
						$marray['page_title'] = $pageArray['page_title'];
						$marray['page_content'] = base64_encode($pageArray['page_content']);
						$marray['inserted_date'] = $pageArray['inserted_date'];
						$marray['status'] = $pageArray['status'];
			

echo json_encode($marray, JSON_FORCE_OBJECT);
?>