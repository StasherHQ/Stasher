           
                <!-- Content Header (Page header) -->
                <section class="content-header manageUser">
                    <span class="userImage"><img src="<?php echo Yii::app()->request->baseUrl; ?>/assets/images/manageUserGrey.svg"></span>
                    <h1 class="col-md-8">                     
                       <span> Manage Users &gt; </span> <?php echo $userdetails->username; ?>                         
                    </h1>
                                     
                </section>

                <!-- Main content -->
                <section class="manageContent">
					<div class="col-md-12 manageUserInner">
                    	<div class="row">
                        	<div class="col-md-2 title">
                            	USERNAME
                            </div>
                            <div class="col-md-10">
                            	<?php echo $userdetails->username; ?> 
                            </div>                            
                        </div>
					</div>
                    <div class="col-md-12 manageUserInner">
                    	<div class="row">
                        	<div class="col-md-2 title">
                            	E-MAIL ADDRESS
                            </div>
                            <div class="col-md-10">
                            	<a href="mailto:<?php echo $userdetails->email; ?>"><?php echo $userdetails->email; ?></a>
                            </div>                            
                        </div>
					</div>
                    <div class="col-md-12 manageUserInner">
                    	<div class="row">
                        	<div class="col-md-2 title">
                            	USER TYPE
                            </div>
                            <div class="col-md-10">
                            	User (<?php 

				if($userdetails->usertype == '3')
					echo "Child";
else if($userdetails->usertype == '4')
echo "Parent";
?>)
                            </div>                            
                        </div>
					</div>
                 
                    <div class="col-md-12 manageUserInner">
                    	<div class="row">
                        	<div class="col-md-2 title">
                            	FIRST NAME
                            </div>
                            <div class="col-md-10">
                            	<?php echo $userdetails->fname; ?>
                            </div>                            
                        </div>
					</div>
                    <div class="col-md-12 manageUserInner">
                    	<div class="row">
                        	<div class="col-md-2 title">
                            	LAST NAME
                            </div>
                            <div class="col-md-10">
                            	<?php echo $userdetails->lname; ?>
                            </div>                            
                        </div>
					</div>
                    <div class="col-md-12 manageUserInner">
                    	<div class="row">
                        	<div class="col-md-2 title">
                            	GENDER
                            </div>
                            <div class="col-md-10">
                            	
<?php if($userdetails->gender == 'm'){ echo "Male";}else {echo "Female";} ?>
                            </div>                            
                            </div>                            
                        </div>
                    <div class="col-md-12 manageUserInner">
                    	<div class="row">
                        	<div class="col-md-2 title">
                            	AVATAR
                            </div>
                            <div class="col-md-10 avatar">
                            	<span>
                            	
                            	<?php
                                             $filename = DOCROOT.'/dynamicAssets/users/avatar/'.$userdetails->avatar;
                                            	if (file_exists($filename) && $userdetails->avatar != '') 
                                            	{
                                            	?>
                                            	<img src="<?php echo SITEURL; ?>/dynamicAssets/users/avatar/<?php echo $userdetails->avatar;?>">
                                            	<?php
                                            	}
                                            	else
                                            	{
                                            	?>
                                            	<img src="<?php echo SITEURL; ?>/admin/assets/images/defaultProfile.png">
                                            	<?php
                                            	}?>
                                            	
                            	</span>
                            </div>                            
                        </div>
					</div>
                    <div class="col-md-12 manageUserInner">
                    	<div class="row">
                        	<div class="col-md-2 title">
                            	BIRTHDATE
                            </div>
                            <div class="col-md-10">
                            	<?php echo $userdetails->dob; ?>
                            </div>                            
                        </div>
					</div>
                    <div class="col-md-12 manageUserInner">
                    	<div class="row">
                        	<div class="col-md-2 title">
                            	<?php  if($userdetails->usertype == '4'){ echo "CHILDREN";}else {echo "PARENTS";} ?>
                            </div>
                            <div class="col-md-10">
                            <?php 
                            if($relativedetails)
                            {
				foreach($relativedetails as $newdata)
{
?>
                            	<div class="col-md-12 childOuter">
                                	<div class="row">
                                    	<div class="col-md-1">
	                                        <div class="childPic">
                                            	<a href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/user/details/?id=<?php echo base64_encode($newdata->userId);?>">
                                            	<?php
                                            	$filename = DOCROOT.'/dynamicAssets/users/avatar/'.$newdata->avatar;
                                            		if (file_exists($filename) && $newdata->avatar != '') 
                                            	{
                                            	?>
                                            	<img src="<?php echo SITEURL; ?>/dynamicAssets/users/avatar/<?php echo $newdata->avatar;?>">
                                            	<?php
                                            	}
                                            	else
                                            	{
                                            	?>
                                            	<img src="<?php echo SITEURL; ?>/admin/assets/images/defaultProfile.png">
                                            	<?php
                                            	}?>
                                            	
                                            	</a>
                                            </div>
                                        </div>
                                        <div class="col-md-11">    
                                            <h5><?php echo $newdata->username;?></h5>
                                            <span><a href="mailto:<?php echo $newdata->email; ?>"><?php echo $newdata->email;?></a></span>
                                        </div>
                                    </div>
                                </div>
<?php
}
}
else
{
   echo "No data found!";
}?>

                               
                            </div>                            
                        </div>
					</div>
                    
                </section><!-- /.content -->
            
