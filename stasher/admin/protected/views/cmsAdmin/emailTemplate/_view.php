<?php
/* @var $this EmailTemplateController */
/* @var $data EmailTemplate */
?>

<div class="col-md-12 col-sm-12">
		<div class="box box-solid col-md-12 col-sm-12 emailTemplates">
				<div class="box-header">
						<!--<i class="fa fa-envelope"></i>-->
						<h3 class="box-title"><?php echo CHtml::encode($data->subject); ?></h3>
				</div><!-- /.box-header -->
				<div class="box-body">
						<dl class="dl-horizontal">
								<dt><?php echo CHtml::encode($data->getAttributeLabel('email_temp_id')); ?>:</dt>
								<dd><?php echo CHtml::link(CHtml::encode($data->email_temp_id), array('view', 'id'=>$data->email_temp_id)); ?></dd>
								
								<dt><?php echo CHtml::encode($data->getAttributeLabel('subject')); ?>:</dt>
								<dd><?php echo CHtml::encode($data->subject); ?></dd>
								
								<dt><?php echo CHtml::encode($data->getAttributeLabel('contect')); ?>:</dt>
								<dd><?php echo $data->contect; ?></dd>
								
								<dt><?php echo CHtml::encode($data->getAttributeLabel('status')); ?>:</dt>
								<dd><?php echo CHtml::encode($data->status); ?></dd>
						</dl>
				</div><!-- /.box-body -->
		</div><!-- /.box -->
</div>