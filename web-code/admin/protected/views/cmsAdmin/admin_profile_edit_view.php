<div>
<form action="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/admin/saveadminuser" method="post" id="saveadminuser">
                              <div class="form-group">
                                <label>Name</label>
                                <input type="text" name="admin_name" id="admin_name" value="<?php if(isset($admin_info->admin_name)) { echo $admin_info->admin_name; }?>" class="form-control" onkeypress="remove_error_class('admin_name')"; onfocus ="remove_error_class('admin_name')"; />
                              </div>
                            
                              <div class="form-group">
                                <label>Username</label>
                                <input type="text" name="admin_username" id="admin_username" value="<?php if(isset($admin_info->admin_username)) { echo $admin_info->admin_username; }?>" class="form-control" onkeypress="remove_error_class('admin_username')"; onfocus ="remove_error_class('admin_username')"; />
                              </div>
                              
                              <div class="form-group">
                              <label>Email</label>
                                <input name="email_id" id="email_id" class="form-control" value="<?php if(isset($admin_info->email_id)) { echo $admin_info->email_id; }?>" />
                              </div>
                             
                             <div class="form-group">
                              <label><?php if(!empty($admin_info)) echo "New";?> Password</label>
                                <input name="new_password" id="new_password" type="password" class="form-control" value="" onkeypress="remove_error_class('new_password')"; onfocus ="remove_error_class('new_password')"; />
                                
                                <input name="old_password" id="old_password" type="hidden" value="<?php if(isset($admin_info->password)) { echo $admin_info->password; }?>" />
                                       
                              </div>
                             
                             <div class="form-group">
                              <label>Confirm Password</label>
                                <input name="confirm_password" id="confirm_password" type="password" class="form-control" value="" onkeypress="remove_error_class('confirm_password')"; onfocus ="remove_error_class('confirm_password')"; />
                             </div>
                             
                            <div class="form-group">
                               <label for="exampleInputPassword1">Profile Pic</label>         
                                <?php
                                      $img_abs_path = Yii::app()->request->baseUrl.'/uploads/default.png';				
                                    if($admin_info->profile_pic != '')
                                    {
                                        $img_abs_path = Yii::app()->request->baseUrl.'/uploads/'.$admin_info->profile_pic;
                                      } 
                                  ?>
                                    <img src="<?php echo $img_abs_path; ?>" alt="User Image" width="50" height="50" />
                                     <input type="file" name="profile_image">
                            </div>
                               
                                
                              <div class="form-group">
                               <label>Status</label>
                                <select name="status" id="status" class="form-control">
                                    <option value="">Select</option>
                                    <option value="active" <?php if(isset($admin_info->admin_status) && ($admin_info->admin_status == 'active')){ echo "selected='selected'"; } ?>>Active</option>
                                    <option value="inactive" <?php if(isset($admin_info->admin_status) && ($admin_info->admin_status == 'inactive')){ echo "selected='selected'"; } ?>>Inactive</option>
                                </select>
                            </div> 
                            
                              <div style="text-align: center;">
                              <input type="hidden" name="saveadminuser_submit" value="1" />
                              <input type="hidden" name="admin_type" value="admin" />
                             
                              <input type="hidden" id="admin_id" name="admin_id" value="<?php if(isset($admin_info->admin_id)) echo $admin_info->admin_id?>" />
                            <button type="submit" onclick="save_adminuser();return false;" class="btn bg-navy btn-flat margin pull-center"><i class="fa  fa-save"></i> Save Profile</button>
                            
                        </div>
                         <?php if(isset($admin_info->admin_id)) $url = "CheckEmailExists"; else $url = "CheckDuplicateEmail"  ?>
               
                    <div id="submitemail" data-url="<?php echo Yii::app()->createUrl('/cmsAdmin/admin/'.$url); ?>"></div>       <?php if(isset($admin_info->admin_id)) $url = "CheckUsernameExists"; else $url = "CheckDuplicateUsername"  ?>
                          <div id="submitusername" data-url="<?php echo Yii::app()->createUrl('/cmsAdmin/admin/'.$url); ?>"></div>
                       
                        </form>
</div>                        