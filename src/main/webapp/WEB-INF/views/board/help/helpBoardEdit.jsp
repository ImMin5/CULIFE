<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/board/helpBoardWrite.css" type="text/css"/>
<script src="//cdn.ckeditor.com/4.18.0/full/ckeditor.js"></script>
<script src="/js/board/helpBoardWrite.js"></script>
<!-- js파일 참조시키기 -->
<div class="container">
<br/>
<form class="form-group" method="post" action="/board/help/helpBoardEditOk?category=help" id="helpForm">
<h1>문의 게시글 수정</h1>
<br>
<input type="hidden" name="no" value="${bvo.no}"><!-- 히든으로해줘야 cnt가 0으로 안나옴 -->
<input type="text" class="form-control" name="subject" id="helpBoardTitle" placeholder="글 제목을 입력하세요." value="${bvo.subject }"/>
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
