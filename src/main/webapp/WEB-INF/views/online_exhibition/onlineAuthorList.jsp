<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/css/exhibition/authorList.css">
<script src="/js/authorList.js"></script>

<style>
	body{
		-webkit-user-select:none; 
		-moz-user-select:none; 
		-ms-user-select:none; 
		user-select:none
	}
</style>

<div id="authorList_container">
	<div id="authorList_wrap">
		<h1 class="hidden">작가 검색 페이지</h1>
		<a href="/online_exhibition/onlineList">전시회가기</a>
		<div class="authorSearchcontainer">
			<form method="get" action="/online_exhibition/onlineAuthorList" id="authorSearchFrm" name="onlineAuthorList" autocomplete="off">
		  		<div class="finder">
		    		<div class="finder__outer">
		        		<div class="finder__inner">
		          			<div class="finder__icon"></div>
		          			<input class="finder__input" type="text" name="searchWord" id="searchWord">
		        		</div>
		      		</div>
		    	</div>
			</form>
		</div>
		<ul id="authorSearchResult">
			<c:forEach var="vo" items="${list}">
				<li>
					<span class="hidden">${vo.no}</span>
					<img src="<c:url value='${url}/upload/${vo.member_no}/author/${vo.author_thumbnail }'/>">
					<div class="author_details">
						<h2>${vo.author}</h2>
						<p>${vo.author_msg }</p>
						<a href="/online_exhibition/onlineAuthorView?no=${vo.no }">자세히보기</a>
					</div>
				</li>
			</c:forEach>
		</ul>
		
		<!-- 페이지네이션 -->
		<div class="pagination">
			<ol> 
				<c:if test="${pVO.currentPage==1}">
		    		<li>&#60;</li> <!-- < 기호 -->
		    	</c:if>
		    	<c:if test="${pVO.currentPage>1}">
		        	<li><a href="/online_exhibition/onlineAuthorList?currentPage=${pVO.currentPage-1}<c:if test='${pVO.searchWord!=null}'>&searchWord=${pVO.searchWord}</c:if>">&#60;</a></li>
		        </c:if>
		    	<c:forEach var="p" begin="${pVO.startPage}" end="${pVO.startPage+pVO.onePageCount-1}">
           		 	<c:if test="${p<=pVO.totalPage}">
               			<c:if test="${p==pVO.currentPage}">
               				<li><a style="color:white; background-color:black" href="/online_exhibition/onlineAuthorList?currentPage=${p}<c:if test='${pVO.searchWord!=null}'>&searchWord=${pVO.searchWord}</c:if>">
              			</c:if>
               			<c:if test="${p!=pVO.currentPage}">
               				<li><a href="/online_exhibition/onlineAuthorList?currentPage=${p}<c:if test='${pVO.searchWord!=null}'>&searchWord=${pVO.searchWord}</c:if>">
              			</c:if>
              			${p}</a></li>
             		</c:if>
        		</c:forEach>
		    	<c:if test="${pVO.currentPage==pVO.totalPage}">
		    		<li>&#62;</li> <!-- > 기호 -->
		    	</c:if>
		    	<c:if test="${pVO.currentPage<pVO.totalPage}">
		        	<li><a href="/online_exhibition/onlineAuthorList?currentPage=${pVO.currentPage+1}<c:if test='${pVO.searchWord!=null}'>&searchWord=${pVO.searchWord}</c:if>">&#62;</a></li>
		        </c:if>
		    </ol>
		</div>
	</div>
</div>