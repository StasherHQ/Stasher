<div class="col-md-7 col-sm-7 spiritType">
	<h5>Sub-Category</h5>
	<select name="sub_category_id" id="sub_category_id" onchange="loadBrandList();">
	 <option value="0">Select Sub Category</option>
	 <?php
	 if(!empty($subcategory_list))
	 {
		 foreach($subcategory_list as $cat)
		 {
			 ?>
			 <option value="<?php echo $cat->category_id;?>"><?php echo $cat->cat_name;?></option>
			 <?
		 }
	 }
	 ?>
	</select>
</div>   