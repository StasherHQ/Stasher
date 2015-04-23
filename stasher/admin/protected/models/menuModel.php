<?php
/*********************************************************************** 
* Filename: menuModel.php:  access name: menuModel 
* Original Author: Snehal Oab 
* File Creation Date: Nov 20, 2014  
* Development Group: OAB
* 
* Description:  This file conatin the database handling for the all admin menu related stuff
***********************************************************************/ 

class menuModel extends CFormModel
{
	/**
	 * Function to get list of menu items as item type
	 **/
	function menu_item_list($searchedCond = array(),$type = '')
	{
		$search_txt = $searchedCond['search_txt'];
		$category = $searchedCond['category'];
		$brand =  $searchedCond['brand'];
		
		$search_string_cond = $category_cond = $brand_cond = '';
	
		//----------Search String -----------------//
		if($search_txt != '')
		{		
		  $search_string_cond = " AND ( ( LOWER(i.item_name) LIKE \"%".mysql_real_escape_string($search_txt)."%\" )) ";
		}
		
		//----------Search Category -----------------//
		if($category != '')
		{		
		  $category_cond = "AND ( ( LOWER(c.cat_name) LIKE \"%".$category."%\" )) ";
		}
		
			//----------Search Brand -----------------//
		if($brand != '')
		{		
		  $brand_cond = "AND ( ( LOWER(b.brand_name) LIKE \"%".$brand."%\" ))  ";
		}
		
		
		$type_cond = "";
		if($type != '')
				$type_cond = "WHERE i.type_id = ".$type."";
			
		$sql = "SELECT SQL_CALC_FOUND_ROWS i.* , c.cat_name, b.brand_name
						FROM items i
						LEFT JOIN category c ON i.category_id = c.category_id
						LEFT JOIN brand b ON i.brand_id = b.brand_id
						INNER JOIN item_type it ON i.type_id = it.type_id
						$type_cond
						$search_string_cond
						$category_cond
						$brand_cond
						AND venue_specific_item = 'no'
						ORDER BY updated_timestamp DESC";
						
	  //	echo $sql ;
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object	
		return $command->queryAll();
	}
	
	/**
	 * Function to get list of modifiers list of menu items 
	 **/
	
	function menu_item_modifiers($item_id,$modifer_type_id,$venue_item_id = 0)
	{
		if($venue_item_id != 0)
		{
			$sql = "SELECT mo.name, vim.price, vim.is_default
					FROM venue_item_modifier vim,item_modifires m
					INNER JOIN items i ON i.item_id = m.item_id
					INNER JOIN modifier mo ON m.modifier_id = mo.modifier_id
					INNER JOIN modifier_type mt ON mo.modifier_type_id = mt.modifier_type_id
					WHERE vim.item_mdf_id = m.item_mdf_id
					AND vim.venue_item_id = :item_id
					AND mo.modifier_type_id = :modifier_type_id";
					
					$item_id = $venue_item_id; // For binding
		}
		else
		{
			$sql = "SELECT m.*,mo.name
					FROM item_modifires m
					INNER JOIN items i ON i.item_id = m.item_id
					INNER JOIN modifier mo ON m.modifier_id = mo.modifier_id
					INNER JOIN modifier_type mt ON mo.modifier_type_id = mt.modifier_type_id
					WHERE i.item_id = :item_id
					AND mo.modifier_type_id = :modifier_type_id";
		}
		
		
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
		$command->bindParam(":item_id" , $item_id);
		$command->bindParam(":modifier_type_id" , $modifer_type_id);	
		return $command->queryAll();
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
	
	/**
	 * Function to get list of modifier type list of menu items 
	 **/
	function get_modifier_type_list($item_id,$venue_item_id = 0)
	{
		if($venue_item_id != 0)
		{
			$sql = "SELECT mt.modifier_type_id,mt.name,mt.select_type
							FROM venue_item_modifier vim, item_modifires m
							INNER JOIN items i ON i.item_id = m.item_id
							INNER JOIN modifier mo ON m.modifier_id = mo.modifier_id
							INNER JOIN modifier_type mt ON mo.modifier_type_id = mt.modifier_type_id
							WHERE m.item_mdf_id = vim.item_mdf_id
							AND vim.venue_item_id = :venue_item_id
							AND mt.status = 'active'
							GROUP BY mo.modifier_type_id";
			$command = Yii::app()->db->createCommand($sql);
			$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
			$command->bindParam(":venue_item_id" , $venue_item_id);
		}
		else
	  {
		 $sql = "SELECT mt.modifier_type_id,mt.name,mt.select_type
							FROM item_modifires m
							INNER JOIN items i ON i.item_id = m.item_id
							INNER JOIN modifier mo ON m.modifier_id = mo.modifier_id
							INNER JOIN modifier_type mt ON mo.modifier_type_id = mt.modifier_type_id
							WHERE i.item_id = :item_id
							AND mt.status = 'active'
							GROUP BY mo.modifier_type_id";
			$command = Yii::app()->db->createCommand($sql);
			$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object
			$command->bindParam(":item_id" , $item_id);
		}					
			
		return $command->queryAll();	
	}
	
	/***
	 * Function to get all the list of spirit type/ category 
	 ***/
	function getCategorylist()
	{		
		$sql = "SELECT category_id,cat_name,description,status
		        FROM category
						WHERE status = 'active'
						AND parent_cat = 0
						AND level = 0
						";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);//fetch each row as Object	
		return $command->queryAll();
	}
	
	/***
	 * Function to get the brand list as per the subcategory
	 ***/
	function get_brands_by_subcategory($itemsubtype_id)
	{		
		$sql = "SELECT brand_id,brand_name
		        FROM brand
						WHERE FIND_IN_SET(:itemsubtype_id, cat_id)
						AND status = 'active'";
		
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);
		$command->bindParam(":itemsubtype_id", $itemsubtype_id);
		return $command->queryAll();
	}
	
	/***
	 * Function to get all modifier type
	 ***/
	function getModifierTypeList()
	{
		$sql = "SELECT *
		        FROM modifier_type
						WHERE status = 'active'
		       ";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);	
		return $command->queryAll();		
	}
	
	/****
	 * Function to get the modifier as per the category
	 ***/
	function get_modifier_by_category($category_id, $item_id = 0, $venue_item_id = 0)
	{
		if($venue_item_id != 0)
		{
			$sql = "SELECT DISTINCT(m.modifier_type_id) , m.name
							FROM modifier_type m, modifier_category c, item_modifires im, modifier mm, venue_item_modifier vim
							WHERE m.modifier_type_id = c.modifier_type_id
							AND im.modifier_id = mm.modifier_id
							AND mm.modifier_type_id = m.modifier_type_id
							AND im.item_mdf_id = vim.item_mdf_id
							AND vim.venue_item_id = :venue_item_id
							AND ( FIND_IN_SET(:category_id, category_id) )
							AND m.status = 'active'";
			
			$command = Yii::app()->db->createCommand($sql);
			$command->setFetchMode(PDO::FETCH_OBJ);
			
			$command->bindParam(":venue_item_id", $venue_item_id);
			$command->bindParam(":category_id", $category_id);
		}
		elseif($item_id != 0)
		{
			$sql = "SELECT DISTINCT(m.modifier_type_id) , m.name
							FROM modifier_type m, modifier_category c, item_modifires im,modifier mm
							WHERE m.modifier_type_id = c.modifier_type_id
							AND im.modifier_id = mm.modifier_id
							AND mm.modifier_type_id = m.modifier_type_id
							AND im.item_id = :item_id
							AND ( FIND_IN_SET(:category_id, category_id) )
							AND m.status = 'active'";
			
			$command = Yii::app()->db->createCommand($sql);
			$command->setFetchMode(PDO::FETCH_OBJ);
			
			$command->bindParam(":item_id", $item_id);
			$command->bindParam(":category_id", $category_id);
		}
		else
		{
			$sql = "SELECT m.modifier_type_id, m.name
							FROM modifier_type m, modifier_category c
							WHERE m.modifier_type_id = c.modifier_type_id
							AND ( FIND_IN_SET(:category_id, category_id) )
							AND m.status = 'active'";
			$command = Yii::app()->db->createCommand($sql);
			$command->setFetchMode(PDO::FETCH_OBJ);			
			$command->bindParam(":category_id", $category_id);
		}
		return $command->queryAll();			  
	}
	
	/***
	 * Function to get the modifiers of type
	 ***/
	function get_modifiers($modifier_type_id,$master_item_id = 0)
	{		
		if($master_item_id != 0)
		{
				$sql = "SELECT im.item_mdf_id , m.modifier_id, m.name,t.name as type_name
								FROM modifier m, modifier_type t, item_modifires im
								WHERE im.modifier_id = m.modifier_id
								AND m.modifier_type_id = t.modifier_type_id
								AND m.modifier_type_id = :modifier_type_id
								AND im.item_id = :item_id
								AND m.status = 'active'
								";
			$command = Yii::app()->db->createCommand($sql);
			$command->setFetchMode(PDO::FETCH_OBJ);
			$command->bindParam(":modifier_type_id", $modifier_type_id );
			$command->bindParam(":item_id", $master_item_id );
		}
		else
		{
			$sql = "SELECT m.modifier_id, m.name,t.name as type_name
							FROM modifier m, modifier_type t
							WHERE m.modifier_type_id = t.modifier_type_id
							AND m.modifier_type_id = :modifier_type_id
							AND m.status = 'active' ";
			$command = Yii::app()->db->createCommand($sql);
			$command->setFetchMode(PDO::FETCH_OBJ);
			$command->bindParam(":modifier_type_id", $modifier_type_id );
		}
		return $command->queryAll();		
	}
	
	/***
	 * Function to get the selected modifers for this item
	 ***/
	function get_selected_modifier($item_id,$modifier_type_id = 0,$venue_item_id = 0)
	{
		$selected_modifier = $output_array = array();
		
		$modifier_type_cond = '';
		if($modifier_type_id != 0)
		{
			$modifier_type_cond = 'AND m.modifier_type_id = :modifier_type_id';
			$default_modifier_id = 0;
		}
		else
		  $default_modifier_id = array();
		if($venue_item_id != 0)
		{
			$sql = "SELECT im.item_mdf_id, m.modifier_id, vim.is_default
		        FROM modifier m, modifier_type t, item_modifires im , venue_item_modifier vim
						WHERE im.modifier_id = m.modifier_id
						AND im.item_mdf_id = vim.item_mdf_id
						AND m.modifier_type_id = t.modifier_type_id
						$modifier_type_cond
						AND vim.venue_item_id = :item_id
						AND m.status = 'active'
						";
			$item_id = $venue_item_id;
		}
		else
		{
			$sql = "SELECT im.item_mdf_id, m.modifier_id,is_default
		        FROM modifier m, modifier_type t, item_modifires im
						WHERE im.modifier_id = m.modifier_id
						AND m.modifier_type_id = t.modifier_type_id
						$modifier_type_cond
						AND im.item_id = :item_id
						AND m.status = 'active'
						";		
		}
		
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);
		$command->bindParam(":item_id", $item_id );
		
		if($modifier_type_id != 0)
		  $command->bindParam(":modifier_type_id", $modifier_type_id );
		
		$rec = $command->queryAll();
		
		if(!empty($rec))
		{
			foreach($rec as $sel)
			{				
				$selected_modifier[] = $sel->modifier_id;
				if($sel->is_default == 1)
				{
					if($modifier_type_id != 0)
					  $default_modifier_id = $sel->modifier_id;
				  else
					  $default_modifier_id[] = $sel->modifier_id;
				}
			}
		}
		
	  $output_array = array('selected_modifier' => $selected_modifier ,
													'default_modifier_id' => $default_modifier_id);
		return $output_array;
	}
	
	/***
	 * Function to get the selected item_mdf_id
	 ***/
	function get_selected_item_mdf_id($venue_item_id)
	{
		$selected_modifier = $default_modifier_id = $modifier_price = $output_array = array();
		$sql = "SELECT im.item_mdf_id, vim.is_default,vim.price
		        FROM modifier m, modifier_type t, item_modifires im , venue_item_modifier vim
						WHERE im.modifier_id = m.modifier_id
						AND im.item_mdf_id = vim.item_mdf_id
						AND m.modifier_type_id = t.modifier_type_id						
						AND vim.venue_item_id = :venue_item_id
						AND m.status = 'active'
						";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);
		$command->bindParam(":venue_item_id", $venue_item_id );
		$rec = $command->queryAll();
		
		if(!empty($rec))
		{
			foreach($rec as $sel)
			{				
				$selected_modifier[] = $sel->item_mdf_id;
				$modifier_price[] = $sel->price;
				if($sel->is_default == 1)
				{
					$default_modifier_id[] = $sel->item_mdf_id;
				}
			}
		}
		
	  $output_array = array('selected_modifier' => $selected_modifier ,
													'default_modifier_id' => $default_modifier_id,
													'modifier_price' => $modifier_price);
		return $output_array;
	}
	
	/***
	 * Function to get the default price of the venue modifier
	 ***/
	function getVenue_modiifer_price($item_mdf_id,$venue_item_id)
	{
		$sql = "SELECT price
		        FROM venue_item_modifier
						WHERE venue_item_id = :venue_item_id
						AND item_mdf_id = :item_mdf_id
						LIMIT 1";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);
		$command->bindParam(":item_mdf_id", $item_mdf_id);
		$command->bindParam(":venue_item_id", $venue_item_id);
		$res = $command->queryRow();
		if(!empty($res))
		  return $res->price;
		else
		  return '';
	}
	
	/***
	 * Function to check the duplicate menu item
	 ***/
	function checkDuplicateMenuItem($current_item_id, $ins_data, $mixer_cat_array)
	{
		$venue_specific_cond = $update_condition = '';
		if($ins_data['venue_specific_item'] == 'yes')
		{
			$venue_id = $ins_data['venue_id'];
			$venue_specific_cond = "AND venue_specific_item = 'yes' AND venue_id = $venue_id ";
		}
		
		if($current_item_id != 0)
		{
			$update_condition = "AND item_id != $current_item_id";
		}
		//------------- Mixer and FOOD ----------------//
		if($ins_data['type_id'] == 3 || $ins_data['type_id'] == 2)
		{
			$sql = "SELECT item_id
							FROM items i
							WHERE i.item_name LIKE :item_name
							AND item_status = 'active'
							AND type_id != 1
							$venue_specific_cond
							$update_condition
							LIMIT 1";
							
			//echo 	"SELECT item_id
			//				FROM items i
			//				WHERE i.item_name LIKE '".$ins_data['item_name']."'
			//				AND item_status = 'active'
			//				AND type_id != 1
			//				$venue_specific_cond
			//				$update_condition
			//				LIMIT 1";
			
			$command = Yii::app()->db->createCommand($sql);
			$command->setFetchMode(PDO::FETCH_OBJ);				
			$command->bindParam(":item_name", $ins_data['item_name']);
		}
		else if($ins_data['type_id'] == 1)
		{
			//May be need to join with cat and brand table
		  $sql = "SELECT item_id
			        FROM items i
							WHERE i.type_id = 1
							AND item_status = 'active'
							AND i.category_id = :category_id
							AND i.parent_cat_id = :parent_cat_id
							AND i.brand_id = :brand_id
							AND i.item_name LIKE :item_name
							$venue_specific_cond
							$update_condition						
							LIMIT 1";
							
			//echo "SELECT item_id
			//        FROM items i
			//				WHERE i.type_id = 1
			//				AND item_status = 'active'
			//				AND i.category_id = ".$ins_data['category_id']."
			//				AND i.parent_cat_id = ".$ins_data['parent_cat_id']."
			//				AND i.brand_id =".$ins_data['brand_id']."
			//				AND i.item_name LIKE '".$ins_data['item_name']."'
			//				$venue_specific_cond
			//				$update_condition
			//				LIMIT 1";
			
			$command = Yii::app()->db->createCommand($sql);
			$command->setFetchMode(PDO::FETCH_OBJ);				
			$command->bindParam(":category_id", $ins_data['category_id']);
			$command->bindParam(":parent_cat_id", $ins_data['parent_cat_id']);
			$command->bindParam(":brand_id", $ins_data['brand_id']);
			$command->bindParam(":item_name", $ins_data['item_name']);
		}
		$rec = $command->queryAll();
		return $rec;
	}
		/***
	 * Function to get the Happy hours list of the venue
	 ***/
	function get_happy_hours($venue_id)
	{		
		$sql = "SELECT *
		        FROM happy_hours 
						WHERE venue_id=:venue_id";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);
		$command->bindParam(":venue_id", $venue_id);
		return $command->queryAll();
	}
			/***
	 * Function to get the Happy hours list of the venue
	 ***/
	function get_venue_items_by_id($venue_item_id )
	{		
		$sql = "SELECT item_id,description 
		        FROM venue_items 
						WHERE venue_item_id=:venue_item_id";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);
		$command->bindParam(":venue_item_id", $venue_item_id);
		return $command->queryRow();
	}
				/***
	 * Function to get the Happy hours list of the venue
	 ***/
	function get_happy_hrs_venue_item($happy_hr_id )
	{		
		$sql = "SELECT venue_item_id 
		        FROM happy_hours_item  
						WHERE happy_hr_id =:id";
		$command = Yii::app()->db->createCommand($sql);
		$command->setFetchMode(PDO::FETCH_OBJ);
		$command->bindParam(":id", $happy_hr_id);
		return $command->queryAll();
	}
}
?>