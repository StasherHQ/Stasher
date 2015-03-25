<?php
include('model/missions.php');
$msnObj = new Model_Mission();
include('model/users.php');
$missionObj = new Model_Mission();

//echo "<pre>";print_r($_REQUEST);exit;
	
$marray = array();
if($_POST['childId'] != '' )
{


			$childId = $_POST['childId'];
			$parentId = $_POST['parentId'];

		
			$price = $_POST['price'];
			$description = $_POST['comment'];			
			$currentdate = date("Y-m-d H:i:s");
						
			$paymentArray = array();	
			$paymentArray['childId'] = $childId;	
			$paymentArray['parentId'] = $parentId;	
			$paymentArray['price'] = $price;	
			$paymentArray['description'] = $description;	
			$paymentArray['inserted_date'] = date("Y-m-d H:i:s");	
			$paymentArray['status'] = 2;	
			$missionObj->newPaymentRequest($paymentArray);	
			
			$marray['success']['code'] = "102";
			$marray['success']['message'] = "Request sent successfully!";
								
}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);
?>
<script src="https://knoxpayments.com/merchant/knox.js" id="knox_payments_script" button_text="PAY WITH YOUR BANK" api-key="sample_0dae605d6594b9ca" recurring="ot" user_request="show_all" invoice_detail="Describe what this payment is for" response_url=""></script>

<div class="knox-payments-div" data-amount="10"></div>
