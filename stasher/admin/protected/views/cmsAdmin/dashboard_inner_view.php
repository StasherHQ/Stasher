 <div class="row">
				 
      		<div class="graph" id="chartcontainer">
          	
          </div>          
      </div>  
      
	
<script type="text/javascript">

	var myData =  new Array(<?php echo $graphArray;?>); ///new Array([10, 20], [15, 10], [20, 30], [25, 10], [30, 5]);
	var myChart = new JSChart('chartcontainer', 'bar');
	myChart.setDataArray(myData);
	//myChart.setBackgroundColor('#efe');
	myChart.setAxisNameX('<?php echo $xAxisTitle;?>');
	myChart.setAxisNameY('$');
	myChart.setSize(527, 344);
	myChart.setTitle('Daily Billing');
//	myChart.setTitleColor('#ffffff'); // Currently hidden
//	myChart.setAxisNameColor('#ffffff'); // Currently hidden	
	myChart.setAxisValuesColor('#333639');
	myChart.setGraphExtend(false);
  myChart.setGridColor('#BCBCBE');
	myChart.setLineColor('#313132');
	myChart.setTitleFontSize(10);
	myChart.setGridOpacityY(1);
  myChart.setGridOpacityX(0);
	myChart.setFlagRadius(4);
	//myChart.setFlagFillColor('#000000');
	//myChart.setFlagColor('#000000');
	//myChart.setTooltip([20, '']);
	//myChart.setTooltip([10, '']);

	
	myChart.setErrors(false);

	myChart.draw();
</script>
