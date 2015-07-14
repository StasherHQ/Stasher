<!--<script type="text/javascript">
	$(document).ready(function() {
	var s = $(".sticky");
	var t = $(".stickyTab");
	var pos = s.position();	  
	$(window).scroll(function() {
	var windowpos = $(window).scrollTop();
	if (windowpos >= pos.top) {
	s.addClass("stick");
	t.addClass("stick");
	} else {
	s.removeClass("stick");	
	t.removeClass("stick");	
	}
	});
	});
</script>
-->
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        Dashboard
        <small>Control panel</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/dashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li class="active"><i class="fa fa-cutlery"></i> <span>Menu</span></li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
 <div class="col-md-12 col-sm-12 menuDrinksContainer">
  <!-- Left side content start -->
  
  <!-- Left side content end -->
  
  <!-- Right side content start -->
  <div class="col-md-12 col-sm-12 menuDrinksContainer">
  
  
  
    <div class="box box-primary" >
      <div class="nav-tabs-custom">
          <ul class="nav nav-tabs stickyTab">
            <?php
            //Get li from database
            foreach($item_type as $it_type)
            {
              if($it_type->type_id == 1)
                $active_class = 'active';
              else
                $active_class = '';
              ?>
               <li class="<?php echo $active_class;?>"><a href="#tab_<?php echo $it_type->type_id?>" data-toggle="tab"><?php echo $it_type->type_name;?></a></li>
              <?php
            }
            ?>                                
          </ul>
          <div class="tab-content col-md-12 col-sm-12 drinkTabContent">
          
          
           <?php
            //Get li from database
            foreach($item_type as $it_type)
            {
              if($it_type->type_id == 1)
                $active_class = 'active';
              else
                $active_class = '';
              ?>
              <div class="tab-pane <?php echo $active_class; ?>" id="tab_<?php echo $it_type->type_id?>">
                
          
          
          
          
          <div class="sticky">
      <div class="box box-primary orderSearch col-md-12 col-sm-12">
        <div class="row">
        
        <!-- form start -->
       <div class="col-md-3 col-sm-3">
       <h4 class="searchBarTitle">Search</h4> 
        <form role="form" action="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/AdminVenue" method="post" id="frmsearch">
                <div class="input-group">
                  <input type="text" class="form-control" name="search_txt" value="<?php if(!empty($search_txt)) echo stripslashes($search_txt); ?>" id="search_txt" onkeypress="searchKeyPress(event,'search_venue');remove_error_class('search_txt');" onfocus ="remove_error_class('search_txt');" placeholder="Search!">
                  <span class="input-group-btn">
                      <button class="btn btn-flat" type="button" onclick="search_venue()">Go!</button>
                  </span>
                </div>
            <!-- /.box-body -->
        </form>
       </div>                         
        
       <div class="col-md-6 col-sm-6">
          <h4 class="searchBarTitle">Filters</h4>  
           <div class="row"> 
            <div class="col-md-6 col-sm-6">         	                 
                <div class="selectOrderSearch">     
                     <select class="form-control">
                           <option>Spirit Type</option>
                           <option>1</option>
                           <option>2</option>
                           <option>3</option>
                           <option>4</option>
                           <option>5</option>
                    </select>
                </div>     
         </div>
         
            <div class="col-md-6 col-sm-6">      
                <div class="selectOrderSearch">     
                     <select class="form-control">
                           <option>Choose Brand</option>
                           <option>1</option>
                           <option>2</option>
                           <option>3</option>
                           <option>4</option>
                           <option>5</option>
                    </select>
                </div>                    	
         </div>
           </div>
       </div>	
     <!--ADD NEW SPIRIT-->
     <div class="col-md-3 col-sm-3">
      <h4 class="searchBarTitle"></h4>  	
         <a class="btn btn-flat createSpirit col-md-12 col-sm-12" data-toggle="modal" data-target="#addspirit-modal" onclick="addspirit()"><i class="fa fa-pencil"></i> Create Spirit</a>
     </div>
     </div>
      </div>
  </div>
  
  			<div class="col-md-12 col-sm-12 box box-primary rightSide" id="">
            	<h4>		  	
					<?php echo $it_type->type_name;?>            
          		</h4>
            <div class="row">
            <div class="col-md-12 col-sm-12 menuTableContainer">
	
   <div class="happyHoursNight">
         <div class="row">
    	<div class="col-md-3 col-sm-3">
        	<div class="table-bordered col-md-12 col-sm-12">
                <div class="row">
                <h4 class="col-md-12 col-sm-12 titleHeight">Name:</h4>
                <h5 class="col-md-9 col-sm-9">Early Birds</h5>
                <input type="checkbox" />
                <div class="col-md-12 col-sm-12 happyHoursActiveBtn">
                	<button class="btn btn-flat">Active</button>
                </div>
                </div>
            </div>
        </div>
        <div class="col-md-9 col-sm-9">
        	<div class="table-bordered col-md-12 col-sm-12">
            <div class="row">
            <h4 class="col-md-3 col-sm-3 titleHeight">Slots</h4>
            <div class="pull-right slotSelect text-center">
              <div class="col-md-5 col-sm-5 text-right"> 
                <select class="form-control">
                       <option>9.00</option>
                       <option>1</option>
                       <option>2</option>
                       <option>3</option>
                       <option>4</option>
                       <option>5</option>
                </select>
                 <select class="form-control">
                       <option>AM</option>
                       <option>PM</option>                   
                </select>
              </div>  
            <div class="col-md-2 col-sm-2">
            	<span>To</span>
            </div>
            <div class="col-md-5 col-sm-5 text-left">
                <select class="form-control">
                       <option>12.00</option>
                       <option>1</option>
                       <option>2</option>
                       <option>3</option>
                       <option>4</option>
                       <option>5</option>
                </select> 
                  <select class="form-control">
                       <option>PM</option>
                       <option>AM</option>                   
                </select>        
 			</div>
            </div>
        </div>
        
        	<div class="col-md-12 col-sm-12">
            <div class="row">        	
              <div class="checkBoxHappyHour">	 	
                <input type="checkbox" value="Mon"/>
                <label>Mon</label>
              </div> 
              <div class="checkBoxHappyHour"> 
                <input type="checkbox" value="Tue"/>
                <label>Tue</label>
              </div>  
              <div class="checkBoxHappyHour">  
                <input type="checkbox" value="Wed"/>
                <label>Wed</label>
              </div>  
              <div class="checkBoxHappyHour">  
                <input type="checkbox" value="Thu"/>
                <label>Thu</label>
              </div>
              <div class="checkBoxHappyHour">  
                <input type="checkbox" value="Fri"/>
                <label>Fri</label>
              </div>
              <div class="checkBoxHappyHour">  
                <input type="checkbox" value="Sat"/>
                <label>Sat</label>
              </div>
              <div class="checkBoxHappyHour">  
                <input type="checkbox" value="Sun"/>
                <label>Sun</label>
              </div>
              </div>  
        </div>
        
        	<div class="col-md-12 col-sm-12 discount">
            	<div class="col-md-6 col-sm-6">
                	<div class="row">
                    <div class="col-md-6 col-sm-6">
                    <div class="row">
                    <input type="checkbox" value="Mon"/>
            		<label>Bulk Discount:</label> 
                    </div>
                    </div>
                    <div class="col-md-6 col-sm-6">
                    <div class="row">
                    <select class="form-control pull-left">
    		           <option>50%</option>
            		   <option>1</option>
               		   <option>2</option>
              		   <option>3</option>
             		   <option>4</option>
             		   <option>5</option>
           		   </select>           
                   </div>
                   </div>
                   </div>
                </div>
                <div class="col-md-6 col-sm-6">
                	<input type="checkbox" value="Mon"/>
            		<label>Min Quantity:</label> 
                    <input type="text" />
 
                </div>
            </div> 
            </div>
       </div>
       </div>
   </div>
 	
				<div class="col-md-2 col-sm-2 happyHoursMenu">
  <div class="row">	
  	<table class="table table-bordered">
    	<tbody>      
        	<tr>
            	<td><a href="#">Spirits</a></td>
            </tr>
            <tr>
            	<td><a href="#">Wine</a></td>
            </tr>
            <tr>
            	<td><a href="#">Shots</a></td>
            </tr>
            <tr>
            	<td><a href="#">Bottles</a></td>
            </tr>
            <tr>
            	<td><a href="#">Cocktails</a></td>
            </tr>
            <tr>
            	<td><a href="#">House Specials</a></td>
            </tr>
            <tr>
            	<td><a href="#">View All</a></td>
            </tr>
            <tr>
            	<td><a href="#">+ADD</a></td>
            </tr>
        </tbody>
    </table>
    </div>
  </div>
          
        	    <div class="col-md-10 col-sm-10 drinkTableOuter">
                <div class="box-body table-responsive">
                  <table id="" class="table table-bordered table-striped">
                      <thead>
                          <tr>
                            <!-- If any column added here.. Remember to add it to thefooter also and  $colspan variable -->
                              <th class="col-md-2 col-sm-2">Name</th>
                              <th class="col-md-2 col-sm-2">Type</th>
                              <th class="col-md-2 col-sm-2">Brand</th>
                              <th class="col-md-2 col-sm-2">Modifires</th> 
                              <th class="col-md-1 col-sm-1 text-center">Price (/Item)</th>
                              <th class="col-md-1 col-sm-1 text-center">Edit / Delete</th>
                              <th class="col-md-1 col-sm-1 text-center">Status</th>
                          </tr>
                      </thead>
                      <tbody>
                        
                        
                        
                        
                        
                        <tr>
                          <td class="col-md-2 col-sm-2 text-center">
                          
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Whiskey
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Jack Daniels
                          </td>
                          <td class="col-md-2 col-sm-2">
                                Size
                                Ice          
                          </td>
                          <td class="col-md-1 col-sm-1 text-center">
                                $15
                          </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <div class="pull-left editCloseBtn editCorrectBtn">
                                <a class="btn btn-small btn-flat"  href="javascript:;">
                                    <i class="fa fa-check"></i>
                                </a>
                                </div>
                                <div class="pull-left closeBtn editCloseBtn">
                                    <form id="frmAction" action="http://54.225.115.65/thirst/index.php/cmsAdmin/category/deleteCategory/cat_id/1" method="post" name="frmAction">
                                    <input class="btn btn-small btn-flat" type="submit" value="X" onclick="return confirm('Are you sure want to delete this category?');">
                                    </form>
                                </div>
                            </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <button class="btn btn-flat activeBtn">Active</button>
                            </td>            
                            
                          </tr>
                          
                        <tr>
                          <td class="col-md-2 col-sm-2 text-center">
                          
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Whiskey
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Jack Daniels
                          </td>
                          <td class="col-md-2 col-sm-2">
                                Size
                                Ice          
                          </td>
                          <td class="col-md-1 col-sm-1 text-center">
                                $15
                          </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <div class="pull-left editCloseBtn editCorrectBtn">
                                <a class="btn btn-small btn-flat"  href="javascript:;">
                                    <i class="fa fa-check"></i>
                                </a>
                                </div>
                                <div class="pull-left closeBtn editCloseBtn">
                                    <form id="frmAction" action="http://54.225.115.65/thirst/index.php/cmsAdmin/category/deleteCategory/cat_id/1" method="post" name="frmAction">
                                    <input class="btn btn-small btn-flat" type="submit" value="X" onclick="return confirm('Are you sure want to delete this category?');">
                                    </form>
                                </div>
                            </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <button class="btn btn-flat activeBtn">Active</button>
                            </td>            
                            
                          </tr>
                          
                        <tr>
                          <td class="col-md-2 col-sm-2 text-center">
                          
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Whiskey
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Jack Daniels
                          </td>
                          <td class="col-md-2 col-sm-2">
                                Size
                                Ice          
                          </td>
                          <td class="col-md-1 col-sm-1 text-center">
                                $15
                          </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <div class="pull-left editCloseBtn editCorrectBtn">
                                <a class="btn btn-small btn-flat"  href="javascript:;">
                                    <i class="fa fa-check"></i>
                                </a>
                                </div>
                                <div class="pull-left closeBtn editCloseBtn">
                                    <form id="frmAction" action="http://54.225.115.65/thirst/index.php/cmsAdmin/category/deleteCategory/cat_id/1" method="post" name="frmAction">
                                    <input class="btn btn-small btn-flat" type="submit" value="X" onclick="return confirm('Are you sure want to delete this category?');">
                                    </form>
                                </div>
                            </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <button class="btn btn-flat activeBtn">Active</button>
                            </td>            
                            
                          </tr>
                          
                        <tr>
                          <td class="col-md-2 col-sm-2 text-center">
                          
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Whiskey
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Jack Daniels
                          </td>
                          <td class="col-md-2 col-sm-2">
                                Size
                                Ice          
                          </td>
                          <td class="col-md-1 col-sm-1 text-center">
                                $15
                          </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <div class="pull-left editCloseBtn editCorrectBtn">
                                <a class="btn btn-small btn-flat"  href="javascript:;">
                                    <i class="fa fa-check"></i>
                                </a>
                                </div>
                                <div class="pull-left closeBtn editCloseBtn">
                                    <form id="frmAction" action="http://54.225.115.65/thirst/index.php/cmsAdmin/category/deleteCategory/cat_id/1" method="post" name="frmAction">
                                    <input class="btn btn-small btn-flat" type="submit" value="X" onclick="return confirm('Are you sure want to delete this category?');">
                                    </form>
                                </div>
                            </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <button class="btn btn-flat activeBtn">Active</button>
                            </td>            
                            
                          </tr>
                          
                        <tr>
                          <td class="col-md-2 col-sm-2 text-center">
                          
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Whiskey
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Jack Daniels
                          </td>
                          <td class="col-md-2 col-sm-2">
                                Size
                                Ice          
                          </td>
                          <td class="col-md-1 col-sm-1 text-center">
                                $15
                          </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <div class="pull-left editCloseBtn editCorrectBtn">
                                <a class="btn btn-small btn-flat"  href="javascript:;">
                                    <i class="fa fa-check"></i>
                                </a>
                                </div>
                                <div class="pull-left closeBtn editCloseBtn">
                                    <form id="frmAction" action="http://54.225.115.65/thirst/index.php/cmsAdmin/category/deleteCategory/cat_id/1" method="post" name="frmAction">
                                    <input class="btn btn-small btn-flat" type="submit" value="X" onclick="return confirm('Are you sure want to delete this category?');">
                                    </form>
                                </div>
                            </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <button class="btn btn-flat activeBtn">Active</button>
                            </td>            
                            
                          </tr>
                          
                        <tr>
                          <td class="col-md-2 col-sm-2 text-center">
                          
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Whiskey
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Jack Daniels
                          </td>
                          <td class="col-md-2 col-sm-2">
                                Size
                                Ice          
                          </td>
                          <td class="col-md-1 col-sm-1 text-center">
                                $15
                          </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <div class="pull-left editCloseBtn editCorrectBtn">
                                <a class="btn btn-small btn-flat"  href="javascript:;">
                                    <i class="fa fa-check"></i>
                                </a>
                                </div>
                                <div class="pull-left closeBtn editCloseBtn">
                                    <form id="frmAction" action="http://54.225.115.65/thirst/index.php/cmsAdmin/category/deleteCategory/cat_id/1" method="post" name="frmAction">
                                    <input class="btn btn-small btn-flat" type="submit" value="X" onclick="return confirm('Are you sure want to delete this category?');">
                                    </form>
                                </div>
                            </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <button class="btn btn-flat activeBtn">Active</button>
                            </td>            
                            
                          </tr>
                          
                        <tr>
                          <td class="col-md-2 col-sm-2 text-center">
                          
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Whiskey
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Jack Daniels
                          </td>
                          <td class="col-md-2 col-sm-2">
                                Size
                                Ice          
                          </td>
                          <td class="col-md-1 col-sm-1 text-center">
                                $15
                          </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <div class="pull-left editCloseBtn editCorrectBtn">
                                <a class="btn btn-small btn-flat"  href="javascript:;">
                                    <i class="fa fa-check"></i>
                                </a>
                                </div>
                                <div class="pull-left closeBtn editCloseBtn">
                                    <form id="frmAction" action="http://54.225.115.65/thirst/index.php/cmsAdmin/category/deleteCategory/cat_id/1" method="post" name="frmAction">
                                    <input class="btn btn-small btn-flat" type="submit" value="X" onclick="return confirm('Are you sure want to delete this category?');">
                                    </form>
                                </div>
                            </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <button class="btn btn-flat activeBtn">Active</button>
                            </td>            
                            
                          </tr>
                          
                        <tr>
                          <td class="col-md-2 col-sm-2 text-center">
                          
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Whiskey
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Jack Daniels
                          </td>
                          <td class="col-md-2 col-sm-2">
                                Size
                                Ice          
                          </td>
                          <td class="col-md-1 col-sm-1 text-center">
                                $15
                          </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <div class="pull-left editCloseBtn editCorrectBtn">
                                <a class="btn btn-small btn-flat"  href="javascript:;">
                                    <i class="fa fa-check"></i>
                                </a>
                                </div>
                                <div class="pull-left closeBtn editCloseBtn">
                                    <form id="frmAction" action="http://54.225.115.65/thirst/index.php/cmsAdmin/category/deleteCategory/cat_id/1" method="post" name="frmAction">
                                    <input class="btn btn-small btn-flat" type="submit" value="X" onclick="return confirm('Are you sure want to delete this category?');">
                                    </form>
                                </div>
                            </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <button class="btn btn-flat activeBtn">Active</button>
                            </td>            
                            
                          </tr>   
                          
                          <tr>
                          <td class="col-md-2 col-sm-2 text-center">
                          
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Whiskey
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Jack Daniels
                          </td>
                          <td class="col-md-2 col-sm-2">
                                Size
                                Ice          
                          </td>
                          <td class="col-md-1 col-sm-1 text-center">
                                $15
                          </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <div class="pull-left editCloseBtn editCorrectBtn">
                                <a class="btn btn-small btn-flat"  href="javascript:;">
                                    <i class="fa fa-check"></i>
                                </a>
                                </div>
                                <div class="pull-left closeBtn editCloseBtn">
                                    <form id="frmAction" action="http://54.225.115.65/thirst/index.php/cmsAdmin/category/deleteCategory/cat_id/1" method="post" name="frmAction">
                                    <input class="btn btn-small btn-flat" type="submit" value="X" onclick="return confirm('Are you sure want to delete this category?');">
                                    </form>
                                </div>
                            </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <button class="btn btn-flat activeBtn">Active</button>
                            </td>            
                            
                          </tr>   
                          
                          <tr>
                          <td class="col-md-2 col-sm-2 text-center">
                          
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Whiskey
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Jack Daniels
                          </td>
                          <td class="col-md-2 col-sm-2">
                                Size
                                Ice          
                          </td>
                          <td class="col-md-1 col-sm-1 text-center">
                                $15
                          </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <div class="pull-left editCloseBtn editCorrectBtn">
                                <a class="btn btn-small btn-success"  href="javascript:;">
                                    <i class="fa fa-check"></i>
                                </a>
                                </div>
                                <div class="pull-left closeBtn editCloseBtn">
                                    <form id="frmAction" action="http://54.225.115.65/thirst/index.php/cmsAdmin/category/deleteCategory/cat_id/1" method="post" name="frmAction">
                                    <input class="btn btn-small btn-danger" type="submit" value="X" onclick="return confirm('Are you sure want to delete this category?');">
                                    </form>
                                </div>
                            </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <button class="btn btn-flat activeBtn">Active</button>
                            </td>            
                            
                          </tr>   
                          
                          <tr>
                          <td class="col-md-2 col-sm-2 text-center">
                          
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Whiskey
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Jack Daniels
                          </td>
                          <td class="col-md-2 col-sm-2">
                                Size
                                Ice          
                          </td>
                          <td class="col-md-1 col-sm-1 text-center">
                                $15
                          </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <div class="pull-left editCloseBtn editCorrectBtn">
                                <a class="btn btn-small btn-flat"  href="javascript:;">
                                    <i class="fa fa-check"></i>
                                </a>
                                </div>
                                <div class="pull-left closeBtn editCloseBtn">
                                    <form id="frmAction" action="http://54.225.115.65/thirst/index.php/cmsAdmin/category/deleteCategory/cat_id/1" method="post" name="frmAction">
                                    <input class="btn btn-small btn-danger" type="submit" value="X" onclick="return confirm('Are you sure want to delete this category?');">
                                    </form>
                                </div>
                            </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <button class="btn btn-flat activeBtn">Active</button>
                            </td>            
                            
                          </tr>   
                          
                          <tr>
                          <td class="col-md-2 col-sm-2 text-center">
                          
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Whiskey
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Jack Daniels
                          </td>
                          <td class="col-md-2 col-sm-2">
                                Size
                                Ice          
                          </td>
                          <td class="col-md-1 col-sm-1 text-center">
                                $15
                          </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <div class="pull-left editCloseBtn editCorrectBtn">
                                <a class="btn btn-small btn-flat"  href="javascript:;">
                                    <i class="fa fa-check"></i>
                                </a>
                                </div>
                                <div class="pull-left closeBtn editCloseBtn">
                                    <form id="frmAction" action="http://54.225.115.65/thirst/index.php/cmsAdmin/category/deleteCategory/cat_id/1" method="post" name="frmAction">
                                    <input class="btn btn-small btn-flat" type="submit" value="X" onclick="return confirm('Are you sure want to delete this category?');">
                                    </form>
                                </div>
                            </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <button class="btn btn-flat activeBtn">Active</button>
                            </td>            
                            
                          </tr>   
                          
                          <tr>
                          <td class="col-md-2 col-sm-2 text-center">
                          
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Whiskey
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Jack Daniels
                          </td>
                          <td class="col-md-2 col-sm-2">
                                Size
                                Ice          
                          </td>
                          <td class="col-md-1 col-sm-1 text-center">
                                $15
                          </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <div class="pull-left editCloseBtn editCorrectBtn">
                                <a class="btn btn-small btn-flat"  href="javascript:;">
                                    <i class="fa fa-check"></i>
                                </a>
                                </div>
                                <div class="pull-left closeBtn editCloseBtn">
                                    <form id="frmAction" action="http://54.225.115.65/thirst/index.php/cmsAdmin/category/deleteCategory/cat_id/1" method="post" name="frmAction">
                                    <input class="btn btn-small btn-flat" type="submit" value="X" onclick="return confirm('Are you sure want to delete this category?');">
                                    </form>
                                </div>
                            </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <button class="btn btn-flat activeBtn">Active</button>
                            </td>            
                            
                          </tr>   
                          
                          <tr>
                          <td class="col-md-2 col-sm-2 text-center">
                          
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Whiskey
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Jack Daniels
                          </td>
                          <td class="col-md-2 col-sm-2">
                                Size
                                Ice          
                          </td>
                          <td class="col-md-1 col-sm-1 text-center">
                                $15
                          </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <div class="pull-left editCloseBtn editCorrectBtn">
                                <a class="btn btn-small btn-flat"  href="javascript:;">
                                    <i class="fa fa-check"></i>
                                </a>
                                </div>
                                <div class="pull-left closeBtn editCloseBtn">
                                    <form id="frmAction" action="http://54.225.115.65/thirst/index.php/cmsAdmin/category/deleteCategory/cat_id/1" method="post" name="frmAction">
                                    <input class="btn btn-small btn-flat" type="submit" value="X" onclick="return confirm('Are you sure want to delete this category?');">
                                    </form>
                                </div>
                            </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <button class="btn btn-flat activeBtn">Active</button>
                            </td>            
                            
                          </tr>   
                          
                          <tr>
                          <td class="col-md-2 col-sm-2 text-center">
                          
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Whiskey
                          </td>
                          <td class="col-md-2 col-sm-2">
                            Jack Daniels
                          </td>
                          <td class="col-md-2 col-sm-2">
                                Size
                                Ice          
                          </td>
                          <td class="col-md-1 col-sm-1 text-center">
                                $15
                          </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <div class="pull-left editCloseBtn editCorrectBtn">
                                <a class="btn btn-small btn-flat"  href="javascript:;">
                                    <i class="fa fa-check"></i>
                                </a>
                                </div>
                                <div class="pull-left closeBtn editCloseBtn">
                                    <form id="frmAction" action="http://54.225.115.65/thirst/index.php/cmsAdmin/category/deleteCategory/cat_id/1" method="post" name="frmAction">
                                    <input class="btn btn-small btn-flat" type="submit" value="X" onclick="return confirm('Are you sure want to delete this category?');">
                                    </form>
                                </div>
                            </td>
                            <td class="col-md-1 col-sm-1 text-center">
                                <button class="btn btn-flat activeBtn">Active</button>
                            </td>            
                            
                          </tr>              
                       
                          
                               
                          
                            
                      </tbody>
                     
                  </table>
                </div><!-- /.box-body -->
				</div>
            </div>
            </div>   
			</div><!-- /.tab-pane --> 

</div>             
              <?php
            }
            ?>
            
              
          <!-- /.tab-content -->
      </div><!-- nav-tabs-custom -->
    </div>
  </div>
  <!-- Right side content end -->
 </div>
 </div>
 
  <!-- Add Spirit Popup -->
    <div class="modal fade" id="addspirit-modal" tabindex="-1" role="dialog" aria-hidden="true">           
    </div><!-- /.modal -->

<script>
  function addspirit()
  {
    $.ajax({
      type: "POST",
      url:    "<?php echo $this->createUrl('cmsAdmin/AdminMenu/addspirit'); ?>",      
      success: function(data){
       //alert("data==>"+data);
           $("#addspirit-modal").html(data);
          }      
    });
  }
  
</script>    

</section><!-- /.content -->
