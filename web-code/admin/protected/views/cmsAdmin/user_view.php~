   <script type='text/javascript' src="<?php echo Yii::app()->request->baseUrl; ?>/assets/slimtable/js/slimtable.min.js"></script>
<link rel='stylesheet' href="<?php echo Yii::app()->request->baseUrl; ?>/assets/slimtable/css/slimtable.css">

<script> 
   $( document ).ready(function() {  
   $('#msg').fadeOut(5000);
   });
   </script>
   <!-- Content Header (Page header) -->
              <?php if(@$_SESSION['msg'] != '' && @$_GET['msg'] == 'success'){?>  
              <p id= "msg" class="bg-success"><?php echo $_SESSION['msg'];?></p>
              <?php } ?>  
                <section class="content-header manageUser">
                    <span class="userImage"><img src="<?php echo Yii::app()->request->baseUrl; ?>/assets/images/manageUserGrey.svg" /></span>
                    <h1 class="col-md-6">                     
                        Manage Users                        
                    </h1> 
                   
                    <div class="col-md-4 pull-right">
                    	<div class="sb-search sb-search-open" id="sb-search">
						<form method="get" >
							<select name="usertype">
								<option value="">Select<option>
								<option value="parent" <?php if(@$_GET['usertype'] == 'parent'){ echo "selected"; }?>>Parent<option>
								<option value="child" <?php if(@$_GET['usertype'] == 'child'){ echo "selected"; }?>>Child<option>
							</select>
							<input style="width:75% !important;" type="text" id="q" name="q" value="<?php echo $q;?>" placeholder="" class=" sb-search-input">
							<input type="submit" value="" class="sb-search-submit">
							<span class="sb-icon-search"></span>
						</form>
					</div>
                    </div>
                                   
                </section>

                <!-- Main content -->
                <section class="manageContent">
                
                <table id='example2'>

<thead>
<tr>
 <th></th>
 <th>Username</th>
 <th>Email address</th>
 <th>User type</th>
 <th>Action</th>

</tr>
</thead>


				<!--<div class="col-md-12 manageUserInner manageTitle">
				    	<div class="row">
				        	<div class="col-md-3">
				            	
				            </div>
				            <div class="col-md-3">
				            	
				            </div>
				            <div class="col-md-3">
				            	
				            </div>
				            <div class="col-md-3">
				            	
				            </div>
				        </div>
				</div> -->
				<tbody>
				<?php 
			if($all_user_list)
			{
			$i=1;
				foreach($all_user_list as $newdata)
{
?>
<tr>
	
	<td><?php echo $i++;?></td>
	<td><a href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/user/details/?id=<?php echo base64_encode($newdata->userId);?>"><?php echo $newdata->username;?></a></td>
	<td><?php echo $newdata->email;?></td>
	<td>User (<?php 

				if($newdata->usertype == '3')
					echo "Child";
else if($newdata->usertype == '4')
echo "Parent";
?>)</td>
	<td><a href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/user/edit/?id=<?php echo base64_encode($newdata->userId);?>"><img src="<?php echo Yii::app()->request->baseUrl; ?>/assets/images/editIcon.svg" /></a>
								<a href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/user/delete/?id=<?php echo base64_encode($newdata->userId);?>"><img src="<?php echo Yii::app()->request->baseUrl; ?>/assets/images/deleteIcon.svg" /></a>
                                <a href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/user/details/?id=<?php echo base64_encode($newdata->userId);?>"><img src="<?php echo Yii::app()->request->baseUrl; ?>/assets/images/view.svg" /></a> 
                                
                                <a title="Mission List" href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/mission/user/?id=<?php echo base64_encode($newdata->userId);?>"><img src="<?php echo Yii::app()->request->baseUrl; ?>/assets/images/missions.svg" width="15" /></a> </td>
</tr>

<?php

}
}
else
{
	echo '<tr><td><div class="text-danger">No user found!</div></td></tr>';
}
?>
</tbody>
</table>                 
			
<script type='text/javascript'>
$(function() {
	
		$("#example2").slimtable({
		colSettings: [ 
			{ colNumber: 0, enableSort: false, addClasses: [ 'customclass1' ] }
		]
	});
});
</script>

 </section><!-- /.content -->
