<div class="table-responsive userListView">
  <table id="<?php echo $tableId?>" class="table table-bordered table-striped">
      <thead>
          <tr>
            <!-- If any column added here.. Remember to add it to thefooter also-->
              <th class="text-center">No.</th>
              <th class="text-center">User Id</th>
              <th class="">Full Name</th>
              <th class="">Email</th>
			  <th class="text-center">Profile Image</th>
           <th class="text-center">Role</th>
              <th class="text-center">Total Wallet Amount </th>
              <th class="text-center">Status</th>
							
							
              <th class=""></th>
          </tr>
      </thead>
      <tbody>
        <?php
        $colspan = 10;
        if(!empty($user_list))
        {
         $i = 1;
         foreach($user_list as $user)
         {
          ?>
          <tr>
            <td class="text-center"><?php echo $i; $i++; ?></td>
            <td class="text-center"><?php echo $user->userId;?></td>
            <td class="">
             <a href="<?php echo Yii::app()->createAbsoluteUrl('/cmsAdmin/user/viewuser', array('id' => $user->userId)); ?>">
                    <?php echo  $user->fname.' '.$user->lname;?>
             </a>
             
            </td>
            <td class=""><?php echo $user->email;?></td>
						<td class="text-center"><?php
                                    $img_abs_path = Yii::app()->request->baseUrl.'/uploads/default.png';				
                                    if($user->avatar != '')
                                    {
                                      $img_abs_path = Yii::app()->request->baseUrl.'/uploads/'.$user->avatar;
                                    } 
                                  ?>
                                  <img src="<?php echo $img_abs_path; ?>" class="img-circle" alt="User Image" width="50" height="50" />  </td>
            <td class="text-center">
              <i class="fa fa-dollar"></i><?php if($user->usertype == '4') { echo "Commander"; }else if($user->usertype == '3') { echo 'Secret Agent';} ?>
            </td>
            <td class="text-center">
              <i class="fa fa-dollar"></i>90
            </td>
            <td class="changestatus_<?php echo $user->userId; ?> text-center">
                  <a class="btn btn-small <?php if($user->status == '2') { echo "btn-primary"; }else if($user->status == '1') {  echo "btn-danger"; } ?>" href="javascript:;" onclick="change_status(<?php echo $user->userId ?>,'<?php echo $user->status?>');">
                    <?php  echo ucfirst($user->status);  ?>
                  </a>
           </td>
		 
            <td class="text-center">
                <a href="javascript:;" data-toggle="modal" data-target="#edituser-modal" onclick="view_user(<?php echo $user->userId?>)" class="btn btn-small btn-success">View</a>
            </td>            
            
          </tr>
          <?php
         }
         //Add jquery pagination code                              
         ?>                               
          <script type="text/javascript">
             $(function() {
                 
                 $('#<?php echo $tableId?>').dataTable({
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
         <?php
        }
        else
        {
          ?>
          <tr>
            <td colspan="<?php echo $colspan; ?>">
              No Records Found
            </td>
          </tr>
          <?
        }
        ?>
      </tbody>     
  </table>
</div><!-- /.box-body -->
<script>
  
  function change_status(userid,userstatus)
{
	$.ajax({
						url: '<?php echo Yii::app()->baseUrl;?>/index.php/cmsAdmin/user/changeUserStatus',						
						type: "POST",
						data :{
										user_id:userid,
										user_status:userstatus,
						},		
						success:function(data) {
             // alert("data==>"+data);
													// $.modal.close();
													// $('.modal').html('');
													$('.changestatus_'+userid).html(data);													
													location.reload(true);
									}
			});	
}
</script>