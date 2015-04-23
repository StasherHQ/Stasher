<?php
/* @var $this EmailTemplateController */
/* @var $model EmailTemplate */
/* @var $form CActiveForm */
?>

<div class="wide form col-md-12 col-sm-12">

<?php $form=$this->beginWidget('CActiveForm', array(
	'action'=>Yii::app()->createUrl($this->route),
	'method'=>'get',
)); ?>

	<div class="col-md-12 col-sm-12 form-group">
        <div class="row">
            <?php echo $form->label($model,'email_temp_id'); ?>
            <?php echo $form->textField($model,'email_temp_id'); ?>
        </div>
    </div>    
    
    <div class="col-md-12 col-sm-12 form-group">
        <div class="row">
            <?php echo $form->label($model,'subject'); ?>
            <?php echo $form->textField($model,'subject',array('size'=>60,'maxlength'=>255)); ?>
        </div>
    </div>
    
    <div class="col-md-12 col-sm-12 form-group">
        <div class="row">
            <?php echo $form->label($model,'contect'); ?>
            <?php echo $form->textArea($model,'contect',array('rows'=>6, 'cols'=>58)); ?>
        </div>
    </div>
    
    <div class="col-md-12 col-sm-12 form-group">
        <div class="row">
            <?php echo $form->label($model,'status'); ?>
            <?php echo $form->textField($model,'status',array('size'=>8,'maxlength'=>8)); ?>
        </div>
    </div>
    
    <div class="col-md-12 col-sm-12 emailTemplateSearchBtn form-group">
        <div class="row buttons">
            <?php echo CHtml::submitButton('Search'); ?>
        </div>
	</div>
    
<?php $this->endWidget(); ?>

</div><!-- search-form -->