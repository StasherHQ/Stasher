<?php
include('model/country.php');

$countryObj = new Model_Country();

$countryArray = $countryObj->getAllActiveCountries();
$k=0;
$marray = array();
if($countryArray)
{
while($k < count($countryArray))
{
	$marray['countries'][$k]['id'] = $countryArray[$k]['id'];
	$marray['countries'][$k]['country_code'] = $countryArray[$k]['country_code'];
	$marray['countries'][$k]['country_name'] = $countryArray[$k]['country_name'];
	$k++;
}
}
else
{
	$marray['error']['code'] = '102';
	$marray['error']['message'] = "No countires found";
}
echo json_encode($marray);
?>