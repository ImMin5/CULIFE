<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/authorWrite.css" type="text/css" />
<main>
	<div class="container">
        <div class="containerWrap">
			<div class="exhibitionContainer">
				<div class="exhibitionWriteTitle">
					<h1>전시 등록</h1>
				</div>
				<div class="exhibitionWriteContent">
					<div class="exhibitionWriteTitle">
						<div>전시 명</div>
						<div><input type="text"></div>
					</div>
					<div class="exhibitionWriteDate">
						<div>전시 기간</div>
						<div><input type="text"></div>
					</div>
					<div class="exhibitionWriteContent">
						<div>전시 설명</div>
						<div><input type="text"></div>
					</div>
				</div>
				<div>
					<input type="submit" value="전시 등록하기"/>
				</div>
			</div>
		</div>
	</div>
</main>