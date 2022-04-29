<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/inc/adminTop.jspf" %>
<link rel="stylesheet" href="/css/memberList.css" type="text/css" />
<script>

</script>

<div class="container">
	<h1>회원관리</h1>
	<ul class='memberList'>
		<li>번호</li>
		<li>카카오ID</li>
		<li>닉네임</li>
		<li>회원등급</li>
		<li>회원가입일</li>
		<li>회원상태</li>
		<li>&nbsp;&nbsp;&nbsp;&nbsp;</li>

		<c:forEach var="vo" items="${memberList}">
			<li>${vo.no}</li>
			<li>${vo.kakao_id}</li>
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
			<c:if test="${vo.status eq 'False'}">
			<li>정상</li>
			</c:if>
			<c:if test="${vo.status eq 'True'}">
			<li>정지</li>
			</c:if>	
			<li>
				<form method="get" action="/admin/memberStatus" id='statusFrm'>
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
		<li>prev</li>
	</c:if>
	<c:if test="${pVO.pageNum > 1 }">
		<li><a href="/admin/memberList?pageNum=${pVO.pageNum-1}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">prev</a></li>
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
		<li>next</li>
	</c:if>
	<c:if test="${pVO.pageNum < pVO.totalPage }">
		<li><a href="/admin/memberList?pageNum=${pVO.pageNum+1}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">next</a></li>
	</c:if>	
		
	</ul>
	
	<!-- 검색 -->
	<div>
		<form method="get" action="/admin/memberList" id='searchFrm'>
			<select name="searchKey">
				<option value='kakao_id'>카카오ID</option>
				<option value='nickname'>닉네임</option>
				<option value='grade'>회원등급</option>
				<option value='status'>회원상태</option>
			</select>
			<input type="text" name="searchWord" id='searchWord'/>
			<input type="submit" value="검색"/>
		</form>
	</div>
	
	
</div><!-- class='container' -->
</body>
</html>