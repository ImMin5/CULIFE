<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="/css/adminPage.css" type="text/css" />
<script>
$(function () {
	$(".author_upgrade").submit(function () {
		var check = confirm('작가로 승인하시겠습니까?');
		if(!check){
			return false;
		}
		
	});
	$(".author_delete").submit(function () {
		var check = confirm('작가를 취소하시겠습니까?');
		if(!check){
			return false;
		}
	});
});
</script>
</head>
<body>
<div class="admin_container">
	<h1>작가관리</h1>
	<ul class='authorList'>
		<li>번호</li>
		<li>회원번호</li>
		<li>작가명</li>
		<li>SNS주소</li>
		<li>신청날짜</li>
		<li>상태</li>
		<li>&nbsp;&nbsp;&nbsp;&nbsp;</li>
		
		<c:forEach var="vo" items="${authorList}">
		<li>${vo.no}</li>
		<li>${vo.member_no}</li>
		<li>${vo.author}</li>
		<li><a href="${vo.sns_link}" target="_blank">${vo.sns_link}</a></li>
		<li>${vo.create_date}</li>
		<li>
			<c:if test="${vo.author_status == 0}">대기중</c:if>
			<c:if test="${vo.author_status == 1}">승인완료</c:if>
		</li>
		<li>
			<c:if test="${vo.author_status == 0}">
			<form method="get" action="/admin/authorUpgrade" class='author_upgrade'>
				<input type="hidden" name="no" value="${vo.no}"/>
				<input type="submit" value="승인"/>
			</form>
			</c:if>
			<form method="get" action="/admin/authorDelete" class='author_delete'>
				<input type="hidden" name="no" value="${vo.no}"/>
				<input type="submit" value="취소"/>
			</form>
		</li>
		</c:forEach>
	</ul>
	
	<!-- 페이징 -->
	<ul class="paging">
	<!--  이전페이지 -->
	<c:if test="${pVO.pageNum == 1 }">
		<li>prev</li>
	</c:if>
	<c:if test="${pVO.pageNum > 1 }">
		<li><a href="/admin/authorList?pageNum=${pVO.pageNum-1}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">prev</a></li>
	</c:if>
	<c:forEach var="p" begin="${pVO.startPage}" end="${pVO.startPage+pVO.onePageCount-1}">
		<c:if test="${p<=pVO.totalPage}">
			<c:if test="${p==pVO.pageNum}">
				<li style="font-weight: bold;">
			</c:if>
			<c:if test="${p!=pVO.pageNum}">
				<li>
			</c:if>
			<a href="/admin/authorList?pageNum=${p}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">${p}</a></li>
		</c:if>
	</c:forEach>
	<!--  다음페이지 -->
	<c:if test="${pVO.pageNum == pVO.totalPage }">
		<li>next</li>
	</c:if>
	<c:if test="${pVO.pageNum < pVO.totalPage }">
		<li><a href="/admin/authorList?pageNum=${pVO.pageNum+1}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">next</a></li>
	</c:if>	
		
	</ul>
	
	<!-- 검색 -->
	<div class='adminList_searchFrm'>
		<form method="get" action="/admin/authorList" id='searchFrm'>
			<select name="searchKey">
				<option value='member_no'>회원번호</option>
				<option value='author'>작가명</option>
				<option value='author_status'>상태</option>
			</select>
			<input type="text" name="searchWord" id='searchWord'/>
			<input type="submit" value="검색"/>
		</form>
	</div>
</div> <!-- div:admin_container -->
</body>
</html>