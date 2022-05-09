<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page trimDirectiveWhitespaces="true" %>
<link rel="stylesheet" href="/css/adminPage.css" type="text/css" />
<script>
$(function () {
	$(".author_upgrade").submit(function () {
		var check = confirm('작가로 승인하시겠습니까?');
		if(!check){
			return false;
		}
		
	});
	//모달창-취소버튼: 모달창on, 취소사유확인on, 취소사유입력close
	$(".modalup-reason").click(function(){
		$(".modal").css("display","block");
		$(".modal_reason").css("display","block");
		$(".modal_cancel").css("display","none");
		$('#reason_msg').val($(this).attr('title'));
	});
	//모달창-취소버튼: 모달창on, 취소사유확인close, 취소사유입력on
	$(".modalup-cancel").click(function(){
		$(".modal").css("display","block");
		$(".modal_reason").css("display","none");
		$(".modal_cancel").css("display","block");
		$('#cancel_no').val($(this).attr('title'));
		$('#textBox').val($(this).attr('name'));
	});
	//모달창 닫기
	$(".modalclose").click(function(){
		$(".modal").css("display","none");
		$(".modal_reason").css("display","none");
		$(".modal_cancel").css("display","none");
	});
	//모달창-취소사유: 글자수 100자제한.
	$('#textBox').keyup(function (e) {
		let content = $(this).val();
		if(content.length == 0 || content == ''){
			$('.textCount').text('0');
		}else{
			$('.textCount').text(content.length);
		}
		//글자수제한
		if(content.length>100){
			$(this).val($(this).val().substring(0,100));
		};
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
	<ul class='mini_top'>
		<li>작가관리</li>
		<li>
			<!-- 검색 -->
			<div class='adminList_searchFrm'>
				<form method="get" action="/admin/memberList" id='searchFrm'>
					<select name="searchKey" id="searchkey">
						<option value='member_no'>회원번호</option>
						<option value='author'>작가명</option>
						<option value='author_status'>상태</option>
					</select>
					<input type="text" name="searchWord" id='searchWord' placeholder="검색"/>
					<input type="submit" value="검색" id="searchBtn"/>
				</form>
			</div>
		</li>
	</ul>
	<ul class='authorList'>
		<li class='list_title'>번호</li>
		<li class='list_title'>회원번호</li>
		<li class='list_title'>작가명</li>
		<li class='list_title'>데뷔년도</li>
		<li class='list_title'>SNS주소</li>
		<li class='list_title'>신청날짜</li>
		<li class='list_title'>상태</li>
		<li class='list_title'>설정</li>
		
		<c:forEach var="vo" items="${authorList}">
		<li>${vo.no}</li>
		<li>${vo.member_no}</li>
		<li>${vo.author}</li>
		<li>${vo.debut_year}</li>
		<li><a href="${vo.sns_link}" target="_blank">${vo.sns_link}</a></li>
		<li>${vo.create_date}</li>
		<li>
			<c:if test="${vo.author_status == 0 && vo.msg eq null}">대기중</c:if>
			<c:if test="${vo.author_status == 0 && vo.msg ne null}">재신청</c:if>
			<c:if test="${vo.author_status == 1}">승인완료</c:if>
			<c:if test="${vo.author_status == 2}">취소됨</c:if>
		</li>
		<li>
			<c:if test="${vo.author_status == 0}">
			<form method="get" action="/admin/authorUpgrade" class='author_upgrade'>
				<input type="hidden" name="no" value="${vo.no}"/>
				<input type="submit" value="승인" class="author_ok"/>
			</form>
			</c:if>
			<!-- <form method="get" action="/admin/authorDelete" class='author_delete'>
				<input type="hidden" name="no" value="${vo.no}"/>
				<input type="submit" value="취소"/>
			</form> -->
			<c:if test="${vo.author_status == 0 || vo.author_status == 1}">
			<input type="button" value="취소" class="modalup-cancel" title="${vo.no}" name="${vo.msg}"/>
			</c:if>
			<c:if test="${vo.author_status == 2}">
			<input type="button" value="취소사유" class="modalup-reason" title="${vo.msg}"/>
			</c:if>
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
		<li><a href="/admin/authorList?pageNum=${pVO.pageNum-1}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">◀</a></li>
	</c:if>
	<c:forEach var="p" begin="${pVO.startPage}" end="${pVO.startPage+pVO.onePageCount-1}">
		<c:if test="${p<=pVO.totalPage}">
			<c:if test="${p==pVO.pageNum}">
				<li style="font-weight: bold;">
			</c:if>
			<c:if test="${p!=pVO.pageNum}">
				<li>
			</c:if>
			<a href="/admin/authorList?pageNum=${p}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">${p}</a></li>
		</c:if>
	</c:forEach>
	<!--  다음페이지 -->
	<c:if test="${pVO.pageNum == pVO.totalPage }">
		<li>▶</li>
	</c:if>
	<c:if test="${pVO.pageNum < pVO.totalPage }">
		<li><a href="/admin/authorList?pageNum=${pVO.pageNum+1}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">▶</a></li>
	</c:if>
		<li><input type="button" value="목록" id="resetList" onclick="location.href='/admin/authorList'"/></li>
	</ul>
</div> <!-- div:admin_container -->
</div>

<!--  div:modal -->	
<div class="modal">
	<div class="modal_body">
		<div class="modal_reason">
			<h1>취소사유 확인</h1>
			<textarea rows="10" cols="100" id="reason_msg" readonly="readonly"></textarea>
			<input type="button" value="확인" class="modalclose"/>
		</div>
		<div class="modal_cancel">
			<h1>취소사유 <span class="textCount">0</span>/100자</h1>
			<form method="get" action="/admin/authorDelete" class='author_delete'>
				<input type="hidden" name="no" value="" id="cancel_no"/>
				<textarea name="msg" rows="10" cols="100" id="textBox">취소사유: </textarea>
				<input type="submit" value="확인"/>
				<input type="button" value="취소" class="modalclose"/>
			</form>
		</div>
	</div>
</div><!--  div:modal -->	
</body>
</html>