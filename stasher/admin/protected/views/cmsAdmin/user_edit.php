    <form method="post" name="frmAction" id="frmAction" enctype="multipart/form-data" action="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/user/update">
    <input type="hidden" name="userId" id="userId" value="<?php echo base64_encode($userdetails->userId); ?>" />          
                <!-- Content Header (Page header) -->
                <section class="content-header manageUser">
                    <span class="userImage"><img src="<?php echo SITEURL; ?>/dynamicAssets/users/avatar/<?php echo $userdetails->avatar;?>"></span>
                    <h1 class="col-md-8">                     
                       <span> Manage Users &gt; </span> <?php echo $userdetails->username; ?>                         
                    </h1>
                    <div class="col-md-3 pull-right">                    	
                        <button class="btn discardSave pull-right" type="submit">Save changes</button>
                        <button class="btn discardSave pull-right">Discard changes</button>
                    </div>                    
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
                            	<?php echo $userdetails->email; ?>
                            </div>                            
                        </div>
					</div>
                    <div class="col-md-12 manageUserInner">
                    	<div class="row">
                        	<div class="col-md-2 title">
                            	USER TYPE
                            </div>
                            <div class="col-md-10">
                            	User (Parent)
                            </div>                            
                        </div>
					</div>
                    <div class="col-md-12 manageUserInner">
                    	<div class="row">
                        	<div class="col-md-2 title">
                            	PASSWORD
                            </div>
                            <div class="col-md-10 sendMail">
                            	<button type="button" class="btn" id="sendpassword">SEND TO USER BY MAIL</button>
                            </div>                            
                        </div>
					</div>
                    <div class="col-md-12 manageUserInner">
                    	<div class="row">
                        	<div class="col-md-2 title">
                            	FIRST NAME
                            </div>
                            <div class="col-md-10">
                            	<input type="text" name="fname" id="fname" value="<?php echo $userdetails->fname; ?>" />
                            </div>                            
                        </div>
					</div>
                    <div class="col-md-12 manageUserInner">
                    	<div class="row">
                        	<div class="col-md-2 title">
                            	LAST NAME
                            </div>
                            <div class="col-md-10">
                            	<input type="text" name="lname" id="lname" value="<?php echo $userdetails->lname; ?>" />
                            </div>                            
                        </div>
					</div>
                    <div class="col-md-12 manageUserInner">
                    	<div class="row">
                        	<div class="col-md-2 title">
                            	GENDER
                            </div>
                            <div class="col-md-10">
                            	
                              	 
                                  <select name="gender"  >
                                    <option value="f" <?php if($userdetails->gender == 'f'){ ?> selected<?php } ?>>Female</option>
                                    <option value="m" <?php if($userdetails->gender == 'm'){ ?> selected<?php } ?>>Male</option>                                                                 
                                  </select>
                            </div>                            
                        </div>
					</div>
                    <div class="col-md-12 manageUserInner">
                    	<div class="row">
                        	<div class="col-md-2 title">
                            	AVATAR
                            </div>
                            <div class="col-md-10 avatar">
<input type="file" name="avatar" id="avatar" />
                            	<span><img src="<?php echo SITEURL; ?>/dynamicAssets/users/avatar/<?php echo $userdetails->avatar;?>"></span>
                            </div>                            
                        </div>
					</div>
                    <div class="col-md-12 manageUserInner">
                    	<div class="row">
                        	<div class="col-md-2 title">
                            	BIRTHDATE
                            </div>
                            <div class="col-md-10">
                            	<input type="text" name="dob" id="dob" value="<?php echo $userdetails->dob; ?>" />
                            </div>                            
                        </div>
					</div>
                    <div class="col-md-12 manageUserInner">
                    	<div class="row">
                        	<div class="col-md-2 title">
                            	<?php if($userdetails->usertype == '3'){ echo "CHILDREN";}else {echo "PARENTS";} ?>
                            </div>
                            <div class="col-md-10">
                            <?php 
				foreach($relativedetails as $newdata)
{
?>
                            	<div class="col-md-12 childOuter">
                                	<div class="row">
                                    	<div class="col-md-1">
	                                        <div class="childPic">
                                            	<img src="<?php echo Yii::app()->request->baseUrl; ?>/dynamicAssets/users/avatar/<?php //echo $newdata->avatar;?>">
                                            </div>
                                        </div>
                                        <div class="col-md-11">    
                                            <h5><?php echo $newdata->username;?></h5>
                                            <span><?php echo $newdata->email;?></span>
                                        </div>
                                    </div>
                                </div>
<?php

}?>

                               
                            </div>                            
                        </div>
					</div>
                    
                </section><!-- /.content -->
 </form>
  
  <script type="text/javascript">
$("document").ready(function(){
//alert("ef");
  $("#sendpassword").click(function(){
 // alert("hi");
   var userId = $("#userId").val();
    var data = {
      userId: userId
    };
   
    $.ajax({
      type: "POST",
      url: "<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/user/sendpassword", //Relative or absolute path to response.php file
      data: data,
      success: function(res) {
       
      }
    });
    return false;
  });
});
</script>
        
