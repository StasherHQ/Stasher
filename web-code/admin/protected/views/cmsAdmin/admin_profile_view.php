<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        Profile
        <small>Users Account Information</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/dashboard"><i class="fa fa-dashboard"></i>Dashboard</a></li>
        <li class="active"> Profile </li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
 <div class="adminProfileContainer">
  <div class="box box-primary col-md-12 col-sm-12 adminProfile">
    
  <!-- Left side content end -->
    
        <!-- Right side content start -->
    
          <div class="">
                    <h4><?php if(Yii::app()->user->hasFlash('user')): ?>

                    <div class="flash-success">
                            <?php echo Yii::app()->user->getFlash('user'); ?>
                    </div>
                    <?php endif; ?></h4>
                    
              <div id="adminuserprofile">                        
                         <dl class="dl-horizontal col-md-12 col-sm-12 adminuserProfilePic text-center">
                            <!--<dt>Profile Pic</dt>-->
                            <div><?php
                                  $img_abs_path = Yii::app()->request->baseUrl.'/uploads/default.png';				
                                  if($admin_info->profile_pic != '')
                                  {
                                    $img_abs_path = Yii::app()->request->baseUrl.'/uploads/'.$admin_info->profile_pic;
                                  } 
                                  ?>
                              <img src="<?php echo $img_abs_path; ?>" alt="User Image" /></div>
                         </dl>
                         <dl class="dl-horizontal col-md-12 col-sm-12">                           
                           <div class="col-md-6 col-sm-6 adminLabels text-right">Name</div>
                             <div class="col-md-6 col-sm-6 adminData"> <?php if(isset($admin_info->admin_name)) { echo $admin_info->admin_name; } ?></div>
                         </dl>
                         
                         <dl class="dl-horizontal col-md-12 col-sm-12">
                           <div class="col-md-6 col-sm-6 adminLabels text-right">Username</div>
                             <div class="col-md-6 col-sm-6 adminData"> <?php if(isset($admin_info->admin_username)) { echo $admin_info->admin_username; } ?></div>
                         </dl>
                         
                         <dl class="dl-horizontal col-md-12 col-sm-12">
                           <div class="col-md-6 col-sm-6 adminLabels text-right"> Email</div>
                            <div class="col-md-6 col-sm-6 adminData"><?php if(isset($admin_info->email_id)) { echo $admin_info->email_id; }?></div> 
                         </dl>
                         
                         
                         <dl class="dl-horizontal col-md-12 col-sm-12">
                            <div class="col-md-6 col-sm-6 adminLabels text-right">Status </div>
                            <div class="col-md-6 col-sm-6 adminData"><?php if(isset($admin_info->admin_status)){ echo ucfirst($admin_info->admin_status); } ?></div>
                         </dl>                         
                      </div>
                      
                       <?php   //Super admin can view other admins profile | admin can view only there profile
						//if super admin then show tabs
							if($admin_info->admin_type == 'super_admin' && Yii::app()->session['admin_type'] == 'super_admin')
							{
							?>
							 <!-- Left side content start -->
						  <div class="">
							  <div class="col-md-4 col-sm-4">
                              		<a href="javascript:;" data-toggle="modal" data-target="#admin-modal" onclick="edit_adminUser(<?php echo $admin_info->admin_id?>,'admin')" class="btn btn-block btn-primary"><i class="fa fa-save"></i> Edit Profile</a>
                              </div>
                              <div class="col-md-4 col-sm-4">
								  <a class="btn btn-block btn-primary" data-toggle="modal" data-target="#admin-modal" onclick="addadminuser()"><i class="fa fa-pencil"></i> Add New User</a>        
							  </div>
							   
							   <div class="col-md-4 col-sm-4">
								  <a class="btn btn-block btn-primary" href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/admin/viewadminuserlist"><i class="fa fa-pencil"></i> View Users List</a>       
							  </div>           
						  </div>
						  <?php } ?> 
                      
                        </div>      
   <!-- Right side content end -->
 </div>
 </div>
</section>
<!-- Edit Admin profile Popup -->
<div class="modal fade" id="admin-modal" tabindex="-1" role="dialog" aria-hidden="true">           
</div><!-- /.modal -->
 
 <script>
  
    function addadminuser()
    {
      $.ajax({
      type: "POST",
      url:    "<?php echo $this->createUrl('cmsAdmin/admin/addadminuser'); ?>",     
      success: function(data){
           $("#admin-modal").html(data);
          }      
    });
    }
    
    function edit_adminUser(admin_id,usertype)
    {
      $.ajax({
      type: "POST",
      data :{admin_id:admin_id,
              usertype:usertype}, 
      url:    "<?php echo $this->createUrl('cmsAdmin/admin/editadminuser'); ?>",     
      success: function(data){
           $("#admin-modal").html(data);
          }      
    });    
  }
  
  
 </script>