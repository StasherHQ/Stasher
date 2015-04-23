<?php
/*********************************************************************** 
* Filename: userModel.php:  access name: userModel 
* Original Author: Vipul Oab 
* File Creation Date: July 31, 2014  
* Development Group: OAB
* 
* Description:  This file conatin the database handling for the user realted stuff
***********************************************************************/ 

class UserModel extends CFormModel
{
	/***
	 * Function to check the user is exist or not
	 ***/
  function checkDuplicaetUser($email_id,$user_id = '')
	{
		$user_cond = '';
		  if($user_id != '')
			  $user_cond = "AND user_id != $user_id ";
			$sql = "SELECT user_id
			        FROM user
							WHERE email_id = '$email_id'
							AND user_status = 'active'
							$user_cond
							LIMIT 1";
			$data_sql = Yii::app()->db->createCommand($sql)->queryAll();
			return $data_sql;
	}
	
	/***
	 * Function to check the facebook login
	 ***/
	function chkFbLogin($fb_id)
	{
		$sql = "SELECT user_id,first_name,last_name,full_name,email_id,profile_image
		        FROM user
						WHERE fb_id = '$fb_id'
						AND user_status = 'active'
						LIMIT 1";
		$data_sql = Yii::app()->db->createCommand($sql)->queryAll();
		return $data_sql;
	}
	
  
	/***
	 * Function to check the custom login
	 ***/
	function checkCustomLogin($email_id, $password)
	{
		$sql = "SELECT user_id,first_name,last_name,full_name,email_id
		        FROM user
						WHERE email_id = :email_id
						AND password = :password
						AND user_status = 'active'
						LIMIT 1";
						
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
		$command->bindParam(":email_id", $email_id);
		$command->bindParam(":password", $password);
		return $command->queryRow();
	}
	
	/***
	 * Function to get the profile image of the user
	 *
	 *  User profile image is store in the 'uploads' folder.
	 ***/
	function getProfileImage($user_id)
	{
		$sql = "SELECT user_id, fb_id,profile_image
		        FROM user
						WHERE user_id = :user_id
						AND user_status = 'active'
						LIMIT 1";
		//$data_sql = Yii::app()->db->createCommand($sql)->queryAll();
		
		$command = Yii::app()->db->createCommand($sql);
		//$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
		$command->bindParam(":user_id", $user_id);		
		$data_sql = $command->queryAll();
	
		if(!empty($data_sql))
		{
			//Check for the user's facebook id is present or not
			$profile_image = $data_sql[0]['profile_image'];
			if($profile_image != '' && $profile_image != 'NULL' )
			{
				$profile_image_url =  Yii::app()->getBaseUrl(true).'/uploads/'.$profile_image;			
			  $rel_profile_image_url = './uploads/'.$profile_image;
				if(!file_exists($rel_profile_image_url))
				  $profile_image_url = Yii::app()->getBaseUrl(true).'/uploads/default.png';				
			}
			else
			{
				//Get fb_id
				$fb_id = $data_sql[0]['fb_id'];
				if($fb_id != '' && $fb_id != 'NULL' )			
				  $profile_image_url = 'http://graph.facebook.com/'.$fb_id.'/picture?width=300&height=300';
				else
				  $profile_image_url = Yii::app()->getBaseUrl(true).'/uploads/default.png';
			}
		}
		else
		 $profile_image_url =  '';
		 
		 return $profile_image_url;
	}
	
	/***
	 * Function to generate the access token
	 ***/
	function generateAccessToken($user_id)
	{
		$access_token = Yii::app()->getSecurityManager()->generateRandomString(12);
		if($this->chkDuplicateoken('user_devices','access_token',$access_token))
		  generateAccessToken();
		else	
		  return $access_token;	
	}
	
	function chkDuplicateoken($table_name,$col_name,$val)
	{
		$sql = "SELECT $col_name
			 FROM $table_name
			 WHERE $col_name = '$val'			 
			 LIMIT 1";	
		
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object		
		$rec =  $command->queryRow();
		if(!empty($rec))
		  return true;
		else
		  return false;
	}
	
	/***
	 * Function to create the unique user id
	 ***/
	function generateUniqueUserId()
	{
		$unique_id = Yii::app()->getSecurityManager()->generateRandomString(8);
		//Check for the unique access token. check for this string in the user_devices table
		if($this->chkDuplicateoken('user','user_unique_id',$unique_id))
		  generateUniqueUserId();
		else	
		  return $unique_id;	
	}
	
	/***
	 * Function to delete the user device record
	 ***/
	function deleteUserDeviceRec($user_id,$device_unique_id,$access_token = '')
	{
		//if($access_token != '')
		//  $acc_cond = "AND access_token = '$access_token' ";
		//else
		//  $acc_cond = '';
		//$sql = "DELETE FROM user_devices WHERE device_unique_id = :device_unique_id AND user_id = :user_id $acc_cond";
		//$command = Yii::app()->db->createCommand($sql);
		//$command->bindParam(":device_unique_id", $device_unique_id);
		//$command->bindParam(":user_id", $user_id);		
		//$command->execute();
		//return true;
		
		 $commonModel =  new CommonModel;
		 $condtionString = 'device_unique_id = :device_unique_id';
	   $del[':device_unique_id'] = $device_unique_id;	
		 $commonModel->deleteData('user_devices',$condtionString,$del);
		 return true;
	}
	
	/***
	 * Function to check the device uniquw id
	 ***/
	function chkDeviceUniqueId($device_unique_id)
	{
	   $sql = "SELECT ud.user_id
		        FROM user_devices ud, user u						
						WHERE u.user_id = ud.user_id
						AND user_status = 'active'						
						AND device_unique_id = :device_unique_id  LIMIT 1";
		//$data_sql = Yii::app()->db->createCommand($sql)->queryAll();
		
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
		$command->bindParam(":device_unique_id", $device_unique_id);		
		return $command->queryRow();		
	}
	
	/***
	 * Function to check the forgot password
	 ***/
	function chkForgotPasswordEmail($email_id)
	{
		 $sql = "SELECT user_id,email_id,full_name
						FROM user
						WHERE email_id = :email_id
						AND user_status = 'active'
						LIMIT 1";	
		
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
		$command->bindParam(":email_id", $email_id);		
		return $command->queryRow();		
	}
	
	/***
	 * Function to upadte the password
	 ***/
	function updatePassword($user_id,$password)
	{
		$sql = "UPDATE user SET password = md5(:password) WHERE user_id = :user_id ";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);    //fetch each row as Object
		$command->bindParam(":user_id", $user_id);
		$command->bindParam(":password", $password);	
		$command->execute();
		return true;
	}
	
	/***
	 * Function to get the users basic information
	 ***/
	function getUserBasicInfo($user_id)
	{
		$sql = "SELECT u.user_id, email_id, first_name, last_name, full_name, mobile_number, gender, birthdate,up.stay_sign_in
		        FROM user u
						LEFT JOIN user_detail_profile up ON u.user_id = up.user_id				
						WHERE u.user_id = :user_id
						AND user_status = 'active'
						LIMIT 1";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
		$command->bindParam(":user_id", $user_id);		
	  return $command->queryRow();
	}
	
	/***
	 * Function to get the user  information from user id
	 ***/
	function getUserInfo($user_id)
	{
		$sql = "SELECT u.user_id, email_id, first_name, last_name, full_name, mobile_number, gender, birthdate,stay_sign_in
		        FROM user u
						LEFT JOIN user_detail_profile up ON u.user_id = up.user_id				
						WHERE u.user_id = :user_id
						AND user_status = 'active'
						LIMIT 1";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
		$command->bindParam(":user_id", $user_id);		
		$user_info = $command->queryRow();
	
		if(!empty($user_info))
		{
			$profile_image = $this->getProfileImage($user_id);
			//print_r($user_info);
			$first_name = $last_name = $full_name = $mobile_number = $gender = $birthdate = '';
			if($user_info->first_name != '')
			 $first_name = $user_info->first_name;
			if($user_info->last_name != '')
			 $last_name = $user_info->last_name;
			if($user_info->full_name != '')
			 $full_name = $user_info->full_name;
			if($user_info->mobile_number != '')
			 $mobile_number = $user_info->mobile_number;
			if($user_info->gender != '')
			 $gender = ucwords($user_info->gender);
			if($user_info->birthdate != '' && $user_info->birthdate != '0000-00-00')
			 $birthdate = date('m/d/Y',strtotime($user_info->birthdate));
			
			//Get users card data
			$card_list = array();
			$card_list = $this->get_user_cc($user_id);
			//foreach($card_list as $cl)
			//{
			//	$cc_list_array = array('id'=>$cl->user_cc_id,
			//'card_digit' =>  $cl->card_digit );
			//
			//	$cc_list[]  = $cc_list_array;
			//}
			$userDetail = array(
													'user_id' => $user_id,
													'first_name' => $first_name,
													'last_name' => $last_name,
													'full_name' => $full_name,
													'email_id' => $user_info->email_id,
													'profile_image' => $profile_image,
													'mobile_number' => $mobile_number,
													'gender' => $gender,
													'birthdate' => $birthdate,
													'stay_sign_in'=> $user_info->stay_sign_in,
													'card_list' => $card_list
													);
			return $userDetail;
		}
		else
		return array();
	}
	
	
	
	/***
	 * Function get the setting info of the user for the setting screen
	 ***/
	function get_setting_info($user_id)
	{
		$sql = "SELECT push_notification, stay_sign_in, receive_email, fb_id, twitter_id
		        FROM user u, user_detail_profile up
						WHERE u.user_id = up.user_id
						AND up.user_id = :user_id
						LIMIT 1";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
		$command->bindParam(":user_id", $user_id);		
		return $command->queryRow();
	}
	
  /***
	 * Function to check the old password
	 ***/
	function checkOldPassword($user_id, $old_password)
	{
		$old_md5 = md5($old_password);
		$sql = "SELECT user_id FROM user
		        WHERE user_id = :user_id
						AND password = :password
						AND user_status = 'active'
						LIMIT 1";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
		$command->bindParam(":user_id", $user_id);
		$command->bindParam(":password", $old_md5);	
		return $command->queryRow();
	}
}
	

