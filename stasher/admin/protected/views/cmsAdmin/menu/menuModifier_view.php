<table class="table table-bordered table-striped" id="sel_modifier_table"> 
		<thead>
				<tr>
					<!-- If any column added here.. Remember to add it to thefooter also and  $colspan variable -->
						<th class="col-md-2 col-sm-2 text-center">Modifier</th>                                      
						<th class="col-md-1 col-sm-1 text-center">Option  <i class="fa fa-question-circle" data-toggle="tooltip" title="Choose modifier to add for this menu item."></i> </th>
						<th class="col-md-4 col-sm-4 text-center">Name</th>
						<th class="col-md-1 col-sm-1 text-center">Select Default <i class="fa fa-question-circle" data-toggle="tooltip" title="Choose default modifier from the selected."></i> </th>
						
						<?php
						//echo "==>".$current_action_status;
						//edit_venue_menu | add_venue_menu
						if($master_item_id != 0 && ($current_action_status == 'add_venue_menu' || $current_action_status == 'edit_venue_menu'))
						{
							$colspan = 5;
							?>
								<th class="col-md-6 col-sm-6 text-center">Add Cost</th>
							<?
						}
						else
						  $colspan = 4;
						?>
						
				</tr>
		</thead>
		<tbody>
			<?php
			
			if(!empty($modifier_type_list))
			{
				foreach($modifier_type_list as $mod_type)
				{
					//Get the modifers of this type
					$mod_type_id = $mod_type->modifier_type_id;
				 
					if($current_action_status == 'edit_master_menu')
		      {
				 	  $modifier_items  = $menuModel->get_modifiers($mod_type_id);
					}
					else
					  $modifier_items  = $menuModel->get_modifiers($mod_type_id,$master_item_id);
					//echo '$venue_item_id=> '.$venue_item_id ;
					//echo '$master_item_id=> '.$master_item_id ;

					if($master_item_id != 0)
					{
						//get selected modifier for thie item
						$selected_modifier_detail = $menuModel->get_selected_modifier($master_item_id,$mod_type_id,$venue_item_id);
						$selected_modifier =   $selected_modifier_detail['selected_modifier'];
						$default_modifier_id = $selected_modifier_detail['default_modifier_id'];
					}
					else
					{
						$default_modifier_id = 0;
					  $selected_modifier = array();
					}
					
					if(!empty($modifier_items))
					{
						$i = 0;
						foreach($modifier_items as $modifier)
						{
							$i++;
							?>							
							<tr class = "tr_modifier_type_<?php echo $mod_type_id?>">                     
								<td class="col-md-2 col-sm-2 text-center">                                    
									<?php
									if($i == 1)
									{
										echo $modifier->type_name;
									}?>
								</td>
								<td class="col-md-1 col-sm-1 text-center">
									<input type="checkbox"
												 id="modifier_id_<?php echo $modifier->modifier_id; ?>"
												
												 onchange="hideDefaultRadioBtn(<?php echo $modifier->modifier_id; ?>,<?php echo $mod_type_id?>);"
												 <?php
												 if(!empty($selected_modifier))
												 {
													if((in_array($modifier->modifier_id,$selected_modifier)))
													{
														echo 'checked="checked"';
													}
													else
													  echo '';
												 }
												 else
												  echo '';
												 //elseif($current_action_status == 'edit_master_menu')
												 //  echo '';
												 //else
												 //  echo 'checked="checked"';
												 ?>
												 <?php
												 if($current_action_status == 'add_venue_menu' || $current_action_status == 'edit_venue_menu')
													{
													?>
													 data-item_mdf_id = "<?php echo $modifier->item_mdf_id; ?>"
													<?php
													}
												 ?>
												 value="<?php echo $modifier->modifier_id; ?>" />
								</td>
								<td class="col-md-4 col-sm-4 text-center">
									<?php echo $modifier->name; ?>
								</td>
								<td class="col-md-1 col-sm-1 text-center">
									<input type="radio"
												 name="radio_modifier_name_<?php echo $mod_type_id?>[]"
												 id="radio_modifier_id_<?php echo $modifier->modifier_id; ?>"
												 onchange = "checkDefaultRadioBtn(<?php echo $modifier->modifier_id; ?>,<?php echo $mod_type_id?>)"
												 value="<?php
												 if($current_action_status == 'add_venue_menu' || $current_action_status == 'edit_venue_menu')
												   echo $modifier->item_mdf_id;
												else
												   echo $modifier->modifier_id; ?>"
												 <?php
												 if($default_modifier_id == $modifier->modifier_id)
												 {
													echo 'checked="checked"';
												 }
												 ?>
												 >
								</td>
								
								<?php
								if($master_item_id != 0 && ($current_action_status == 'add_venue_menu' || $current_action_status == 'edit_venue_menu'))
								{
									if( $current_action_status == 'edit_venue_menu')
									  $modifier_price = $menuModel->getVenue_modiifer_price($modifier->item_mdf_id,$venue_item_id);
									else
									  $modifier_price = '';
									?>
										<td class="col-md-6 col-sm-6">										
											<div class="form-group">
											  <input id="modifier_price_<?php echo $modifier->modifier_id; ?>" type="text" class="form-control"
															 value="<?php echo $modifier_price; ?>" placeholder="0.00" onkeypress="remove_error_class('modifier_price_<?php echo $modifier->modifier_id; ?>')"/>
											</div>											
										</td>
										<?php
								}?>
							</tr>							
							<?php
						}
						?>
						<?php
					}
					?>
					<tr ><td colspan="<?php echo $colspan;?>" style="background-color : #cccccc !important"> </td></tr>
					<?php
				}
			}
			?>
		</tbody>	 
</table>