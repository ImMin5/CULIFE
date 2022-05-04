<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
	<br/>
		<h1 id="rentBrd">자유 게시판</h1>
		<br/>
		<a href="/board/freeBoardWrite" class="btn" id="freeBoardWrite">글 작성하기</a>
		<div class="row">
				<ul class="boardList">
		<li><input type="checkbox" id="checkAll"></li>
		<li>번호</li>
		<li>제목</li>
		<li>글쓴이</li>
		<li>조회수</li>
		<li>등록일</li>
		<c:set var="url" value="<%=request.getContextPath()%>"/>
		<form method="post" action="${url}/board/freeBoardDel" id="checkFrm">
			<c:forEach var="vo" items="${list}">
				<li><input type="checkbox" name="noList" value="${vo.no}"></li>
				<li>&nbsp;${vo.no }</li>
				<li><a href="/board/boardView?no=${vo.no}">${vo.subject}</a></li>
				<li>${vo.userid }</li>
				<li>&nbsp;&nbsp;&nbsp;${vo.hit }</li>
				<li>${vo.writedate }</li>
			</c:forEach>
		</form>
	</ul>
		</div>
		<div class="row">
			<ul class="pagination justify-content-center" id="paging">
				<c:if test="${pvo.currentPage==1}">
					<li class="page-item disabled"><a class="page-link" id="prevBtn"><i class="fa fa-angle-left"></i></a></li>
				</c:if>
				<c:if test="${pvo.currentPage>1}">
					<li class="page-item"><a class="page-link" href="javascript:void(0);" id="prevBtn" 
							onclick="goPrev(${pvo.currentPage})"><i class="fa fa-angle-left"></i></a></li>
				</c:if>
				<c:forEach var="p" begin="${pvo.startPage}" end="${pvo.totalPage}">
					<c:if test="${p<=pvo.totalPage}">
						<c:choose>
							<c:when test="${p==pvo.currentPage}">
								<li class="page-item disabled"><a class="page-link">${p}</a></li>
							</c:when>
							<c:when test="${p!=pvo.currentPage}">
								<li class="page-item"><a class="page-link"href="javascript:void(0);"
										onclick="goPage(${p})">${p}</a></li>
							</c:when>
						</c:choose>
					</c:if>
				</c:forEach>
				<c:if test="${pvo.currentPage==pvo.totalPage}">
					<li class="page-item disabled"><a class="page-link" id="nextBtn"><i class="fa fa-angle-right"></i></a></li>
				</c:if>
				<c:if test="${pvo.currentPage<pvo.totalPage}">
					<li class="page-item"><a class="page-link" href="javascript:void(0);" id="nextBtn"
							onclick="goNext(${pvo.currentPage})"><i class="fa fa-angle-right"></i></a></li>
				</c:if>
			</ul>
		</div>	
	<br/>
</div>