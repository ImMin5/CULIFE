<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="/css/exhibition/authorWrite.css"
	type="text/css" />
<script>
	
</script>
<main>
	<div class="container">
		<div class="exhibitionContainer">
			<div class="exhibitionWriteTitle">
				<h1>전시 등록</h1>
			</div>
			<form id="dataFrm" method="post" action="/exhibitionWriteOk"
				enctype="multipart/form-data">

				<div class="exhibitionWriteContent">

					<div class="exhibitionWriteTitle">
						<div>전시 명</div>
						<input type="text" name="subject">						
					</div>
					<div class="exhibitionWriteDate">
						<div>전시 기간</div>
						<div>
							<input type="date" name="start_date" id="start_date" class="exhibitionDate"> - <input type="date" name="end_date" id="end_date" class="exhibitionDate">
							
						</div>
					</div>
					<div class="exhibitionWriteContent">
						<div>전시 설명</div>
						<div>
							<input type="text" name="content">
						</div>
					</div>
					<div class="exhibitionWritePoster">
						<div>대표 포스터</div>
<!-- 						<input type="file" name="poster" class="poster" id="poster"
								style="width: 270px; height: 46px;"> -->
					</div>
					<div>
						<input type="radio" name="type" value="1"> 그림 전시
						<input type="radio" name="type" value="2"> 글 전시
					</div>
				</div>
				<div>
					<input type="submit" value="전시 등록하기" />
				</div>
			</form>
		</div>
	</div>
</main>