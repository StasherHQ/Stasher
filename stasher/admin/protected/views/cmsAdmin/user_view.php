   <!-- Content Header (Page header) -->
                <section class="content-header manageUser">
                    <span class="userImage"><img src="<?php echo Yii::app()->request->baseUrl; ?>/assets/images/manageUserGrey.svg" /></span>
                    <h1 class="col-md-8">                     
                        Manage Users                        
                    </h1> 
                   
                    <div class="col-md-2 pull-right">
                    	<div class="sb-search sb-search-open" id="sb-search">
						<form method="get" >
							<input type="text" id="q" name="q" value="<?php echo $q;?>" placeholder="" class="sb-search-input">
							<input type="submit" value="" class="sb-search-submit">
							<span class="sb-icon-search"></span>
						</form>
					</div>
                    </div>
                                   
                </section>

                <!-- Main content -->
                <section class="manageContent">
					<div class="col-md-12 manageUserInner manageTitle">
                    	<div class="row">
                        	<div class="col-md-3">
                            	Username
                            </div>
                            <div class="col-md-3">
                            	Email address
                            </div>
                            <div class="col-md-3">
                            	User type
                            </div>
                            <div class="col-md-3">
                            	Action
                            </div>
                        </div>
					</div>
                   
			<?php 
			if($all_user_list)
			{
				foreach($all_user_list as $newdata)
{
?>
 <div class="col-md-12 manageUserInner">
                    	<div class="row">
                        	<div class="col-md-3">
                            	<a href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/user/details/?id=<?php echo base64_encode($newdata->userId);?>"><?php echo $newdata->username;?></a>
                            </div>
                            <div class="col-md-3">
                            	<?php echo $newdata->email;?>
                            </div>
                            <div class="col-md-3">
                            	User (<?php 

				if($newdata->usertype == '3')
					echo "Secrete Agent";
else if($newdata->usertype == '4')
echo "Commander";
?>)
                            </div>
                            <div class="col-md-3 action">
                            	<a href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/user/edit/?id=<?php echo base64_encode($newdata->userId);?>"><img src="<?php echo Yii::app()->request->baseUrl; ?>/assets/images/editIcon.svg" /></a>
								<a href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/user/delete/?id=<?php echo base64_encode($newdata->userId);?>"><img src="<?php echo Yii::app()->request->baseUrl; ?>/assets/images/deleteIcon.svg" /></a>
                                <a href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/user/details/?id=<?php echo base64_encode($newdata->userId);?>"><img src="<?php echo Yii::app()->request->baseUrl; ?>/assets/images/view.svg" /></a> 
                                
                                <a title="Mission List" href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/mission/user/?id=<?php echo base64_encode($newdata->userId);?>"><img src="<?php echo Yii::app()->request->baseUrl; ?>/assets/images/mission.svg" /></a> 
                                                               
                            </div>
                        </div>
					</div>
<?php

}
}
else
{
	echo '<div class="text-danger">No user found!</div>';
}
?>
 </section><!-- /.content -->
