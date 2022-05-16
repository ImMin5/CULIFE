<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="/css/board/freeBoardView.css"	type="text/css" />
<link rel="stylesheet" href="/css/board/boardViewReply.css"	type="text/css" />

<div class="container">
	<!-- 글내용 -->
	<br>
	<ul>
	<div class="parent">
		<div class="child1">작성자 : ${viewVo.member_no}</div>
		<div class="child2"><h1>제목 : ${viewVo.subject}</h1></div>
		<div class="child1">조회수 : ${viewVo.view}</div>
	</div>
	<hr/>
		<br>

		<li>글 내용</li>
		<br>
		<div class="freeContent">

		<div>${viewVo.content}</div>
		</div>
	</ul>
	<!-- 댓글 -->
	<hr />
	<div>
		<i class="fa fa-comment fa-lg"></i><span class="iconValue">댓글</span>
	</div>
	<form method="post" id="replyForm">
		<input type="hidden" name="no" id="no" value="${viewVo.no}">
		<div id="commentLine">
			<textarea name="coment" id="coment" class="freeBoardComent" rows="4"
				cols="80" placeholder="내용을 입력하세요"></textarea>
			<span id="replyBtn"><input type="submit" class="btn"
				id="replyInsert" value="댓글 등록"></span>
		</div>
	</form>
	<!-- 댓글 목록 표시 -->
	<div id="replyList"></div>
</div>
<br />