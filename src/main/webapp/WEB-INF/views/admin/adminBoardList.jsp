<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="/css/adminPage.css" type="text/css" />
</head>
<body>
<div class="admin_container">
<h1>자유게시판관리</h1>
	<form method="get" action="" id='listFrm'>
	<ul class='adminBoardList'>
		<li>번호</li>
		<li>제목</li>
		<li>닉네임</li>
		<li>조회수</li>
		<li>날짜</li>
		<li><input type="checkbox" id="allCheck"/></li>
		
		<c:forEach var="vo" items="${adminBoardList}">
			<li>${vo.no }</li>
			<li><a href='#'>${vo.subject }</a></li>
			<li>${vo.nickname }</li>
			<li>${vo.view }</li>
			<li>${vo.write_date }</li>
			<li><input type="checkbox" name="noList" value="${vo.no}" class="chk"/></li>
		</c:forEach>
		<li><input type="submit" value="삭제"/></li>
	</ul>
	</form>
	
	<!-- 페이징 -->
	<ul class="paging">
	<!--  이전페이지 -->
	<c:if test="${pVO.pageNum == 1 }">
		<li>prev</li>
	</c:if>
	<c:if test="${pVO.pageNum > 1 }">
		<li><a href="/admin/adminBoardList?pageNum=${pVO.pageNum-1}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">prev</a></li>
	</c:if>
	<c:forEach var="p" begin="${pVO.startPage}" end="${pVO.startPage+pVO.onePageCount-1}">
		<c:if test="${p<=pVO.totalPage}">
			<c:if test="${p==pVO.pageNum}">
				<li style="font-weight: bold;">
			</c:if>
			<c:if test="${p!=pVO.pageNum}">
				<li>
			</c:if>
			<a href="/admin/adminBoardList?pageNum=${p}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">${p}</a></li>
		</c:if>
	</c:forEach>
	<!--  다음페이지 -->
	<c:if test="${pVO.pageNum == pVO.totalPage }">
		<li>next</li>
	</c:if>
	<c:if test="${pVO.pageNum < pVO.totalPage }">
		<li><a href="/admin/adminBoardList?pageNum=${pVO.pageNum+1}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">next</a></li>
	</c:if>	
		
	</ul>
	
	<!-- 검색 -->
	<div class='adminList_searchFrm'>
		<form method="get" action="/admin/adminBoardList" id='searchFrm'>
			<select name="searchKey">
				<option value='b.no'>게시글번호</option>
				<option value='subject'>제목</option>
				<option value='m.nickname'>닉네임</option>
			</select>
			<input type="text" name="searchWord" id='searchWord'/>
			<input type="submit" value="검색"/>
		</form>
	</div>
</div> <!-- div:admin_container -->
</body>
</html>