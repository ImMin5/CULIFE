<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page trimDirectiveWhitespaces="true" %>
<link rel="stylesheet" href="/css/adminPage.css" type="text/css" />
<style>
	.admin_gallery li:nth-child(1) {
		background: url(/img/admin/6.jpg) no-repeat center center;
	}
</style>
<script>
$(function () {	
	$("#allCheck").click(function () {
		if($("#allCheck").is(":checked")){
			$(".chk").prop("checked", true);
		}else{
			$(".chk").prop("checked", false);
		}
	});
	
	$("#multiDel").click(function () {
		var cnt = 0;
		//체크한 갯수를 구한다.
		$(".chk").each(function (i,obj) {
			if(obj.checked){
				cnt++;
			}
		});
		//체크한게 없다면 삭제할 필요없음.
		if(cnt<1){
			alert("선택된 목록이 없습니다.");
			return false;
		}
		//cnt>0면, submit이벤트 발생시켜버림
		$("#listFrm").submit();
	});
	
	$("#searchFrm").submit(function(){
		if($("#searchWord").val()==""){
			alert("검색어를 입력해주세요.");
			return false;
		}
	});	
});
</script>
<div class="wrap">
<%@ include file="adminTop.jspf" %>
<div class="admin_container">
	<div class="admin_gallery_wrap">
		<ul class="admin_gallery">
			<li>
				<div class="admin_gallery_content">
					<h2>감상평관리</h2>
				</div>
			</li>
		</ul>
	</div>
	<ul class='mini_top'>
		<li>감상평관리</li>
		<li>
			<!-- 검색 -->
			<div class='adminList_searchFrm'>
				<form method="get" action="/admin/adminExReplyList" id='searchFrm'>
					<select name="searchKey" id="searchkey">
						<option value='subject'>전시명</option>
						<option value='content'>댓글내용</option>
						<option value='nickname'>작성자</option>
					</select>
					<input type="text" name="searchWord" id='searchWord' placeholder="검색"/>
					<input type="submit" value="검색" id="searchBtn"/>
				</form>
			</div>
		</li>
	</ul>
	<form method="get" action="/admin/adminExReplyDel" id='listFrm'>
	<ul class='adminExReplyList'>
		<li class='list_title'>번호</li>
		<li class='list_title'>전시명</li>
		<li class='list_title'>댓글내용</li>
		<li class='list_title'>작성자</li>
		<li class='list_title'>작성일</li>
		<li class='list_title'>전체선택<input type="checkbox" id="allCheck"/></li>
		
		<c:forEach var="vo" items="${adminExReplyList}">
			<li>${vo.no }</li>
			<li>${vo.subject }</li>
			<li><a href='#'>${vo.content }</a></li>
			<li>${vo.nickname }</li>
			<li>${vo.write_date }</li>
			<li><input type="checkbox" name="noList" value="${vo.no}" class="chk"/></li>
		</c:forEach>
	</ul>
	</form>
	
	<!-- 페이징 -->
	<ul class="paging">
	<!--  이전페이지 -->
	<c:if test="${pVO.pageNum == 1 }">
		<li>◀</li>
	</c:if>
	<c:if test="${pVO.pageNum > 1 }">
		<li><a href="/admin/adminExReplyList?pageNum=${pVO.pageNum-1}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">◀</a></li>
	</c:if>
	<c:forEach var="p" begin="${pVO.startPage}" end="${pVO.startPage+pVO.onePageCount-1}">
		<c:if test="${p<=pVO.totalPage}">
			<c:if test="${p==pVO.pageNum}">
				<li style="font-weight: bold;">
			</c:if>
			<c:if test="${p!=pVO.pageNum}">
				<li>
			</c:if>
			<a href="/admin/adminExReplyList?pageNum=${p}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">${p}</a></li>
		</c:if>
	</c:forEach>
	<!--  다음페이지 -->
	<c:if test="${pVO.pageNum == pVO.totalPage }">
		<li>▶</li>
	</c:if>
	<c:if test="${pVO.pageNum < pVO.totalPage }">
		<li><a href="/admin/adminExReplyList?pageNum=${pVO.pageNum+1}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">▶</a></li>
	</c:if>
		<li>
			<input type="button" value="삭제" id="multiDel"/>
			<input type="button" value="목록" id="resetList" onclick="location.href='/admin/adminExReplyList'"/>		
		</li>
	</ul>
</div> <!-- div:admin_container -->
</div>