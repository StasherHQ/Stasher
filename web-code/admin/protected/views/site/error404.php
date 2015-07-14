<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title><?php echo CHtml::encode($this->pageTitle); ?></title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <!-- bootstrap 3.0.2 -->
        <link href="<?php echo Yii::app()->request->baseUrl; ?>/css/bootstrap.min.css" rel="stylesheet" type="text/css" media="screen, projection"/>
        <!-- font Awesome -->
        <link href="<?php echo Yii::app()->request->baseUrl; ?>/css/font-awesome.min.css" rel="stylesheet" type="text/css" media="screen, projection"/>
        <!-- Ionicons -->
        <link href="<?php echo Yii::app()->request->baseUrl; ?>/css/ionicons.min.css" rel="stylesheet" type="text/css" media="screen, projection"/>
        <!-- Morris chart -->
        <?php /* <link href="<?php echo Yii::app()->request->baseUrl; ?>/css/morris/morris.css" rel="stylesheet" type="text/css" media="screen, projection"/> 
        <!-- jvectormap -->
        <link href="<?php echo Yii::app()->request->baseUrl; ?>/css/jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" media="screen, projection"/> */ ?>
        <!-- fullCalendar -->
        <link href="<?php echo Yii::app()->request->baseUrl; ?>/css/fullcalendar/fullcalendar.css" rel="stylesheet" type="text/css" media="screen, projection"/>
        <!-- Daterange picker -->
        <link href="<?php echo Yii::app()->request->baseUrl; ?>/css/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" media="screen, projection"/>
				<link href="<?php echo Yii::app()->request->baseUrl; ?>/css/date-time.css" rel="stylesheet" type="text/css" />				
        <!-- bootstrap wysihtml5 - text editor -->
        <link href="<?php echo Yii::app()->request->baseUrl; ?>/css/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" media="screen, projection"/>
        <!-- Theme style -->
        <link href="<?php echo Yii::app()->request->baseUrl; ?>/css/AdminLTE.css" rel="stylesheet" type="text/css" />
				<!-- Custom style CSS-->
				<link href="<?php echo Yii::app()->request->baseUrl; ?>/css/thirst_cutom_style.css" rel="stylesheet" type="text/css" />
        
         <!-- chosen for multiple select box -->
        <link href="<?php echo Yii::app()->request->baseUrl; ?>/css/chosen/chosen.css" rel="stylesheet" type="text/css" />
        
        <!--switch css-->
        <link href="<?php echo Yii::app()->request->baseUrl; ?>/css/bootstrap-switch.css" rel="stylesheet" type="text/css" />
       
         <!-- jQuery 1.11.0 -->
        <script src="<?php echo Yii::app()->request->baseUrl; ?>/js/jquery-1.11.0.min.js"></script>
        <script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
        
        <script src="<?php echo Yii::app()->request->baseUrl; ?>/js/jquery-ui-timepicker-addon.js"></script>

        <!--For ajax image upload-->
        <script src="<?php echo Yii::app()->request->baseUrl; ?>/js/ajaxupload.js"></script>
        
        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->
        
        <script type="text/javascript">
            var BASE_URL = '<?php echo Yii::app()->request->baseUrl.'/index.php/'; ?>';
            var SITE_URL = '<?php echo Yii::app()->request->baseUrl; ?>'; //URL FOR THE IMAGES AND JS
    </script>
    </head>
    <body class="skin-black fixed">
        <!-- header logo: style can be found in header.less -->
        <header class="header">
            <a href="<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/dashboard" class="logo">
                <!-- Add the class icon to your logo image or logo icon to add the margining -->
                <?php  // echo CHtml::encode(Yii::app()->name); ?>
                <img src= "<?php echo Yii::app()->request->baseUrl; ?>/img/logo.png" />
            </a>
            <!-- Header Navbar: style can be found in header.less -->
            <nav class="navbar navbar-static-top" role="navigation">
                <!-- Sidebar toggle button-->
                <a href="#" class="navbar-btn sidebar-toggle" data-toggle="offcanvas" role="button">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <!--  Right Side Admin Info -->
           <?php
           if(!(Yii::app()->session['admin_id'] == '' &&  Yii::app()->session['admin_name'] == ''))
            {
             ?>
            <div class="navbar-right">
                    <ul class="nav navbar-nav">
                        <!----   MESSAGE NOTOFICAION ---->
                        <!-- User Account: style can be found in dropdown.less -->
                        <li class="dropdown user user-menu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="glyphicon glyphicon-user"></i>
                                <span>
                                  <?php  echo ucwords(Yii::app()->session['admin_name'] );     ?>
                                  <i class="caret"></i></span>
                            </a>
                            <ul class="dropdown-menu">
                                <!-- User image -->
                                <li class="user-header bg-light-blue">
                                  <?php
                                                      $img_abs_path = Yii::app()->request->baseUrl.'/img/avatar3.png';				
                                                      if(Yii::app()->session['profile_pic'] != '')
                                                      {
                                                        $img_abs_path = Yii::app()->request->baseUrl.'/uploads/'.Yii::app()->session['profile_pic'];
                                                      } 
                                                    ?>
                                            <img src="<?php echo $img_abs_path; ?>" class="img-circle" alt="User Image" />
                                    <p>
                                       <?php  echo ucwords(Yii::app()->session['admin_name'] );?>  -
                                       
                                       <?php echo CHtml::encode(Yii::app()->name); ?> 
                                       <?php  if(Yii::app()->session['admin_type'] == 'super_admin')
                                                echo 'Super Admin';
                                              if(Yii::app()->session['admin_type'] == 'admin')
                                                echo 'Admin';
                                              if(Yii::app()->session['admin_type'] == 'venue_manager')
                                                echo 'Venue Manager';   ?>
                                       
                                        <!--<small>Admin Since 2014</small>-->
                                    </p>
                                </li>
                                <!-- Menu Body -->
                                
                                <!-- Menu Footer-->
                                <li class="user-footer">
                                    <div class="pull-left">
                                        <a href="<?php echo Yii::app()->createAbsoluteUrl('/cmsAdmin/admin/profile', array('id' => Yii::app()->session['admin_id'])); ?>" class="btn btn-default btn-flat">Profile</a>
                                    </div>
                                    <div class="pull-right">
                                        <a href="<?php echo Yii::app()->request->baseUrl;?>/cmsAdmin/login/logout" class="btn btn-default btn-flat">Sign out</a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            <?php
            }
            else
            {
              ?>
              <div class="navbar-right">
                  <a href="<?php echo Yii::app()->request->baseUrl;?>/cmsAdmin/login/" class="btn outerLoginBtn">
                      <i class="fa fa-user"></i> Login
                  </a>
              </div>
              <?php
            }
            ?>
            <!--  Right Side Admin Info -->
            </nav>
        </header>
        
        <?php if(isset(Yii::app()->session['activetab']) && !empty(Yii::app()->session['activetab'])){  $activetab = Yii::app()->session['activetab'];}else { $activetab = ''; } ?>
        
        <div class="wrapper row-offcanvas row-offcanvas-left">
            <!-- Left side column. contains the logo and sidebar -->
            <aside class="left-side sidebar-offcanvas collapse-left">
                
            </aside>

            <!-- Right side column. Contains the navbar and content of the page -->
            <aside class="right-side strech">            
							               <!-- Main content -->
                <section class="content">

                    <div class="error-page">
                        <h2 class="headline text-info"> 404</h2>
                        <div class="error-content">
                            <h3><i class="fa fa-warning text-yellow"></i> Oops! Page not found.</h3>
                            <p>
                                We could not find the page you were looking for.
                                Meanwhile, you may <a href='<?php echo Yii::app()->request->baseUrl; ?>/cmsAdmin/dashboard'>return to dashboard</a> or try using the search form.
                            </p>
                            <?php /*<form class='search-form'>
                                <div class='input-group'>
                                    <input type="text" name="search" class='form-control' placeholder="Search"/>
                                    <div class="input-group-btn">
                                        <button type="submit" name="submit" class="btn btn-primary"><i class="fa fa-search"></i></button>
                                    </div>
                                </div><!-- /.input-group -->
                            </form>
                            */ ?>
                        </div><!-- /.error-content -->
                    </div><!-- /.error-page -->

                </section><!-- /.content -->              
            </aside><!-- /.right-side -->
        </div><!-- ./wrapper -->

        <!-- add new calendar event modal -->
       
        <!-- jQuery UI 1.10.3 -->
        <script src="<?php echo Yii::app()->request->baseUrl; ?>/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
        <!-- Bootstrap -->
        <script src="<?php echo Yii::app()->request->baseUrl; ?>/js/bootstrap.min.js" type="text/javascript"></script>
         <script src="<?php echo Yii::app()->request->baseUrl; ?>/js/bootstrap-switch.js" type="text/javascript"></script>
        <!-- Morris.js charts -->
        <!--<script src="//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>-->
        <!--<script src="<?php echo Yii::app()->request->baseUrl; ?>/js/plugins/morris/morris.min.js" type="text/javascript"></script>-->
        <!-- Sparkline -->
        <script src="<?php echo Yii::app()->request->baseUrl; ?>/js/plugins/sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
        <!-- jvectormap -->
        <script src="<?php echo Yii::app()->request->baseUrl; ?>/js/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js" type="text/javascript"></script>
        <script src="<?php echo Yii::app()->request->baseUrl; ?>/js/plugins/jvectormap/jquery-jvectormap-world-mill-en.js" type="text/javascript"></script>
        <!-- fullCalendar -->
        <script src="<?php echo Yii::app()->request->baseUrl; ?>/js/plugins/fullcalendar/fullcalendar.min.js" type="text/javascript"></script>
        <!-- jQuery Knob Chart -->
        <script src="<?php echo Yii::app()->request->baseUrl; ?>/js/plugins/jqueryKnob/jquery.knob.js" type="text/javascript"></script>
        <!-- daterangepicker -->
        <script src="<?php echo Yii::app()->request->baseUrl; ?>/js/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
        <!-- Bootstrap WYSIHTML5 -->
        <script src="<?php echo Yii::app()->request->baseUrl; ?>/js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>
        <!-- iCheck -->
     <?php /*?>  <script src="<?php echo Yii::app()->request->baseUrl; ?>/js/plugins/iCheck/icheck.min.js" type="text/javascript"></script><?php */?>

        <!-- AdminLTE App -->
        <script src="<?php echo Yii::app()->request->baseUrl; ?>/js/AdminLTE/app.js" type="text/javascript"></script>
        
        <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
        <script src="<?php echo Yii::app()->request->baseUrl; ?>/js/AdminLTE/dashboard.js" type="text/javascript"></script>     
        
        <!-- AdminLTE for demo purposes -->
       <?php /*?> <script src="<?php echo Yii::app()->request->baseUrl; ?>/js/AdminLTE/demo.js" type="text/javascript"></script><?php */?>
        
         <!-- common JS -->
        <script src="<?php echo Yii::app()->request->baseUrl; ?>/js/custom/common.js"></script>
      	
           <!-- Chosen  -->
        <script src="<?php echo Yii::app()->request->baseUrl; ?>/js/chosen.jquery.min.js" type="text/javascript"></script>
        
        <script>
			$(document).ready(function(e) {
                $('.flash-success').delay(7000).fadeOut(800);
            });
		</script>
      <div id="ajax_loader" class="ajax_loader" style="display: none">
		     <?php  //echo $this->renderPartial('cmsAdmin/venue/loader_view');   ?> 
      </div>
      <div id="image_box" class="ajax_loader imageFullSize col-md-12 col-sm-12 col-xs-12" style="display: none;">
	 <a href="javascript:void(0)" onclick="hide_ajax_loader();" class="close pull-right">x</a>
		<img id="img_src_code" src=""  alt="Loading..." />
</div>
<div id="ajax_backdrop" class="modal-backdrop" style="display: none"></div>
    </body>
</html>