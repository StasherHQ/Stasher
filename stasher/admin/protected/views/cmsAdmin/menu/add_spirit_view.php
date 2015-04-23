 <div class="modal-dialog addSpiritModel">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title text-center"><i class="fa <?php if(!empty($categorydet)) echo "fa-edit"; else echo "fa-plus-square-o"; ?>"></i> Add a New spirit</h4>
                        <!--<select class="form-control">
                        	<option>Spirit</option>
                            <option>2</option>
                            <option>3</option>
                        </select>-->
                    </div>
                    
                    <form action="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/AdminMenu/savespirit" method="post" id="savespirit">
                        <div class="modal-body">                        
                             <!-- left column -->
                        <div class="col-md-12 col-sm-12">
                             <div class="row">
                                   <div class="row"> 
                                      <div class="form-group col-md-6 col-sm-6 modelType">
                                          <div class=" table-bordered spiritNameModel">
                                            <h5>Name (if applicable)</h5>
                                            <input type="text" class="form-control" name="category_name" id="catname" value="" />
                                          </div>   
                                      </div>
                                      <div class="col-md-6 col-sm-6 form-group modelBrand">
                                          <div class="table-bordered modelBasePrice">
                                            <h5>Base Price <i class="fa fa-question-circle"></i></h5>
                                            <input type="text" class="form-control" />
                                          </div>   
                                     </div>
                                  </div>   
                            <div class="row">
                              <div class="form-group col-md-6 col-sm-6 modelType">
                              	<div class="col-md-12 col-sm-12 table-bordered"> 
	    							                <div class="col-md-7 col-sm-7 spiritType">
                                         <h5>Type of spirit</h5>
    	                                 <input type="text" class="form-control" name="category_name" id="catname" value="" />
                                    </div>     
                                 	<div class="col-md-5 col-sm-5 notFoundBtn">	
                                    	<div class="row">      
                                            <span class="text-right">not found
                                                <i class="fa fa-question-circle"></i>                                        
                                            </span>                                           
                                 			<button class="btn btn-primary btn-flat pull-right requestthirstBtn">Request Thirst</button>
                                          </div>    
                                    </div>   
                              	</div>
                              </div>
                             
                              <div class="form-group col-md-6 col-sm-6 modelBrand">
                               <div class="col-md-12 col-sm-12 table-bordered"> 	 
                                    <div class="col-md-7 col-sm-7 spiritType">
                                         <h5>Select Brand</h5>
                                         <input type="text" class="form-control" name="category_name" id="catname" value="" />
                                    </div>
                                    <div class="col-md-5 col-sm-5 notFoundBtn">	
                                    	<div class="row">     
                                             <span class="text-right">not found
                                             	<i class="fa fa-question-circle"></i>
                                             </span>
                                             <button class="btn btn-primary btn-flat pull-right requestthirstBtn">Request Thirst</button>
                                     </div>    
                                    </div>         
                               </div>  
                            </div> 
                          </div>  
                          
                          <div class="row">  
                            <div class="form-group col-md-4 col-sm-4 modelType">
                            
                            <div class="col-md-12 col-sm-12 form-group table-bordered applicableModifiers">	
                                <h5>Choose Applicable Modifiers</h5>
                                  <div class="col-md-12 col-sm-12">
                                    <div class="row">	
                                        <input type="checkbox" />
                                    	<label>Size</label>
                                    </div>    
                                  </div>  
                                  <div class="col-md-12 col-sm-12">
                                  	<div class="row">
                                        <input type="checkbox" />
                                        <label>Taste</label>
                                    </div>    
                                  </div>
                                  <div class="col-md-12 col-sm-12">  
                                    <div class="row">    
                                        <input type="checkbox" />
                                        <label>Ice</label>
                                    </div>    
                                  </div>
                                  <div class="col-md-12 col-sm-12">  
                                     <div class="row">   
                                        <input type="checkbox" />
                                        <label>Salt</label>
                                     </div>   
                                  </div>
                                  <div class="col-md-12 col-sm-12">  
                                      <div class="row">  
                                        <input type="checkbox" />
                                        <label>Modifier 5</label>
                                     </div>   
                                  </div>
                                  <div class="col-md-12 col-sm-12">  
                                     <div class="row">   
                                        <input type="checkbox" />
                                        <label>Extra</label>
                                     </div>   
                                  </div>  
                             </div>                                                                                                                     
                            </div>
                            
                            <div class="form-group col-md-8 col-sm-8 modelBrand">
                            
                            
                            <table class="table table-bordered table-striped" id="">
                              <thead>
                                  <tr>
                                    <!-- If any column added here.. Remember to add it to thefooter also and  $colspan variable -->
                                      <th class="col-md-2 col-sm-2 text-center">Modifier</th>                                      
                                      <th class="col-md-3 col-sm-3 text-center">Option</th>
                                      <th class="col-md-4 col-sm-4 text-center">Name</th>
                                      <th class="col-md-3 col-sm-3 text-center">Add'Cost</th>                                       
                                  </tr>
                              </thead>
                              <tbody>                                                               
                                  
                                <tr>                     
                                  <td class="col-md-2 col-sm-2 text-center">                                    
                                  	Size
                                  </td>
                                  <td class="col-md-3 col-sm-3 text-center">
                                  	<input type="checkbox" />
                                  </td>
                                  <td class="col-md-4 col-sm-4 text-center">
                                  	Single
                                  </td>
                                  <td class="col-md-3 col-sm-3 text-center">
                                  	<input type="text" class="form-control" value="$20.00"/>
                                  </td>                                    
                                </tr>  
                                
                                <tr>                     
                                  <td class="col-md-2 col-sm-2 text-center">                                    
                                  </td>
                                  <td class="col-md-3 col-sm-3 text-center">
                                  	<input type="checkbox" />
                                  </td>
                                  <td class="col-md-4 col-sm-4 text-center">
                                  	Single
                                  </td>
                                  <td class="col-md-3 col-sm-3 text-center">
                                  	<input type="text" class="form-control" value="$20.00"/>
                                  </td>                                    
                                </tr>                           
                                  
                                <tr>                     
                                  <td class="col-md-2 col-sm-2 text-center">                                    
                                  	Size
                                  </td>
                                  <td class="col-md-3 col-sm-3 text-center">
                                  	<input type="checkbox" />
                                  </td>
                                  <td class="col-md-4 col-sm-4 text-center">
                                  	Single
                                  </td>
                                  <td class="col-md-3 col-sm-3 text-center">
                                  	<input type="text" class="form-control" value="$20.00"/>
                                  </td>                                    
                                </tr>  
                                
                                <tr>                     
                                  <td class="col-md-2 col-sm-2 text-center">                                    
                                  </td>
                                  <td class="col-md-3 col-sm-3 text-center">
                                  	<input type="checkbox" />
                                  </td>
                                  <td class="col-md-4 col-sm-4 text-center">
                                  	Single
                                  </td>
                                  <td class="col-md-3 col-sm-3 text-center">
                                  	<input type="text" class="form-control" value="$20.00"/>
                                  </td>                                    
                                </tr>
                       
                              </tbody>
                             
                          </table>
                            
                            
                            </div>
                          </div>  
                           </div>   
                        </div>
                                               
                        <div style="text-align: center;">
                              <input type="hidden" name="savecategory_submit" value="1" />
                              <input type="hidden" id="category_id" name="category_id" value="" />
                            <button type="submit" class="btn btn-flat btn-danger margin pull-center"><i class="fa  fa-save"></i> Save And Close</button>
                            <button type="submit" class="btn btn-flat btn-primary margin pull-center"><i class="fa  fa-save"></i> Add Another</button>
                            <button type="submit" class="btn btn-flat btn-primary margin pull-center"><i class="fa fa-fast-forward"></i> Add Cross-cell Items </button>
                        </div>
                        </div>
                        
                    </form>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->