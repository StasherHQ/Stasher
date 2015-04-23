 	<!-- Content Header (Page header) -->
<script type="text/javascript" src="<?php echo Yii::app()->request->baseUrl; ?>/js/jscharts.js"></script>
<!-- date-range-picker -->
<script src="<?php echo Yii::app()->request->baseUrl; ?>/js/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>

<script>
		 $(function() {
				//$( "#from_date" ).datepicker({ dateFormat: 'yy-m-d'});
				//$( "#to_date" ).datepicker({ dateFormat: 'yy-m-d'});
				$('#reservationtime').daterangepicker({timePicker: true, timePickerIncrement: 30, format: 'MM/DD/YYYY H:mm:ss'});
			});
</script>
<!-- Main content -->
	<div class="row">       
            <div class="col-md-12 col-sm-12">
            	<div class="box box-primary col-md-12 col-sm-12">                	
									
									<!--<img src="<?php // echo Yii::app()->request->baseUrl; ?>/images/dashboardgraph.png" alt="">-->
								<?php
								  /* Redirect to UserVenue for Venue Manager admin type to view his orders */
                
							/*	$frmurl = "";
                if(Yii::app()->session['admin_type'] == 'admin' || Yii::app()->session['admin_type'] == 'super_admin' || Yii::app()->session['admin_type'] == 'developer_account')
                {
                    $frmurl = "/cmsAdmin/dashboard/Index";
                }
                else if(Yii::app()->session['admin_type'] == 'venue_manager')
                {
                    $frmurl = "/cmsAdmin/UserVenue/dashboardSearchVenue";
                }
                else
                {
                		$frmurl = '/cmsAdmin/dashboard';
                }*/
								if(Yii::app()->session['admin_type'] != 'venue_manager')
							{
							?>
                 <form role="form" action="<?php echo Yii::app()->request->baseUrl.'/cmsAdmin/dashboard'; ?>" method="post" id="frmbillingsearch">
								 
									<div class="row">
                                    
                 	<div class="col-md-10 col-sm-10 dashbordSelect reports">
                        <h3 class="searchBarTitle">Title</h3>
                        <div class="selectOrderSearch">	
                        <h4 class="searchBarTitle pull-left">Select Range:</h4>
                            <div class="col-md-10 col-sm-10">						
                             <input type="text" name="from_date" id="reservationtime" value="<?php echo $from_date.'-'.$to_date;?>" class="form-control" onkeypress="remove_error_class('from_date')"; onfocus ="remove_error_class('from_date')"; placeholder="From Date"/>										
                            </div>
                        </div>  
					</div>
										<!--<div class="col-md-3 col-sm-3 dashbordSelect">											
												<div class="selectOrderSearch">
														 <input type="text" name="to_date" id="to_date" value="<?php echo $to_date;?>" class="form-control" onkeypress="remove_error_class('from_date')"; onfocus ="remove_error_class('from_date')"; placeholder="To Date"/>															
												</div>
								 </div>-->
										<div class="col-md-2 col-sm-2 dashbordSelect reports">
                                        <h3 class="searchBarTitle"></h3>
                    	 <button class="btn btn-primary col-md-12 col-sm-12" type="button" onclick="showReport('<?php echo $report_type;?>')">Go!</button>
                    </div>
									</div>
									</form>
								<?php }else{ ?>
									
									<div class="row">
										<div class="col-md-12 col-sm-12 dashbordSelect text-center">
													<a class="btn btn-primary text-center goToUserPanelBtn" href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/UserVenue">													
                        								Manage <?php echo $venuename; ?>
                                                    </a>
									</div>
									</div>
									
									<?php } ?>
									
									 <div id="inner_view" class="innerView">
												<?php
									
											/*	$data['time_frame_text'] = $time_frame_text;
												$data['total_orders'] = $total_orders;
												$data['total_tip'] = $total_tip;
												$data['total_tax'] = $total_tax;
											*/
											//	$data['total_sale'] = $total_sale;
											//	$data['total_gifted_item'] = $total_gifted_item;			
											//	$data['waitTime'] = $waitTime;
												$data['graphArray'] = $graphArray;
												//$data['xAxisTitle'] = $xAxisTitle;
									
												echo $this->renderPartial('cmsAdmin/reports/report_inner_view',$data); ?>
												</div>
                                               
                                                
									 
									
                </div>	
            </div>
            <div class="col-md-12 col-sm-12">
            	<div class="box box-primary col-md-12 col-sm-12">
								<?php		if(Yii::app()->session['admin_type'] == 'venue_manager')
											{ ?>
									<h4>Customers</h4>
									<?php } ?>
									
                	<div class="row">       
                        <div class="col-md-12 col-sm-12">
                            <h4 class="box-title"><?php echo $report_type;?></h4>
                            <table class="table table-bordered table-striped dataTable" id="billing">
                                <thead>
                                    <tr role="row">
                                        <th class="">Date</th>
                                        <th class="">Record</th>
                                    </tr>
                                </thead>
                                <tbody role="alert" aria-live="polite" aria-relevant="all">
																	<?php if(!empty($report_date_data)){
																		 $count=sizeof($report_date_data);
																					for($i=0;$i<$count;$i++){?>
                                    <tr>
                                        <td class="">
                                           <?php echo $report_date_data[$i]; ?>
                                        </td>
                                        <td class="">
                                            <?php echo $report_sales_data[$i];  ?>
                                        </td>
                                    </tr>
																<?php } }else{ ?>
																		<tr>
                                        <td colspan="2">
                                            No records found
                                        </td>                                        
                                    </tr>
																<?php } ?>
                                </tbody>
                            </table>
                       		
                       	
                        	<div class="col-md-12 col-sm-12 text-center topUser">
															<?php		if(Yii::app()->session['admin_type'] != 'venue_manager')
                                                            { ?>		
                                                        <!--<a href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/user">													
                                <button class="btn btn-primary text-center goToUserPanelBtn">Go to user panel</button></a>-->
                                                        
                                                        <?php }else{ ?>
                                                        
                                                        <!--<a href="<?php // echo Yii::app()->request->baseUrl; ?>/cmsAdmin/userVenue">													
                                <button class="btn btn-primary text-center goToUserPanelBtn">View Customers</button></a>-->
                                                        <?php } ?>
                            </div>
                        
                        </div>
                        <?php /*
												echo "<pre>";
												print_r($report_date_data);
												echo "</pre>";
													echo "<pre>";
												print_r($report_sales_data);
												echo "</pre>";
												*/?>
							
												
                     
                	</div>        
                </div>
            </div>
    	</div>        
	</div>