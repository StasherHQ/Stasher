<section class="manageContent">
 <div class="col-md-12 manageUserInner">
                    	<div class="row">
                        	<div class="col-md-2 title">
                            	MISSIONS
                            </div>
                            <div class="col-md-10">
                             <?php 
				foreach($missionArray as $newdata)
{
?>
                            	<div class="col-md-12 missionOuter">
                                    <div class="col-md-6">	
                                    <table class="table" id="example2">
                                        <tbody><tr>
                                            <td>
                                                <label>TITLE</label>
                                                <h4><?php echo $newdata->title;?></h4>		
                                            </td>
                                            <td>
                                                <label>REWARDS</label>
                                                <h4>$<?php echo $newdata->rewards; ?></h4>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>START DATE/TIME</label>
                                                <h4> 
                                                <?php echo date("m/d/Y g:i A", strtotime($newdata->start_time)); ?>
                                                </h4>		
                                            </td>
                                            <td>
                                                <label> <?php if($userArray->usertype == '3')
                                                 echo 'PARENT';
                                                 else
                                                 echo 'CHILD';
                                                ?></label>
                                                <h4><?php echo $newdata->parent->fname;?></h4>
                                            </td>
                                        </tr>                                                   
                                        <tr>
                                            <td>
                                                <label>END DATE/TIME</label>
                                                <h4>Due in 2 Hours</h4>	
                                            </td>
                                            <td>
                                                <label>STATUS</label>
                                                 <?php if($newdata->status == '3')
                                                {
                                                ?>
                                                <h4 class="text-success">Completed</h4>
                                                <?php
                                                }
                                                else
                                                {
                                                ?>
                                                 <h4 class="text-danger">Pending</h4>
                                                <?php
                                                }
                                                ?>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                    </div>
                                    <div class="col-md-6 missionInnerRight">
                                    <table class="table" id="example2">
                                        <tbody><tr>
                                            <td>
                                                <label>TRANSACTION ID</label>
                                                <h4>56789OPQRS</h4>	
                                            </td>
                                            <td>
                                                <label>SMS DATE + TIME</label>
                                                <h4>01/16/2015 7:49PM</h4>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>NAME</label>
                                                <h4>Carrie Thompson</h4>	
                                            </td>
                                            <td>
                                                <label>STATUS CODE</label>
                                                <h4>XYZ3210987</h4>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>EMAIL</label>
                                                <h4>mom01@gmail.com</h4>	
                                            </td>
                                            <td>
                                                <label>TRANSACTION STATUS</label>
                                                <?php if($newdata->status == '3')
                                                {
                                                ?>
                                                <h4 class="text-success">COMPLETED</h4>
                                                <?php
                                                }
                                                else
                                                {
                                                ?>
                                                 <h4 class="text-danger">COMPLETED</h4>
                                                <?php
                                                }
                                                ?>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>AMOUNT</label>
                                                <h4>$50.00 USD</h4>	
                                            </td>
                                            <td>
                                                
                                            </td>
                                        </tr>
                                    </tbody></table>
                               </div>
                                </div>
                             <?php

}?>   
                                                                                              
                            </div>                            
                        </div>
					</div>
                    
                </section>
