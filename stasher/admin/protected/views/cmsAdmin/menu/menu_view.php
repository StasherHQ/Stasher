<!--- JS FILE with the common function -->
<script src="<?php echo Yii::app()->request->baseUrl; ?>/js/custom/menuFunction.js"></script>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        Master Menu Panel
        <small>Control panel</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/dashboard"> Dashboard</a></li>
        <li class="active"><span>Menu</span></li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="menuDrinksContainer">
  <!-- Left side content start -->
  
  <!-- Left side content end -->
  <!-- Right side content start -->
  <div class="menuDrinksContainer">
  
    <div class="box box-primary" >
      <div class="nav-tabs-custom">
          <ul class="nav nav-tabs stickyTab">
             <li class="<?php if($menu_all == '1'){ echo "active";} ?>" id="all"><a href="#tab_all" data-toggle="tab">All</a></li>
            <?php
            //Get li from database
            foreach($item_type as $it_type)
            {  
              ?>
               <li class="<?php if($menutab == $it_type->type_name){ echo "active";} ?>" id="<?php echo $it_type->type_name;?>"><a href="#tab_<?php echo $it_type->type_id?>" data-toggle="tab"><?php echo $it_type->type_name;?></a></li>
              <?php
            }
            ?>                                
          </ul>
          
            
          <div class="tab-content col-md-12 col-sm-12 drinkTabContent">
              <div class="tab-pane <?php if($menu_all == '1'){ echo "active";} ?>" id="tab_all">
                    <?php
                     $data['category_names'] = $category_names;
                     $data['search_txt'] = $search_txt;
                     $data['brand_names'] = $brand_names;
                     $data['search_category'] = $search_category;
                     $data['search_brand'] = $search_brand;     
                     echo $this->renderPartial('cmsAdmin/menu/search_master_menu',$data);                            
                    ?>
              
                <div class="col-md-12 col-sm-12 rightSide" id="">
                  <div class="row">
                    <?php
                      $data['venuemenuModel'] =  $venuemenuModel;
                       $data['menuModel'] = $menuModel;
                      $data['menu_list'] = $all_menu_list;
                      $data['tableId'] = 'all_menue_list';                   
                      echo $this->renderPartial('cmsAdmin/menu/menu_table_list_view',$data);                            
                    ?>
                  </div>
                </div>               
          </div>
            
            
            <?php
            //Get li from database
            foreach($item_type as $it_type)
            {  
              ?>
              <div class="tab-pane <?php if($menutab == $it_type->type_name){ echo "active";} ?>" id="tab_<?php echo $it_type->type_id?>">
                 <?php
                     $data['category_names'] = $category_names;
                     $data['search_txt'] = $search_txt;
                     $data['brand_names'] = $brand_names;
                     $data['search_category'] = $search_category;
                     $data['search_brand'] = $search_brand;     
                     echo $this->renderPartial('cmsAdmin/menu/search_master_menu',$data);                            
                  ?>
                  
                  <div class="col-md-12 col-sm-12 rightSide" id="">
                    <div class="row">                  
                    <?php if($it_type->type_name == 'Drinks'){                     
                              $data['venuemenuModel'] =  $venuemenuModel;
                              $data['menuModel'] = $menuModel;
                              $data['menu_list'] = $drinks_menu_list;
                              $data['tableId'] = 'drinks_menue_list';                   
                              echo $this->renderPartial('cmsAdmin/menu/menu_table_list_view',$data); 
                          }
                          else if($it_type->type_name == 'Mixers'){
                            $data['venuemenuModel'] =  $venuemenuModel;
                              $data['menuModel'] = $menuModel;
                              $data['menu_list'] = $mixers_menu_list;
                              $data['tableId'] = 'mixers_menue_list';                   
                              echo $this->renderPartial('cmsAdmin/menu/menu_table_list_view',$data); 
                          }
                          else if($it_type->type_name == 'Food'){
                            $data['venuemenuModel'] =  $venuemenuModel;
                              $data['menuModel'] = $menuModel;
                              $data['menu_list'] = $food_menu_list;
                              $data['tableId'] = 'food_menue_list';                   
                              echo $this->renderPartial('cmsAdmin/menu/menu_table_list_view',$data); 
                          }
                     ?>
                    </div>
                  </div>
                
              </div><!-- /.tab-pane -->              
              <?php
            }
            ?>
              
          </div><!-- /.tab-content -->
           
           </div><!-- nav-tabs-custom -->
    </div>
  </div>
  <!-- Right side content end -->
  
    <!-- ADD NEW DRINK MODAL -->
    <div class="modal fade" id="addmenuitem-modal" tabindex="-1" role="dialog" aria-hidden="true"></div>
    <!-- /.modal -->
 </div>  

</section><!-- /.content -->
 <!-- DATA TABES SCRIPT -->
<script src="<?php echo Yii::app()->request->baseUrl; ?>/js/plugins/datatables/jquery.dataTables.js" type="text/javascript"></script>
<script src="<?php echo Yii::app()->request->baseUrl; ?>/js/plugins/datatables/dataTables.bootstrap.js" type="text/javascript"></script>

 
  <div class="flash-success" id="menuFlash" style="display: none;z-index:20000" >
  <?php
  //this code not is use yet
  if(Yii::app()->user->getFlash('item'))
    echo Yii::app()->user->getFlash('item');
  ?>
  </div>

