    <link rel="stylesheet" href="<?php echo Yii::app()->request->baseUrl; ?>/assets/css/daterangepicker/datepicker3.css" type="text/css"/>   
      <form method="post" name="frmAction" id="frmAction" enctype="multipart/form-data" action="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/user/update">
    <input type="hidden" name="userId" id="userId" value="<?php echo base64_encode($userdetails->userId); ?>" />          
                <!-- Content Header (Page header) -->
                <section class="content-header manageUser manageUserForm">
                    <span class="userImage"><img src="<?php echo Yii::app()->request->baseUrl; ?>/assets/images/manageUserGrey.svg"></span>
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
                            	<span><?php
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
                                            	}?></span>
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
                            	<?php if($userdetails->usertype == '4'){ echo "CHILDREN";}else {echo "PARENTS";} ?>
                            </div>
                            <div class="col-md-10">
                            <?php 
				foreach($relativedetails as $newdata)
{
?>
                            	<div class="col-md-12 childOuter">
                                	<div class="row" id="userrelation<?php echo $newdata->id; ?>">
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
                                  <a href="javascript:void(0);" onclick="return removeUser(<?php echo $newdata->id; ?>);" title="Remove">x</a>   
                                            <h5><?php echo $newdata->username;?></h5>
                                            <a href="mailto:<?php echo $newdata->email; ?>"><span><?php echo $newdata->email;?></a></span>
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
  
  
  
              
              
  <script src="<?php echo Yii::app()->request->baseUrl; ?>/assets/js/daterangepicker/bootstrap-datepicker.js" type="text/javascript"></script>
        <script type="text/javascript">
function removeUser(id)
{
var newid = "#userrelation"+id;	  
    var datas = {
      id: id
    };
   
    $.ajax({
      type: "POST",
      url: "<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/user/removeuserrelation",
      data: datas,
      success: function(res) {
      $(newid).remove();
      // $(".sendMail").append(res);
      // $('#msg').fadeOut(5000);
      }
    });
}

            $(function() {                
                $('#dob').datepicker({
                format: 'yyyy-mm-dd'
                });             
            });	
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
       $(".sendMail").append(res);
       $('#msg').fadeOut(5000);
      }
    });
    return false;
  });
});
</script>
        
