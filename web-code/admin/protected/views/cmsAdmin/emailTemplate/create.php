<?php
/* @var $this EmailTemplateController */
/* @var $model EmailTemplate */

$this->breadcrumbs=array(
	'Email Templates'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List EmailTemplate', 'url'=>array('index')),
	array('label'=>'Manage EmailTemplate', 'url'=>array('admin')),
);
?>

<div class="row">
	<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
       Create Email Templates
    </h1>
    <ol class="breadcrumb">
        <li><a href="javascript:void(0)"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Email Templates</li>
    </ol>
</section>
</div>
<?php $this->renderPartial('_form', array('model'=>$model)); ?>

