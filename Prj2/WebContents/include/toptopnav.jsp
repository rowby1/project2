<%@page import="javax.swing.plaf.metal.MetalBorders.Flush3DBorder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
		pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String id = (String) session.getAttribute("id");
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">




<div class="toptopnav" id="mytopTopnav">
		<%-- 	<div onclick="location.href='/mboard?cmd=HOME&id=<%=id%>'" class="toptopnavtitle"><i class="fas fa-info-circle">My코로나</i></div> --%>	
		<c:choose>
		<c:when test="${id != null }">
			<a href="/mboard?cmd=COVIDINFOFORM&id=<%=id%>"><i class="fas fa-info-circle">개인코로나정보</i></a>
			<a href="/mboard?cmd=MEMINFOFORM&id=<%=id%>"><i class="fas fa-user-edit">회원정보</i></a>
			<a href="/mboard?cmd=LOGOUT"><i class="fas fa-sign-out-alt">로그아웃</i></a>
		</c:when>
		
		<c:when test="${id == null }">
			<a href="memReg.jsp"><i class="fas fa-file-signature">회원가입</i></a>
			<a href="/mboard?cmd=LOGIN"><i class="fas fa-sign-in-alt">로그인</i></a>
		</c:when>
	</c:choose>
	<a href="javascript:void(0);" class="icon" onclick="myFunction()"></a>
</div>