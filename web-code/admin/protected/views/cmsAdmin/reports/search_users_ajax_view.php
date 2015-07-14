 <?php foreach($userList as $ulist)
                         	{
                         	?>
                                    <li>
                                    	<a href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/reports/?userId=<?php echo base64_encode($ulist->userId);?>">
                                    	<span class="userImg">
                                    	<?php
                                            	$filename = DOCROOT.'/dynamicAssets/users/avatar/'.$ulist->avatar;
                                            	if (file_exists($filename) && $ulist->avatar != '') 
                                            	{
                                            	?>
                                            	<img src="<?php echo SITEURL; ?>/dynamicAssets/users/avatar/<?php echo $ulist->avatar;?>">
                                            	<?php
                                            	}
                                            	else
                                            	{
                                            	?>
                                            	<img src="<?php echo SITEURL; ?>/admin/assets/images/defaultProfile.png">
                                            	<?php
                                            	}?>
                                    	
                                    	</span>
                                        <span class="outerSpan">    
                                            <span class="userName"><?php echo $ulist->username; ?></span>
                                            <span class="reportEmail"><?php echo $ulist->email; ?></span>                            
                                        </span>
                                        </a>
                                    </li> 
                                    <?php
                         	}
                         	?> 
