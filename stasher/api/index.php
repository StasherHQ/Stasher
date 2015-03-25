<?php

include("config/settings.php");

$accesstoken = "d4fhf576ggh895qqwh90";

if($_REQUEST['action'])
{
	if($_REQUEST['accesstoken'] == $accesstoken)
	{
	
		$action = $_REQUEST['action'];
		$flag = 1;
		switch($action)
		{
			
                    case 'push' : $file ="push.php";
			break; 
                     case 'underregister' : $file ="underregister.php";
			break; 
                        case 'login' : $file ="login.php";
			break; 
			case 'facebooklogin' : $file ="facebooklogin.php";
			break;
                    case 'facebookregister' : $file ="facebookregister.php";
			break;
			case 'changepassword' : $file ="changepassword.php";
			break; 
			case 'profile' : $file ="profile.php";
			break; 
			case 'dashboard' : $file ="dashboard.php";
			break;
			case 'addchild' : $file ="addchild.php";
			break;
			case 'createchild' : $file ="createchild.php";
			break;
			case 'searchchild' : $file ="searchchild.php";
			break;  
			case 'searchparent' : $file ="searchparent.php";
			break; 
			case 'addparent' : $file ="addparent.php";
			break; 
			
				case 'inviteparent' : $file ="inviteparent.php";
			break; 
			
			
			case 'register' : $file ="register.php";
			break; 
			case 'registerstep1' : $file ="registerstep1.php";
			break; 
			case 'editprofile' : $file ="editprofile.php";
			break; 
			case 'forgotpassword' : $file ="forgotpassword.php";
			break; 
			case 'allcountries' : $file ="countries.php";
			break; 
			case 'addmission' : $file ="addmission.php";
			break; 
			case 'editmission' : $file ="editmission.php";
			break; 
			case 'deletemission' : $file ="deletemission.php";
			break; 

			case 'activemissions' : $file ="activemissions.php";
			break; 
			case 'completedmissions' : $file ="completedmissions.php";
			break; 
			case 'pendingmissions' : $file ="pendingmissions.php";
			break; 
			case 'actiononmission' : $file ="actiononmission.php";
			break;
			case 'child_completedmissions' : $file ="child_completedmissions.php";
			break; 
			case 'child_pendingmissions' : $file ="child_pendingmissions.php";
			break; 
			case 'child_activemissions' : $file ="child_activemissions.php";
			break; 
			case 'completemission_child' : $file ="completemission_child.php";
			break; 
			case 'acceptmission' : $file ="acceptmission.php";
			break; 
			case 'searchmission' : $file ="searchmission.php";
			break;
			case 'myactivities' : $file ="myactivities.php";
			break;
			case 'activities' : $file ="activities.php";
			break;
			
			case 'paymentrequest' : $file ="paymentrequest.php";
			break;

			case 'remind' : $file ="remind.php";
			break;
			
			case 'makepayment' : $file ="makepayment.php";
			break;
			case 'paymentresponse' : $file ="paymentresponse.php";
			break;
			
			case 'terms' : $file ="terms.php";
			break;
                    
                    case 'addbankaccount' : $file ="addbankaccount.php";
			break;
                    
                        case 'parent_graph' : $file ="parent_graph.php";
			break;
                     case 'child_graph' : $file ="child_graph.php";
			break;


			default : $array = array();
					$array['error'] = "101";
					$array['message'] = "Please check your action";
					echo json_encode($array);
					$flag= 0;
			break;
		}
		if($flag == 1)
		include($file);
	}
	else
	{
		$array = array();
		$array['error'] = "102";
		$array['message'] = "Access token does not match";
		echo json_encode($array);
	}
}
else
{
$array = array();
$array['error'] = "404";
$array['message'] = "Please input your action";
echo json_encode($array);
}
?>