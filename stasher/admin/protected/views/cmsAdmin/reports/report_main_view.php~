<link rel="stylesheet" href="<?php echo Yii::app()->request->baseUrl; ?>/assets/css/daterangepicker/daterangepicker-bs3.css" type="text/css"/> 
       
<input type="hidden" name="missiontype" id="missiontype"  value=""/>       
 <input type="hidden" name="userIds" id="userIds" value=""/> 
 <input type="hidden" name="fromdate" id="fromdate" value=""/> 
 <input type="hidden" name="todate" id="todate" value=""/> 
 <input type="hidden" name="sortingfield" id="sortingfield" value=""/> 
  <input type="hidden" name="sortingby" id="sortingby" value="asc"/> 
 
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

                                  <?php foreach($userList as $ulist)
                         	{
                         	?>
                                    <li><a href="javascript:void(0);" onclick="setUser('<?php echo base64_encode($ulist->userId);?>')">
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
                                        </span></a>
                                    </li> 
                                    <?php
                         	}
                         	?>    
                                  </ul>
                               </div>                            
                            
                            </li>
                              <li>SELECT DATE</li>
                            <li class="reportDate"><input type="text" class="datePickerReport" placeholder="MM/DD/YYYY" id="datePicker"/><span class="caret"></span></li>                                                       
                            <li>SORT BY</li>
                            <li class="dropdown">
                              	  <a aria-expanded="false" role="button" data-toggle="dropdown" class="dropdown-toggle" href="javascript:void(0);" >DATE <span class="caret"></span></a>
                                  <ul role="menu" class="dropdown-menu">
                                    <li><a href="javascript:void(0);" onclick="setSortingField('date')">DATE</a></li>
                                    <li><a href="javascript:void(0);" onclick="setSortingField('title')">TITLE</a></li>                           
                                  </ul>
                            </li>
                            <button onclick="exportcsv();" class="btn csv pull-right">EXPORT .CSV</button>
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
        function setSortingBy(sortingby)
        {
        	 $("#sortingby").val(sortingby);
       		ajaxReportList();
        }
        
        function setSortingField(sortingfield)
        {
        	 $("#sortingfield").val(sortingfield);
       		ajaxReportList();
        }
        function setUser(userId)
        {
        	 $("#userIds").val(userId);
       		ajaxReportList();
        }
         function setMissionType(mtype)
        {
        $("#missiontype").val(mtype);
       		ajaxReportList();
        }
        function ajaxReportList()
        {
       
        var userIds = $("#userIds").val();
         var sortingfield = $("#sortingfield").val();
          var sortingby = $("#sortingby").val();
         var mtype = $("#missiontype").val();
         var fromdate = $("#fromdate").val();
    var todate = $("#todate").val();
    var datas = {
    	
      fromdate: fromdate,
      m:mtype,
      userIds: userIds,
      todate: todate,
      sortingfield: sortingfield,
      sortingby: sortingby
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
        
         function exportcsv()
        {
       
        var userIds = $("#userIds").val();
         var sortingfield = $("#sortingfield").val();
          var sortingby = $("#sortingby").val();
         var mtype = $("#missiontype").val();
         var fromdate = $("#fromdate").val();
    var todate = $("#todate").val();
    var datas = {
    	
      fromdate: fromdate,
      m:mtype,
      userIds: userIds,
      todate: todate,
      sortingfield: sortingfield,
      sortingby: sortingby
    };
    
        $.ajax({
      type: "POST",
      url: "<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/export", 
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

