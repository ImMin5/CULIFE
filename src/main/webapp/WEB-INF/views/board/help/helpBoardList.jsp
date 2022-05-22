<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/board/board.css" type="text/css" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container">
	<br> <br> <br>
	<h1>문 의 사 항</h1>
	<br>
	<h5>※이 게시판은 본인과 관리자외에는 열람이 불가능합니다.</h5>
	<br>
	<div id="write_div">
		<button id="write" style='float: right'	onclick="location.href='helpBoardWrite'">글쓰기</button>
	</div>
	<ul class='helpboardList'>
		<li></li>
		<li>제목</li>
		<li>닉네임</li>
		<li>조회수</li>
		<li>작성일</li>
		<c:choose>
			<c:when test="${!empty list}">
				<c:forEach var="vo" items="${list}">
					<li>${vo.no }</li>
					<li><a href="/board/help/helpBoardView?no=${vo.no}">${vo.subject}</a></li>
					<li>${vo.nickname }</li>
					<li>${vo.view }</li>
					<li>${vo.write_date }</li>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div id="nullresult">검색된 결과가 없습니다.</div>
			</c:otherwise>
		</c:choose>
		</ul>
		<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
			<div class="page">
		<ul class="paging">
			<!--  이전페이지 -->
			<c:if test="${pVO.currentPage == 1 && !empty list}">
				<li>◀</li>
			</c:if>
			<c:if test="${pVO.currentPage > 1 }">
				<li><a
					href="/board/help/helpBoardList?category=${pVO.category}&currentPage=${pVO.currentPage-1}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">◀</a></li>
			</c:if>
			<c:forEach var="p" begin="${pVO.startPage}"
				end="${pVO.startPage+pVO.onePageCount-1}">
				<c:if test="${p<=pVO.totalPage}">
					<c:if test="${p==pVO.currentPage}">
						<li style="font-weight: bold;">
					</c:if>
					<c:if test="${p!=pVO.currentPage}">
						<li>
					</c:if>
					<a
						href="/board/help/helpBoardList?category=${pVO.category}&currentPage=${p}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">${p}</a>
					</li>
				</c:if>
			</c:forEach>
			<!--  다음페이지 -->
			<c:if test="${pVO.currentPage == pVO.totalPage }">
				<li>▶</li>
			</c:if>
			<c:if test="${pVO.currentPage < pVO.totalPage }">
				<li><a
					href="/board/help/helpBoardList?category=${pVO.category}&currentPage=${pVO.currentPage+1}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">▶</a></li>
			</c:if>
		</ul>
	</div>
	<div>
		<form method="get" action="/board/help/helpBoardList" id='searchFrm'>
			<input type="hidden" name="category" value="help"> <select
				name="searchKey" id="searchkey">
				<option value='b.no'>게시글번호</option>
				<option value='subject'>제목</option>
				<option value='nickname'>닉네임</option>
			</select> <input type="text" name="searchWord" id='search' placeholder="검색" />
			<input type="submit" value="검색" id="searchBtn" />
		</form>
	</div>
</div>