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
<style>
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>

<script>
function myFunction() {
	  var x = document.getElementById("myTopnav");
	  if (x.className === "topnav") {
	    x.className += " responsive";
	  } else {
	    x.className = "topnav";
	  }
	}
	window.onload = function(){
		var url = document.getElementById('ifm1');
		console.dir(url);
	}
</script>
</head>
<body>
<%@ include file="/include/toptopnav.jsp" %>

<div class="title" id="mytitle"><h2>잔여백신</h2></div>
 <%@ include file="/include/topnav.jsp" %>
<%@ include file="/include/chat.jsp" %>
		<div class="iframebox">
		<iframe id="ifm1" src="https://m.place.naver.com/rest/vaccine?x=${lon}&y=${lat }" frameborder="0" allowfullscreen></iframe>
<%-- 		<iframe id="ifm" src="https://m.place.naver.com/rest/vaccine?x=${lon}&y=${lat }" width="600" height="600"></iframe> --%>
	</div>
	 <%@ include file="/include/bottomnav.jsp" %>
</body>
</html>