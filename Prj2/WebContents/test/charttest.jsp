<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$( function() {
	/* $('#gubun').on('change', function() {
		$('#btnGetData').click();		
	});  */   
	   function addComma(value){
	        value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	        return value; 
	    }
$.ajax( {
	//url     : 'http://localhost:9090/CovidStatus/covidstatus',
	url     : 'http://localhost:9090/countrycovidstatus',
	// data    : { gubun : $('#gubun').val() },
	type    : 'GET',
	success : function( xml ) {
		console.log(xml);
		var labelsArr = new Array();
		var dataArr = new Array(); 
		var xArr = new Array();
		var yArrnatDeathCntkor = new Array(); 
		var yArrnatDeathCntjap = new Array(); 
		var yArrnatDeathCntchi = new Array();
		var yArrnatDeathCntusa = new Array();
		var xArrGapnatDeathCntDate = new Array(); 
		var yArrGapnatDeathCntkor = new Array(); 
		var yArrGapnatDeathCntjap = new Array(); 
		var yArrGapnatDeathCntchi = new Array();
		var yArrGapnatDeathCntusa = new Array();
		var yArrnatDefCntkor = new Array(); 
		var yArrnatDefCntjap = new Array(); 
		var yArrnatDefCntchi = new Array();
		var yArrnatDefCntusa = new Array();
		var xArrGapnatDefCntDate = new Array(); 
		var yArrGapnatDefCntkor = new Array(); 
		var yArrGapnatDefCntjap = new Array(); 
		var yArrGapnatDefCntchi = new Array();
		var yArrGapnatDefCntusa = new Array();
		var html = '';
		$(xml).find('item').each(function( index ) {
			if($('#courseID').val()==null || $('#courseID').val()==""){
				
			var nationNM = $(this).find('nationNm').html(); 
			var areaNm = $(this).find('areaNm').html();
			var natDefCnt = $(this).find('natDefCnt').html();
			var natDeathCnt = $(this).find('natDeathCnt').html();
			var natDeathRate = $(this).find('natDeathRate').html();
			var stdDay = $(this).find('stdDay').html();
			
			
			
			
			html += '<tr class="row">';
			html += '<td id="area" class = "area">' + nationNM +'</td>';
			html += '<td>' + areaNm +'</td>';
			html += '<td>' + natDefCnt +'</td>';
			html += '<td>' + natDeathCnt +'</td>';
			html += '<td>' + natDeathRate +'</td>';
			html += '<td>' + stdDay +'</td>';
			html += '</tr>';

			
			
			
			
			
			if(nationNM=='??????'){	
			labelsArr.push(stdDay);
			dataArr.push(natDeathCnt);
			xArr.push(stdDay);
			yArrnatDeathCntkor.push(natDeathCnt);
			yArrnatDefCntkor.push(natDefCnt);
			

			
			}
			

			
			
			if(nationNM=='??????'){
				yArrnatDeathCntjap.push(natDeathCnt);
				yArrnatDefCntjap.push(natDefCnt);
			}
			if(nationNM=='??????'){
				yArrnatDeathCntchi.push(natDeathCnt);
				yArrnatDefCntchi.push(natDefCnt);
			}
			if(nationNM=='??????'){
				yArrnatDeathCntusa.push(natDeathCnt);
				yArrnatDefCntusa.push(natDefCnt);
			}
			
		
		
			
			}
			
			
			/* countrysaveFunction($(this).find('nationNm').html(), $(this).find('natDefCnt').html()); */
		})
		$('table').append(html)
		//??????2-----------------------------------------------
		// ?????? ?????????
		var GapDeathCntKor ='';
		var GapDeathCntjap ='';
		var GapDeathCntchi ='';
		var GapDeathCntusa ='';
		// ?????? ?????????
		var GapnatDefKor ='';
		var GapnatDefjap ='';
		var GapnatDefchi ='';
		var GapnatDefusa ='';
			console.log("yArrnatDeathCntkor:" + yArrnatDeathCntkor);
			console.log("yArrnatDeathCntjap:" + yArrnatDeathCntjap);
			console.log("yArrnatDeathCntchi:" + yArrnatDeathCntchi);
			console.log("yArrnatDeathCntusa:" + yArrnatDeathCntusa);
			console.log("yArrnatDefCntkor:" + yArrnatDefCntkor);
			console.log("yArrnatDeathCntjap:" + yArrnatDeathCntjap);
			console.log("yArrnatDeathCntchi:" + yArrnatDeathCntchi);
			console.log("yArrnatDeathCntusa:" + yArrnatDeathCntusa);
			console.log("xArr:" + xArr);
			console.log(xArr.shift()); // ?????? ????????? ??????
			console.log(xArr); // ?????? ???????????? ??????
			// ????????? ????????? ???????????? ???????????? ??????
				for (var i = yArrnatDeathCntkor.length; i >= 0 ; i--) {
					if (isNaN(yArrnatDeathCntkor[i] - yArrnatDeathCntkor[i - 1])==false ) {
						//1??? ?????????
					GapDeathCntKor = yArrnatDeathCntkor[i] - yArrnatDeathCntkor[i - 1]
					GapDeathCntjap = yArrnatDeathCntjap[i] - yArrnatDeathCntjap[i - 1]
					GapDeathCntchi = yArrnatDeathCntchi[i] - yArrnatDeathCntchi[i - 1]
					GapDeathCntusa = yArrnatDeathCntusa[i] - yArrnatDeathCntusa[i - 1]
					yArrGapnatDeathCntkor.push(GapDeathCntKor)
					yArrGapnatDeathCntjap.push(GapDeathCntjap)
					yArrGapnatDeathCntchi.push(GapDeathCntchi)
					yArrGapnatDeathCntusa.push(GapDeathCntusa)
					
					//1??? ?????????
					GapnatDefKor = yArrnatDefCntkor[i] - yArrnatDefCntkor[i - 1]
					GapnatDefjap = yArrnatDefCntjap[i] - yArrnatDefCntjap[i - 1]
					GapnatDefchi = yArrnatDefCntchi[i] - yArrnatDefCntchi[i - 1]
					GapnatDefusa = yArrnatDefCntusa[i] - yArrnatDefCntusa[i - 1]
					yArrGapnatDefCntkor.push(GapnatDefKor)
					yArrGapnatDefCntjap.push(GapnatDefjap)
					yArrGapnatDefCntchi.push(GapnatDefchi)
					yArrGapnatDefCntusa.push(GapnatDefusa)
						
					}
				}
			
				
				
			console.log(yArrGapnatDefCntkor);
			console.log(yArrGapnatDefCntjap);
			console.log(yArrGapnatDefCntchi);
			console.log(yArrGapnatDefCntusa);
		var xValues = [100,200,300,400,500,600,700,800,900,1000];

		
		
				//??????------------------------------------------------------------------
				console.log('labelsArr[1]:' + labelsArr[1]);		
				console.log('dataArr[1]:' + dataArr[1]);
				const ctx1 = document.getElementById('myChart1')
						.getContext('2d');
				const myChart1 = new Chart(ctx1, {
					type : 'line',
					data : {
						labels : xArr, //x ??? ??????  labelsArr = ['??????', '???????????????', '???????????????'  ......]
						datasets : [ 
							{
							label : '?????? ????????? ??????', // ????????? ??????
							data : yArrGapnatDefCntkor, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
							borderColor : "red",
							fill : false
						},
						{
							label : '?????? ????????? ??????', // ????????? ??????
							data : yArrGapnatDefCntjap, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
							borderColor : "green",
							fill : false
						},
						{
							label : '?????? ????????? ??????', // ????????? ??????
							data : yArrGapnatDefCntchi, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
							borderColor : "blue",
							fill : false
						},	
						{
							label : '?????? ????????? ??????', // ????????? ??????
							data : yArrGapnatDefCntusa, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
							borderColor : "cyan",
							fill : false
						}
						]
					},
					options : {
						scales : {
							y : {
								beginAtZero : true
							}
						}
					}
				});
				//??????------------------------------------------------------------------
				console.log('labelsArr[1]:' + labelsArr[1]);		
				console.log('dataArr[1]:' + dataArr[1]);
				const ctx2 = document.getElementById('myChart2')
						.getContext('2d');
				const myChart2 = new Chart(ctx2, {
					type : 'line',
					data : {
						labels : xArr, //x ??? ??????  labelsArr = ['??????', '???????????????', '???????????????'  ......]
						datasets : [ 
							{
							label : '?????? ????????? ??????', // ????????? ??????
							data : yArrGapnatDeathCntkor, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
							borderColor : "red",
							fill : false
						},
						{
							label : '?????? ????????? ??????', // ????????? ??????
							data : yArrGapnatDeathCntjap, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
							borderColor : "green",
							fill : false
						},
						{
							label : '?????? ????????? ??????', // ????????? ??????
							data : yArrGapnatDeathCntchi, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
							borderColor : "blue",
							fill : false
						},	
						{
							label : '?????? ????????? ??????', // ????????? ??????
							data : yArrGapnatDeathCntusa, //y ??? ??????  dataArr = [40905177, 7652368, 2616908 ............]
							borderColor : "cyan",
							fill : false
						}
						]
					},
					options : {
						scales : {
							y : {
								beginAtZero : true
							}
						}
					}
				});
				
				
			},
			error : function(xhr) {
				alert(xhr.status + ':' + xhr.statusText);
			}
		})
		
		
		
	})
</script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
   		<canvas id="myChart1" style="width:100%;max-width:600px"></canvas>
   </div>
<div>
   		<canvas id="myChart2" style="width:100%;max-width:600px"></canvas>
   </div>
   
  	
   	
</body>
</html>