<?php
/*********************************************************************** 
* Filename: adminModel.php:  access name: adminModel 
* Original Author: Vipul Oab 
* File Creation Date: Feb 12, 2015  
* Development Group: OAB
* 
* Description:  This file conatin the database handling for the all admin related stuff
***********************************************************************/ 

class adminModel extends CFormModel
{
	function chkAdminLogin($email_id,$password)
	{
		$sql = "SELECT *
		        FROM tbl_users
		        WHERE (email = :email_id OR username =:email_id)
						AND password = password
						AND status = '2' AND usertype IN (1,2)
						LIMIT 0,1";
						
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
		$command->bindParam(":email_id", $email_id);
		$command->bindParam(":password", $password);
		return $command->queryRow();
	}
	
	function getUserDetailsByEmail($email_id)
	{
		$sql = "SELECT *
		        FROM tbl_users
		        WHERE (email = :email_id OR username =:email_id)
						AND status = '2' AND usertype IN (1,2)
						LIMIT 1";
						
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
		$command->bindParam(":email_id", $email_id);
		return $command->queryRow();
	}


	/***
	 * Function to get the item type
	 ***/
	function getItemType()
	{
		$sql = "SELECT type_id,type_name
		        FROM item_type";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object	
		return $command->queryAll();
	}
	
	/***
	 * Function to get the user list
	 ***/
	function get_user_list($search_text)
	{
		$status_cond = '';
		$search_cond = '';
				
		
		if($search_text != '')
			{
					$search_text = trim( strtolower ($search_text));
					$search_cond = "AND ( ( LOWER(i.fname) LIKE \"%".$search_text."%\" ) OR ( LOWER(i.lname) LIKE \"%".$search_text."%\" ) OR ( LOWER(email) LIKE \"%".$search_text."%\" ) ) ";						
			}
			else
				  $search_cond = '';
					
		
		$sql = "SELECT u.*,i.* FROM tbl_users as u left join tbl_user_information as i on u.userId = i.userId 
						WHERE ( u.usertype = '3' OR u.usertype='4' ) AND status <> '0'
						$status_cond
						$search_cond
						ORDER BY registered_date DESC";
		
		
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);	
		return $command->queryAll();
	}
	
	/***
	 * Function to get the user device info to show in the list
	 *
	 * One user can logged in from multiple device so we are keeping the device toekn and access token multiple time per user
	 * When they logged out from device we are deleting there record from system
	 ***/
	function getUserDeviceInfo($user_id)
	{
	  $sql = "SELECT ud_id,access_token, device_unique_id, device_type
		        FROM user_devices  ud, user u
						WHERE u.user_id = ud.user_id
						AND u.user_id = :user_id
						ORDER BY updated_timstamp DESC";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);
		$command->bindParam(':user_id',$user_id);
		return $command->queryAll();
	}
	
	function getUserDetailsByUserId($user_id)
	{
		$sql = "SELECT u.*,i.*
		        FROM tbl_users as u left join tbl_user_information as i on u.userId = i.userId 
						
						WHERE u.userId = :user_id			
						LIMIT 1";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);
		$command->bindParam(':user_id',$user_id);
		return $command->queryRow();		
	}
	function getParentListByChildId($user_id)
	{
		 $user_id.$sql = "SELECT u.*,i.*,p.fname,p.lname,p.avatar
		        FROM tbl_user_relation as u left join tbl_users as i on u.parentId = i.userId left join tbl_user_information as p on p.userId = i.userId WHERE  u.childId = :user_id";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);
		$command->bindParam(':user_id',$user_id);
		return $command->queryAll();		
	}
function getChildListByParentId($user_id)
	{
		$sql = "SELECT u.*,i.*,p.fname,p.lname,p.avatar 
		        FROM tbl_user_relation as u left join tbl_users as i on u.childId = i.userId left join tbl_user_information as p on p.userId = i.userId WHERE  u.parentId = :user_id ";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);
		$command->bindParam(':user_id',$user_id);
		return $command->queryAll();		
	}


	
	function updateUser($upd,$user_id)
	{
	
		
		
		$sql = "UPDATE user SET first_name = '$upd[first_name]',
					last_name = '$upd[last_name]',
					email_id = '$upd[email_id]',
				
			WHERE user_id = :user_id ";
			
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);    //fetch each row as Object
		$command->bindParam(":user_id", $user_id);		
		$command->execute();
		return true;				
	}
	
	
	function updateUserInformation($upd,$userId)
	{
		
		if($upd['avatar'])
		{
		$sql = "UPDATE tbl_user_information SET fname = '$upd[fname]',
					lname = '$upd[lname]',
					gender = '$upd[gender]',
					avatar = '$upd[avatar]',
					dob = '$upd[dob]'
					
			WHERE userId = :userId ";
		}
		else
		{
		$sql = "UPDATE tbl_user_information SET fname = '$upd[fname]',
					lname = '$upd[lname]',
					gender = '$upd[gender]',
					dob = '$upd[dob]'
					
			WHERE userId = :userId ";
			}
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);    //fetch each row as Object
		$command->bindParam(":userId", $userId);		
		$command->execute();
		return true;				
	}
	
	/***
	 * Function to get the admin information from admin Id
	 ***/
	function getAdmininfo($admin_id)
	{
		$sql = "SELECT * FROM admin WHERE admin_id = :admin_id LIMIT 1";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);
		$command->bindParam(':admin_id',$admin_id);
		return $command->queryRow();	
	}
	
	/**
	 * Function to get admin users list
	 **/
	
	function getAdminUserslist()
	{
		$sql = "SELECT * FROM admin
		        WHERE admin_type != 'developer_account'";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);	
		return $command->queryAll();
	}
	
	function deleteUser($userId)
	{
		$sql = "UPDATE tbl_users set status= '0'
					
			WHERE userId = :userId ";
			
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);    //fetch each row as Object
		$command->bindParam(":userId", $userId);		
		$command->execute();
		return true;	
	}
	
	function changePasswordOfUser($upd,$userId)
	{
		$sql = "UPDATE tbl_users set password= '$upd[password]',saltkey = '$upd[saltkey]'
					
			WHERE userId = :userId ";
			
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);    //fetch each row as Object
		$command->bindParam(":userId", $userId);		
		$command->execute();
		return true;	
	}
	
	function updateAdminUser($upd,$admin_id)
	{
		$sql = "UPDATE admin SET admin_name = '$upd[admin_name]',
			admin_username = '$upd[admin_username]',
			email_id = '$upd[email_id]',
			password = '$upd[password]',
			admin_status = '$upd[admin_status]',
			profile_pic = '$upd[profile_pic]'		
			WHERE admin_id = :admin_id ";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);   
		$command->bindParam(":admin_id", $admin_id);		
		$command->execute();
		return true;
	}
	
	function checkDuplicateEmail($email_id)
	{
		$sql = "SELECT admin_id
			FROM admin			
			WHERE email_id = :email_id
			LIMIT 1";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);
		$command->bindParam(":email_id", $email_id);
		return $command->queryAll();		
	}
	
	function checkDuplicateUsername($username)
	{
		$sql = "SELECT admin_id
			FROM admin			
			WHERE admin_username = :username
			LIMIT 1";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);
		$command->bindParam(":username", $username);
		return $command->queryAll();		
	}
	
	function checkEmailExists($admin_id,$email_id)
	{
		$sql = "SELECT admin_id
			FROM admin			
			WHERE email_id = :email_id
			AND admin_id != :admin_id
			LIMIT 1";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);
		$command->bindParam(":email_id", $email_id);
		$command->bindParam(":admin_id", $admin_id);
		return $command->queryAll();		
	}
	
	function checkUsernameExists($admin_id,$username)
	{
		$sql = "SELECT admin_id
			FROM admin			
			WHERE admin_username = :username
			AND admin_id != :admin_id
			LIMIT 1";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);
		$command->bindParam(":username", $username);
		$command->bindParam(":admin_id", $admin_id);

		return $command->queryAll();		
	}
	
	function checkPasswordexists($admin_id,$old_password)
	{
		$sql = "SELECT admin_id
			FROM admin			
			WHERE password = md5(:password)
			AND admin_id = :admin_id
			LIMIT 1";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);
		$command->bindParam(":password", $old_password);
		$command->bindParam(":admin_id", $admin_id);
		return $command->queryAll();		
	}
	
	/***
	 * Function to delete/inactive the admin user 
	 ***/
	function deleteAdminUser($admin_id)
	{	
		$sql = "UPDATE admin SET admin_status = 'inactive'
						WHERE admin_id = :admin_id";
		$command = Yii::app()->db->createCommand($sql);
		$command->bindParam(":admin_id", $admin_id);		
		$command->execute();
		return true;
	}
	/**
	 * Function to fetch user sharing Details
	 */
	function user_share_details($user_id)
	{
		$sql = "SELECT *
			FROM share_thirst			
			WHERE user_id = :user_id
			";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);
		$command->bindParam(":user_id", $user_id);
		return $command->queryAll();	
	}
	function updateSetting($upd,$user_id)
	{
		$sql = "UPDATE user_detail_profile SET push_notification = '$upd[push_notification]',
			stay_sign_in = '$upd[stay_sign_in]',
			receive_email = '$upd[receive_email]'
			WHERE user_id = :user_id ";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);   
		$command->bindParam(":user_id", $user_id);		
		$command->execute();
		return true;
	}
	
	  function getAllUserList($search_text)
	 {
	 
	 	if($search_text != '')
			{
					$search_text = trim( strtolower ($search_text));
					$search_cond = "AND ( ( LOWER(i.fname) LIKE \"%".$search_text."%\" ) OR ( LOWER(i.lname) LIKE \"%".$search_text."%\" ) OR ( LOWER(email) LIKE \"%".$search_text."%\" ) ) ";						
			}
			else
				  $search_cond = '';
				  
		 $sql = "SELECT u.username,u.email FROM tbl_users as u left join tbl_user_information as i on u.userId = i.userId 
						WHERE ( u.usertype = '3' OR u.usertype='4' ) AND status <> '0'
						
						$search_cond
						ORDER BY registered_date DESC";
		
		
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);	
		return $command->queryAll();
	 	
	 }
	   function getTotalRegisteredUserCountByTypeAndDate($type,$fromdate,$todate)
	 {
				  
		 $sql = "SELECT count(userId) as totalusers FROM tbl_users
						WHERE usertype = '".$type."' AND  (registered_date BETWEEN  '".$fromdate."' AND '".$todate."')  AND status <> '0'";
		
		
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);	
		$qryres = $command->queryRow();
		return $qryres->totalusers;
	 	
	 }
}

