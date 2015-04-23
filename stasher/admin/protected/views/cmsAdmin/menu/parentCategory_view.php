 <?php
 if($type_id == 1)
 {
 ?>
 <h5>Select Category</h5>
	<select name="category_id" id="category_id" onchange="loadSubCat(); loadBrandList(); loadModiferList();">
	 <option value="0">Select Category</option>
	 <?php
	 if(!empty($category_list))
	 {
		 foreach($category_list as $cat)
		 {
			 ?>
			 <option value="<?php echo $cat->category_id;?>" <?php if(!empty($item_info)) { if($item_info->parent_cat_id == $cat->category_id) echo 'selected="selected"'; } ?> ><?php echo $cat->cat_name;?></option>
			 <?
		 }
	 }
	 ?>
	</select>
	<?php
 }
 elseif($type_id == 2 )
 {
	?>
	<h5>Applicable Categories: <i class="fa fa-question-circle" data-toggle="tooltip" title="Select multiple categories with whom you like to serve this mixer."></i> </h5>
	<select class="col-md-12" name="category_id" id="category_id" onchange="remove_error_class('category_id');" multiple data-rel="chosen"  data-placeholder="Choose Categories">
	 
	 <?php
	 if(!empty($category_list))
	 {
		 foreach($category_list as $cat)
		 {
			 ?>
			 <option value="<?php echo $cat->category_id;?>"
			 <?php if(isset($sel_category)) {  if(in_array($cat->category_id, $sel_category)) { echo 'selected = "selected"'; } }?>
														><?php echo $cat->cat_name;?></option>
			 <?
		 }
	 }
	 ?>
	</select>
	<?php
 }?>