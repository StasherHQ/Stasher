<?php
include('model/missions.php');
$msnObj = new Model_Mission();
include('model/users.php');

$usrObj = new Model_Users();


if($_POST['transactionId'] != '' && $_POST['childId'] != '')
{
    

$transId = $_POST['transactionId'];
//$tokenresponce = createToken($transactionId,0.01);
//$transId = "f276e314954a0f1d8047130e64fc70a4d67744e5";
$pass = "7a383e494ac323569402b9f1fe591c1735906202";
$key = "4aa327f5ac661878d6178e2c2b44aa5a9a0708d2";
// get transactions details by transasction details.




$url ="https://knoxpayments.com/admin/api/get_payment_details.php?trans_id=".$transId."&API_key=".$key."&API_pass=".$pass;
 
 $returned_content = getCURLdata($url);
$data = json_decode($returned_content);

//echo $data->GetPaymentDetails->trans_id;
//echo "<pre>";print_r($data);exit;
	


$transArray = array();
$transArray['trans_id'] = $data->GetPaymentDetails->trans_id;
$transArray['name'] = $data->GetPaymentDetails->name;
$transArray['email'] = $data->GetPaymentDetails->email;
$transArray['address'] = $data->GetPaymentDetails->address;
$transArray['phone'] = $data->GetPaymentDetails->phone;
$transArray['status_code'] = $data->GetPaymentDetails->status_code;
$transArray['merchant'] = $data->GetPaymentDetails->merchant;
$transArray['payment_amount'] = $data->GetPaymentDetails->payment_amount;
$transArray['invoice_detail'] = $data->GetPaymentDetails->invoice_detail;
$transArray['sms_date'] = $data->GetPaymentDetails->sms_date;
$transArray['sms_time'] = $data->GetPaymentDetails->sms_time;
$transArray['credit_amount'] = $data->GetPaymentDetails->credit_amount;
$transArray['debit_amount'] = $data->GetPaymentDetails->debit_amount;
$transArray['error_code'] = $data->GetPaymentDetails->error_code;
$transArray['parentId'] = $childId;
$usrObj->addTransaction($transArray);




$marray['transaction']['trans_id'] = $data->GetPaymentDetails->trans_id;
$marray['transaction']['name'] = $data->GetPaymentDetails->name;
$marray['transaction']['email'] = $data->GetPaymentDetails->email;
$marray['transaction']['address'] = $data->GetPaymentDetails->address;
$marray['transaction']['phone'] = $data->GetPaymentDetails->phone;
$marray['transaction']['status_code'] = $data->GetPaymentDetails->status_code;
$marray['transaction']['merchant'] = $data->GetPaymentDetails->merchant;
$marray['transaction']['payment_amount'] = $data->GetPaymentDetails->payment_amount;
$marray['transaction']['invoice_detail'] = $data->GetPaymentDetails->invoice_detail;
$marray['transaction']['sms_date'] = $data->GetPaymentDetails->sms_date;
$marray['transaction']['sms_time'] = $data->GetPaymentDetails->sms_time;
$marray['transaction']['credit_amount'] = $data->GetPaymentDetails->credit_amount;
$marray['transaction']['debit_amount'] = $data->GetPaymentDetails->debit_amount;
$marray['transaction']['error_code'] = $data->GetPaymentDetails->error_code;

                                                        

}
else
{
	$marray['error']['code'] = "101";
	$marray['error']['message'] = "Please chcek your compulsory fields.";
}
echo json_encode($marray);

?>
