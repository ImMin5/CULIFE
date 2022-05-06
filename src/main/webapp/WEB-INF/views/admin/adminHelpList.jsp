<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file="adminTop.jspf" %>
<link rel="stylesheet" href="/css/adminPage.css" type="text/css" />
<script>

</script>
<div class="admin_container">
<!-- 불러오는 매퍼는 설정했음. 이제 다시 게시판 하듯이? 하면됨 -->
<h1>문의사항관리</h1>
	<ul>
		<li>번호</li>
		<li>제목</li>
		<li>닉네임</li>
		<li>날짜</li>
		<li>상태</li>
		<li><input type="checkbox" id="allCheck"/></li>
	</ul>
</div><!-- class='memberList_container' -->