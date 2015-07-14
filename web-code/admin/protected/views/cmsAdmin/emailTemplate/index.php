<?php
/* @var $this EmailTemplateController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Email Templates',
);

$this->menu=array(
	array('label'=>'Create EmailTemplate', 'url'=>array('create')),
	array('label'=>'Manage EmailTemplate', 'url'=>array('admin')),
);
?>
<div class="row">
	
    <!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        Email Templates
    </h1>
    <ol class="breadcrumb">
        <li><a href="javascript:void(0)"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Email Templates</li>
    </ol>
</section>
</div>
	<?php $this->widget('zii.widgets.CListView', array(
		'dataProvider'=>$dataProvider,
		'itemView'=>'_view',
	)); ?>
