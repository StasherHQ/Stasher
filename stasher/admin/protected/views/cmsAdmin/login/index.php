<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title><?php echo CHtml::encode($this->pageTitle); ?></title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <!-- bootstrap 3.0.2 -->
        <link href="<?php echo Yii::app()->request->baseUrl; ?>/assets/css/bootstrap.css" rel="stylesheet" type="text/css" />
        <!-- font Awesome -->
        <link href="<?php echo Yii::app()->request->baseUrl; ?>/assets/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- Ionicons -->
        <link href="<?php echo Yii::app()->request->baseUrl; ?>/assets/css/ionicons.min.css" rel="stylesheet" type="text/css" />
        <!-- Theme style -->
        <link href="<?php echo Yii::app()->request->baseUrl; ?>/assets/css/AdminLTE.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/assets/css/custom.css" />        

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
    	<div class="container-fluid loginBg">
    		<div class="container">
    			<div class="loginOuter text-center">
                	<img src="<?php echo Yii::app()->request->baseUrl; ?>/assets/images/logo.svg">
                    <span>CONTENT MANAGEMENT SYSTEM</span>
                    <div class="loginDetails">
  <form action="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/login/loginaction" method="POST" id="loginForm">
                    	<input type="text" placeholder="Username" name="loginForm_email_id"/>
                        <input type="password" placeholder="Password" name="loginForm_password"/>
                        <button class="btn btn-block" name="loginForm_submit">Login</button>
</form> 
                    </div>
                </div>
            </div>
       	</div>
        
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
        <!-- Bootstrap -->       
        <script src="<?php echo Yii::app()->request->baseUrl; ?>/assets/js/bootstrap.js" type="text/javascript"></script>
        <!-- AdminLTE App -->
        

    </body>
</html>
