<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/board/freeBoardWrite.css" type="text/css"/>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
<script src="//cdn.ckeditor.com/4.18.0/full/ckeditor.js"></script>

<div class="container">
<h1>글쓰기폼</h1>
<input type="text" class="form-control" id="shareBoardTitle" placeholder="글 제목을 입력하세요." name="title"/>
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
		<input type="reset" id="resetBtn" class="btn" value="취소"/>
		<input type="button" class="btn" id="backList" value="리스트로 돌아가기"/>
    </div>
<br />
</div>
