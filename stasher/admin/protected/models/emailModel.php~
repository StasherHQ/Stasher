<?php

class emailModel extends CFormModel
{
	function getEmaildetailsByEmailId($id)
	{
		 $sql = "SELECT *
		        FROM tbl_emailtemplates 
		        WHERE id = :id
		        ";
			
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
		$command->bindParam(":id", $id);
		return $command->queryRow();
	}
	
	 function sendEmailNotification($to,$toname,$from,$fromname,$template,$subject)
{

$email = Yii::app()->mandrillwrap;
//echo $template;exit;
$email->sendEmail($subject,$fromname,$from,$toname,$to,$template);

}

}
