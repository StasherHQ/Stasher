<table id="chart_list" class="table table-bordered table-striped menuTable">
    <tbody>
    <tr><td><a onclick="showReport('total_transaction')">Total # Transactions</a></td></tr>
    <tr><td><a onclick="showReport('total_sales')">Total $ Sales</a></td></tr>
    <tr><td><a onclick="showReport('total_tip')">Total $ Tips</a></td></tr>
    <tr><td><a onclick="showReport('total_sales_tax')">Total $ Sales Tax Collected</a></td></tr>
    <tr><td><a onclick="showReport('Average_Item')">Average # of items per transaction</a></td></tr>
    <tr><td><a href="<?php echo $this->createUrl('cmsAdmin/reports',array('type'=>'tot_transaction')); ?>"># unique guests</a></td></tr>
    <tr><td><a onclick="showReport('orders_confirmed')" ># of orders confirmed</a></td></tr>
    <tr><td><a onclick="showReport('orders_modified')"># of orders modified</a></td></tr>
    <tr><td><a onclick="showReport('orders_cancelled')"># of orders cancelled</a></td></tr>
    <tr><td><a onclick="showReport('wait_per_transaction')">Average wait time per transaction</a></td></tr>
    <tr><td><a onclick="showReport('gifted_drink_redem')"># Gifted Drink Redeemed</a></td></tr>
    <tr><td><a href="<?php echo $this->createUrl('cmsAdmin/reports',array('type'=>'tot_transaction')); ?>">Total amount of gifted drinks sales</a></td></tr>
    <tr><td><a href="<?php echo $this->createUrl('cmsAdmin/reports',array('type'=>'tot_transaction')); ?>">Total amount made on upsells</a></td></tr>
    <tr><td><a href="<?php echo $this->createUrl('cmsAdmin/reports',array('type'=>'tot_transaction')); ?>">Most popular drinks</a></td></tr>
    <tr><td><a href="<?php echo $this->createUrl('cmsAdmin/reports',array('type'=>'tot_transaction')); ?>">Most popular brands</a></td></tr>
    <tr><td><a href="<?php echo $this->createUrl('cmsAdmin/reports',array('type'=>'tot_transaction')); ?>"># Users in venue</a></td></tr>
    <tr><td><a href="<?php echo $this->createUrl('cmsAdmin/reports',array('type'=>'tot_transaction')); ?>">Drink order placed from what sections of the menu</a></td></tr>
  </tbody>
</table>