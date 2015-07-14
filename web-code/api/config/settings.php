<?php

include('config.php');
include('table.php');
include('functions.php');
include('Database.php');

require(DOC_ROOT.'/model/common.php');
$commonObj = new Model_Common();
$allVarraibles =$commonObj->getAllVariables();
	//echo "";print_r($allVarraibles);exit;
	$k=0;
	while($k<count($allVarraibles)) {
            ## Site Name
            define($allVarraibles[$k]['var_name'], $allVarraibles[$k]['var_value']);
           
            $k++;
	}
	
	

?>