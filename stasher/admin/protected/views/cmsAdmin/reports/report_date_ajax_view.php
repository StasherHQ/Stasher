                            <?php 
                            foreach($missionArray as $marray)
                            {
                            ?>                         
                                <div class="col-md-12 missionOuter">
                                    <div class="col-md-6">	
                                    <table class="table">
                                        <tbody><tr>
                                            <td>
                                                <label>TITLE</label>
                                                <h4><?php echo $marray->title;?></h4>		
                                            </td>
                                            <td>
                                                <label>REWARDS</label>
                                                <h4>$<?php echo $marray->rewards;?></h4>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>START DATE/TIME</label>
                                                <h4> <?php echo date("m/d/Y g:i A", strtotime($marray->start_time)); ?></h4>		
                                            </td>
                                            <td>
                                                <label>PARENT</label>
                                                <h4><?php echo $marray->parent->fname; ?></h4>
                                            </td>
                                        </tr>                                                   
                                        <tr>
                                            <td>
                                                <label>END DATE/TIME</label>
                                                <h4>Due in 2 Hours</h4>	
                                            </td>
                                            <td>
                                                <label>STATUS</label>
                                               <?php if($marray->status == '3')
                                                {
                                                ?>
                                                <h4 class="text-success">Completed</h4>
                                                <?php
                                                }
                                                else if($marray->status == '2')
                                                {
                                                ?>
                                                <h4 class="text-success">Active</h4>
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
                                    <div class="col-md-6 missionInnerRight missionKnoxPending text-center">
                                    	<span>KNOX TRANSACTION DETAILS</span>
                                        <h3>Pending</h3>
                                    </div>
                                </div> 
                                <?php 
                                }?>
