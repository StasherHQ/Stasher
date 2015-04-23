<?php
 if(!empty($modifier_type_list))
 {
	?>
<div class="form-group col-md-4 col-sm-4 modelType">
	<div class="col-md-12 col-sm-12 form-group table-bordered applicableModifiers" id="applicableModifiers">	
		 <h5>Choose Applicable Modifiers <i class="fa fa-question-circle" data-toggle="tooltip" title="Check the modifier type to get there modifers on the right side"></i>
	</h5>
		 <?php
		 if(!empty($modifier_type_list))
		 {
			 foreach($modifier_type_list as $mod_type)
			 {				 
				 ?>
				 <div class="col-md-12 col-sm-12">
				 <div class="row">	
					 <input type="checkbox"
									name="modifier_type"
									id="modifier_type_<?php echo $mod_type->modifier_type_id; ?>"
									onchange="showHideModifier(<?php echo $mod_type->modifier_type_id; ?>)"
									<?php									
									if(isset($selected_modifier_type_list))
									{										
										if(in_array($mod_type->modifier_type_id, $selected_modifier_type_list))
										  { echo 'checked="checked"'; }
									}
									elseif($current_action_status == 'edit_master_menu')
										echo '';									
									else
										echo 'checked="checked"';
									?>
									
									value="<?php echo $mod_type->modifier_type_id; ?>"  />
					 <label><?php echo $mod_type->name; ?></label>
				 </div>    
			 </div>  
				 <?php
			 }
		 }
		 ?>
	</div>
</div>

<div class="form-group col-md-8 col-sm-8 modelBrand table-bordered" style="overflow-y: scroll;height: 250px">
	<?php
	  //If you add any variable here please remer to add same in the add_masterMenu_view.php
		$data['menuModel'] = $menuModel;
		$data['modifier_type_list'] = $modifier_type_list;		
		$data['master_item_id'] = $master_item_id;
		$data['venue_item_id'] = $venue_item_id;
		$data['current_action_status'] = $current_action_status;
		echo $this->renderPartial('cmsAdmin/menu/menuModifier_view',$data);
	?>
</div>
<?php
 }
 ?>
