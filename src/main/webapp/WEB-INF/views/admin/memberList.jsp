<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page trimDirectiveWhitespaces="true" %>
<link rel="stylesheet" href="/css/adminPage.css" type="text/css" />
<style>
	.memberList>li{position:relative;}
	.memberList img{
		background-color: gray;
		position: absolute;
		left: 120px;
		top: -40px;
		border: 1px solid black;
		z-index: 999999 !important;
		display:none;
	}
</style>
<script>
$(function () {	
	$("#searchFrm").submit(function(){
		if($("#searchWord").val()==""){
			alert("검색어를 입력해주세요.");
			return false;
		}
	});	
	
	$(".noimg").mouseover(function(){
		var point = $(this).offset();
		alert(point.top);
	});
	
	/*이*/
	$(".memberList>li:nth-child(8n+2)").hover(function(){
			$(this).children("img").css("display","block");
		},
		function(){
			$(".memberList img").css("display","none");
		}		
	);
});	
</script>
<div class="wrap">
<%@ include file="adminTop.jspf" %>
<div class="admin_container">
	<div class="img_top">
	
	</div>
	<ul class='mini_top'>
		<li>회원관리</li>
		<li>
			<!-- 검색 -->
			<div class='adminList_searchFrm'>
				<form method="get" action="/admin/memberList" id='searchFrm'>
					<select name="searchKey" id="searchkey">
						<option value='kakao_id'>카카오ID</option>
						<option value='nickname'>닉네임</option>
						<option value='grade'>회원등급</option>
						<option value='status'>회원상태</option>
					</select>
					<input type="text" name="searchWord" id='searchWord' placeholder="검색"/>
					<input type="submit" value="검색" id="searchBtn"/>
				</form>
			</div>
		</li>
	</ul>
	
	<ul class='memberList'>
		<li class='list_title'>번호</li>
		<li class='list_title'>카카오ID</li>
		<li class='list_title'>닉네임</li>
		<li class='list_title'>회원등급</li>
		<li class='list_title'>회원가입일</li>
		<li class='list_title'>정지기간</li>
		<li class='list_title'>회원상태</li>
		<li class='list_title'>설정</li>

		<c:forEach var="vo" items="${memberList}">
			<li>${vo.no}</li>
			<li>${vo.kakao_id}
			<c:if test="${vo.thumbnail eq Null}">
				<img id="thumbnail_member" src="${url}/img/member/default_thumbnail.png"/>
			</c:if>
			<c:if test="${vo.thumbnail ne Null}">
				<img id="thumbnail_member" src="${url}/upload/${vo.no}/thumbnail/${vo.thumbnail}"/>
			</c:if>
			</li>
			<li>${vo.nickname}</li>
			<c:if test="${vo.grade == 0}">
			<li>일반회원</li>
			</c:if>
			<c:if test="${vo.grade == 1}">
			<li>작가</li>
			</c:if>
			<c:if test="${vo.grade == 2}">
			<li>관리자</li>
			</c:if>			
			<li>${vo.create_date}</li>
			<c:if test="${empty vo.end_date}">
			<li>-</li>
			</c:if>
			<c:if test="${not empty vo.end_date}">
			<li>${vo.end_date}</li>
			</c:if>
			<c:if test="${vo.status eq '0'}">
			<li>정상</li>
			</c:if>
			<c:if test="${vo.status eq '1'}">
			<li>정지</li>
			</c:if>	
			<li>
				<form method="get" action="/admin/memberStatus" class='statusFrm'>
					<input type="hidden" name="no" value="${vo.no}"/>
					<select name="memberStatus">
						<option value="ok">정상</option>
						<option value="7">7일정지</option>
						<option value="30">30일정지</option>
						<option value="del">탈퇴</option>
					</select>
					<input type="submit" value="적용"/>
				</form>
			</li>
   		</c:forEach>
	</ul>
	<!-- 페이징 -->
	<ul class="paging">
	<!--  이전페이지 -->
	<c:if test="${pVO.pageNum == 1 }">
		<li>◀</li>
	</c:if>
	<c:if test="${pVO.pageNum > 1 }">
		<li><a href="/admin/memberList?pageNum=${pVO.pageNum-1}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">◀</a></li>
	</c:if>
	<c:forEach var="p" begin="${pVO.startPage}" end="${pVO.startPage+pVO.onePageCount-1}">
		<c:if test="${p<=pVO.totalPage}">
			<c:if test="${p==pVO.pageNum}">
				<li style="font-weight: bold;">
			</c:if>
			<c:if test="${p!=pVO.pageNum}">
				<li>
			</c:if>
			<a href="/admin/memberList?pageNum=${p}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">${p}</a></li>
		</c:if>
	</c:forEach>
	<!--  다음페이지 -->
	<c:if test="${pVO.pageNum == pVO.totalPage }">
		<li>▶</li>
	</c:if>
	<c:if test="${pVO.pageNum < pVO.totalPage }">
		<li><a href="/admin/memberList?pageNum=${pVO.pageNum+1}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">▶</a></li>
	</c:if>
		<li><input type="button" value="목록" id="resetList" onclick="location.href='/admin/memberList'"/></li>
	</ul>
</div><!-- class='adminList_container' -->
</div>