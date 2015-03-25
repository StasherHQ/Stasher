<?php
class Model_CMS extends Database
{	
	## Constructor
	function Model_CMS() {
		$this->cmspages = CMSPAGES;
		$this->Database();
	}	
	
	function getCMSPageDetailsById($id){
		$fields = array();
		$tables = array($this->cmspages);
		if($id){
			$where  = array("id= '".$id."'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchRow($result);
		return $result1;
	}	
}
?>