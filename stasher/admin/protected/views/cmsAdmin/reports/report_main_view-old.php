<link rel="stylesheet" href="<?php echo Yii::app()->request->baseUrl; ?>/assets/css/daterangepicker/daterangepicker-bs3.css" type="text/css"/> 
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
 <script type="text/javascript" src="<?php echo Yii::app()->request->baseUrl; ?>/assets/autosearch/jquery.tokeninput.js"></script>

    <link rel="stylesheet" href="<?php echo Yii::app()->request->baseUrl; ?>/assets/autosearch/token-input-facebook.css" type="text/css" />
    <link rel="stylesheet" href="<?php echo Yii::app()->request->baseUrl; ?>/assets/autosearch/highlight.css" type="text/css" />
      
     <script type="text/javascript">
    $(document).ready(function() {
      $(".highlight").each(function() {
        var originalWidth = $(this).width();
        var idealWidth = Math.max(originalWidth, $(this).find("pre").contents().width());
        $(this).hover(function () {
          $(this).animate({width: idealWidth});
        }, function () {
          $(this).animate({width: originalWidth});
        });
      });
 
            $("#searchusers").tokenInput("<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/reports/searchusers", {
        theme: "facebook"
    });
        });
        </script>
        
<input type="hidden" name="missiontype" id="missiontype"  value=""/>       
 <input type="hidden" name="userIds" value=""/> 
 <input type="hidden" name="fromdate" id="fromdate" value=""/> 
 <input type="hidden" name="todate" id="todate" value=""/> 
 <input type="hidden" name="sortdate" value=""/> 
 
 
                <!-- Content Header (Page header) -->
                <section class="content-header manageUser">
                    <span class="userImage"><img src="<?php echo Yii::app()->request->baseUrl; ?>/assets/images/reportsGrey.svg"></span>
                    <h1 class="col-md-8">                     
                       <span> View Reports</span>                      
                    </h1>                                      
                </section>

                <!-- Main content -->
                <section class="manageContent">
					<div class="col-md-12 viewReports">
                    	<ul class="list-unstyled">
                        	 <li>VIEW</li>
                              <li class="dropdown">
                              	  <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">ALL MISSIONS <span class="caret"></span></a>
                                  <ul class="dropdown-menu" role="menu">
                                    <li><a href="javascript:void(0);" onclick="return setMissionType('all');">ALL MISSIONS</a></li>
                                    <li><a href="javascript:void(0);" onclick="return setMissionType('active');">ACTIVE MISSIONS</a></li>
                                    <li><a href="javascript:void(0);" onclick="return setMissionType('inactive');">INACTIVE MISSIONS</a></li>   
                                     <li><a href="javascript:void(0);" onclick="return setMissionType('completed');">COMPLETED MISSIONS</a></li>                                                           
                                  </ul>
                            </li>
                            <li>FOR</li>
                            <li class="dropdown">
                           
                              <a id="allUser" href="javascript:void(0);">ALL USERS <span class="caret"></span></a>
  <div class="allUserList" id="allUserList">	
  <ul role="menu" class="userDropdown">
                                    <li><a href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/reports">ALL USERS</a></li>
                                    <li><a href="javascript:void(0);">SOME USERS</a></li>
                                    <li class="searchLi"><input type="search" id="searchusers"/><span class="reportSearch"><img src="<?php echo Yii::app()->request->baseUrl; ?>/assets/images/searchIcon.svg"/></span>
                                    
                                    
                                    
                                    
                                    </li> 

                                    
                                  </ul>
                               </div>                            
                            
                            </li>
                              <li>SELECT DATE</li>
                            <li class="reportDate"><input type="text" class="datePickerReport" placeholder="MM/DD/YYYY" id="datePicker"/><span class="caret"></span></li>                                                       
                            <li>SORT BY</li>
                            <li class="dropdown">
                              	  <a aria-expanded="false" role="button" data-toggle="dropdown" class="dropdown-toggle" href="javascript:void(0);">DATE <span class="caret"></span></a>
                                  <ul role="menu" class="dropdown-menu">
                                    <li><a href="javascript:void(0);">DATE</a></li>
                                    <li><a href="javascript:void(0);">USER</a></li>                           
                                  </ul>
                            </li>
                            <button onclick="javasccript:window.location='<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/export'" class="btn csv pull-right">EXPORT .CSV</button>
                        </ul>
					</div>                                                           
                    <div class="col-md-12 manageUserInner">
                    	<div class="row">                        	
                            <div class="col-md-10" id="ajaxdiv"> 
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
                                                <h4><?php //echo $marray->parent->fname; ?></h4>
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
                                
                              
                                                                                               
                            </div>                            
                        </div>
					</div>
                    
                </section><!-- /.content -->
                
<script src="<?php echo Yii::app()->request->baseUrl; ?>/assets/js/daterangepicker/daterangepicker.js" type="text/javascript"></script>
        <script type="text/javascript">
        
         function setMissionType(mtype)
        {
        $("#missiontype").val(mtype);
       		ajaxReportList();
        }
        function ajaxReportList()
        {
       
        var mtype = $("#missiontype").val();
        
         var fromdate = $("#fromdate").val();
    var todate = $("#todate").val();
    var datas = {
      fromdate: fromdate,
      m:mtype,
      todate: todate
    };
    
        $.ajax({
      type: "POST",
      url: "<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/reports/ajaxlist", 
      data: datas,
      success: function(res) {
       $("#ajaxdiv").html();
       $("#ajaxdiv").html(res);
      }
    });
    return false;
    
    
        	
        }
            $(function() {                
                $('#datePicker').daterangepicker();             
            });	
         
         
         $("document").ready(function(){
  $(".applyBtn").click(function(){
   var fromdate = $("input[name=daterangepicker_start]").val();
    var todate = $("input[name=daterangepicker_end]").val();
    $("#fromdate").val(fromdate);
     $("#todate").val(todate);
     ajaxReportList();
  });

                $('#allUser').click(function() {
                   $('#allUserList').slideToggle(); 
                });
                

            });
</script>

