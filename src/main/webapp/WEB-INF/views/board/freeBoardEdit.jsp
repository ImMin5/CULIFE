<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/board/freeBoardWrite.css" type="text/css"/>
<script src="//cdn.ckeditor.com/4.18.0/full/ckeditor.js"></script>
<script src="/js/board/freeBoardWrite.js"></script>
<!-- js파일 참조시키기 -->
<div class="container">
<br/>
<form class="form-group" method="post" action="/board/freeBoardEditOk?category=free" id="freeForm">
<h1>자유 게시판 수정폼</h1>
<input type="hidden" name="no" value="${bvo.no}"><!-- 히든으로해줘야 cnt가 0으로 안나옴 -->
<input type="text" class="form-control" name="subject" id="freeBoardTitle" placeholder="글 제목을 입력하세요." value="${bvo.subject }"/>
<textarea name="content" id="editor">${bvo.content }</textarea>
	<script>
    window.onload = function(){
       ck = CKEDITOR.replace("editor");
    };
    </script>
    <br>
    <div class="writeok">
    	<input type="submit" class="btn" id="writeBtn" value="수정"/>
		<input type="button" class="btn" id="backList" value="돌아가기"/>
    </div>
    </form>
<br />
</div>
