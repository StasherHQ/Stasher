 <div class="modal-dialog addSpiritModel">
	<div class="modal-content">
			<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title text-center"><i class="fa <?php if(!empty($categorydet)) echo "fa-edit"; else echo "fa-plus-square-o"; ?>"></i> Add a new Menu Item</h4>
			</div>
			
			<form action="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/AdminMenu/savemenuitem" method="post" id="savemenuitem">
					<div class="modal-body">                        
							 <!-- left column -->
					<div class="col-md-12 col-sm-12">
							 <div class="row">
										 <div class="row"> 
												<div class="form-group col-md-6 col-sm-6 modelType">
														<div class=" table-bordered spiritNameModel">
															<h5>Name your menu item (if applicable)</h5>
														 <div><input type="text" class="form-control" name="itemname" id="itemname" placeholder="e.g Classic Gin Martini" value="" /></div>
														 
															<div>
															<h5>Description</h5>
															<input type="text" class="form-control" name="description" id="description" value="" />
															</div>
														</div>
														
														
														 
												</div>
												<div class="col-md-6 col-sm-6 form-group modelBrand">
														<div class="table-bordered modelBasePrice modalChooseBrandSubBrand">
															<div class="col-md-9 col-sm-9">
															    <h5>Choose Drink Type</h5>
																	<div>   
																	<select name="itemtype" id="itemtype" onchange="get_menuitemsubtype();remove_error_class('itemtype');" data-rel="chosen" class="col-md-12"  data-placeholder="Choose Drink Type">
																		<option value="">Select Drink Type</option>
																				<?php   if(!empty($categorylist)){
																								 foreach($categorylist as $cname){ ?>                                    
																								 <option value="<?php echo $cname->category_id?>"><?php echo $cname->cat_name?></option>
																				<?php } } ?>
																		</select>
																	</div>
								
															
															</div>
															<div class="col-md-3 col-sm-3">
															</div>
															
															<div class="col-md-9 col-sm-9">
															<h5>Choose Drink Sub-type</h5>
																
																 <div id="menuitemsubtype" style="display:none;">
																	<!-- menu item sub type list here  -->
																	</div>               
															
															</div>
															<div class="col-md-3 col-sm-3 notFoundBtn">	
																<div class="row">      
																			<span class="">not found ? <br/>
																			add new drink type                          
																			</span>
																			<a class="btn btn-flat btn-primary requestthirstBtn" data-toggle="modal" data-target="#addcategory-modal" onclick="addcategory()"><i class="fa fa-pencil"></i> Add</a>																
																		</div>    
															</div>
														
														</div>
														
											 </div>
										</div>   
							<div class="row">
								<div class="form-group col-md-6 col-sm-6 modelType">
									<div class="col-md-12 col-sm-12 table-bordered modalChooseBrandSubBrand"> 
			<div class="col-md-9 col-sm-9">
												 
													 <h5>Select Brand</h5>																				
													<div id="itembrands" style="display:none;">
														<!-- menu item  brands list here  -->
													</div>																				
											</div>     
										<div class="col-md-3 col-sm-3 notFoundBtn">	
												<div class="row">      
															<span class="">not found ? <br/>
																add new brand                               
															</span>
															<a class="btn btn-primary btn-flat requestthirstBtn" data-toggle="modal" data-target="#addcategory-modal" onclick="addbrand()"><i class="fa fa-pencil"></i> Add</a>                          
														</div>    
											</div>   
									</div>
								</div>
							 
								<div class="form-group col-md-6 col-sm-6 modelBrand">
								 <div class="col-md-12 col-sm-12 table-bordered modalChooseBrandSubBrand"> 	 
											<div class="col-md-9 col-sm-9">
													 <h5>Choose Allowed Modifiers</h5>
													 
													 <select id="modifier_type" name="modifier_type" class="form-control" data-placeholder="Select Modifier Type">
																	<option value="0">Select Modifier Type</option>
																		<?php   if(!empty($modifiertype)){                                      
																						 foreach($modifiertype as $mtype){ ?>                                    
																						 <option value="<?php echo $mtype->modifier_type_id?>">
																						 <?php echo $mtype->name?></option>
																		<?php } } ?>
																</select>
													
											</div>
											<div class="col-md-3 col-sm-3 notFoundBtn">	
												<div class="row">     
															 <span class="">not found? <br/>
															 add new modifier
															 </span>
																<a class="btn btn-primary btn-flat requestthirstBtn" data-toggle="modal" data-target="#addmodifier-modal" onclick="addmodifier()"><i class="fa fa-pencil"></i> Add</a>
															 
											 </div>    
											</div>         
								 </div>  
							</div> 
						</div>  
						
						
						 </div>   
					</div>
																 
					<div style="text-align: center;">
								<input type="hidden" name="savemenuitem_submit" value="1" />                            
							<button type="submit" onclick="save_menuitem();return false;" class="btn bg-flat margin pull-center"><i class="fa  fa-save"></i> Save Drink</button>
							
					</div>
					</div>
					
			</form>
	</div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->

		<!-- ADD NEW CATEGORY -->
        <div class="modal fade" id="addcategory-modal" tabindex="-1" role="dialog" aria-hidden="true">           
        </div><!-- /.modal -->
				
          <!-- ADD NEW Modifier -->
	<div class="modal fade" id="addmodifier-modal" tabindex="-1" role="dialog" aria-hidden="true">           
	</div><!-- /.modal -->
	
<script>
               $('[data-rel="chosen"],[rel="chosen"]').chosen({search_contains: true});        
</script>
<script>
      	
      function get_menuitemsubtype()
      {
               var cat_id = $('#itemtype').val();
							 var error_flag = 0;
							 
							 if (cat_id == '') {
									add_error_class('itemtype','Please choose drink type');
									error_flag = 1;
									
									$("#menuitemsubtype").html('');
                  $('#menuitemsubtype').css("display","none");
									
									$("#itembrands").html('');
                  $('#itembrands').css("display","none");						
							 }
									//	alert("cat id==>"+cat_id);
                   if (error_flag == 0)
									 {
										$.ajax({
												url: '<?php echo Yii::app()->baseUrl;?>/index.php/cmsAdmin/AdminMenu/menuitemsubtype', 
												type: "POST",
												data:{cat_id:cat_id},
												success: function(data){
                          //alert("data==>"+data);
													  if (data != 'No Data Found') {
																$("#menuitemsubtype").html(data);
																$('#menuitemsubtype').css("display","block");
																$('[data-rel="chosen"],[rel="chosen"]').chosen({search_contains: true});												
														}
														else
														{
															$("#menuitemsubtype").html(data);
                              $('#menuitemsubtype').css("display","block");
														}
														
													}      
										    });
									 }		
      }
			
		function get_brands()
		{
			
								var cat_id = $('#menuitemsub_typeid').val();										
								 
										$.ajax({
												url: '<?php echo Yii::app()->baseUrl;?>/index.php/cmsAdmin/AdminMenu/menuitembrands', 
												type: "POST",
												data:{cat_id:cat_id},
												success: function(data){
                          //alert("data==>"+data);
													  if (data != 'No Data Found') {
																$("#itembrands").html(data);
																$('#itembrands').css("display","block");
																$('[data-rel="chosen"],[rel="chosen"]').chosen({search_contains: true});												
														}
														else
														{
															$("#itembrands").html(data);
                              $('#itembrands').css("display","block");
														}
														
													}      
										    });
			
		}
		
	function save_menuitem()
	{
			
			$.ajax({
      type: "POST",
      url:    "<?php echo $this->createUrl('cmsAdmin/AdminMenu/savemenuitem'); ?>",     
      success: function(data){
							$('#savemenuitem').submit();
          }      
    });		
	}
	
		
//		
//	function addcategory()
//  {
//    $.ajax({
//      type: "POST",
//      url:    "<?php echo $this->createUrl('cmsAdmin/category/addcategory'); ?>",     
//      success: function(data){
//           $("#addcategory-modal").html(data);
//          }      
//    });
//  }
//	
//	 function addbrand()
//  {
//    $.ajax({
//      type: "POST",
//      url:    "<?php echo $this->createUrl('cmsAdmin/category/addbrand'); ?>",     
//      success: function(data){
//           $("#addcategory-modal").html(data);
//          }      
//    });
//  }
//  
//  
//  function addmodifier()
//  {
//    $.ajax({
//      type: "POST",
//      url:    "<?php echo $this->createUrl('cmsAdmin/category/addmodifier'); ?>",     
//      success: function(data){
//           $("#addmodifier-modal").html(data);
//          }      
//    });
//  }
//	
	
</script>    						
						