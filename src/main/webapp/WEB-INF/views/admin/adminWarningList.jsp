<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page trimDirectiveWhitespaces="true" %>
<link rel="stylesheet" href="/css/adminPage.css" type="text/css" />
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
	<ul class='mini_top'>
		<li>신고관리</li>
		<li>
			<!-- 검색 -->
			<div class='adminList_searchFrm'>
				<form method="get" action="/admin/adminWarningList" id='searchFrm'>
					<select name="searchKey" id="searchkey">
						<option value='category'>카테고리</option>
						<option value='title'>작품명</option>
						<option value='content'>리뷰내용</option>
						<option value='nickname'>작성자</option>
						<option value='reporter'>신고자</option>
					</select>
					<input type="text" name="searchWord" id='searchWord' placeholder="검색"/>
					<input type="submit" value="검색" id="searchBtn"/>
				</form>
			</div>
		</li>
	</ul>
	<form method="get" action="/admin/adminWarningDel" id='listFrm'>
	<ul class='adminWarningList'>
		<li class='list_title'>카테고리</li>
		<li class='list_title'>작품명</li>
		<li class='list_title'>리뷰내용</li>
		<li class='list_title'>작성자</li>
		<li class='list_title'>신고자</li>
		<li class='list_title'>신고일</li>
		<li class='list_title'>전체선택<input type="checkbox" id="allCheck"/></li>
		
		<c:forEach var="vo" items="${adminWarningList}">
			<li>${vo.category }</li>
			<li>${vo.title }</li>
			<li>
				<c:if test="${vo.category eq '영화' }">
					<a href='${url}/movie/movieView?movieId=${vo.numb}' target="_blank">${vo.content }</a>
				</c:if>
				<c:if test="${vo.category ne '영화' }">
					<a href='${url}/theater/theaterView?seq=${vo.numb}' target="_blank">${vo.content }</a>
				</c:if>
			</li>
			<li>${vo.nickname }</li>
			<li>${vo.reporter }</li>
			<li>${vo.write_date }</li>
			<li>
				<c:if test="${vo.category eq '영화' }">
					<input type="checkbox" name="movie_noList" value="${vo.no}" class="chk"/>
				</c:if>
				<c:if test="${vo.category ne '영화' }">
					<input type="checkbox" name="noList" value="${vo.no}" class="chk"/>
				</c:if>
			</li>
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
		<li><a href="/admin/adminWarningList?pageNum=${pVO.pageNum-1}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">◀</a></li>
	</c:if>
	<c:forEach var="p" begin="${pVO.startPage}" end="${pVO.startPage+pVO.onePageCount-1}">
		<c:if test="${p<=pVO.totalPage}">
			<c:if test="${p==pVO.pageNum}">
				<li style="font-weight: bold;">
			</c:if>
			<c:if test="${p!=pVO.pageNum}">
				<li>
			</c:if>
			<a href="/admin/adminWarningList?pageNum=${p}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">${p}</a></li>
		</c:if>
	</c:forEach>
	<!--  다음페이지 -->
	<c:if test="${pVO.pageNum == pVO.totalPage }">
		<li>▶</li>
	</c:if>
	<c:if test="${pVO.pageNum < pVO.totalPage }">
		<li><a href="/admin/adminWarningList?pageNum=${pVO.pageNum+1}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">▶</a></li>
	</c:if>
		<li>
			<input type="button" value="삭제" id="multiDel"/>
			<input type="button" value="목록" id="resetList" onclick="location.href='/admin/adminWarningList'"/>		
		</li>
	</ul>
</div> <!-- div:admin_container -->
</div>