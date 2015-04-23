<?php
/* @var $this EmailTemplateController */
/* @var $model EmailTemplate */

$this->breadcrumbs=array(
	'Email Templates'=>array('index'),
	$model->email_temp_id,
);

$this->menu=array(
	array('label'=>'List EmailTemplate', 'url'=>array('index')),
	array('label'=>'Create EmailTemplate', 'url'=>array('create')),
	array('label'=>'Update EmailTemplate', 'url'=>array('update', 'id'=>$model->email_temp_id)),
	array('label'=>'Delete EmailTemplate', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->email_temp_id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage EmailTemplate', 'url'=>array('admin')),
);
?>

<h1>View EmailTemplate #<?php echo $model->email_temp_id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'email_temp_id',
		'subject',
		'contect',
		'status',
	),
)); ?>
