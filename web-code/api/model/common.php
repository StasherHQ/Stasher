<?php
class Model_Common extends Database 
{	
	## Constructor
	function Model_Common() {
		$this->siteSettings = SITESETTINGS;
		$this->Database();
	}	
	
## List all variables
	function getAllVariables() {
		$fields = array();	
		$tables = array($this->siteSettings);		
		$where = array();
		$result1 = $this->SelectData($fields,$tables, $where, $order = array("id"), $group=array(),$limit='',0,0); 
		$result  = $this->FetchAll($result1); 
		return $result;
	}
		## get valiables values by id
	function getSettingValueById($id) {
		
		$fields = array();	
		$tables = array($this->siteSettings);
		$result1 = $this->SelectData($fields,$tables, $where= array("id ='".$id."'"), $order = array(), $group=array(),$limit = "",0,0); 
		$result  = $this->FetchRow($result1); 
		return $result;
	}
	function editSettingsByValueId($array,$id)
	{
		$this->UpdateData($this->siteSettings,$array,"id",$id,0);		
	}
}
?>