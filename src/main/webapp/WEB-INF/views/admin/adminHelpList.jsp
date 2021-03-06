<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page trimDirectiveWhitespaces="true" %>
<link rel="stylesheet" href="/css/adminPage.css" type="text/css" />
<style>
	.admin_gallery li:nth-child(1) {
		background: url(/img/admin/7.jpg) no-repeat center center;
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

		if($("#searchKey").val().equals("cnt")){
			if($("#searchWord").val().equals("답변완료")){
				$("#searchWord").val(1);
				alert($("#searchWord").val());
			}else if($("#searchWord").val().equals("미답변")){
				$("#searchWord").val(2);
			}else{
				alert("정확히 검색해주세요.");
				return false; 
			}	
		}
	});
	$(document).on('mouseover','.test li', function (e) {
		$(e.target).parent().children('li').css("background-color","rgb(0,0,0,0.1)");
	});
	$(document).on('mouseleave','.test li', function (e) {
		$(e.target).parent().children('li').css("background-color","white");
	}); 

	$(".select_pageNum a").attr("style","color:white");

});
</script>
<div class="wrap">
<%@ include file="adminTop.jspf" %>
<div class="admin_container">
	<div class="admin_gallery_wrap">
		<ul class="admin_gallery">
			<li>
				<div class="admin_gallery_content">
					<h2>문의사항</h2>
				</div>
			</li>
		</ul>
	</div>
	<ul class='mini_top'>
		<li>문의사항관리</li>
		<li>
			<!-- 검색 -->
			<div class='adminList_searchFrm'>
				<form method="get" action="/admin/adminHelpList" id='searchFrm'>
					<select name="searchKey" id="searchkey">
						<option value='b.no'>게시글번호</option>
						<option value='b.subject'>제목</option>
						<option value='m.nickname'>닉네임</option>
						<option value='cnt'>상태</option>
					</select>
					<input type="text" name="searchWord" id='searchWord' placeholder="검색"/>
					<input type="submit" value="검색" id="searchBtn"/>
				</form>
			</div>
		</li>
	</ul>
	<form method="get" action="/admin/adminHelpDel" id='listFrm'>
	<ul class="adminHelpList">
		<li class='list_title'>번호</li>
		<li class='list_title'>제목</li>
		<li class='list_title'>닉네임</li>
		<li class='list_title'>날짜</li>
		<li class='list_title'>상태</li>
		<li class='list_title'>전체선택<input type="checkbox" id="allCheck"/></li>
		<c:if test="${empty adminHelpList}">
			<div class="noanswer_img">
			</div>
		</c:if>		
		<c:forEach var="vo" items="${adminHelpList}">
		<ul class="test">
			<li>${vo.no }</li>
			<li><a href='/board/help/helpBoardView?no=${vo.no}' target="_blank">${vo.subject }</a></li>
			<li>${vo.nickname }</li>
			<li>${vo.write_date }</li>
			<li>
				<c:if test="${vo.cnt eq 0}">
					미답변
				</c:if>
				<c:if test="${vo.cnt ne 0}">
					답변완료
				</c:if>
			</li>
			<li><input type="checkbox" name="noList" value="${vo.no}" class="chk"/></li>
		</ul>
		</c:forEach>		
	</ul>
	</form>

	<input type="button" value="삭제" id="multiDel"/>
	<input type="button" value="목록" id="resetList" onclick="location.href='/admin/adminHelpList'"/>		
	
	<!-- 페이징 -->
	<ul class="paging">
	<!--  이전페이지 -->
	<c:if test="${pVO.pageNum == 1 }">
		<li class="arrow_prev"></li>
	</c:if>
	<c:if test="${pVO.pageNum > 1 }">
		<li class="arrow_prev"><a href="/admin/adminHelpList?pageNum=${pVO.pageNum-1}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">&nbsp;&nbsp;&nbsp;</a></li>
	</c:if>
	<c:forEach var="p" begin="${pVO.startPage}" end="${pVO.startPage+pVO.onePageCount-1}">
		<c:if test="${p<=pVO.totalPage}">
			<c:if test="${p==pVO.pageNum}">
				<li class="select_pageNum" style="font-weight: bold; background-color: #42454c;">
			</c:if>
			<c:if test="${p!=pVO.pageNum}">
				<li>
			</c:if>
			<a href="/admin/adminHelpList?pageNum=${p}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">${p}</a></li>
		</c:if>
	</c:forEach>
	<!--  다음페이지 -->
	<c:if test="${pVO.pageNum == pVO.totalPage }">
		<li class="arrow_next"></li>
	</c:if>
	<c:if test="${pVO.pageNum < pVO.totalPage }">
		<li class="arrow_next"><a href="/admin/adminHelpList?pageNum=${pVO.pageNum+1}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">&nbsp;&nbsp;&nbsp;</a></li>
	</c:if>
	</ul>
</div><!-- class='memberList_container' -->
</div>