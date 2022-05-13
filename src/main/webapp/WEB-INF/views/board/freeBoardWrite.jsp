<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/board/freeBoardWrite.css" type="text/css"/>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>

<div class="container">
<br/>
<form class="form-group" method="post" action="/board/freeBoardWriteOk?category=free" id="freeForm">
<h1>자유 게시판 글쓰기폼</h1>
<input type="text" class="form-control" id="freeBoardTitle" placeholder="글 제목을 입력하세요." name="title"/>
<textarea name="content" id="editor"></textarea>
    <script>
    ClassicEditor
        .create( document.querySelector('#editor'))
        .catch( error => {
            console.error( error );
        } );
    </script>
    <!-- <tbody> ckeditor4 사용법 알아오기
		<tr>
			<td id="tbBody">
				<input type="text" class="form-control" id="shareBoardTitle" placeholder="글 제목을 입력하세요." name="title"/>
			</td>
		</tr>
		<tr>
			<td><textarea name="content" id="writeContent" placeholder="글 내용을 입력하세요."></textarea></td>
		</tr>
	</tbody> -->
    <br>
    <div class="writeok">
    	<input type="submit" class="btn" id="writeBtn" value="등록"/>
		<input type="reset"  class="btn"id="resetBtn" value="취소"/>
		<input type="button" class="btn" id="backList" value="돌아가기"/>
    </div>
    </form>
<br />
</div>
