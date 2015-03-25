<?php
class Model_Mission extends Database
{	
	## Constructor
	function Model_Mission() {
		$this->missions = MISSIONS;
		$this->fundrequest = FUNDREQUESTS;
		$this->user_personal = USERPERSONAL;
		$this->notes = NOTES;
		$this->badges = BADGES;
		$this->Database();
	}	
	
function addMission($Array) {
		$this->InsertData( $this->missions,$Array);		
		$insertId = mysql_insert_id();
		return $insertId;
	}
	function addNoteToMission($Array) {
		$this->InsertData( $this->notes,$Array);		
		$insertId = mysql_insert_id();
		return $insertId;
	}
function newPaymentRequest($Array) {
		$this->InsertData( $this->fundrequest,$Array);		
		$insertId = mysql_insert_id();
		return $insertId;
	}
		
	function getRequestListByParentId($id){
		$fields = array();
		$tables = array($this->fundrequest);
		if($id){
			$where  = array("parentId= '".$id."'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchAll($result);
		return $result1;
	}
	
	function getMissionDetailsById($id){
		$fields = array();
		$tables = array($this->missions);
		if($id){
			$where  = array("id= '".$id."'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchRow($result);
		return $result1;
	}
	
	function checkTheCreatorOfMission($missionId,$parentId){
		$fields = array();
		$tables = array($this->missions);

			$where  = array("id= '".$missionId."' AND parentId='".$parentId."' ");

		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchRow($result);
		return $result1;
	}
	function checkTheAssignedMission($missionId,$childId){
		$fields = array();
		$tables = array($this->missions);

			$where  = array("id= '".$missionId."' AND childId='".$childId."' ");

		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchRow($result);
		return $result1;
	}
	
	
	function getAllActiveMissionsByParentId($parentId){
		$fields = array();
		$tables = array($this->missions);
		if($parentId){
			$where  = array("parentId= '".$parentId."' AND status='2'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchAll($result);
		return $result1;
	}
	
	function getAllActiveMissionsByChildId($childId){
		$fields = array();
		$tables = array($this->missions);
		if($childId){
			$where  = array("childId= '".$childId."' AND status='2'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchAll($result);
		return $result1;
	}
	
	function getCountOfActiveMissionsByChildId($childId){
			$fields = array('count(id) as total');
		$tables = array($this->missions);
		if($childId){
			$where  = array("childId= '".$childId."' AND status='2'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchRow($result);
		if($result1['total'] == '')
		return 0;
		else
		return $result1['total'];
	}
	
	function getCountOfActiveMissionsByParentId($parentId){
		$fields = array('count(id) as total');
		$tables = array($this->missions);
		if($parentId){
			$where  = array("parentId= '".$parentId."' AND status='2'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchRow($result);
		if($result1['total'] == '')
		return 0;
		else
		return $result1['total'];
	}
	function getAllCompletedMissionsByParentId($parentId){
		$fields = array();
		$tables = array($this->missions);
		if($parentId){
			$where  = array("parentId= '".$parentId."' AND (status='3' or status = '5')");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchAll($result);
		return $result1;
	}
	function getCountOfCompletedMissionsByParentId($parentId){
		$fields = array('count(id) as total');
		$tables = array($this->missions);
		if($parentId){
			$where  = array("parentId= '".$parentId."' AND status='3'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchRow($result);
		if($result1['total'] == '')
		return 0;
		else
		return $result1['total'];
	}

	function getAllCompletedMissionsByChildId($childId){
		$fields = array();
		$tables = array($this->missions);
		if($childId){
			$where  = array("childId= '".$childId."' AND (status='5' or status= '3') ");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchAll($result);
		return $result1;
	}
	
	function getCountOfCompletedMissionsByChildId($childId){
		$fields = array('count(id) as total');
		$tables = array($this->missions);
		if($childId){
			$where  = array("childId= '".$childId."' AND status='3'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchRow($result);
		if($result1['total'] == '')
		return 0;
		else
		return $result1['total'];
	}
	
	function getAllPendingMissionsByParentId($parentId){
		$fields = array();
		$tables = array($this->missions);
		if($parentId){
			$where  = array("parentId= '".$parentId."' AND ( status='1' OR status='4')");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchAll($result);
		return $result1;
	}
	
	function getCountOfPendingMissionsByParentId($parentId){
		$fields = array('count(id) as total');
		$tables = array($this->missions);
		if($parentId){
			$where  = array("parentId= '".$parentId."' AND status='1'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchRow($result);
		if($result1['total'] == '')
		return 0;
		else
		return $result1['total'];
		}
	
	
	function getAllPendingMissionsByChildId($childId){
		$fields = array();
		$tables = array($this->missions);
		if($childId){
			$where  = array("childId= '".$childId."' AND status='4'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchAll($result);
		return $result1;
	}
	
	
		function getCountOfPendingMissionsByChildId($childId){
		$fields = array('count(id) as total');
		$tables = array($this->missions);
		if($childId){
			$where  = array("childId= '".$childId."' AND status='1'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchRow($result);
		if($result1['total'] == '')
		return 0;
		else
		return $result1['total'];
	}
	
	
	function editMission($array, $Id){
		$this->UpdateData($this->missions,$array,"id",$Id,0);
	}
	
	function searchMissionsByQuery($q, $orderField='m.title', $orderBy='DESC', $limit='',$offset=''){
		$fields = array("");
		$tables = array($this->missions.' as m',$this->user_personal.' as p');
		$where = array('m.parentId= p.userId');
		if($q) {
			$where[] = '(m.title LIKE "%'.$q.'%")';
		}
		
		$order = array("$orderField $orderBy");
		$result1 = $this->SelectData($fields,$tables,$where,$order,$group,$limit,$offset,0);
		$result = $this->FetchAll($result1);
		return $result;
	}


function getAllbadges($userId){
		$fields = array();
		$tables = array($this->missions);
		if($parentId){
			$where  = array("childId= '".$childId."' AND status='1'");
		}
		$result = $this->SelectData($fields,$tables, $where, $order = array(), $group=array(),$limit = "",0,0); 
		$result1 = $this->FetchAll($result);
		return $result1;
	}
	
}
?>