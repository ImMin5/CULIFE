<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/board/board.css" type="text/css" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container">
	<br><br><br><br>
	<h1>문의사항</h1>
	<br><br><br><br><br>
	<ul class='helpboardList'>
		<li>번호</li>
		<li>제목</li>
		<li>닉네임</li>
		<li>조회수</li>
		<li>작성일</li>
		<!-- 지워도되는부분 ↓↓↓
		<li>01</li>
		<li><a href="javascript:alert('본인 또는 관리자가 아닙니다.');" onfocus="this.blur()">비밀글입니다.</a></li>
		<li>1날다람쥐1</li>
		<li>1 회</li>
		<li>22-05-06</li> -->
		<c:forEach var="vo" items="${list}">
			<li>${vo.no }</li>
			<li><a href="/board/help/helpBoardView?no=${vo.no}">${vo.subject}</a></li>
			<li>${vo.member_no }</li>
			<li>${vo.view }</li>
			<li>${vo.write_date }</li>
		</c:forEach>
		</ul>
		<input id="search" type="text" placeholder="검색" style="float:left">
		<button id="write" style='float:right' onclick="location.href='helpBoardWrite'">글쓰기</button>
	</ul>
</div>