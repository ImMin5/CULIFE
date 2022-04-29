<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="${url}/css/exhibition/authorApply.css" rel="stylesheet" type="text/css">

<main>
	<div class="container">
        <div class="containerWrap">
			<div class="exhibitionContainer">
				<div class="authorApplyTitle">
					<h1>작가등록</h1>
				</div>
				<div class="authorApplyContent">
					<div class="authorApplyID">
						<div>아이디 ${vo.nickname }</div>
						<div><input type="text"></div>
					</div>
					<div class="authorApplyName">
						<div>작가명</div>
						<div><input type="text"></div>
					</div>
					<div class="authorApplySNS">
						<div>SNS 주소</div>
						<div><input type="text"></div>
					</div>
					<div class="authorApplyThumbnail">
						<div>프로필 사진</div>
						<input type="file" name="filename" id="filename1"/>
					</div>
				</div>
				<div>
					<input type="submit" value="작가 신청하기"/>
				</div>
				냥냥~
			</div>
		</div>
	</div>
</main>