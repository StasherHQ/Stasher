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
 <div class="col-md-12 col-sm-12 box box-primary adminUserListView">
  
   
         <!-- Left side content start -->
      <div class="col-md-3 col-sm-12 adminUserListBtns">
      <div class="row">
          <div class="adminAddNewUser col-md-12 col-sm-6">
              <a class="btn btn-block btn-primary" data-toggle="modal" data-target="#admin-modal" onclick="addadminuser()"><i class="fa fa-pencil"></i> Add New Admin User</a>        
          </div>
          
           <div class="adminAddNewUser col-md-12 col-sm-6">
              <a class="btn btn-block btn-primary" href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/admin/viewadminuserlist"><i class="fa fa-pencil"></i> View Admin Users List</a>       
          </div>
           </div>
      </div>
  <!-- Left side content end -->
      
        <!-- Right side content start -->
  <div class="col-md-9 col-sm-12">      
        <div class="row">
        <div class="box-body table-responsive">
          <h4><?php if(Yii::app()->user->hasFlash('adminuser')): ?>

                    <div class="flash-success">
                            <?php echo Yii::app()->user->getFlash('adminuser'); ?>
                    </div>
                    <?php endif; ?></h4>
          
            <table id="adminusers" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th class="col-md-1 col-sm-1 text-center">No.</th>
                                                <th class="col-md-2 col-sm-2">Name</th>
                                                <th class="col-md-3 col-sm-3">Email</th>
                                                <th class="col-md-1 col-sm-1 text-center">Profile Pic</th>
                                                 <th class="col-md-1 col-sm-1 text-center">Admin Type</th>
                                                <th class="col-md-1 col-sm-1 text-center">Status</th>
                                                <th class="col-md-2 col-sm-2"></th>                                                
                                            </tr>
                                        </thead>
                                        <tbody>
                                            
        <?php
            if(!empty($admin_users))
            {
                $i = 0;
                foreach($admin_users as $user)    
                {
                    $i++;
        ?>    
                    <tr>
                                                <td class="col-md-1 col-sm-1 text-center"><b><?php echo $i; ?></b></td>
                                                <td class="col-md-2 col-sm-2"><?php echo $user->admin_name?></td>
                                                <td class="col-md-3 col-sm-3"><?php echo $user->email_id?></td>
                                                <td class="col-md-1 col-sm-1 adminProfileImage text-center"><?php
                                                      $img_abs_path = Yii::app()->request->baseUrl.'/uploads/default.png';				
                                                      if($user->profile_pic != '')
                                                      {
                                                        $img_abs_path = Yii::app()->request->baseUrl.'/uploads/'.$user->profile_pic;
                                                      } 
                                                    ?>
                                                        <img src="<?php echo $img_abs_path; ?>" alt="User Image" />
                                                </td>
                                                <td class="col-md-1 col-sm-1 text-center"><?php echo ucfirst($user->admin_type);?></td>
                                              	<td class="col-md-1 col-sm-1 text-center"><?php echo ucfirst($user->admin_status);?></td>
                                                <td class="col-md-2 col-sm-2 adminUserViewEditClose">
                                                <div class="pull-left editCloseBtn editCorrectBtn">
                                                	 <a href="javascript:;" data-toggle="modal" data-target="#admin-modal" onclick="edit_adminUser(<?php echo $user->admin_id?>,'superadmin')" class="btn btn-small"><i class="fa fa-edit"></i></a>
												</div>
                                                 <div class="pull-left closeBtn editCloseBtn">
                                                  <form name="frmAction" method="post" action="<?php echo Yii::app()->createAbsoluteUrl('/cmsAdmin/admin/deleteAdminUser', array('admin_id' => $user->admin_id)); ?>" id="frmAction">
                                                 <input type="submit" class="btn btn-small" onclick="return confirm('Are you sure want to delete this admin user?');" value="X"></input>
                                                 </form>
                                                 </div>
                                                </td>
                                            </tr>
                                          <?php } ?>
                                           <script type="text/javascript">
                                                $(function() {
                                                    
                                                    $('#adminusers').dataTable({
                                                        "bPaginate": true,
                                                        "bLengthChange": false,
                                                        "bFilter": false,
                                                        "bSort": true,
                                                        "bInfo": true,
                                                        "bAutoWidth": false,
																												"iDisplayLength" : 50
                                                    });
                                                });
                                            </script>
                                            <?php }
                                                else{
                                            ?>
                                            <tr class="center">
                                              <td class="center" colspan="7"><b> No Records Found. </b></td>
                                            </tr>
                                            <?
                                              }
                                              ?>
                                    </table>
</div> 
</div>      
 </div>   <!-- Right side content end -->
 
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