 <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><i class="fa <?php if(!empty($admin_info)) echo "fa-edit"; else echo "fa-plus-square-o"; ?>"></i><?php if(!empty($admin_info)) echo " Edit"; else echo " Add New"?> Admin User</h4>
                    </div>
                    
                    <form action="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/admin/saveadminuser" method="post" id="saveadminuser" enctype="multipart/form-data">
                        <div class="modal-body">                        
                             <!-- left column -->
                              <div class="col-md-12 col-sm-12">
                             
                             <div class="form-group col-md-6 col-sm-6 adminuserProfilePic">
                               <label for="exampleInputPassword1">Profile Pic</label>
                               <?php
                                   $img_abs_path = Yii::app()->request->baseUrl.'/uploads/default.png';	
                                  if(!empty($admin_info))
                                  {
                                    if($admin_info->profile_pic != '')
                                    {
                                        $img_abs_path = Yii::app()->request->baseUrl.'/uploads/'.$admin_info->profile_pic;
                                    }
								  }
                                    ?>
                                    <img src="<?php echo $img_abs_path; ?>" alt="User Image" />
                                    <input name="old_profile_pic" id="old_profile_pic" type="hidden" value="<?php if(isset($admin_info->profile_pic)) { echo $admin_info->profile_pic; }?>" />
                                       
                                <div class="browseImage text-center">
                                	<button class="btn btn-primary">Change Photo</button>	
                                    <input type="file" name="profile_image">
                                </div>    
                             </div>
                             
                             <div class="form-group col-md-6 col-sm-6 errorMargin">
                                <label>Name</label>
                                <input type="text" name="admin_name" id="admin_name" value="<?php if(isset($admin_info->admin_name)) { echo $admin_info->admin_name; }?>" class="form-control" onkeypress="remove_error_class('admin_name')"; onfocus ="remove_error_class('admin_name')"; />
                              </div>
                            
                             <div class="form-group col-md-6 col-sm-6 errorMargin">
                                <label>Username</label>
                                <input type="text" name="admin_username" id="admin_username" value="<?php if(isset($admin_info->admin_username)) { echo $admin_info->admin_username; }?>" class="form-control" onkeypress="remove_error_class('admin_username')"; onfocus ="remove_error_class('admin_username')"; />
                              </div>
                             
                              <div class="form-group col-md-6 col-sm-6 errorMargin">
                              <label>Email</label>
                                <input name="email_id" id="email_id" class="form-control" value="<?php if(isset($admin_info->email_id)) { echo $admin_info->email_id; }?>" />
                              </div>
                           
                              <?php if($usertype == 'admin'){ ?>
                              <div class="form-group col-md-6 col-sm-6 errorMargin">
                              <label> Old Password</label>
                                <input name="previous_password" id="previous_password" type="password" class="form-control" value="" onkeypress="remove_error_class('previous_password')"; onfocus ="remove_error_class('previous_password')"; />
                              </div>
                              
                              <div id="chkduplicatepassword" data-url="<?php echo Yii::app()->createUrl('/cmsAdmin/admin/checkPasswordExists'); ?>"></div>
                              
                              <?php } ?>
                             <div class="form-group col-md-6 col-sm-6 errorMargin">
                              <label><?php if(!empty($admin_info)) echo "New";?> Password</label>
                                <input name="new_password" id="new_password" type="password" class="form-control" value="" onkeypress="remove_error_class('new_password')"; onfocus ="remove_error_class('new_password')"; />
                                
                                <input name="old_password" id="old_password" type="hidden" value="<?php if(isset($admin_info->password)) { echo $admin_info->password; }?>" />
                                       
                              </div>
                             
                             <div class="form-group col-md-6 col-sm-6 errorMargin">
                              <label>Confirm Password</label>
                                <input name="confirm_password" id="confirm_password" type="password" class="form-control" value="" onkeypress="remove_error_class('confirm_password')"; onfocus ="remove_error_class('confirm_password')"; />
                             </div>
                             
                             
                             
                              <div class="form-group <?php if(isset($admin_info->admin_id)) { echo "col-md-6 col-sm-6";}else { echo "col-md-12 col-sm-12";}?>">
                               <label>Status</label>
                                <select name="status" id="status" class="form-control">
                                    <option value="">Select</option>
                                    <option value="active" <?php if(isset($admin_info->admin_status) && ($admin_info->admin_status == 'active')){ echo "selected='selected'"; } ?>>Active</option>
                                    <option value="inactive" <?php if(isset($admin_info->admin_status) && ($admin_info->admin_status == 'inactive')){ echo "selected='selected'"; } ?>>Inactive</option>
                                </select>
                            </div> 
                              
                        </div>
                                               
                        <div style="text-align: center;">
                              <input type="hidden" name="saveadminuser_submit" value="1" />
                                <input type="hidden" name="admin_type" value="<?php echo $usertype?>" />
                              <input type="hidden" id="admin_id" name="admin_id" value="<?php if(isset($admin_info->admin_id)) echo $admin_info->admin_id?>" />
                            <button type="submit" onclick="save_adminuser();return false;" class="btn bg-navy margin pull-center"><i class="fa  fa-save"></i> Submit</button>
                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>               
                        </div>
                         <?php if(isset($admin_info->admin_id)) $url = "CheckEmailExists"; else $url = "CheckDuplicateEmail"  ?>
                          <div id="submitemail" data-url="<?php echo Yii::app()->createUrl('/cmsAdmin/admin/'.$url); ?>"></div>
                <?php if(isset($admin_info->admin_id)) $url = "CheckUsernameExists"; else $url = "CheckDuplicateUsername"  ?>
                          <div id="submitusername" data-url="<?php echo Yii::app()->createUrl('/cmsAdmin/admin/'.$url); ?>"></div>
                        
                    </form>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->