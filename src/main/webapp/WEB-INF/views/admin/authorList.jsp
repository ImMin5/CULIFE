<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page trimDirectiveWhitespaces="true" %>
<link rel="stylesheet" href="/css/adminPage.css" type="text/css" />
<style>
	.admin_gallery li:nth-child(1) {
		background: url(/img/admin/2.jpg) no-repeat center center;
	}
</style>
<script>
$(function () {	
	//모달창-취소버튼: 모달창on, 취소사유확인close, 취소사유입력on
	$(".modalup_info").click(function(){
		$(".modal").css("display","block");
		$(".modal_info").css("display","block");
		console.log($(this).attr('title'));
		//작가 정보 가져오기.
			var url = "/admin/adminAuthorInfo";
			$.ajax({
				url: url,
				data: {
					no: $(this).attr('title')
				},
				success: function(vo) {
					var tag = '<ul>';
					tag += '<li>작가신청</li>';
					tag += '<li><img src="/upload/'+vo.member_no+'/author/thumbnail/'+vo.author_thumbnail+'" id="preview" style="width: 170px; height: 170px;" /></li>';
					tag += '<li>작가명: '+vo.author+'</li>';
					tag += '<li>SNS주소: <a href="'+vo.sns_link+'" target="_blank">'+vo.sns_link+'</a></li>';
					tag += '<li>데뷔년도: '+vo.debut_year+'</li>';
					tag += '<li>자기소개 </li>	';
					tag += '<li><textarea name="msg" rows="10" id="textBox1" readonly="readonly" style="width:86.5%; resize:none">'+vo.author_msg+'</textarea></li>';
					tag += '<li>취소사유   <span class="textCount">0</span>/100</li>';
					tag += '</ul>';
					tag += '<form method="get" action="/admin/authorDelete" class="author_delete">';
					tag += '<input type="hidden" name="no" value="'+vo.no+'" id="cancel_no"/>';
					tag += '<input type="hidden" name="member_no" value="'+vo.member_no+'" id="cacel_member_no"/>';
					/* 취소일때 - 취소사유확인 */
					if(vo.author_status == 2){
						tag += '<textarea name="msg" rows="10" cols="70" id="textBox2" readonly="readonly" style="width:86.5%; resize:none">'+vo.msg+'</textarea>';
					}
					/* 신청일때 - 걍 취소*/
					if(vo.author_status == 0 && vo.msg == null || vo.author_status == 1){
						tag += '<textarea name="msg" rows="10" cols="70" id="textBox2" style="width:86.5%; resize:none" onclick="alert("감자")">취소사유: </textarea>';						
					}
					/* 재신청일때 - 취소사유보여주고 재설정 */
					if(vo.author_status == 0 && vo.msg != null){
						tag += '<textarea name="msg" rows="10" cols="70" id="textBox2" style="width:86.5%; resize:none" onkeyup="alert("감자")">'+vo.msg+'</textarea>';
					}
					if(vo.author_status == 0){
						tag += '<div class="btn_wrap">'
						tag += '<input type="button" value="작가승인" id="author_ok" title="'+vo.no+'"/>';
						tag += '<input type="button" value="작가취소" id="author_cancel"/>';
						tag += '<input type="button" value="닫기" class="modalclose"/>';
						tag += '</div>'
					}
					if(vo.author_status == 1){
						tag += '<div class="btn_wrap">'
						tag += '<input type="button" value="작가취소" id="author_cancel"/>';
						tag += '<input type="button" value="닫기" class="modalclose"/>';
						tag += '</div>'
					}
					if(vo.author_status == 2){
						tag += '<input type="button" value="닫기" class="modalclose"/>';
					}
					tag += '</form>'; 
					$(".modal_info").html(tag);
				},
				error: function(e) {
					console.log(e.responseText);
				}
			});
	});
	
	//모달창-취소사유: 글자수 100자제한.
	$(document).on('keyup','#textBox2', function (e) {
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
	
	//모달창 닫기(1)
	$(document).on('click','.modalclose', function (e) {
		$(".modal").css("display","none");
		$(".modal_info").css("display","none");
	});
	//모달창 닫기(2)
	$(document).on('click','.modal', function (e) {
		if($(e.target).hasClass('modal')){
			$(".modal").css("display","none");
			$(".modal_info").css("display","none");
		}
	});
	
	//작가 승인
	$(document).on('click','#author_ok', function (e) {
		var url = "/admin/authorUpgrade";
		$.ajax({
			url: url,
			data: {
				no: $(this).attr('title'),
				member_no: $("#cacel_member_no").val()
			},
			success: function(vo) {
				alert("승인이 완료되었습니다.");
				location.reload();
			},
			error: function(e) {
				console.log(e.responseText);
			}
		});
	});
	
	//작가 취소
	$(document).on('click','#author_cancel', function (e) {
		$(".author_delete").submit();
	});
	$("#searchFrm").submit(function(){
		if($("#searchWord").val()==""){
			alert("검색어를 입력해주세요.");
			return false;
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
					<h2>작가관리</h2>
				</div>
			</li>
		</ul>
	</div>
	<ul class='mini_top'>
		<li>작가관리</li>
		<li>
			<!-- 검색 -->
			<div class='adminList_searchFrm'>
				<form method="get" action="/admin/authorList" id='searchFrm'>
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
		<c:if test="${empty authorList}">
			<div class="noanswer_img">
			</div>
		</c:if>	
		
		<c:forEach var="vo" items="${authorList}">
		<ul class="test">
		<li>${vo.no}</li>
		<li>${vo.member_no}</li>
		<li>${vo.author}</li>
		<li>${vo.debut_year}</li>
		<li><a href="${vo.sns_link}" target="_blank">${vo.sns_link}</a></li>
		<li>${vo.create_date}</li>
		<li>
			<c:if test="${vo.author_status == 0 && vo.msg eq null}">대기(일반)</c:if>
			<c:if test="${vo.author_status == 0 && vo.msg ne null}">대기(재신청)</c:if>
			<c:if test="${vo.author_status == 1}">승인</c:if>
			<c:if test="${vo.author_status == 2}">취소</c:if>
		</li>
		<li>
			<input type="button" value="상세보기" class="modalup_info" title="${vo.no}"/>
		</li>
		</ul>
		</c:forEach>
	</ul>
	<input type="button" value="목록" id="resetList" onclick="location.href='/admin/authorList'"/>
	<!-- 페이징 -->
	<ul class="paging">
	<!--  이전페이지 -->
	<c:if test="${pVO.pageNum == 1 }">
		<li class="arrow_prev"></li>
	</c:if>
	<c:if test="${pVO.pageNum > 1 }">
		<li class="arrow_prev"><a href="/admin/authorList?pageNum=${pVO.pageNum-1}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">&nbsp;&nbsp;&nbsp;</a></li>
	</c:if>
	<c:forEach var="p" begin="${pVO.startPage}" end="${pVO.startPage+pVO.onePageCount-1}">
		<c:if test="${p<=pVO.totalPage}">
			<c:if test="${p==pVO.pageNum}">
				<li class="select_pageNum" style="font-weight: bold; background-color: #42454c;">
			</c:if>
			<c:if test="${p!=pVO.pageNum}">
				<li>
			</c:if>
			<a href="/admin/authorList?pageNum=${p}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">${p}</a></li>
		</c:if>
	</c:forEach>
	<!--  다음페이지 -->
	<c:if test="${pVO.pageNum == pVO.totalPage }">
		<li class="arrow_next"></li>
	</c:if>
	<c:if test="${pVO.pageNum < pVO.totalPage }">
		<li class="arrow_next"><a href="/admin/authorList?pageNum=${pVO.pageNum+1}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">&nbsp;&nbsp;&nbsp;</a></li>
	</c:if>
	</ul>
</div> <!-- div:admin_container -->
</div>

<!--  div:modal -->	
<div class="modal" id="modal">
	<div class="modal_body">
		<div class="modal_info">
		</div>
	</div>
</div><!--  div:modal -->	

</body>
</html>