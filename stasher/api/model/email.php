<?php
class Model_Email extends Database
{	
	## Constructor
	function Model_Email() {
		$this->email = EMAILTEMPLATES;
		$this->Database();
	}	
	

	function getEmaildetailsByEmailId($id){
		$fields = array();
		$tables = array($this->email);
		if($id){
			$where  = array("id= '".$id."'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchRow($result);
		return $result1;
	}
}
?>