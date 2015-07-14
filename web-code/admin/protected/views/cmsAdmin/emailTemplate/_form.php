<?php
/* @var $this EmailTemplateController */
/* @var $model EmailTemplate */
/* @var $form CActiveForm */
?>


<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'email-template-form',
	// Please note: When you enable ajax validation, make sure the corresponding
	// controller action is handling ajax validation correctly.
	// There is a call to performAjaxValidation() commented in generated controller code.
	// See class documentation of CActiveForm for details on this.
	'enableAjaxValidation'=>false,
)); ?>
<div class="col-md-12 col-sm-12 emailTemplateForm">
	<!--<p class="note">Fields with <span class="required">*</span> are required.</p>-->

	<?php echo $form->errorSummary($model); ?>
	
    <div class="col-md-12 col-sm-12 createTemplateSub form-group">
        <div class="row">
            <?php echo $form->labelEx($model,'subject'); ?>
            <?php echo $form->textField($model,'subject',array('size'=>59,'maxlength'=>255)); ?>
            <?php echo $form->error($model,'subject'); ?>
        </div>
    </div>
	<div class="col-md-12 col-sm-12 form-group">
        <div class="row">
            <?php echo $form->labelEx($model,'contect'); ?>
            <?php echo $form->textArea($model,'contect',array('rows'=>6, 'cols'=>59)); ?>
            <?php echo $form->error($model,'contect'); ?>
        </div>
    </div>
        
	<div class="col-md-12 col-sm-12 createTemplateStatus form-group">
        <div class="row">
            <?php echo $form->labelEx($model,'status'); ?>
            <?php echo $form->textField($model,'status',array('size'=>8,'maxlength'=>8)); ?>
            <?php echo $form->error($model,'status'); ?>
        </div>
    </div>

	<div class="col-md-12 col-sm-12 createTemplateCreateBtn">
        <div class="row buttons text-center">
            <?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
        </div>	
    </div>
</div>
<?php $this->endWidget(); ?>

<!-- form -->