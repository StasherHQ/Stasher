<?php

//LOCAL
//return array(
//			'connectionString' => 'mysql:host=localhost;dbname=thirst_version_0.1',
//			'emulatePrepare' => true,
//			'username' => 'root',
//			'password' => '',   //bandit@Pride1
//			'charset' => 'utf8',
      //  'initSQLs'=>array(
      //          "SET time_zone = '-5:00'"
      //),
//		);


//SERVER
return array(
     'enableProfiling'=>true,
     'enableParamLogging' => true,
			'connectionString' => 'mysql:host=localhost;dbname=db_stasher',
			'emulatePrepare' => true,
			'username' => 'root',
			'password' => 'bandit@Pride1',
			'charset' => 'utf8',
      'initSQLs'=>array(
                "SET time_zone = '-5:00'"
      ),
		);
?>
		
