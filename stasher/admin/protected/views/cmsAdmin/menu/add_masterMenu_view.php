 <div class="modal-dialog addSpiritModel">
	<div class="modal-content">
		<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title text-center"><i class="fa <?php if(!empty($categorydet)) echo "fa-edit"; else echo "fa-plus-square-o"; ?>"></i>
				<?php
				if($venue_specific_item == 'yes')
				{
					if($item_id == 0)
				    echo 'Add <B>'.$current_venue_name.'</B> Specific Menu <i class="fa fa-question-circle" data-toggle="tooltip" title="This is venue specific item and will not be visible to any other venue."></i>' ;
					else
					  echo  'Edit <B>'.$current_venue_name.'</B> Specific Menu <i class="fa fa-question-circle" data-toggle="tooltip" title="This is venue specific item and will not be visible to any other venue."></i>' ;
				}
				else
				{
					if($item_id == 0)
				    echo 'Add a New Master Menu Item';
					else
					  echo 'Edit Master Menu Item';
				}
				?>
				</h4>
				<?php
				//Dont change or delete the id of the following hidden input, We are using all of them.
				?>
				<input type="hidden" id="current_venue_id" value="<?php echo $venue_id;?>" />
				<input type="hidden" id="current_venue_specific_item" value="<?php echo ($venue_specific_item == 'addMasterMenu') ? 'no': $venue_specific_item;?>" />
				<input type="hidden" id="current_item_id"       value="<?php if(!empty($item_info)) echo $item_info->item_id; else echo 0; ?>" />
				<input type="hidden" id="current_parent_cat_id" value="<?php if(!empty($item_info)) echo $item_info->parent_cat_id; ?>" />
				<input type="hidden" id="current_sub_cat_id" 	  value="<?php if(!empty($item_info)) echo $item_info->category_id; ?>" />
				<input type="hidden" id="current_brand_id" 	    value="<?php if(!empty($item_info)) echo $item_info->brand_id; ?>" />				
				<input type="hidden" id="current_action_status" value="<?php if(!empty($item_info)) echo 'edit_master_menu'; else echo 'add_master_menu'; ?>" />
							
		</div>
			
	  <form  method="post" id="saveMasterMenu">
			<div class="modal-body">                        
					<div class="col-md-12 col-sm-12">
						<div class="row">
							<div class="row">	
								<div class="form-group modelType">
										<div class="table-bordered spiritNameModel">
											<h5>Select Type  &nbsp;&nbsp;&nbsp;
											<select name="type_id" id="type_id" onchange="chkDrinkType()" <?php if(!empty($item_info)) echo 'disabled=disabled'; ?>> 
												<?php
												foreach($item_type as $it)
												{
													?>
													<option value="<?php echo $it->type_id;?>" <?php if(!empty($item_info)) { if($item_info->type_id == $it->type_id ) { echo  'selected="selected"'; } } ?>>&nbsp;<?php echo $it->type_name?>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
													<?
												}?>																			
											</select>
											</h5>
										</div>   
								</div>
							</div>
						</div>   
					</div>
					<div class="col-md-12 col-sm-12">
							 <div class="row">
									<div class="row">																		
										 <div class="form-group col-md-6 col-sm-6 modelType">
												 <div class="table-bordered spiritNameModel">
													 <h5>Name <label id="item_name_lable"><i class="fa fa-question-circle" data-toggle="tooltip" title="If not given name is Brand name with Category name."></i></label></h5>
													 <div>
														<input type="text" class="form-control" name="item_name" id="item_name"
																	 value="<?php if(!empty($item_info)) echo $item_info->item_name; ?>"
																	 onkeypress="remove_error_class('item_name')"/>
													 </div>
												 </div>   
										 </div>
										 <div class="col-md-6 col-sm-6 form-group modelBrand">
												 <div class="table-bordered modelBasePrice">
													 <h5>Description <i class="fa fa-question-circle" data-toggle="tooltip" title="Description for this item."></i></h5>
													 <textarea class="form-control" rows="1" placeholder="Enter ..." name="description" id="description"><?php if(!empty($item_info)) echo $item_info->description; ?></textarea>
												 </div>   
										</div>
								 </div>
								 
							<div class="row" id="cat_brand_div">
									<div class="form-group col-md-6 col-sm-6 modelType">
										<div class="col-md-12 col-sm-12 table-bordered"> 
												<div class="col-md-7 col-sm-7 spiritType padding_bottom_10">
													 <div id="parentCatDiv">
														<?php
														  $data['type_id'] = $type_id;
															$data['category_list'] = $category_list;
															$data['item_info'] = $item_info;
															echo $this->renderPartial('cmsAdmin/menu/parentCategory_view',$data); ?>
													 </div> 
													 
													 <!--SubCategory Div-->
											     <div id="subCat"></div>
											
												</div>
												
										<!--	<div class="col-md-5 col-sm-5 notFoundBtn">	
													<div class="row ">      
																<span class="pull-right">not found
																		<i class="fa fa-question-circle"></i>                                        
																</span>                                           
													   <button class="btn btn-primary pull-right requestthirstBtn">Add</button>
													</div>    
												</div>   -->
										</div>
									</div>
							 
								<div class="form-group col-md-6 col-sm-6 modelBrand" id="brand_list_div">								   
									 <?php
									 $data['brandList'] = array();
									 echo $this->renderPartial('cmsAdmin/menu/menuBrand_view',$data); ?>
							  </div> 
							 </div>
						
						<div class="row">
							<div class="form-group col-md-6 col-sm-6 modelType">
								<div class="table-bordered spiritNameModel">
									<h5>Status</h5>
									<div>
										<select id="item_status" name="item_status">
											<option value="active" <?php if(!empty($item_info)) { if($item_info->item_status == 'active') echo 'selected="selected"'; } ?>>Active</option>
											<option value="inactive" <?php if(!empty($item_info)) { if($item_info->item_status == 'inactive') echo 'selected="selected"'; } ?>>Inactive</option>
										</select>
									</div>
								</div>   
							 </div>
						</div>	
						
						<div class="row" id="modi_div">  
							<?php
							$data['menuModel'] = $menuModel;
							$data['master_item_id'] = 0;
							$data['venue_item_id']  = 0;
							$data['modifier_type_list'] = $modifier_type_list;							
							$data['current_action_status'] = $current_action_status;
							
							echo $this->renderPartial('cmsAdmin/menu/menuModifierType_view',$data); ?>		
						</div>
						
						
						
					 </div>   
					</div>
																 
					<div class="text-center">
						<?php
						if($venue_specific_item == 'yes')
						{
							?>
							<button type="button" onclick="saveMasterMenu('saveNgoBack');"  class="btn btn-primary btn-flat margin pull-center"><i class="fa fa-save"></i> Save And Return</button>
							<?
						}
						else if($venue_specific_item == 'addMasterMenu')
						{
							?>
							<button type="button" onclick="saveMasterMenu('saveNreturn');"  class="btn btn-primary btn-flat margin pull-center"><i class="fa fa-save"></i> Save And Return</button>
							<?php
						}
						else
						{
							?>
								<button type="button" onclick="saveMasterMenu('saveNclose');"  class="btn btn-primary btn-flat margin pull-center"><i class="fa fa-save"></i> Save And Close</button>
							<?php
							if(empty($item_info))
							{
							?>
									<button type="button" onclick="saveMasterMenu('saveNopen');" class="btn btn-primary bg-flat margin pull-center"><i class="fa fa-save"></i> Save And Add Another</button>
									<!--<button type="submit" class="btn bg-navy margin pull-center"><i class="fa fa-fast-forward"></i> Add Cross-cell Items </button>-->
							<?php
						  }
						}
						?>						
					</div>
			</div><!--<div class="modal-body">-->
		</form>
	</div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->