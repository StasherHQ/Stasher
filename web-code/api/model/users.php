<?php
class Model_Users extends Database
{	
	## Constructor
	function Model_Users() {
		$this->user = USERS;
		$this->user_personal = USERPERSONAL;
		$this->user_relation = USERRELATION;
		$this->user_activities = USERACTIVITIES;
                $this->transactions = TRANSACTIONS;
		$this->Database();
	}	
	
	function addUser($Array) {
		$this->InsertData( $this->user,$Array);		
		$insertId = mysql_insert_id();
		return $insertId;
	}
        
        function addTransaction($Array) {
		$this->InsertData( $this->transactions,$Array);		
		$insertId = mysql_insert_id();
		return $insertId;
	}
        
	function addRelation($Array) {
		$this->InsertData( $this->user_relation,$Array);		
		$insertId = mysql_insert_id();
		return $insertId;
	}
	function addUserInformation($Array) {
		$this->InsertData( $this->user_personal,$Array);		
		$insertId = mysql_insert_id();
		return $insertId;
	}
	function editUser($array, $Id){
		$this->UpdateData($this->user,$array,"userId",$Id,0);
	}

	function editUserInformation($array, $Id){
		$this->UpdateData($this->user_personal,$array,"userId",$Id,0);
	}
	function editActivity($array, $Id){
		$this->UpdateData($this->user_activities,$array,"id",$Id,0);
	}

	function editRelation($array, $where){
		
		$this->UpdateDataWithWhere($this->user_relation,$array,$where,0);
	}


	function checkEmailExists($email,$id){
		$fields = array();
		$tables = array($this->user);
		if($id){
			$where  = array("email='".$email."' AND userId!= ".$id." AND status!='0'");
		}else{
			$where  = array("email='".$email."' AND status!='0'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchRow($result);
		return $result1;
	}
	function checkUsernameExists($email,$id){
		$fields = array();
		$tables = array($this->user);
		if($id){
			$where  = array("username='".$email."' AND userId!= ".$id." AND status!='0'");
		}else{
			$where  = array("username='".$email."' AND status!='0'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchRow($result);
		return $result1;
	}
	function getUserDetailsByUsernameOrEmail($username){
		$fields = array();
		$tables = array($this->user);
		if($username){
			$where  = array("(username='".$username."' OR email='".$username."' )  AND usertype <> '1' AND status <> '0'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchRow($result);
		return $result1;
	}
        
        function getUserLastTransactionDetails($userId){
		$fields = array();
		$tables = array($this->transactions);
		if($userId){
			$where  = array("parentId='".$userId."'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array("id DESC"), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchRow($result);
		return $result1;
	}
        
        
        
	function getUserDetailsByUsernameOrEmailWithPassword($username,$password){
		$fields = array();
		$tables = array($this->user);
		if($username){
			$where  = array("(username='".$username."' OR email='".$username."' )  AND password='".$password."' AND status!='0'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchRow($result);
		return $result1;
	}
	function checkOldPasswordCorrectOrWrong($userId,$password){
		$fields = array();
		$tables = array($this->user);
		if($userId){
			$where  = array("userId = '".$userId."'  AND password='".$password."' AND status!='0'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchRow($result);
		return $result1;
	}
	
	function getUserDetailsByUserId($userId){
		$fields = array();
		$tables = array($this->user);
		if($userId){
			$where  = array("userId='".$userId."'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchRow($result);
		return $result1;
	}
	function getUserInformationByUserId($userId){
		$fields = array();
		$tables = array($this->user_personal);
		if($userId){
			$where  = array("userId='".$userId."'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchRow($result);
		return $result1;
	}
	function searchChildrenByQuery($q, $orderField='p.fname', $orderBy='DESC', $limit='',$offset=''){
		$fields = array("");
		$tables = array($this->user.' as u',$this->user_personal.' as p');
		$where = array('u.userId= p.userId AND u.usertype = "3" AND u.status="2" AND u.userId <> "1"');
		if($q) {
			$where[] = '(p.fname LIKE "%'.$q.'%" OR p.lname LIKE "%'.$q.'%" OR u.username LIKE "%'.$q.'%" OR u.email LIKE "%'.$q.'%" )';
		}
		
		$order = array("$orderField $orderBy");
		$result1 = $this->SelectData($fields,$tables,$where,$order,$group,$limit,$offset,0);
		$result = $this->FetchAll($result1);
		return $result;
	}
	
	function searchParentByQuery($q, $orderField='p.fname', $orderBy='DESC', $limit='',$offset=''){
		$fields = array("");
		$tables = array($this->user.' as u',$this->user_personal.' as p');
		$where = array('u.userId= p.userId AND u.usertype = "4" AND u.status="2" AND u.userId <> "1"');
		if($q) {
			$where[] = '(p.fname LIKE "%'.$q.'%" OR p.lname LIKE "%'.$q.'%" OR u.username LIKE "%'.$q.'%" OR u.email LIKE "%'.$q.'%" )';
		}
		
		$order = array("$orderField $orderBy");
		$result1 = $this->SelectData($fields,$tables,$where,$order,$group,$limit,$offset,0);
		$result = $this->FetchAll($result1);
		return $result;
	}
	
	function getAllChildrenOfParentByUserId($userId){
		$fields = array();
		$tables = array($this->user_relation);
		if($userId){
			$where  = array("parentId='".$userId."' AND status='2'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchAll($result);
		return $result1;
	}
	function getAllParentdOfChildByUserId($userId){
		$fields = array();
		$tables = array($this->user_relation);
		if($userId){
			$where  = array("childId='".$userId."' AND status='2'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchAll($result);
		return $result1;
	}
	function checkRelationExistOrNot($childId,$parentId){
		$fields = array();
		$tables = array($this->user_relation);

		$where  = array("childId='".$childId."' AND parentId='".$parentId."'");
	
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchRow($result);
		return $result1;
	}
	function getMyActivities($userId){
		$fields = array();
		$tables = array($this->user_activities);
		if($userId){
			$where  = array("userId='".$userId."' AND status='2'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array("inserted_date DESC"), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchAll($result);
		return $result1;
	}
	
	function getGlobalActivities($userIds){
		$fields = array();
		$tables = array($this->user_activities);
		if($userIds){
			$where  = array("userId IN ('".$userIds."') AND status='2'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchAll($result);
		return $result1;
	}


	function addActivity($Array) {
		$this->InsertData( $this->user_activities,$Array);		
		$insertId = mysql_insert_id();
		return $insertId;
	}
	function getMyRelatives($userId,$relation){
		
		$tables = array($this->user_relation);
		if($userId){
				if($relation == '3')
				{
					$fields = array('parentId');
					$where  = array("childId='".$userId."' AND status='2'");
				}
				else
				{
					$fields = array('childId');
					$where  = array("parentId='".$userId."' AND status='2'");
				}
			
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchAll($result);
		return $result1;
	}
	
	
	
}
?>
