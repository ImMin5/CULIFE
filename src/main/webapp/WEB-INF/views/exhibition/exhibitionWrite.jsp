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
						<input type="date" name="startDate" id="startDate" class="ridingDate"> - <input type="date" name="endDate" id="endDate" class="ridingDate">
					</div>
					<div class="exhibitionWriteDate">
						<div>전시 기간</div>
						<div>
							<input type="text">
						</div>
					</div>
					<div class="exhibitionWriteContent">
						<div>전시 설명</div>
						<div>
							<input type="text">
						</div>
					</div>
				</div>
				<div>
					<input type="submit" value="전시 등록하기" />
				</div>
			</form>
		</div>
	</div>
</main>