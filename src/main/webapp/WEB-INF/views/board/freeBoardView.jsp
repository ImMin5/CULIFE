<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="/css/board/freeBoardView.css"	type="text/css" />
<link rel="stylesheet" href="/css/board/boardViewReply.css"	type="text/css" />

<div class="container">
	<!-- 글내용 -->
	<hr />
	<ul>
		<li>번호 : 01</li>
		<li>작성자 : 닉네임입니다.</li>
		<li>작성일 : 22-05-06</li>
		<li>조회수 : 1회</li>
		<li>제목 : 제목쓸공간입니다1.</li>
		<li>글 내용</li>
		<li>글내용이 길어질예정입니다.</li>
	</ul>
	<!-- 댓글 -->
	<hr />
	<div>
		<i class="fa fa-comment fa-lg"></i><span class="iconValue">댓글</span>
	</div>
	<form method="post" id="replyForm">
		<input type="hidden" name="no" id="no" value="${viewVo.no}">
		<div id="commentLine">
			<textarea name="coment" id="coment" class="rentBoardComent" rows="4"
				cols="80" placeholder="내용을 입력하세요"></textarea>
			<span id="replyBtn"><input type="submit" class="btn"
				id="replyInsert" value="댓글 등록"></span>
		</div>
	</form>
	<!-- 댓글 목록 표시 -->
	<div id="replyList"></div>
</div>
<br />