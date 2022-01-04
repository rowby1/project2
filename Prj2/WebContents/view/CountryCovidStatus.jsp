<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/css/prj2.css">

<title>Insert title here</title>
<style></style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.bundle.min.js" ></script>

<script>
$( function() {
	


})
</script>


<script>
function getyesterday(){
	var now = new Date();
	var yesterday = new Date(now.setDate(now.getDate() -2));
	var year 	= yesterday.getFullYear();
	var month	= ('0' + (yesterday.getMonth() + 1)).slice(-2);
	var day		= ('0' + yesterday.getDate()).slice(-2);
	//2021-11-24 00:00:00
	var dateString = year + '-' + month + '-' + day;
//	console.log("dateString:" + dateString);
	return dateString
}


function myFunction() {
	  var x = document.getElementById("myTopnav");
	  if (x.className === "topnav") {
	    x.className += " responsive";
	  } else {
	    x.className = "topnav";
	  }
	}

	
	// shift enter키 사용, enter키 전송
	
	function enterkey(){
		if (window.event.keyCode==13){
			var button = document.getElementById('chart1searchbutton');
			button.click();

		}
	}
	
	
	function stopgetsearch() {
				$("#myChart3").empty();
				$("#myChart4").empty();
				$("#area").empty();

			}

	$(function(){
		nosearchchartrun();
	
	
		
	$("#chart1searchbutton").on({
		"click" : function(){
			stopgetsearch();
			
			var chart1search = document.getElementById('chart1search').value;
			document.getElementById('search1').innerHTML =  chart1search + ' 일일 확진자';
			document.getElementById('search2').innerHTML =  chart1search + ' 일일 사망자';
			document.getElementById('search3').innerHTML =  chart1search + ' 및 주요국 총 확진자 현황';
			document.getElementById('search4').innerHTML =  '한국 및 ' + chart1search + ' 코로나 현황표';
			chartrun(chart1search);
			console.log(chart1search);
			 $("#search").css("display", "block");
			 $(".table2").css("display", "block");
			 $("#nonesearch").css("display", "none");
			 $(".table1").css("display", "none");
		}
			
		
	})
	})
	
	function addComma(value){
	        value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	        return value; 
	    }

	/* $('#gubun').on('change', function() {
		$('#btnGetData').click();		
	});  */   
	
	function nosearchchartrun(){
		var yesterday = getyesterday();

     $("#search").css("display", "none");
		 $(".table2").css("display", "none");
	   
		
	   $.ajax( {
			//url     : 'http://localhost:9090/CovidStatus/covidstatus',
			url     : 'http://localhost:9090/countrycovidstatus',
			// data    : { gubun : $('#gubun').val() },
			type    : 'GET',
			success : function( xml ) {
				//console.log(xml);
				var labelsArr = new Array();
				var dataArr = new Array(); 
				var xArr = new Array();
				var yArrnatDeathCntkor = new Array(); 
				var yArrnatDeathCntjap = new Array(); 
				var yArrnatDeathCntchi = new Array();
				var yArrnatDeathCntusa = new Array();
				var yArrnatDeathCntGer = new Array();
				var yArrnatDeathCntInd = new Array();
				var yArrnatDeathCntsearch = new Array();
				var xArrGapnatDeathCntDate = new Array(); 
				var yArrGapnatDeathCntkor = new Array(); 
				var yArrGapnatDeathCntjap = new Array(); 
				var yArrGapnatDeathCntchi = new Array();
				var yArrGapnatDeathCntusa = new Array();
				var yArrGapnatDeathCntGer = new Array();
				var yArrGapnatDeathCntInd = new Array();
				var yArrGapnatDeathCntsearch = new Array();
				var yArrnatDefCntkor = new Array(); 
				var yArrnatDefCntjap = new Array(); 
				var yArrnatDefCntchi = new Array();
				var yArrnatDefCntusa = new Array();
				var yArrnatDefCntGer = new Array();
				var yArrnatDefCntInd = new Array();
				var yArrnatDefCntsearch = new Array();
				var xArrGapnatDefCntDate = new Array(); 
				var yArrGapnatDefCntkor = new Array(); 
				var yArrGapnatDefCntjap = new Array(); 
				var yArrGapnatDefCntchi = new Array();
				var yArrGapnatDefCntusa = new Array();
				var yArrGapnatDefCntGer = new Array();
				var yArrGapnatDefCntInd = new Array();
				var yArrGapnatDefCntsearch = new Array();
				var countryArrDoughNut = new Array();
				var valueArrDoughNut = new Array();
				var dummyArrDoughNut = new Array();
				var othervalueArrDoughNut = new Array();
				var barColorsArrDoughNut = [  "#b91d47","#00aba9","#2b5797","#e8c3b9","#1e7145"]
	
				$("#chart1searchbutton").on({
					"click" : function(){
						var chart1search = document.getElementById('chart1search').value;
						console.log(chart1search);
					}
					
				})
				var html = '';
				$(xml).find('item').each(function( index ) {
					if($('#courseID').val()==null || $('#courseID').val()==""){
						
					var nationNM = $(this).find('nationNm').html(); 
					var areaNm = $(this).find('areaNm').html();
					var natDefCnt = $(this).find('natDefCnt').html();
					var natDeathCnt = $(this).find('natDeathCnt').html();
					var natDeathRate = $(this).find('natDeathRate').html();
					var stdDay = $(this).find('stdDay').html();
					
					
					
					
					html += '<tr class="row" id="row">';
					html += '<td id="area" class = "area">' + nationNM +'</td>';
					html += '<td>' + areaNm +'</td>';
					html += '<td>' + natDefCnt +'</td>';
					html += '<td>' + natDeathCnt +'</td>';
					html += '<td>' + natDeathRate +'</td>';
					html += '<td>' + stdDay +'</td>';
					html += '</tr>';

					
					
					
			
					
					
					
					if(nationNM=='한국'){	
					dataArr.push(natDeathCnt);
					xArr.push(stdDay);
					yArrnatDeathCntkor.push(natDeathCnt);
					yArrnatDefCntkor.push(natDefCnt);
					

					
					}
					

					
					
					if(nationNM=='일본'){
						yArrnatDeathCntjap.push(natDeathCnt);
						yArrnatDefCntjap.push(natDefCnt);
					}
					if(nationNM=='중국'){
						yArrnatDeathCntchi.push(natDeathCnt);
						yArrnatDefCntchi.push(natDefCnt);
					}
					if(nationNM=='미국'){
						yArrnatDeathCntusa.push(natDeathCnt);
						yArrnatDefCntusa.push(natDefCnt);
					}
					if(nationNM=='독일'){
						yArrnatDeathCntGer.push(natDeathCnt);
						yArrnatDefCntGer.push(natDefCnt);
					}
					if(nationNM=='인도'){
						yArrnatDeathCntInd.push(natDeathCnt);
						yArrnatDefCntInd.push(natDefCnt);
					}
					if(nationNM==chart1search){
						yArrnatDeathCntsearch.push(natDeathCnt);
						yArrnatDefCntsearch.push(natDefCnt);
						console.log('chart1search:' + nationNM);
						console.log('chart1search:' + yArrnatDeathCntsearch);
						console.log('chart1search:' + yArrnatDefCntsearch);
						console.log('chart1search:' + chart1search);
					}
					
					if((nationNM=='미국'||nationNM=='일본'||nationNM=='독일'||nationNM=='영국'||nationNM=='인도'||nationNM=='프랑스'||nationNM=='이탈리아'||nationNM=='한국') && stdDay==yesterday){
						dummyArrDoughNut.push(natDeathRate);
			//				console.log(yesterday);
							countryArrDoughNut.push(nationNM);
							valueArrDoughNut.push(natDefCnt);	
					}
					
				
					
					}
					
					/* countrysaveFunction($(this).find('nationNm').html(), $(this).find('natDefCnt').html()); */
				})
				
						var html1 = '';
				$($(xml).find('item').get().reverse()).each(function( index ) {
					if($('#courseID').val()==null || $('#courseID').val()==""){
					
						if(index < 190 *5){
					var nationNM = $(this).find('nationNm').html(); 
					var areaNm = $(this).find('areaNm').html();
					var natDefCnt = $(this).find('natDefCnt').html();
					var natDeathCnt = $(this).find('natDeathCnt').html();
					var natDeathRate = $(this).find('natDeathRate').html();
					var stdDay = $(this).find('stdDay').html();
					
					
					
					
					html1 += '<tr class="row" id="row">';
					html1 += '<td id="area" class = "area">' + nationNM +'</td>';
					html1 += '<td>' + areaNm +'</td>';
					html1 += '<td>' + natDefCnt +'</td>';
					html1 += '<td>' + natDeathCnt +'</td>';
					html1 += '<td>' + natDeathRate +'</td>';
					html1 += '<td>' + stdDay +'</td>';
					html1 += '</tr>';
						}
				
					
					}
					
					
					/* countrysaveFunction($(this).find('nationNm').html(), $(this).find('natDefCnt').html()); */
				})
				$('#table1').append(html1)
				
				
				//차트2-----------------------------------------------
				// 일일 사망자
				var GapDeathCntKor ='';
				var GapDeathCntjap ='';
				var GapDeathCntchi ='';
				var GapDeathCntusa ='';
				var GapDeathCntGer ='';
				var GapDeathCntInd ='';
				var GapDeathCntsearch ='';
				// 일일 확진자
				var GapnatDefKor ='';
				var GapnatDefjap ='';
				var GapnatDefchi ='';
				var GapnatDefusa ='';
				var GapnatDefGer ='';
				var GapnatDefInd ='';
				var GapnatDefsearch ='';
				//	console.log("yArrnatDeathCntkor:" + yArrnatDeathCntkor);
				//	console.log("yArrnatDeathCntjap:" + yArrnatDeathCntjap);
				//	console.log("yArrnatDeathCntchi:" + yArrnatDeathCntchi);
				//	console.log("yArrnatDeathCntusa:" + yArrnatDeathCntusa);
				//	console.log("yArrnatDefCntkor:" + yArrnatDefCntkor);
				//	console.log("yArrnatDeathCntjap:" + yArrnatDeathCntjap);
				//	console.log("yArrnatDeathCntchi:" + yArrnatDeathCntchi);
				//	console.log("yArrnatDeathCntusa:" + yArrnatDeathCntusa);
				//	console.log("yArrnatDeathCntusa:" + yArrnatDeathCntusa);
					
					
				//	console.log("xArr:" + xArr);
				//	console.log(xArr.shift()); // 배열 첫번째 빼기
				//	console.log(xArr); // 배열 첫번째뺀 값들
					// 사망자 전날과 비교하여 사망자수 확인
						for (var i = yArrnatDeathCntkor.length; i >= 0 ; i--) {
							if (isNaN(yArrnatDeathCntkor[i] - yArrnatDeathCntkor[i - 1])==false ) {
								//1일 사망자
							GapDeathCntKor = yArrnatDeathCntkor[i] - yArrnatDeathCntkor[i - 1]
							GapDeathCntjap = yArrnatDeathCntjap[i] - yArrnatDeathCntjap[i - 1]
							GapDeathCntchi = yArrnatDeathCntchi[i] - yArrnatDeathCntchi[i - 1]
							GapDeathCntusa = yArrnatDeathCntusa[i] - yArrnatDeathCntusa[i - 1]
							GapDeathCntGer = yArrnatDeathCntGer[i] - yArrnatDeathCntGer[i - 1]
							GapDeathCntInd = yArrnatDeathCntInd[i] - yArrnatDeathCntInd[i - 1]
							yArrGapnatDeathCntkor.push(GapDeathCntKor)
							yArrGapnatDeathCntjap.push(GapDeathCntjap)
							yArrGapnatDeathCntchi.push(GapDeathCntchi)
							yArrGapnatDeathCntusa.push(GapDeathCntusa)
							yArrGapnatDeathCntGer.push(GapDeathCntGer) 
							yArrGapnatDeathCntInd.push(GapDeathCntInd) 
							
							//1일 확진자
							GapnatDefKor = yArrnatDefCntkor[i] - yArrnatDefCntkor[i - 1]
							GapnatDefjap = yArrnatDefCntjap[i] - yArrnatDefCntjap[i - 1]
							GapnatDefchi = yArrnatDefCntchi[i] - yArrnatDefCntchi[i - 1]
							GapnatDefusa = yArrnatDefCntusa[i] - yArrnatDefCntusa[i - 1]
							GapnatDefGer = yArrnatDefCntGer[i] - yArrnatDefCntGer[i - 1]
							GapnatDefInd = yArrnatDefCntInd[i] - yArrnatDefCntInd[i - 1]
								
							yArrGapnatDefCntkor.push(GapnatDefKor)
							yArrGapnatDefCntjap.push(GapnatDefjap)
							yArrGapnatDefCntchi.push(GapnatDefchi)
							yArrGapnatDefCntusa.push(GapnatDefusa)
							yArrGapnatDefCntGer.push(GapnatDefGer)
							yArrGapnatDefCntInd.push(GapnatDefInd)
								
							}
						}
					
						
				//	console.log(yArrGapnatDefCntkor);
				//	console.log(yArrGapnatDefCntjap);
				//	console.log(yArrGapnatDefCntchi);
				//	console.log(yArrGapnatDefCntusa);
				var xValues = [100,200,300,400,500,600,700,800,900,1000];

	
				console.log("yArrGapnatDefCntkor:" + yArrGapnatDefCntkor);
				console.log("xArr:" + xArr);
				console.log(yArrGapnatDefCntkor);
				xArr.pop();
				console.log(xArr);
				
						//차트------------------------------------------------------------------
					//	console.log('labelsArr[1]:' + labelsArr[1]);		
					//	console.log('dataArr[1]:' + dataArr[1]);
						const ctx1 = document.getElementById('myChart1')
								.getContext('2d');
						const myChart1 = new Chart(ctx1, {
							type : 'line',
							data : {
								labels : xArr, //x 축 제목  labelsArr = ['전국', '서울특별시', '부산광역시'  ......]
								datasets : [ 
									{
									label : '한국 확진자 현황', // 데이터 범례
									data : yArrGapnatDefCntkor.reverse(), //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
									borderColor : "#b91d47",
									fill : false
								},
								{
									label : '일본 확진자 현황', // 데이터 범례
									data : yArrGapnatDefCntjap.reverse(), //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
									borderColor : "#00aba9",
									fill : false
								},
								{
									label : '중국 확진자 현황', // 데이터 범례
									data : yArrGapnatDefCntchi.reverse(), //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
									borderColor : "#2b5797",
									fill : false
								},	
								{
									label : '미국 확진자 현황', // 데이터 범례
									data : yArrGapnatDefCntusa.reverse(), //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
									borderColor : "#e8c3b9",
									fill : false
								},
								{
									label : '독일 확진자 현황', // 데이터 범례
									data : yArrGapnatDefCntGer.reverse(), //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
									borderColor : "#1e7145",
									fill : false
								},
								{
									label : '인도 확진자 현황', // 데이터 범례
									data : yArrGapnatDefCntInd.reverse(), //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
									borderColor : "#8A2BE2",
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
						//차트------------------------------------------------------------------
					//	console.log('labelsArr[1]:' + labelsArr[1]);		
					//	console.log('dataArr[1]:' + dataArr[1]);
						const ctx2 = document.getElementById('myChart2')
								.getContext('2d');
						const myChart2 = new Chart(ctx2, {
							type : 'line',
							data : {
								labels : xArr, //x 축 제목  labelsArr = ['전국', '서울특별시', '부산광역시'  ......]
								datasets : [ 
									{
									label : '한국 사망자 현황', // 데이터 범례
									data : yArrGapnatDeathCntkor.reverse(), //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
									borderColor : "#b91d47",
									fill : false
								},
								{
									label : '일본 사망자 현황', // 데이터 범례
									data : yArrGapnatDeathCntjap.reverse(), //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
									borderColor : "#00aba9",
									fill : false
								},
								{
									label : '중국 사망자 현황', // 데이터 범례
									data : yArrGapnatDeathCntchi.reverse(), //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
									borderColor : "#2b5797",
									fill : false
								},	
								{
									label : '미국 사망자 현황', // 데이터 범례
									data : yArrGapnatDeathCntusa.reverse(), //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
									borderColor : "#e8c3b9",
									fill : false
								},
								{
									label : '독일 사망자 현황', // 데이터 범례
									data : yArrGapnatDeathCntGer.reverse(), //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
									borderColor : "#1e7145",
									fill : false
								},
								{
									label : '인도 사망자 현황', // 데이터 범례
									data : yArrGapnatDeathCntInd.reverse(), //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
									borderColor : "#8A2BE2",
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
						//도넛차트------------------------------------------------------------------
						var barColorsDoughNut = [
							  "#b91d47",
							  "#00aba9",
							  "#2b5797",
							  "#e8c3b9",
							  "#1e7145",
							  "#8A2BE2",
							  "#45484B",
							  "#FF7F50",
							  "#00FFFF",
							  "#FF8C00"
						];

						new Chart("myChart5", {
						  type: "pie",
						  data: {
						    labels: countryArrDoughNut,
						    datasets: [{
						      backgroundColor: barColorsDoughNut,
						      data: valueArrDoughNut
						    }]
						  },
						  options: {
						    title: {
						    /*   display: true,
						      text: "주요국 발생 현황" */
						    }
						  }
						});
					},
					error : function(xhr) {
						alert(xhr.status + ':' + xhr.statusText);
					}
				})
				
			}
	

				
	
	
	
	/* $('#gubun').on('change', function() {
		$('#btnGetData').click();		
	});  */   
	// 검색시 실행
		function chartrun(chart1search){
			var yesterday = getyesterday();


	
		
	   $.ajax( {
			//url     : 'http://localhost:9090/CovidStatus/covidstatus',
			url     : 'http://localhost:9090/countrycovidstatus',
			// data    : { gubun : $('#gubun').val() },
			type    : 'GET',
			success : function( xml ) {
			//	console.log(xml);
				var labelsArr = new Array();
				var dataArr = new Array(); 
				var xArr = new Array();
				var yArrnatDeathCntkor = new Array(); 
				var yArrnatDeathCntsearch = new Array();
				var xArrGapnatDeathCntDate = new Array(); 
				var yArrGapnatDeathCntkor = new Array(); 
				var yArrGapnatDeathCntsearch = new Array();
				var yArrnatDefCntkor = new Array(); 
				var yArrnatDefCntsearch = new Array();
				var xArrGapnatDefCntDate = new Array(); 
				var yArrGapnatDefCntkor = new Array(); 
				var yArrGapnatDefCntsearch = new Array();
				var countryArrDoughNut = new Array();
				var valueArrDoughNut = new Array();
				var dummyArrDoughNut = new Array();
				var othervalueArrDoughNut = new Array();
				var barColorsArrDoughNut = [  "#b91d47","#00aba9","#2b5797","#e8c3b9","#1e7145"]
				   
			       
			       
			       
			       
			       
			       
			     
				
				var html = '';
				
				$(xml).find('item').each(function( index ) {
						
					var nationNM = $(this).find('nationNm').html(); 
					var areaNm = $(this).find('areaNm').html();
					var natDefCnt = $(this).find('natDefCnt').html();
					var natDeathCnt = $(this).find('natDeathCnt').html();
					var natDeathRate = $(this).find('natDeathRate').html();
					var stdDay = $(this).find('stdDay').html();
					
					
			
					
					html += '<tr class="row" id="row">';
					html += '<td id="area" class = "area">' + nationNM +'</td>';
					html += '<td>' + areaNm +'</td>';
					html += '<td>' + natDefCnt +'</td>';
					html += '<td>' + natDeathCnt +'</td>';
					html += '<td>' + natDeathRate +'</td>';
					html += '<td>' + stdDay +'</td>';
					html += '</tr>';

					
					
					
			
					
					
					
					if(nationNM=='한국' ){	
					labelsArr.push(stdDay);
					dataArr.push(natDeathCnt);
					xArr.push(stdDay);
					yArrnatDeathCntkor.push(natDeathCnt);
					yArrnatDefCntkor.push(natDefCnt);
					

					
					}
					

					
	
					if(nationNM==chart1search){
						yArrnatDeathCntsearch.push(natDeathCnt);
						yArrnatDefCntsearch.push(natDefCnt);
				//		console.log('chart1search:' + nationNM);
				//		console.log('chart1search:' + yArrnatDeathCntsearch);
				//		console.log('chart1search:' + yArrnatDefCntsearch);
				//		console.log('chart1search:' + chart1search);
					}
					
					if((nationNM=='미국'||nationNM=='일본'||nationNM=='독일'||nationNM=='영국'||nationNM=='인도'||nationNM=='프랑스'||nationNM=='이탈리아'||nationNM=='한국'||nationNM==chart1search) && stdDay==yesterday){
						dummyArrDoughNut.push(natDeathRate);
					//		console.log(yesterday);
							countryArrDoughNut.push(nationNM);
							valueArrDoughNut.push(natDefCnt);	
					}
					
					
					
					/* countrysaveFunction($(this).find('nationNm').html(), $(this).find('natDefCnt').html()); */
				})
				
					var html1 = '';
				html1 += '<tr>';
				html1 += '<td>국가명</td>';
				html1 += '<td>지역명</td>';
				html1 += '<td>국가별 확진자 수</td>';
				html1 += '<td>국가별 사망자 수</td>';
				html1 += '<td>확진률 대비 사망률</td>';
				html1 += '<td>기준일시</td>';
				html1 += '</tr>';
				$($(xml).find('item').get().reverse()).each(function( index ) {
					if($(this).find('nationNm').html()==chart1search || $(this).find('nationNm').html()=="한국"){
						
					var nationNM = $(this).find('nationNm').html(); 
					var areaNm = $(this).find('areaNm').html();
					var natDefCnt = $(this).find('natDefCnt').html();
					var natDeathCnt = $(this).find('natDeathCnt').html();
					var natDeathRate = $(this).find('natDeathRate').html();
					var stdDay = $(this).find('stdDay').html();
					
					
					
					
					html1 += '<tr class="row" id="row">';
					html1 += '<td id="area" class = "area">' + nationNM +'</td>';
					html1 += '<td>' + areaNm +'</td>';
					html1 += '<td>' + natDefCnt +'</td>';
					html1 += '<td>' + natDeathCnt +'</td>';
					html1 += '<td>' + natDeathRate +'</td>';
					html1 += '<td>' + stdDay +'</td>';
					html1 += '</tr>';


					}
					
					
					/* countrysaveFunction($(this).find('nationNm').html(), $(this).find('natDefCnt').html()); */
				})
				$('#table2').html(html1)
				//차트2-----------------------------------------------
				// 일일 사망자
				var GapDeathCntKor ='';
				var GapDeathCntsearch ='';
				// 일일 확진자
				var GapnatDefKor ='';
				var GapnatDefsearch ='';
				//	console.log("yArrnatDeathCntkor:" + yArrnatDeathCntkor);
				//	console.log("yArrnatDefCntkor:" + yArrnatDefCntkor);
					
					
				//	console.log("xArr:" + xArr);
				//	console.log(xArr.shift()); // 배열 첫번째 빼기
				//	console.log(xArr); // 배열 첫번째뺀 값들
					// 사망자 전날과 비교하여 사망자수 확인
						for (var i = yArrnatDeathCntkor.length; i >= 0 ; i--) {
							if (isNaN(yArrnatDeathCntkor[i] - yArrnatDeathCntkor[i - 1])==false ) {
								//1일 사망자
							GapDeathCntKor = yArrnatDeathCntkor[i] - yArrnatDeathCntkor[i - 1]
							GapDeathCntsearch = yArrnatDeathCntsearch[i] - yArrnatDeathCntsearch[i - 1]
							yArrGapnatDeathCntkor.push(GapDeathCntKor)
							yArrGapnatDeathCntsearch.push(GapDeathCntsearch)
							
							//1일 확진자
							GapnatDefKor = yArrnatDefCntkor[i] - yArrnatDefCntkor[i - 1]
							GapnatDefsearch = yArrnatDefCntsearch[i] - yArrnatDefCntsearch[i - 1]
							yArrGapnatDefCntkor.push(GapnatDefKor)
							yArrGapnatDefCntsearch.push(GapnatDefsearch)
								
							}
						}
					
						
						
				//	console.log(yArrGapnatDefCntkor);
				var xValues = [100,200,300,400,500,600,700,800,900,1000];

	
				
						//차트------------------------------------------------------------------
					//	console.log('labelsArr[1]:' + labelsArr[1]);		
					//	console.log('dataArr[1]:' + dataArr[1]);
					xArr.pop();
						const ctx3 = document.getElementById('myChart3')
								.getContext('2d');
						const myChart3 = new Chart(ctx3, {
							type : 'line',
							data : {
								labels : xArr, //x 축 제목  labelsArr = ['전국', '서울특별시', '부산광역시'  ......]
								datasets : [ 
									{
									label : '한국 확진자 현황', // 데이터 범례
									data : yArrGapnatDefCntkor.reverse(), //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
									borderColor : "red",
									fill : false
								},
								{
									label : chart1search + ' 확진자 현황', // 데이터 범례
									data : yArrGapnatDefCntsearch.reverse(), //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
									borderColor : "blue",
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
						//차트------------------------------------------------------------------
						const ctx4 = document.getElementById('myChart4')
								.getContext('2d');
						const myChart4 = new Chart(ctx4, {
							type : 'line',
							data : {
								labels : xArr, //x 축 제목  labelsArr = ['전국', '서울특별시', '부산광역시'  ......]
								datasets : [ 
									{
									label : '한국 사망자 현황', // 데이터 범례
									data : yArrGapnatDeathCntkor.reverse(), //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
									borderColor : "red",
									fill : false
								},
								{
									label : chart1search + ' 사망자 현황', // 데이터 범례
									data : yArrGapnatDeathCntsearch.reverse(), //y 축 숫자  dataArr = [40905177, 7652368, 2616908 ............]
									borderColor : "blue",
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
						//도넛차트------------------------------------------------------------------
						console.log("countryArrDoughNut:" + countryArrDoughNut);
						console.log("valueArrDoughNut:" + valueArrDoughNut);
					//	console.log(valueArr[1]);
					//	console.log(typeof valueArr[1]);
							var barColorsDoughNut = [
								  "#b91d47",
								  "#00aba9",
								  "#2b5797",
								  "#e8c3b9",
								  "#1e7145",
								  "#8A2BE2",
								  "#45484B",
								  "#FF7F50",
								  "#00FFFF",
								  "#FF8C00"
							];

							new Chart("myChart6", {
							  type: "pie",
							  data: {
							    labels: countryArrDoughNut,
							    datasets: [{
							      backgroundColor: barColorsDoughNut,
							      data: valueArrDoughNut
							    }]
							  },
							  options: {
							    title: {
							    /*   display: true,
							      text: chart1search + "및 주요국 발생 현황" */
							    }
							  }
							});
					},
					error : function(xhr) {
						alert(xhr.status + ':' + xhr.statusText);
					}
				})
				
	}
	
	// 검색 도넛 차트 시작
	
	// 검색 도넛 차트 끝
	
	
	
		
		
/* 	/저장/
		function countrysaveFunction(nationNm, natDefCnt) {
			$.ajax({
				type : "POST",
				url : "/countrycovidstatussavesevlet",
				data : {
					nationNm : nationNm
					natDefCnt : natDefCnt
				},
				success : function(data) {
					if (data == "")
						return;
					var parsed = JSON.parse(data);
					var result = parsed.result;
					for (var i = 0; i < result.length; i++) {
						addChat(result[i][0].value, result[i][1].value,
								result[i][2].value);

					}
					lastID = Number(parsed.last);
				}

			});
		} */
</script>
</head>
<body>
<%@ include file="/include/toptopnav.jsp" %>

<div class="title" id="mytitle"><h2>해외코로나 현황</h2></div>
 <%@ include file="/include/topnav.jsp" %>
<%@ include file="/include/chat.jsp" %>
  <div>
    <main>   
 
   
	<div>
	<label id="chart1searchlabel">나라명:</label>
	<input type="text" id="chart1search" onkeyup="enterkey()" >
	<input type="button" id="chart1searchbutton" value="검색">
	</div>
	

<div id=nonesearch>
   	<div id ="countryCovidChart5">
    <div id = "countryCovidChart5-1" class ="countryCovidChartDiv">주요국 총 확진자 현황</div>
	<canvas id="myChart5" ></canvas>
	</div>
   
<!-- 	<label>나라명:</label>
	<input type="text" id="chart1search">
	<input type="button" id="chart1searchbutton" value="검색"> -->
	<div id ="countryCovidChart1">	
	<div class ="countryCovidChartDiv">주요국 일일 확진자 현황</div>
   		<canvas id="myChart1" ></canvas>
   		</div>
<div id ="countryCovidChart2">
	<div class ="countryCovidChartDiv">주요국 일일 사망자 현황</div>
   		<canvas id="myChart2" ></canvas>
   </div>
   </div>
   


<!-- 	<label>나라명:</label>
	<input type="text" id="chart1search">
	<input type="button" id="chart1searchbutton" value="검색"> -->
	<div id=search>
	   	<div id ="countryCovidChart6">
    <div  id = "search3" class ="countryCovidChartDiv">주요국 총 확진자 현황</div>
	<canvas id="myChart6" ></canvas>
	</div>
		<div id ="countryCovidChart3">
		<div id = "search1" class ="countryCovidChartDiv">일일 확진자 현황</div>
   		<canvas id="myChart3" ></canvas>
   		</div>
   		
<div id ="countryCovidChart4">
	<div id = "search2" class ="countryCovidChartDiv">일일 사망자 현황</div>
   		<canvas id="myChart4" ></canvas>
   </div>
   </div>
   
   	
   <div class="table1">
   <div  class ="countryCovidChartDiv">해외코로나 현황표</div>
   <table id="table1" >
     <tr>
       <td>국가명</td>
       <td>지역명</td>
       <td>국가별 확진자 수</td>
       <td>국가별 사망자 수</td>
       <td>확진률 대비 사망률</td>
       <td>기준일시</td>
     </tr>
   </table>
   </div>
   
	<div class="table2">
	<div id = "search4" class ="countryCovidChartDiv">해외코로나 현황표</div>
   <table id="table2" >
     <tr>
       <td>국가명</td>
       <td>지역명</td>
       <td>국가별 확진자 수</td>
       <td>국가별 사망자 수</td>
       <td>확진률 대비 사망률</td>
       <td>기준일시</td>
     </tr>
   </table>
   </div>
   
   
  </main>  
 </div>  
  
   
   
 
 <%@ include file="/include/bottomnav.jsp" %>
</body>
</html>