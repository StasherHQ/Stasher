<div class="col-md-12 col-sm-12 table-bordered"> 	 
	<div class="col-md-7 col-sm-7 spiritType padding_bottom_10">
			 <h5>Select Brand <i class="fa fa-question-circle" data-toggle="tooltip" title="Select Category/Subcategory to get the brand list"></i></h5> 			 
			 <select name="brand_id" id="brand_id" onchange="remove_error_class('brand_id');">
					<option value="0">Select Brand</option>
					<?php
					if(!empty($brandList))
					{
						foreach($brandList as $brand)
						{
							?>
							<option value="<?php echo $brand->brand_id?>"><?php echo $brand->brand_name?></option>
							<?
						}
					}
					?>
			 </select>			 
	</div>
	<!--<label class="text-yellow">If you dont want to select any brand please select 'No Brand'</label>-->
	<!-- <div class="col-md-5 col-sm-5 notFoundBtn">	
		<div class="row">     
			<span class="pull-right">not found
			  <i class="fa fa-question-circle"></i>
			</span>
			<button class="btn btn-primary pull-right requestthirstBtn">Add</button>
		</div>    
	</div> -->     
</div>