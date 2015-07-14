<?php
/*********************************************************************** 
* Filename: commonModel.php  |  access name: commonModel 
* Original Author: Vipul Oab 
* File Creation Date: March 4, 2015  
* Development Group: OAB Studios
* 
* Description:  This file conatin the database related very common function
*               for regular task
***********************************************************************/ 

class CommonModel extends CFormModel
{
	
	/***
	 * Function to insert data in table name
	 * 	EX:
	 * 	To get the last inserted id :
	   //--------  Insert start----------//
		 $inser_rec = array();
		 $inser_rec['COL_NAME'] = $col_name;
	   $commonModel->insertData('TABLE_NAME' , $inser_rec);
	   $new_id = Yii::app()->db->getLastInsertID();
	   $inser_rec = array();
	   //-------- Insert End----------//
	 ***/
	function insertData($table_name , $key_val)
	{	
		$data_sql = Yii::app()->db->createCommand()->insert($table_name,$key_val);
		if($data_sql)
		 return true;
		else
		 return false;
	}
	
	/***
	 * Function to delete the data from table as per the given condition
	 *	EX:
	    //-------- Delete start----------//
			$del = array();  $condtionString = '';
	    $condtionString = 'user_id = :user_id AND venue_id = :venue_id';
	    $del[':user_id'] = $user_id;
			$del[':venue_id'] = $venue_id;			
			$commonModel->deleteData('venue_favourite',$condtionString,$del);
			//-------- Delete End----------//					
	 ***/
	function deleteData($table_name, $where_string , $where_array)
	{
		//$data_sql =Yii::app()->db->createCommand()->delete($table_name, 'user_id=:id', array(':id'=>2));
		if(Yii::app()->db->createCommand()->delete($table_name,  $where_string , $where_array))
	    return true;
		else
		  return false;
	}
	
	/***
	 * Function to update the data
	 * 	EX:
      //-------- Update start----------//
      $update_data = $where_array = array(); $where_string = '';
    	$update_data['twitter_id'] = $twitter_id;								
			$where_string = 'user_id = :user_id';
			$where_array[':user_id'] = $user_id;
			$commonModel->updateData('user', $update_data , $where_string , $where_array);
			$update_data = $where_array = array(); $where_string = '';
			//-------- Update End----------//
								
	 ***/
	function updateData($table_name, $condtion , $where_string, $where_array)
	{	
		if(Yii::app()->db->createCommand()->update($table_name, $condtion , $where_string , $where_array))
	    return true;
		else
		  return false;
	}
	
	/***
	 * Function to check duplicate
	 ***/
	function checkDuplicate($table_name,$where_string,$where_array)
	{
		return Yii::app()->db->createCommand()->select()->from($table_name)->where($where_string, $where_array)->queryRow();		
	}
	
	/***
	 * To count the total number of records
	 ***/
	function countRows()
	{
		$sql = "SELECT FOUND_ROWS() as tot_row";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
		$rec = $command->queryRow();
		return $rec->tot_row;
	}
	
	/***
	 * Function to get the email template
	 ***/
	function getEmailTemplate($email_token = '')
	{
		$sql = "SELECT subject,contect,from_email
		        FROM email_template
		        WHERE email_token = :email_token
						AND status = 'active'
						LIMIT 1";
						
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
		$command->bindParam(":email_token" , $email_token);	
		return $command->queryRow();
	}
	
	/***
	 * Function to check the setting is on or not
	 ***/
	function check_setting($email_id, $setting_col )
	{
		$sql = "SELECT $setting_col
		        FROM user_detail_profile ud, user u
						WHERE u.user_id = ud.user_id
						AND u.email_id = :email_id
						LIMIT 1 ";

		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
		$command->bindParam(":email_id", $email_id);	
		$rec = $command->queryRow();
		if(!empty($rec))
			return $rec->$setting_col;
		else
		  return 1;
	}
	
	/***
	 * Function to send the email notification to the user
	 ***/
	function sendEmailNotification($email_data)
	{
		if(!(isset($email_data['chk_receive_email'] )))
			 $email_data['chk_receive_email'] = 'yes';
						 
		//SEND email notification to the user
			$email = Yii::app()->mandrillwrap;
			
			$body = $email_data['body'];
			$subject = $email_data['subject'];
			if($email_data['fromEmail'] != '')
			  $fromEmail = $email_data['fromEmail'];
			else
			  $fromEmail = Yii::app()->params['adminEmail']; 
			$fromName = $email_data['fromName'];
			//$toEmail  = $email_data['toEmail'];
			//Check that this user has on the send email setting only if not then dont send emails
			if($email_data['chk_receive_email'] == 'no')		
			{				
				$toEmail  = $email_data['toEmail'];
			}
			else
			{
				$can_email = $this->check_setting( $email_data['toEmail'] ,'receive_email');
				if($can_email == 1)
				{
					$toEmail  = $email_data['toEmail'];
					//$toEmail = Yii::app()->params['developerEmail']; //This is for testing purpose only removed when need to give build.
				}
				else
				{
					$body = '------ This user has receive_email setting OFF. --------'."<br>".$body;
					$toEmail = Yii::app()->params['developerEmail']; //If user is not acceppting email send it to the developer account.
				}
			}
			$toName = $email_data['toName'];
			$email->sendEmail($subject,$fromName,$fromEmail,$toName,$toEmail,$body);
			//For now send each email to developer account
			$toEmail = Yii::app()->params['developerEmail'];
			$email->sendEmail($subject,$fromName,$fromEmail,$toName,$toEmail,$body);
	}
	
	/***
	 * Function to send the output email to developer account
	 ***/
	function send_output_mail($result,$function_name)
	{
		$email_body_array['content'] = $result;
		$body = Yii::app()->controller->renderPartial('email_print_r_payment_op', $email_body_array , true);
		
		//Place the data in the subject		
		$email['subject'] = 'Thirst Output Result Array : '.$function_name;
			
		$email['body'] = $body;
		$email['fromName'] =  Yii::app()->name;
		$email['fromEmail'] = Yii::app()->params['developerEmail'];
		$email['toEmail'] =   Yii::app()->params['developerEmail'];
		$email['toName'] = 'Thirst Developer';
		
		$this->sendEmailNotification($email);
		Yii::log('In send_output_mail Function', CLogger::LEVEL_INFO , " Email sent to developer account.");
	}
	
	/***
	 * Function to get the user id from access token
	 ***/
	function getUserIdFrmAccessToken($access_token,$device_unique_id)
	{
		$sql = "SELECT u.user_id
						FROM user u, user_devices ud
						WHERE u.user_id = ud.user_id
						AND ud.access_token = :access_token
						AND ud.device_unique_id = :device_unique_id
						AND u.user_status = 'active'
						LIMIT 1";	
		
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
		$command->bindParam(":access_token", $access_token);
		$command->bindParam(":device_unique_id", $device_unique_id);
		$user_info = $command->queryRow();
		if(!empty($user_info))
			return $user_info->user_id;
		else
		  return '';			
	}
	
	/***
	 * Function to get the user id from access token
	 ***/
	function getUserIdFrmAccessToken_logout($access_token)
	{
		$sql = "SELECT u.user_id
						FROM user u, user_devices ud
						WHERE u.user_id = ud.user_id
						AND ud.access_token = :access_token						
						AND u.user_status = 'active'
						LIMIT 1";	
		
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
		$command->bindParam(":access_token", $access_token);		
		$user_info = $command->queryRow();
		if(!empty($user_info))
			return $user_info->user_id;
		else
		  return '';			
	}		

	/***
	 * Function to get the distace between
	 *
	 *  echo distance(32.9697, -96.80322, 29.46786, -98.53506, "M") . " Miles<br>";
			echo distance(32.9697, -96.80322, 29.46786, -98.53506, "K") . " Kilometers<br>";
			echo distance(32.9697, -96.80322, 29.46786, -98.53506, "N") . " Nautical Miles<br>";
	 ***/
	function distance($lat1, $lon1, $lat2, $lon2, $unit = 'M')
	{
		$theta = $lon1 - $lon2;
		$dist = sin(deg2rad($lat1)) * sin(deg2rad($lat2)) +  cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * cos(deg2rad($theta));
		$dist = acos($dist);
		$dist = rad2deg($dist);
		$miles = $dist * 60 * 1.1515;
		$unit = strtoupper($unit);
	
		if ($unit == "K") {
			return ($miles * 1.609344);
		} else if ($unit == "N") {
				return ($miles * 0.8684);
			} else {
					return $miles;
				}
  }
	
	/***
	 * Function to get the time differnce between two timestamp in text format to print on system
	 ***/
	function get_time_diff($time)
		{
		  $time = strtotime($time);
			$time = time() - $time; // to get the time since that moment
		//  $time =  $time - 60;
			$tokens = array (
					31536000 => 'year',
					2592000 => 'month',
					604800 => 'week',
					86400 => 'day',
					3600 => 'hour',
					60 => 'min',
					1 => 'second'
			);
			
		  $res = 'Just now';
			
			foreach ($tokens as $unit => $text) {
					if ($time < $unit) continue;
					$numberOfUnits = floor($time / $unit);
				  $res = $numberOfUnits.' '.$text.(($numberOfUnits>1)?'s':'').' ago';
					break;
			}
			$res = ($res == '') ? 'Just now' : $res ;
			if($res == '1 day ago')
			  return 'yesterday';
			else
			  return $res;
		}
		
		/***
		 * Function to calculate time difference between time is h:i:s format
		 ***/
		function get_time_difference($end_time, $start_time)
		{
			$sql = "SELECT TIMEDIFF( :end_time, :start_time ) as difference FROM DUAL";
			$command = Yii::app()->db->createCommand($sql);
			$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
			$command->bindParam(":end_time", $end_time);
			$command->bindParam(":start_time", $start_time);		
			$diff = $command->queryRow();
			if(!empty($diff))
				return $diff->difference;
			else
				return '';	
		}
		
		/***
		 * Function to log the array in the log file
		 * We are creating the sting of the array and log them in file
		 *
		 * $log_output =  http_build_query($array, '', "\n ");
			$log_output = str_replace('%5',' -- ',$log_output);
			
		 ***/
		function log_array($fun_name, $logMsg, $array)
		{
			$log_output = '';
			if(is_array($array))
			  $log_output = implode("  \n  ", array_map(function ($v, $k) { return $k . '=' . (is_array($v) ? 'Array' : $v); }, $array, array_keys($array)));
			else
			  $log_output = $array;
			Yii::log(" @ ", CLogger::LEVEL_INFO , " $logMsg  $fun_name  \n Output Array is: \n $log_output \n");
			return true;
		}
		
		/***
		 * Funtion to check the api status for the current version
		 * 'venue_app' an 'user_app'
		 * status 0- Expired, 1 - Active , 2 - Stop(under maintaince)
		 ***/
		function check_app_version_status($app_type,$app_version_id,$device_type = 'iOS')
		{
			if($app_type == 'venue_app')
			  $from_cond = 'app_version_venue_app';
			elseif($app_type == 'user_app')
			  $from_cond = 'app_version';
		
			$sql = "SELECT status
			        FROM $from_cond
							WHERE device_type = :device_type
							AND version = :version
							LIMIT 1";

			$command = Yii::app()->db->createCommand($sql);
			$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
			$command->bindParam(":device_type", $device_type);
			$command->bindParam(":version", $app_version_id);		
			$rec = $command->queryRow();
			if(!empty($rec))
			{
				$status = $rec->status;
				if($status == 1)
					return true;
				elseif($status == 0)
				{
					//Force update
					$data = array('status' => '410' ,
												'statusInfo' => "Please update ".Yii::app()->name." to the latest version to continue.");
					echo CJSON::encode($data);
					Yii::app()->end();
				}
				elseif($status == 2)
				{
					$data = array('status' => '409' ,
												'statusInfo' => 'App is currently under upgradation, please try later.');
					echo CJSON::encode($data);
					Yii::app()->end();
				}
			}
			else
			{
				$data = array('status' => '401' ,
											'statusInfo' => "Please update '".Yii::app()->name."' to the latest version to continue.");
				echo CJSON::encode($data);
				Yii::app()->end();
			}
		}//end of the function
		
		/***
		 * Function to get download link of the app
		 ***/
		function get_app_download_link()
		{
			return "<a href='javascript:void(0)'>Download ".Yii::app()->name."</a>";
		}
		
		 /***
	  * Function to check two array are same or not
	  ***/
		function array_equal($a1, $a2)
		{
			 return !array_diff($a1, $a2) && !array_diff($a2, $a1);
		}
		
			/***
	 * Function to get the device token from user id
	 ***/
		function getDeviceTokenFrmUserId($user_id)
		{
			$sql = "SELECT DISTINCT(ud.device_token)
							FROM user u, user_devices ud
							WHERE u.user_id = ud.user_id
							AND ud.user_id = :user_id						
							AND u.user_status = 'active'";	
			
			$command = Yii::app()->db->createCommand($sql);
			$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
			$command->bindParam(":user_id", $user_id);		
			return $command->queryAll();
		}
		
		/*** 
		 * Function to send the push notification to the user
		 ***/
		function sendPushNotification($user_id,$msg,$type,$target_id = '')
		{
			//Send the push notification code goes here
			$device_token_array = array();
			$pushnotificationHelper = new pushnotificationHelper;
			$sql = "SELECT DISTINCT(ud.device_token)
							FROM user u, user_devices ud
							WHERE u.user_id = ud.user_id
							AND ud.user_id = :user_id						
							AND u.user_status = 'active'";	
			
			$command = Yii::app()->db->createCommand($sql);
			$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
			$command->bindParam(":user_id", $user_id);		
			$device_token_array = $command->queryAll();
			     
			if(!empty($device_token_array))
			{
				Yii::log('In push notification code', CLogger::LEVEL_INFO , "  In push notification function. ");	
					foreach ($device_token_array as $user_devices)
					{
							$device_token = $user_devices->device_token;
							Yii::log('In push notification code', CLogger::LEVEL_INFO , " user_id : $user_id  |  device_token : $device_token | $msg ");	
							if($device_token!='(null)' || $device_token !='')
							{
								Yii::log('In push notification code', CLogger::LEVEL_INFO , " in if $device_token ");
								$pushnotificationHelper->push_notification($device_token, $msg, $type, $target_id);
							}                
					}
			}
		}
		
		/**
		 * remove the unwanted charaters from the phone number
		 ***/
		function cleanup_phoneNumeber($friend_value)
		{
			Yii::log('In actionSendCreditGift Function', CLogger::LEVEL_INFO , " friend_value before cleanup  $friend_value ");
				$friend_value = str_replace('(','',$friend_value);
				$friend_value = str_replace(')','',$friend_value);
				$friend_value = str_replace('-','',$friend_value);
				$friend_value = str_replace(' ','',$friend_value);
				//$friend_value = str_replace('+','',$friend_value);
				$first_2_char = substr($friend_value, 0, 2);
				if($first_2_char != '+1')
					$friend_value = "+1".trim($friend_value);						
			 Yii::log('In actionSendCreditGift Function', CLogger::LEVEL_INFO , " friend_value after cleanup  $friend_value ");
			 return $friend_value;
		}
		
		/***
		 * Function to get the venue tax value
		 ***/
		function get_venue_tax($venue_id)
		{
			$sql = "SELECT venue_tax_percentage FROM venue  WHERE venue_id = :venue_id LIMIT 1";
			$command = Yii::app()->db->createCommand($sql);
			$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
			$command->bindParam(":venue_id", $venue_id);		
			$rec = $command->queryRow();
			if(!empty($rec))
			  return $rec->venue_tax_percentage;
		  else
			  return 0;
		}
}//emd of the class CommonModel
