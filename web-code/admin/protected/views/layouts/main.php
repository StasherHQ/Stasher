<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Stasher</title>
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
        <!-- jQuery 2.0.2 -->
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
        <!-- Bootstrap -->       
        <script src="<?php echo Yii::app()->request->baseUrl; ?>/assets/js/bootstrap.js" type="text/javascript"></script>
        <!-- AdminLTE App -->
       
    </head>
    <body class="skin-blue">
        <!-- header logo: style can be found in header.less -->
        <div class="container-fluid">
        	<div class="wrapper row-offcanvas row-offcanvas-left">
            <!-- Left side column. contains the logo and sidebar -->
            <aside class="left-side sidebar-offcanvas">                
                <!-- sidebar: style can be found in sidebar.less -->
                <section class="sidebar">
                    <!-- Sidebar user panel -->                                   
                    <!-- sidebar menu: : style can be found in sidebar.less -->
                    <ul class="sidebar-menu stasherMenu">
                        <li class="active">
                            <a href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/user">
                                <img src="<?php echo Yii::app()->request->baseUrl; ?>/assets/images/manageUsers.svg" /> <span>Manage users</span>
                            </a>
                        </li>   
                        <li class="">
                            <a href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/reports">
                                <img src="<?php echo Yii::app()->request->baseUrl; ?>/assets/images/reports.svg" /> <span>View reports</span>
                            </a>
                        </li> 
                        <li class="">
                            <a href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/login/logout">
                                <img src="<?php echo Yii::app()->request->baseUrl; ?>/assets/images/logout.svg" /> <span>Logout</span>
                            </a>
                        </li>                     
                    </ul>
                    
                </section>
                <!-- /.sidebar -->
                <a class="sidebarLogo" href="#"><img src="<?php echo Yii::app()->request->baseUrl; ?>/assets/images/logo.svg"/></a>
            </aside>

            <!-- Right side column. Contains the navbar and content of the page -->
            <aside class="right-side">                
           <?php echo $content; ?>  
            </aside><!-- /.right-side -->
        </div>
        </div>
        <!-- ./wrapper -->


        
    </body>
</html>
