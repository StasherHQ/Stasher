<?php
/*********************************************************************** 
* Filename: AdminMenuController.php  :  access name: AdminMenuController 
* Original Author: Anuja Oab 
* File Creation Date: Aug 08 , 2014  
* Development Group: OAB
* 
* Description:  Create edit menu realted stuff will go in this class
***********************************************************************/
ob_start();
class AdminMenuController extends Controller
{
	public function __construct()
	{
		if(Yii::app()->session['admin_id'] == '' &&  Yii::app()->session['admin_name'] == '')
			$this->redirect('login'); //Load login view
			
			Yii::app()->session['activetab'] = 'menu';	
  }
	
	/***
	 * Function to load the menu related page
	 ***/
	public function actionIndex()
	{
		$this->setPageTitle(Yii::app()->name.' - Menu'); //Set the custom page title 
		
		$commonModel = new commonModel;			
		$menuModel = $data['menuModel'] = new menuModel;
		$categoryModel = $data['categoryModel'] = new categoryModel;
		$venuemenuModel = $data['venuemenuModel'] = new venuemenuModel;
		$search_txt = $search_category = $search_brand = $activetab = "";
		$searchedCond = array();
		
		if(isset($_POST['active_tab']))
				$activetab = $_POST['active_tab'];
		
		//echo "active tab==>".$activetab;
		
		$data['menutab'] = $data['menu_all'] = "";
		if($activetab == "all")
		{
			$data['menu_all'] = '1';			
		}
		else if($activetab == 'Drinks')
		{
			$data['menutab'] = "Drinks";	
		}
		else if($activetab == 'Mixers')
		{
			$data['menutab'] = "Mixers";
		}
		else if($activetab == 'Food')
		{
			$data['menutab'] = "Food";
		}
		else{
					$data['menu_all'] = '1';			
		}
		
		if(isset($_POST['search_txt']) && !empty($_POST['search_txt']))
		{
				$search_txt = $_POST['search_txt'];
		}
		if(isset($_POST['category']) && !empty($_POST['category']))
		{
				$search_category = $_POST['category'];
		}
		if(isset($_POST['brand']) && !empty($_POST['brand']))
		{
				$search_brand = $_POST['brand'];
		}
		
		$data['search_txt'] = $searchedCond['search_txt'] = $search_txt;
		$data['search_category'] = $searchedCond['category'] = $search_category;
		$data['search_brand'] = $searchedCond['brand'] = $search_brand;
		
		$data['category_names'] = $menuModel->getCategorylist();		
		$data['brand_names'] = $categoryModel->getBrandlist();		
		
		//get the type of the item type
		$data['item_type'] = $item_type = $menuModel->getItemType();
		
		//get the type of the items menu
		$data['all_menu_list'] = $menuModel->menu_item_list($searchedCond);
		$data['drinks_menu_list'] = $menuModel->menu_item_list($searchedCond,1);
		$data['mixers_menu_list'] = $menuModel->menu_item_list($searchedCond,2);
		$data['food_menu_list'] = $menuModel->menu_item_list($searchedCond,3);
		 
	  $this->render('cmsAdmin/menu/menu_view',$data);
	}
	
	/***
	 * Function to add the menu in the item table
	 **/
	function actionAddMasterMenuItem()
	{
		$data =  array();
		$categoryModel = new categoryModel;
		$menuModel = new menuModel;
		$data['menuModel'] = $menuModel;
		$data['item_info'] = array();
		$data['venue_id'] = $venue_id = $_POST['venue_id'];
		$data['venue_specific_item']  = $_POST['venue_specific_item'];		
		$data['item_id'] = $item_id = $_POST['item_id'];
		
		if($venue_id != 0)
		{
			$venueModel = new venueModel;
			$vm = $venueModel->get_venue_names($venue_id);
			if(!empty($vm))
			{
				$data['current_venue_name'] = $vm[0]->venue_name;
			}
			if($item_id != 0)
			{
				$data['current_action_status'] =  'edit_master_menu';
			}
			else
			  $data['current_action_status'] =  'add_master_menu';
		}
		else
		{
		 $data['current_venue_name'] = '';
		 if($item_id != 0)
		   $data['current_action_status'] =  'edit_master_menu';
		 else
		   $data['current_action_status'] =  'add_master_menu';
		}
		
		$data['type_id'] = 1;
		$data['item_type'] = $menuModel->getItemType();
		$data['category_list'] = $categoryModel->getCategoryActivelist();
		$data['modifier_type_list'] = $menuModel->getModifierTypeList();
		
		if($item_id != 0)
		{
			$venuemenuModel = new venuemenuModel;
			//Get the item details
			$data['item_info'] = $venuemenuModel->getItemDetail($item_id);
			if(!empty($data['item_info']))
			{
				$data['venue_id'] = $data['item_info']->venue_id;
		    $data['venue_specific_item']  = $data['item_info']->venue_specific_item;
			}			
		}
		
		echo $this->renderPartial('cmsAdmin/menu/add_masterMenu_view',$data,true);
	}
	
	/***
	 * Function to save the master menu in the item tabke
	 **/
	function actionSaveMasterMenuItem()
	{
		$output_array = array();
		$commonModel = new commonModel;
		$menuModel   = new menuModel;
		
		$current_item_id = $_POST['current_item_id'];
		$current_action_status = $_POST['current_action_status'];

		$type_id =  $ins_data['type_id'] = $_POST['type_id'];
		$item_name = $ins_data['item_name'] = $_POST['item_name'];
		$ins_data['item_status'] = $_POST['item_status']; 
		$description = $ins_data['description'] = $_POST['description'];		
		$category_id = $mixer_cat_array = $_POST['category_id'];
		$sub_category_id = $_POST['sub_category_id'];
		
		//Venue Specific Drink if master menu the venue_specific_item is no and venue id is 0
	  $ins_data['venue_specific_item'] = $venue_specific_item = $_POST['venue_specific_item'];
		$ins_data['venue_id'] = $venue_id = $_POST['venue_id'];
    
		if($venue_id != 0 && $venue_specific_item == 'yes')
		{
			$ins_data['venue_specific_item'] = $venue_specific_item;
			$ins_data['venue_id'] = $venue_id;
		}
		if($type_id == 1) //If drink then only we have catedory and sub category
		{
			if($sub_category_id != 0)
			{
				$ins_data['category_id'] =  $sub_category_id;
				$ins_data['parent_cat_id'] =  $category_id;
			}
			else
			{
				$ins_data['category_id'] =  $category_id;
			  $ins_data['parent_cat_id'] =  $category_id;
			}
			$brand_id = $ins_data['brand_id'] = $_POST['brand_id'];
		}
		else
		{
			$ins_data['category_id'] = 0;
			$ins_data['parent_cat_id'] = 0;			
			$ins_data['brand_id'] = 0;
		}
				
		$ins_data['submitted_timestamp'] = date('Y-m-d h:i:s');
		
		$dupItem = $menuModel->checkDuplicateMenuItem($current_item_id,$ins_data,$mixer_cat_array);
		if(!empty($dupItem))
		{
			$output_array = array('status' => 'duplicate' , 'item_id' => 0);
		}
		else
		{
			//---------------- ADD ITEM ---------------------//
			if($current_action_status == 'add_master_menu')
			{
					if($commonModel->insertData('items',$ins_data))
			    {
						$item_id = Yii::app()->db->getLastInsertID();
						$venue_item_id = 0;
					  //---------- If venue specific Item then insert this in to the venue_items table------//
						if($venue_specific_item == 'yes')
						{
							$ins_vim = array();
							$ins_vim['venue_id'] = $venue_id;
							$ins_vim['item_id'] = $item_id;
							$ins_vim['description'] = $description;
							$ins_vim['base_price'] = 0;
							$ins_vim['parent_venue_item_id'] = 0;
							$ins_vim['vi_status'] = 'inactive';
							$ins_vim['created_timestamp'] = date('Y-m-d h:i:s');
							$commonModel->insertData('venue_items',$ins_vim);
							$venue_item_id = Yii::app()->db->getLastInsertID();
						}
					 //If this is type mixer then add the entry in the  mixer_category table
					 if($type_id == 2)
					 {
						 //category_id is array in this case
						 foreach($mixer_cat_array as $cat)
						 {
							 $ins_mix = array();
							 $ins_mix['mixer_id'] = $item_id;
							 $ins_mix['category_id'] = $cat;					
							 $commonModel->insertData('master_mixer_category',$ins_mix);
							 
							 //Insert in to the mixer_category for the venue specific menu
							 if(($venue_specific_item == 'yes') && ($venue_item_id == 0))
							 {
								$ins_vim_mix = array();
								$ins_vim_mix['mixer_id'] = $item_id;
								$ins_vim_mix['venue_item_id'] = $venue_item_id;								
								$ins_vim_mix['category_id'] = $cat;					
								$commonModel->insertData('mixer_category',$ins_vim_mix);
							 }
						 }				
					 }
					 elseif($type_id == 1)
					 {
						$selected_modifier_ids = $default_modifier = array();
						if(isset($_POST['selected_modifier_ids']))
						 $selected_modifier_ids =  $_POST['selected_modifier_ids'];
						if(isset($_POST['default_modifier']))
						 $default_modifier = $_POST['default_modifier'];
						 
						 //Insert in to item_modifires table
						 foreach($selected_modifier_ids as $sel)
						 {
							 $ins_modifier = array();
							 $ins_modifier['item_id'] =  $item_id;
							 $ins_modifier['modifier_id'] =  $sel;
							 //Check this modifier is present in the default modifier array or not
							 if(!empty($default_modifier))
							 {
								 if(in_array($sel,$default_modifier))
									 $ins_modifier['is_default'] =  1;
								 else
									 $ins_modifier['is_default'] =  0;
							 }
							 else
								$ins_modifier['is_default'] =  0;
								 
							 $commonModel->insertData('item_modifires',$ins_modifier);							 
							 //Insert in to venue_item_modifier 
							 if(($venue_specific_item == 'yes') && ($venue_item_id == 0))
							 {
								 $item_mdf_id = Yii::app()->db->getLastInsertID();
								 $ins_vim_modifier = array();
								 $ins_vim_modifier['venue_item_id'] = $venue_item_id ;
								 $ins_vim_modifier['item_mdf_id'] = $item_mdf_id;
								 $ins_vim_modifier['price'] = 0;
								 $ins_vim_modifier['is_default'] = $ins_modifier['is_default'];
								 $ins_vim_modifier['status'] = 'active';
								 $commonModel->insertData('venue_item_modifier',$ins_vim_modifier);	
							 }
						 }//end of the foreach				
					 }					 
					 $output_array = array('status' => 'success', 'item_id' => $item_id, 'venue_item_id' => $venue_item_id);	
					}//end of of the if insert
					else
					{
					 $output_array = array('status' => 'error' , 'item_id' => 0);
					}
			}//end of condition if($current_action_status == 'add_master_menu')				
			else  //---------------- UPDATE ITEM ---------------------//
			{
				    $item_id = $current_item_id;
						//-------- Update start----------//
						$update_data = $where_array = array(); $where_string = '';
						$update_data = $ins_data;								
						$where_string = 'item_id = :item_id';
						$where_array[':item_id'] = $current_item_id;
						$commonModel->updateData('items', $update_data , $where_string , $where_array);
						$update_data = $where_array = array(); $where_string = '';
						//-------- Update End----------//
					
						//-------------- DRINK ------------------//
						if($type_id == 1)
					  {
							$selected_modifier_ids = $default_modifier_ids = array();
							
							if(isset($_POST['selected_modifier_ids']))							
							  $selected_modifier_ids = $_POST['selected_modifier_ids'];
							
							if(isset($_POST['default_modifier']))	
							  $default_modifier_ids = $_POST['default_modifier'];
								
						  $venuemenuModel =  new venuemenuModel;
							$menuModel = new menuModel;
							$selected_modifier_detail = $menuModel->get_selected_modifier($item_id);
							$prev_selected_modifiers = $selected_modifier_detail['selected_modifier'];
							$prev_default_modifiers = $selected_modifier_detail['default_modifier_id'];
						  
							//echo "Current Mod \n";
							//print_r($selected_modifier_ids);
							//echo "Current Def Mod \n";
							//print_r($default_modifier_ids);
							//
							//echo "== Prev Mod \n";
							//print_r($prev_selected_modifiers);
							//echo "== Prev Default Mod \n";
							//print_r($prev_default_modifiers);
							
							$is_same = $commonModel->array_equal($selected_modifier_ids,$prev_selected_modifiers);
							if($is_same)
							{
								$is_same_default = $commonModel->array_equal($default_modifier_ids,$prev_default_modifiers);
								if(!$is_same_default)
								{
								  //1. Make all default zero
								  //-------- Update start----------//
									$update_data = $where_array = array(); $where_string = '';
									$update_data['is_default'] =  0;					
									$where_string = 'item_id = :item_id';
									$where_array[':item_id'] = $current_item_id;
									$commonModel->updateData('item_modifires', $update_data , $where_string , $where_array);
									//-------- Update Ends----------//
									
									foreach($default_modifier_ids as $mod)
									{
										//-------- Update start----------//
										$update_data = $where_array = array(); $where_string = '';
										$update_data['is_default'] =  1;					
										$where_string = 'modifier_id = :modifier_id';
										$where_array[':modifier_id'] = $mod;
										$commonModel->updateData('item_modifires', $update_data , $where_string , $where_array);
										//-------- Update Ends----------//
									}
								}
							}
							elseif(!$is_same) // If array same no need to do anything
							{
								//1.Get the same element from array
								$com_modifier = array_intersect($selected_modifier_ids,$prev_selected_modifiers);
								//print_r($com_modifier);
								if(!empty($com_modifier))
								{
									//Do Nothing for the common modifier
								}
								
								//2. First Array Diff
								//echo "\n first_array_diff =>";
								$first_array_diff = array_diff($selected_modifier_ids,$prev_selected_modifiers);								
								if(!empty($first_array_diff))
								{
									foreach($first_array_diff as $mod)
									{
										//Insert this in to table
										//--------  Insert start----------//
										$ins_modifier = array();
										$ins_modifier['item_id'] =  $item_id;
										$ins_modifier['modifier_id'] =  $mod;
										$ins_modifier['is_default'] =  0;											
										$commonModel->insertData('item_modifires',$ins_modifier);
										//-------- Insert End----------//
									}
								}
								
								//3. Second Array Diff
								//echo "\n second_array_diff =>";
								$second_array_diff = array_diff($prev_selected_modifiers,$selected_modifier_ids);
								if(!empty($second_array_diff))
								{
									foreach($second_array_diff as $mod)
									{
										//-------- Delete start----------//
										$del = array();  $condtionString = '';
										$condtionString   = 'modifier_id = :modifier_id AND item_id = :item_id';
										$del[':modifier_id']  = $mod;
										$del[':item_id'] = $item_id;			
										$commonModel->deleteData('item_modifires',$condtionString,$del);
										//-------- Delete End----------//	
									}
								}
								
									//-----------Update the default modifer ---------//
									//1. Make all default zero
								  //-------- Update start----------//
									$update_data = $where_array = array(); $where_string = '';
									$update_data['is_default'] =  0;					
									$where_string = 'item_id = :item_id';
									$where_array[':item_id'] = $current_item_id;
									$commonModel->updateData('item_modifires', $update_data , $where_string , $where_array);
									//-------- Update Ends ----------//
									
									foreach($default_modifier_ids as $mod)
									{
										//-------- Update start----------//
										$update_data = $where_array = array(); $where_string = '';
										$update_data['is_default'] =  1;					
										$where_string = 'modifier_id = :modifier_id';
										$where_array[':modifier_id'] = $mod;
										$commonModel->updateData('item_modifires', $update_data , $where_string , $where_array);
										//-------- Update Ends----------//
									}
							}		
						}
						 elseif($type_id == 2)//-------------- MIXER ------------------//
						{
							//Get previous category list
							$venuemenuModel =  new venuemenuModel;
							$prev_sel_category = array();
							$sel_category = $venuemenuModel->getMixerItemCategory($item_id);
							foreach($sel_category as $sel)
							{
								$prev_sel_category[] = $sel->category_id;
							}
								
							//$mixer_cat_array
							$is_same = $commonModel->array_equal($mixer_cat_array,$prev_sel_category);
							if(!$is_same) // If array same no need to do anything
							{
								//Array not equal so update here
								//1.Get the same element from array
								//echo "\n Comm =>";
								$com_mix_cat = array_intersect($mixer_cat_array,$prev_sel_category);
								//print_r($com_mix_cat);
								if(!empty($com_mix_cat))
								{
									//Do Nothing for the common category
								}	
								
								//2. First Array Diff
								//echo "\n first_array_diff =>";
								$first_array_diff = array_diff($mixer_cat_array,$prev_sel_category);
								//print_r($first_array_diff);
								if(!empty($first_array_diff))
								{
									foreach($first_array_diff as $cat)
									{
										//Insert this in to table
										//--------  Insert start----------//
										 $ins_mix = array();
										 $ins_mix['mixer_id'] = $item_id;
										 $ins_mix['category_id'] = $cat;					
										 $commonModel->insertData('master_mixer_category',$ins_mix);
										//-------- Insert End----------//
									}
								}
								
								//3. Second Array Diff
								//echo "\n second_array_diff =>";
								$second_array_diff = array_diff($prev_sel_category,$mixer_cat_array);
								if(!empty($second_array_diff))
								{
									foreach($second_array_diff as $cat)
									{
										//-------- Delete start----------//
										$del = array();  $condtionString = '';
										$condtionString   = 'category_id = :category_id AND mixer_id = :mixer_id';
										$del[':category_id']  = $cat;
										$del[':mixer_id'] = $item_id;			
										$commonModel->deleteData('master_mixer_category',$condtionString,$del);
										//-------- Delete End----------//	
									}
								}
							}
						}
						
					$output_array = array('status' => 'success' , 'item_id' => $current_item_id);						
			}			
		}//end of the else
		echo json_encode($output_array);
	} 
	
  /***
	 * Function to load the category view as per the type
	 ***/
	function actionGetCategory()
	{
		$categoryModel =  new categoryModel;
		$data['type_id'] = $_POST['type_id'];
		$item_id = $_POST['item_id'];
		if($item_id != 0 )
		{
			$venuemenuModel = new venuemenuModel;
		  $sel_category = $venuemenuModel->getMixerItemCategory($item_id);
			foreach($sel_category as $sel)
			{
				$data['sel_category'][] = $sel->category_id;
			}
		}
		else
		  $data['sel_category'] = array();
		$data['category_list'] = $categoryModel->getCategoryActivelist();
		echo $this->renderPartial('cmsAdmin/menu/parentCategory_view',$data,true);
	}
	
	/**
	 * Function to get sub category for add new menu item
	 ***/
	function actionGetSubCategory()
	{
		$cat_id = $_POST['category_id'];		
		$categoryModel = new categoryModel;		
		$data['subcategory_list'] = $categoryModel->get_sub_category($cat_id);
		if(!empty($data['subcategory_list']))
		 echo $this->renderPartial('cmsAdmin/menu/subCategory_view',$data,true);
		else
		 echo '';
	}
	
	/****
	 * Function to get the brand list
	 ***/
	function actionGetBrandList()
	{
		$category_id = $_POST['sub_category_id'];
		
		$menuModel = new menuModel;		
		$data['brandList'] = $menuModel->get_brands_by_subcategory($category_id);
		echo $this->renderPartial('cmsAdmin/menu/menuBrand_view',$data,true);
	}
	
	/***
	 * Function to get the modifier list
	 ***/
	function actionGetModifierList()
	{
		$data['current_action_status'] = $current_action_status = $_POST['current_action_status'];
		$category_id = $_POST['category_id'];
		$data['master_item_id'] = $master_item_id = $_POST['master_item_id'];
		$data['venue_item_id'] = $venue_item_id = isset($_POST['venue_item_id']) ? $_POST['venue_item_id'] : 0;
		
		$data['selected_modifier_type_list'] = array();
		$data['menuModel'] = $menuModel = new menuModel;		
	
		//Get the modifier list as per the action status - add_master_menu | edit_master_menu | edit_venue_menu | add_venue_menu
		if($current_action_status == 'add_master_menu')
		  $data['modifier_type_list'] = $menuModel->get_modifier_by_category($category_id);		
		else if($current_action_status == 'edit_master_menu')
		{
			$data['modifier_type_list'] = $menuModel->get_modifier_by_category($category_id);
			$selected_modifier_type = $menuModel->get_modifier_by_category($category_id,$master_item_id);
			foreach($selected_modifier_type as $modi)
				{
					$data['selected_modifier_type_list'][] = $modi->modifier_type_id;
				}
		}
		else if($current_action_status == 'add_venue_menu' || $current_action_status == 'edit_venue_menu' )
		{
		  $data['modifier_type_list'] = $menuModel->get_modifier_by_category($category_id,$master_item_id);
			if($current_action_status == 'add_venue_menu')
			  $sel_modifier = $data['modifier_type_list'];
			else
			  $sel_modifier = $menuModel->get_modifier_by_category($category_id,$master_item_id,$venue_item_id);
			foreach($sel_modifier as $modi)
			{
				$data['selected_modifier_type_list'][] = $modi->modifier_type_id;
			}
		}
		
		echo $this->renderPartial('cmsAdmin/menu/menuModifierType_view',$data,true);
	}//end of the function actionGetModifierList
	
}//end of the class AdminMenuController
ob_clean();
?>