<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/board/board.css" type="text/css" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
	<br><br><br><br>
	<h1>자유게시판</h1>
	<br><br><br><br><br>
	<ul class='freeboardList'>
		<li>번호</li>
		<li>제목</li>
		<li>닉네임</li>
		<li>조회수</li>
		<li>작성일</li>
		<!-- 지워도되는부분 ↓↓↓ -->
		<c:forEach var="vo" items="${list}">
				<li>${vo.no }</li>
				<li><a href="/board/freeboardView?no=${vo.no}">${vo.subject}</a></li>
				<li>${vo.member_no }</li>
				<li>${vo.view }</li>
				<li>${vo.write_date }</li>
		</c:forEach>
		</ul>
		<!-- <li>01</li>
		<li><a href="/board/freeBoardView?no=1">제목쓸공간입니다1.</a></li>
		<li>닉네임입니다.</li>
		<li>1 회</li>
		<li>22-05-06</li>
		<li>02</li>
		<li><a href="/board/freeBoardView">제목쓸공간입니다2.</a></li>
		<li>닉네임입니다.</li>
		<li>2 회</li>
		<li>22-05-06</li> -->
		<!-- 지워도되는부분 ↑↑↑ -->
		<input id="search" type="text" placeholder="검색" style="float:left">
		<button id="write" style='float:right' onclick="location.href='freeBoardWrite'">글쓰기</button>
<!-- 		<ol><a href="#"> ◀ </a></ol>
		<ol><a href="#"> 1 </a></ol>
		<ol><a href="#"> 2 </a></ol>
		<ol><a href="#"> 3 </a></ol>
		<ol><a href="#"> 4 </a></ol>
		<ol><a href="#"> 5 </a></ol>
		<ol><a href="#"> ▶ </a></ol> -->
</div>