<?php
class Model_Badges extends Database
{	
	## Constructor
	function Model_Badges() {
		$this->user_badges = USERBADGES;
		$this->user_personal = USERPERSONAL;
		$this->badges = BADGES;
		$this->Database();
	}	
	
function addUserBadge($Array) {
		$this->InsertData( $this->user_badges,$Array);		
		$insertId = mysql_insert_id();
		return $insertId;
	}
	

function getAllUserBadges($userId){
		$fields = array();
		$tables = array($this->user_badges.' as ub',$this->badges.' as b');
		$where  = array("childId= '".$userId."' AND ub.badgeId = b.id");
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchAll($result);
		return $result1;
	}
	
	function getAllBadges(){
		$fields = array();
		$tables = array($this->badges);
		$where  = array("status='2'");
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchAll($result);
		return $result1;
	}
	
}
?>