<?php
class SettingsModel extends CFormModel
{

	function getAllSiteVariables()
	{
		 $sql = "SELECT *
		        FROM tbl_sitesettings
		        ";
				//exit;		
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
		
		return $command->queryAll();
	}
}
