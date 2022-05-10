<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/authorApply.css" type="text/css" />
<main>
	<div class="container">
        <div class="containerWrap">
			<div class="exhibitionContainer">
				<div class="exhibitionApplyTitle">
					<h1>작품 수정페이지</h1>
				</div>
				<div class="exhibitionApplyContent">
					<div class="exhibitionApplyTitle">
						<div>작품 명</div>
						<div><input type="text"></div>
					</div>
					<div class="authorApplyThumbnail">
						<div>작품</div>
						<input type="file" name="filename" id="filename1"/>
					</div>
					<div class="exhibitionApplyContent">
						<div>작품 설명</div>
						<div><input type="text"></div>
					</div>
				</div>
				<div>
					<input type="submit" value="작품 수정하기"/>
				</div>
			</div>
		</div>
	</div>
</main>