<%@page import="javax.swing.plaf.metal.MetalBorders.Flush3DBorder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
		pageEncoding="UTF-8"%>
		
     
<div class="topnav" id="myTopnav">
  <a href="/mboard?cmd=HOME&id=${ memViewVo.id }" class="active">My코로나</a>
  <%-- <a href="/mboard?cmd=HOME&id=${ memViewVo.id }" class="topnavtitle">My코로나</a> --%>
  <a href="/mboard?cmd=COVIDSTATUS&id=${ memViewVo.id }">코로나현재상황</a>
  <a href="/mboard?cmd=COUNTRYCOVIDSTATUS&id=${ memViewVo.id }">해외코로나현황</a>
  <a href="/mboard?cmd=VACCINESTATICS&id=${ memViewVo.id }">예방접종통계</a>
  <a href="/mboard?cmd=VACCINATIONCENTER">예방접종센터</a>
  <a href="/mboard?cmd=NOSHOWVACCINE">잔여백신</a>
  <a href="/mboard?cmd=SCREENING&id=${ memViewVo.id }">선별진료소</a>
  <a href="/mboard?cmd=NEWS&id=${ memViewVo.id }">코로나뉴스</a>
  <a href="/view/YoutubNews.jsp">동영상뉴스</a>
  <a href="/mboard?cmd=BOARD&id=${ memViewVo.id }">게시판</a>
  <a href="javascript:void(0);" class="icon" onclick="myFunction()">
    <i class="fa fa-bars"></i>
  </a>
</div>