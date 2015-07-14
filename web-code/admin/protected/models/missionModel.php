<?php
/*********************************************************************** 
* Filename: adminModel.php:  access name: adminModel 
* Original Author: Vipul Oab 
* File Creation Date: Feb 12, 2015  
* Development Group: OAB
* 
* Description:  This file conatin the database handling for the all admin related stuff
***********************************************************************/ 

class missionModel extends CFormModel
{

	
	/***
	 * Function to get the user list
	 ***/
	function getAllMissionsByUserId($userId,$usertype)
	{
		//echo "hi";exit;
		
		if($usertype == '4')
			{
			$where = " AND parentId='".$userId."'";		
										
			}
			else
			 $where = " AND childId='".$userId."'";	
					
		
		 $sql = "SELECT * FROM tbl_missions 
						WHERE  status <> '0'					
						$where
						ORDER BY inserted_date DESC";
		
		
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);	
		return $command->queryAll();
	}
	
	
	function getAllMissions($m,$fromdate,$todate,$userId,$sortingfield,$sortingby)
	{
		$cond = '';
		$search_cond = '';
		$datecond = '';
		$usrcond = '';
		if($userId !='')
		{
			$usrcond = "  AND (parentId = '".$userId."' OR childId = '".$userId."')";
		}
		if($fromdate != '' && $todate!= '')
		{
			$datecond = " AND ( inserted_date between '".$fromdate."' AND '".$todate."')";
		}		
		if($m == 'active')
		{
		  $cond = " AND status='3'"; 
		}
		else if($m == 'inactive')
		{
		  $cond = " AND status='1'"; 
		}
		else if($m == 'completed')
		{
		  $cond = " AND status='5'"; 
		}
		
		if($sortingfield == 'date')
		{
			$sortfield = ' inserted_date';
		}
		else if($sortingfield == 'title')
		{
			$sortfield = 'title';
		}
		else
		{
			$sortfield = ' inserted_date';
		}			
		if($sortingby)
		{
			$sortingby = $sortingby;
		}
		else
		{
			$sortingby = ' asc';
		}
		
		
		
		 $sql = "SELECT * FROM tbl_missions where status <> '0'
						$cond
						$search_cond
						$datecond
						$usrcond
						ORDER BY $sortfield $sortingby";
		
		
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);	
		return $command->queryAll();
	}
	
}

