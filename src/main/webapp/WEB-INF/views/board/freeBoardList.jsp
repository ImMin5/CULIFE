<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/board/board.css" type="text/css" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> -->
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
		<c:forEach var="vo" items="${list}">
				<li>${vo.no }</li>
				<li><a href="/board/freeBoardView?no=${vo.no}">${vo.subject}</a></li>
				<li>${vo.member_no }</li>
				<li>${vo.view }</li>
				<li>${vo.write_date }</li>
		</c:forEach>
		</ul>
		<input id="search" type="text" placeholder="검색" style="float:left">
		<button id="write" style='float:right' onclick="location.href='freeBoardWrite'">글쓰기</button>
	<!-- 	<div class="container">
			<div class="row">
				<div class="col" style:float=center>
					<ul class="pagination">
						<li class="page-item"><a class="page-link" href="#">Previous</a></li>
						<li class="page-item"><a class="page-link" href="#">1</a></li>
						<li class="page-item"><a class="page-link" href="#">2</a></li>
						<li class="page-item"><a class="page-link" href="#">3</a></li>
						<li class="page-item"><a class="page-link" href="#">4</a></li>
						<li class="page-item"><a class="page-link" href="#">5</a></li>
						<li class="page-item"><a class="page-link" href="#">Next</a></li>
					</ul>
				</div>
			</div>
		</div> -->
</div>