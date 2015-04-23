<?php

echo  "Cuurent Date-Time on server =>".date('Y-m-d  -- h:i:s a');
$datetime1 =  date('Y-m-d h:i:s');
echo "<br> $datetime1 <br>";



date_default_timezone_set('America/New_York');

echo  "<br> Cuurent Date-Time on server =>".date('Y-m-d  -- h:i:s a');
$datetime2 = date('Y-m-d h:i:s');

$time1 = strtotime($datetime1);
$time2 = strtotime($datetime2);
$diff = $time2 - $time1;
echo "<br><br>";
echo 'Time 1: '.date('H:i:s', $time1).'<br>';
echo 'Time 2: '.date('H:i:s', $time2).'<br>';

if($diff){
    echo 'Diff: '.date('H:i:s', $diff);
}else{
    echo 'No Diff.';
}
?>