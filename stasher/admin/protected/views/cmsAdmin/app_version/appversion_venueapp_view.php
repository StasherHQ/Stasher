<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        App Version Venue App        
    </h1>
    <ol class="breadcrumb">
        <li><a href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/dashboard">Dashboard</a></li>
        <li class="active"><span>Users</span></li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
 <div class="box box-primary">
    <div class="" >
      <div class="nav-tabs-custom">
          <ul class="nav nav-tabs">
             <li class="active"><a href="#tab_all" data-toggle="tab">All</a></li>
             <li><a href="#tab_active" data-toggle="tab">Active</a></li>           
          </ul>
          <div class="tab-content">
           
            <div class="tab-pane active" id="tab_all">             
              <div class="">
                <div class="box-header">
                    <h3 class="box-title">App Version</h3>
                     <h4><?php if(Yii::app()->user->hasFlash('user')): ?>

                    <div class="flash-success" style="text-align: center;color: green;">
                            <?php echo Yii::app()->user->getFlash('user'); ?>
                    </div>
                    <?php endif; ?></h4>
                     
                </div>
                   
                    
                    
                    <div class="">
							<table id="" class="table table-bordered table-striped table-responsive">
                                <thead>
                                    <tr>
                                        <th class="col-md-2 col-sm-2 text-center">Menu App Version Id</th>
                                        <th class="col-md-5 col-sm-4">Version</th>
                                        <th class="col-md-2 col-sm-2">Release Date</th>
                                        <th class="col-md-1 col-sm-1 text-center">Device Type</th>
                                        <th class="col-md-1 col-sm-1 text-center">Status</th>
                                        <th class="col-md-1 col-sm-2 text-center"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                     
                                    <tr>
                                        <td class="col-md-2 col-sm-2 text-center">1</td>
                                        <td class="col-md-5 col-sm-4">
                                        	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been
                                        </td>
                                        <td class="col-md-2 col-sm-2">
                                        	20-Nov-2014
                                        </td>
                                        <td class="col-md-1 col-sm-1 text-center">
                                        	<input type="radio" />
                                        </td>
                                        <td class="col-md-1 col-sm-1 text-center">
                                        	<span class="expCircle appVersionCircle"></span>                                           
                                        </td>
                                        <td class="col-md-1 col-sm-1 text-center">
                                        	<a class="btn btn-block btn-primary" data-toggle="modal" data-target="#editversion-modal" onclick="editversion()">
                                                <i class="fa fa-edit"></i>
                                               	Edit
                                            </a>
                                        </td>
                                    </tr>
                                    
                                    
                                    <tr>
                                        <td class="col-md-2 col-sm-2 text-center">1</td>
                                        <td class="col-md-5 col-sm-4">
                                        	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been
                                        </td>
                                        <td class="col-md-2 col-sm-2">
                                        	20-Nov-2014
                                        </td>
                                        <td class="col-md-1 col-sm-1 text-center">
                                        	<input type="radio" />
                                        </td>
                                        <td class="col-md-1 col-sm-1 text-center">                                        	
                                            <span class="activeCircle appVersionCircle"></span>
                                        </td>
                                        <td class="col-md-1 col-sm-1 text-center">
                                        	<a class="btn btn-block btn-primary" data-toggle="modal" data-target="#editversion-modal" onclick="editversion()">
                                                <i class="fa fa-edit"></i>
                                               	Edit
                                            </a>
                                        </td>
                                    </tr>
                                    
                                    
                                    <tr>
                                        <td class="col-md-2 col-sm-2 text-center">1</td>
                                        <td class="col-md-5 col-sm-4">
                                        	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been
                                        </td>
                                        <td class="col-md-2 col-sm-2">
                                        	20-Nov-2014
                                        </td>
                                        <td class="col-md-1 col-sm-1 text-center">
                                        	<input type="radio" />
                                        </td>
                                        <td class="col-md-1 col-sm-1 text-center">                                        	
                                            <span class="stopCircle appVersionCircle"></span>
                                        </td>
                                        <td class="col-md-1 col-sm-1 text-center">
                                        	<a class="btn btn-block btn-primary" data-toggle="modal" data-target="#editversion-modal" onclick="editversion()">
                                                <i class="fa fa-edit"></i>
                                               	Edit
                                            </a>
                                        </td>
                                    </tr>
                                    
                                    
                                    <tr>
                                        <td class="col-md-2 col-sm-2 text-center">1</td>
                                        <td class="col-md-5 col-sm-4">
                                        	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been
                                        </td>
                                        <td class="col-md-2 col-sm-2">
                                        	20-Nov-2014
                                        </td>
                                        <td class="col-md-1 col-sm-1 text-center">
                                        	<input type="radio" />
                                        </td>
                                        <td class="col-md-1 col-sm-1 text-center">
                                        	<span class="expCircle appVersionCircle"></span>                                           
                                        </td>
                                        <td class="col-md-1 col-sm-1 text-center">
                                        	<a class="btn btn-block btn-primary" data-toggle="modal" data-target="#editversion-modal" onclick="editversion()">
                                                <i class="fa fa-edit"></i>
                                               	Edit
                                            </a>
                                        </td>
                                    </tr>
                                  
                                    <tr class="center">
                                      <td class="center"  colspan="6"><b> No Records Found. </b></td>
                                    </tr>                                  
                            </table>
					</div>  
                    
                                                      
           
                    
                    
                    
                    
                    
              </div>        
            </div>
            
            <div class="tab-pane " id="tab_active">
              <div class="">
                <div class="box-header">
                    <h3 class="box-title">Active User List</h3>
                </div>
                   Active User List
              </div>
            </div>
            
           
          
          </div>
      </div>
    </div>

  
  <!-- Edit Version -->
        <div class="modal fade" id="editversion-modal" tabindex="-1" role="dialog" aria-hidden="true">           
        	<div class="modal-dialog editVersionModal">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Edit</h4>
                    </div>
                    
                    <form action="" method="post" id="">
                        <div class="modal-body">                        
                             <!-- left column -->
                        <div class="">
                    	<div class="form-group col-md-12 col-sm-12">
                            <label>Version</label>
                            <input type="text" class="form-control" />
                        </div>
                        
                        <div class="form-group col-md-12 col-sm-12">
                            <label>Release Date</label>
                            <div class="input-group">
                                <div class="input-group-addon">
                                    <i class="fa fa-calendar"></i>
                                </div>
                                <input type="text" class="form-control pull-right" id="reservation"/>
                            </div><!-- /.input group -->
                        </div>                  
                        
                        <div class="form-group col-md-12 col-sm-12">
                           <div class="row"> 
                            <label class="col-md-3 col-sm-3">Device Type</label>
                            <div class="radio col-md-2 col-sm-2">
                                <label>
                                    <input type="radio" name="" id="" value="iOS" checked>
                                    iOS
                                </label>
                            </div>
                            <div class="radio col-md-2 col-sm-2">
                                <label>
                                    <input type="radio" name="" id="" value="android" checked>
                                    android
                                </label>
                            </div>
                          </div>                              
                        </div> 
                        
                        <div class="form-group col-md-12 col-sm-12">
                           <div class="row">
                            <label class="col-md-3 col-sm-3">Status</label>
                            
                            <div class="radio col-md-2 col-sm-2">
                                <label>
                                    <input type="radio" name="" id="" value="Active" checked>
                                    Active
                                </label>
                            </div> 
                            <div class="radio col-md-2 col-sm-2">
                                <label>
                                    <input type="radio" name="" id="" value="Expire" checked>
                                    Expire
                                </label>
                            </div> 
                            <div class="radio col-md-2 col-sm-2">
                                <label>
                                    <input type="radio" name="" id="" value="Stop" checked>
                                    Stop
                                </label>
                            </div>                             
                       	  </div>	
                        </div> 	                                      
                    </div>
                                               
                        <div class="text-center">
                              <input type="hidden" name="savecategory_submit" value="1" />
                              <input type="hidden" id="category_id" name="category_id" value="<?php if(isset($categorydet->category_id)) echo $categorydet->category_id?>" />
                            <button type="submit" onclick="save_category();return false;" class="btn bg-navy margin pull-center"><i class="fa  fa-save"></i> Submit</button>
                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
                        </div>
                        
                        <?php if(isset($categorydet->category_id)) $url = "CheckCategoryNameExists"; else $url = "CheckDuplicateCategoryName"  ?>
                        
                        <div id="submitcat" data-url="<?php echo Yii::app()->createUrl('/cmsAdmin/category/'.$url); ?>"></div>
                        
                    </form>
                </div>
            </div>
        
        
        </div>
  
   
 </div>
</section>

 <!-- DATA TABES SCRIPT -->
        <script src="<?php echo Yii::app()->request->baseUrl; ?>/js/plugins/datatables/jquery.dataTables.js" type="text/javascript"></script>
        <script src="<?php echo Yii::app()->request->baseUrl; ?>/js/plugins/datatables/dataTables.bootstrap.js" type="text/javascript"></script>
        
        <script type="text/javascript">		
			
			 $(function() {
				$('#reservation').daterangepicker();	 
			 });
			 
			  
		</script>
