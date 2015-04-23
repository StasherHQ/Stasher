<style>
  .drinkModifiers
  {  
    margin-bottom: 10px;
    width: 100%;
    float: left;
  }
  .drinkModifiers span
  {
    float: left;
    width: 40%;
  }
  .drinkModifiers .modifierName
  {
    float: left;
    width: 60%;
  }
</style>
<div class="table-responsive">
  <table id="<?php echo $tableId?>" class="table table-bordered table-striped menuTable">
      <thead>
          <tr>
            <!-- If any column added here.. Remember to add it to thefooter also and  $colspan variable -->              
              <th class="col-md-1 col-sm-1 text-center">Type</th>
              <th class="col-md-1 col-sm-1 text-center">No.</th>
              <th class="col-md-2 col-sm-2">Name</th>
              <th class="col-md-5 col-sm-5">Description</th>
              <th class="col-md-3 col-sm-3">Modifiers</th>
              <th class="col-md-3 col-sm-3">Status</th>
              <th class="col-md-1 col-sm-1 text-center">Action</th>
          </tr>
      </thead>
      <tbody>
        <?php
        $colspan = 7;
        if(!empty($menu_list))
        {
         $i = 1;
         foreach($menu_list as $item)
         { 
          ?>
          <tr>
            
            <td class="col-md-1 col-sm-1 text-center"> <?php
            if($item->type_id == 1) echo '<i class="fa fa-glass" data-toggle="tooltip" title="Drink">';
            else if($item->type_id == 2) echo '<i class="fa fa-flask" data-toggle="tooltip" title="Mixer.">';
            else if($item->type_id == 3) echo '<i class="fa fa-cutlery" data-toggle="tooltip" title="Food.">';
            ?>
            </td>
            <td class="col-md-1 col-sm-1 text-center"><?php echo $i; $i++; ?></td>
            <td class="col-md-2 col-sm-2"><?php echo $item->item_name;?></td>
            <td class="col-md-5 col-sm-5">
                <?php  echo "<b>Description :</b>".$item->description;
                echo "<br/>";?>
                <?php
                if($item->type_id == 1) //Drink
                {
                  if($item->description != '')
                    echo "<br/>";
                  echo "<b>Category :</b>".$item->cat_name;
                  echo "<br/><b>Brand :</b>".$item->brand_name;
                }
                elseif($item->type_id == 2) //Mixer
                {
                  if($item->description != '')
                   echo "<br/>";
                  echo "<b> Applicable Categories:</b>";
                  $selected_cat = $venuemenuModel->getMixerItemCategory($item->item_id);
                  $i = 0;
                  if(!empty($selected_cat))
                  {                   
                    foreach($selected_cat  as $cat)
                    {
                      $i++;
                      echo $cat->cat_name;
                      if(count($selected_cat) != $i)
                      echo ",";                     
                    }
                  }
                }
                ?>
            </td>
            
           
            <td class="col-md-3 col-sm-3">            
                <?php
                if($item->type_id == 2 || $item->type_id == 3 )
                {
                  echo "N/A";
                }
                else
                {
                      $modifier_type = $menuModel->get_modifier_type_list($item->item_id);
                      if(!empty($modifier_type))
                      {
                       //  echo "<div>";
                          foreach($modifier_type as $mtype)
                          {
                            echo "<div class='drinkModifiers'><span><b>".$mtype->name."</b> - </span>";
                            
                             $modifiers = $menuModel->menu_item_modifiers($item->item_id,$mtype->modifier_type_id);
                                if(!empty($modifiers)){
                                  echo "<div class='modifierName'>";
                                    foreach($modifiers as $mname)
                                    {                                     
                                      if($mname->is_default == '1')
                                        echo "<strong>".$mname->name."</strong><br/>";
                                      else
                                        echo $mname->name."<br/>";                                       
                                    }
                                    echo "</div>";
                                }
                                   echo "</div>";
                          }                          
                         echo "<br/>";
                      }
                }
                  ?>                  
           </td>
            <td class="col-md-2 col-sm-2"><?php echo ucwords($item->item_status);?></td>
            <td class="col-md-1 col-sm-1 text-center">
              <a href="javascript:void(0);" onclick="editMasterVenueItem('<?php echo $item->item_id; ?>')" class="btn btn-flat">
                 <i class="fa fa-edit" data-toggle="tooltip" title="Click here to edit this item."></i>
              </a>              
            </td>            
            
          </tr>
          <?php
         }
         //Add jquery pagination code                              
         ?>                               
          <script type="text/javascript">
             $(function()
               {                 
                 $('#<?php echo $tableId?>').dataTable({                 
                     "bPaginate": true,
                     "bLengthChange": false,
                     "bFilter": false,
                     "bSort": true,
                     "bInfo": true,
                     "bAutoWidth": false,
                     "iDisplayLength" : 50
                 });
             });
         </script>
         <?php
        }
        else
        {
          ?>
          <tr>
            <td colspan="<?php echo $colspan; ?>">
              No Records Found
            </td>
          </tr>
          <?
        }
        ?>
      </tbody>      
  </table>
</div><!-- /.box-body -->