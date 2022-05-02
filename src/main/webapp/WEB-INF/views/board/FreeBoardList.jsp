<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="/css/board/reqBoardList.css" type="text/css" />
<div class="container">
	<br />
	<h1 id="freeBrd">자유게시판</h1>
	<br /> <a href="/board/freeBoardWrite" class="btn" id="freeBoardWrite">글	작성하기</a>
	<div class="row">
		<c:forEach var="listVo" items="${list}">
			<div class="col-sm-4 rqb">
				<div class="card">
					<div class="embed-responsive embed-responsive-4by3">
						<a href="/board/reqBoardView?no=${listVo.no}"> 
						<c:if test="${listVo.thumbnailImg==null}">
								<img src="/img/thumbnail_request.jpg"
									class="embed-responsive-item">
							</c:if>
						</a>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
