<?php
class Model_Country extends Database
{	
	## Constructor
	function Model_Country() {
		$this->country = COUNTRY;
		$this->Database();
	}	
	

	function getAllActiveCountries(){
		$fields = array();
		$tables = array($this->country);
		
		$result = $this->SelectData($fields,$tables, $where, $order = array("country_name ASC"), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchAll($result);
		return $result1;
	}
}
?>