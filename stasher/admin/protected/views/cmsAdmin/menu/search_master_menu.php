     <div class="row">
    <div class="sticky">
      <div class="box box-primary orderSearch">
        <!-- form start -->
       
        <form role="form" action="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/AdminMenu" method="post" id="frmsearch_all">
            <div class="row">        
              <div class="col-md-8 col-sm-8"> 
                 <div class="row">       
                    <div class="col-md-4 col-sm-4">
                       <h4 class="searchBarTitle">Search</h4> 
                        <div class="searchBox">
                          <input type="text" class="form-control" name="search_txt" value="<?php if(!empty($search_txt)) echo stripslashes($search_txt); ?>" id="search_txt" onkeypress="searchKeyPress(event,'search_menu','all');remove_error_class('search_txt');" onfocus ="remove_error_class('search_txt');" placeholder="Search!">                  
                        </div>
                    </div>                         
            
                  <div class="col-md-4 col-sm-4">
                    <h4 class="searchBarTitle">Filters</h4>  
                      <div class="selectOrderSearch">     
                           <select class="form-control" name="category" id="category">
                                 <option value="">Spirit Type</option>
                                 <?php if(isset($category_names)){
                                          foreach($category_names as $catname){ ?>
                                            <option value="<?php echo $catname->cat_name ?>" <?php if($search_category == $catname->cat_name){ echo "selected='selected'"; } ?>><?php echo $catname->cat_name ?></option>                             
                                  <?php        }
                                  } ?>                           
                          </select>
                      </div>     
                  </div>
               
                  <div class="col-md-4 col-sm-4">
                      <h4 class="searchBarTitle"></h4>
                      <div class="selectOrderSearch">     
                           <select class="form-control" name="brand" id="brand">
                                 <option value="">Choose Brand</option>
                                 <?php if(isset($brand_names)){
                                          foreach($brand_names as $brandname){ ?>
                                            <option value="<?php echo $brandname->brand_name ?>" <?php if($search_brand == $brandname->brand_name){ echo "selected='selected'"; } ?>><?php echo $brandname->brand_name ?></option>                             
                                  <?php        }
                                  } ?>                          
                          </select>
                      </div>                    	
                 </div>
              
                </div>    
              </div>
            
             <div class="col-md-4 col-sm-4">
                <div class="row">  
                    <div class="col-md-4 col-sm-4 goBtn">  
                      <button class="btn btn-primary btn-flat" type="button" onclick="search_menu('all'); return false;">Go!</button>
                       <input type="hidden" name="active_tab" id="activemenu_all" value="" />
                    </div>
                    
                    <div class="col-md-8 col-sm-8">
                        <h4 class="searchBarTitle"></h4>  	
                           <a class="btn btn-primary btn-flat createSpirit col-md-12 col-sm-12" data-toggle="modal" data-target="#addmenuitem-modal" onclick="addmenuitem()"><i class="fa fa-pencil"></i> Add New Menu Item</a>                   
                   </div>
                </div>  
             </div>    
             
          </div> 
        </form>
        </div>  
      </div> 
    </div> 