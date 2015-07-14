<?php

// uncomment the following to define a path alias
// Yii::setPathOfAlias('local','path/to/local-folder');

// This is the main Web application configuration. Any writable
// CWebApplication properties can be configured here.

require_once( dirname(__FILE__) . '/../components/CommonHelper.php');

return array(
	'basePath'=>dirname(__FILE__).DIRECTORY_SEPARATOR.'..',
  
	'name'=>'Stasher',
  
  'timeZone' => 'America/New_York', //Added by anuja on 4 nov to check for the newyork time stamp

	// preloading 'log' component
	'preload'=>array('log'),

	// autoloading model and component classes
	'import'=>array(
		'application.models.*',
		'application.components.*',
	),


	'modules'=>array(
		// uncomment the following to enable the Gii tool
		
		'gii'=>array(
			'class'=>'system.gii.GiiModule',
			'password'=>'password',
			// If removed, Gii defaults to localhost only. Edit carefully to taste.
			'ipFilters'=>array('127.0.0.1','::1'),
		),
		
	),

    'import' => array(
        'application.models.*',
        'application.components.*'
    ),
    
	// application components
	'components'=>array(
    //Admin Mandrill component
    'mandrillwrap'=>array(
        'class'=>'application.extensions.mandrillwrap.mandrillwrap',
    ),
     
		'user'=>array(
			// enable cookie-based authentication
			'allowAutoLogin'=>true,
		),
		// uncomment the following to enable URLs in path-format
		
		'urlManager'=>array(
			'urlFormat'=>'path',
			'showScriptName'=>false,
			'rules'=>array(
        'cmsAdmin'=>'cmsAdmin/dashboard',
				'<controller:\w+>/<id:\d+>'=>'<controller>/view',
				'<controller:\w+>/<action:\w+>/<id:\d+>'=>'<controller>/<action>',
				'<controller:\w+>/<action:\w+>'=>'<controller>/<action>'        
			),
		),
		
		/*'db'=>array(
			'connectionString' => 'sqlite:'.dirname(__FILE__).'/../data/testdrive.db',
		),
		*/
		// uncomment the following to use a MySQL database : For db details please check the dp.php file
		'db'=> require(dirname(__FILE__).'/db.php'),

		'errorHandler'=>array(
			// use 'site/error' action to display errors
			'errorAction'=>'site/error',
		),
		'log'=>array(
			'class'=>'CLogRouter',
			'routes'=>array(
				array(
					'class'=>'CFileLogRoute',
					'levels'=>'error,warning,info', //Remove the info when u want to remove the logging of the info messgaes
          'logFile'=>'application.log.'.date('Y-m-d'), 
          'enabled'=>true
				),
				// uncomment the following to show log messages on web pages
				/*
				array(
					'class'=>'CWebLogRoute',
				),
				*/
			),
		),
	),

	// application-level parameters that can be accessed
	// using Yii::app()->params['paramName']

	'params'=>array(
		// this is used in contact page
		'adminEmail'=>'vipul@oabstudios.com',  // Yii::app()->params['adminEmail'];
    'developerEmail'=>'vipul@oabstudios.com', // Yii::app()->params['developerEmail'];
    'totalOrderItems'=> 10,  // Yii::app()->params['totalOrderItems'];
  'activityPerPage' => 20, // Yii::app()->params['activityPerPage'];
 //Please note Braintree credentials are stored in the 'protected\extensions\BraintreeApi\lib\Braintree\Configuration.php'       
	),
);
