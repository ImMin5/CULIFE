<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/css/exhibition/authorView.css">
<script src="/js/modal.js"></script>
<script src="/js/authorView.js"></script>

<style>
	body{
		-webkit-user-select:none; 
		-moz-user-select:none; 
		-ms-user-select:none; 
		user-select:none
	}
	html {-ms-overflow-style: none;}
	html::-webkit-scrollbar{display:none}
</style>
<script>
	$(function(){
		get_author_fan(${param.no});
	})
</script>
<div id="authorView_container">
	<div id="authorView_wrap">
		<h1 class="hidden"></h1>
		<ul>
			<li id="author_profile">
				<h2 class="hidden">상세정보</h2>
				<img src="${url}/upload/${vo.member_no}/author/${vo.author_thumbnail}">
				<ul>
					<li>작가명 : ${vo.author}</li>
					<li>데뷔년도 : ${vo.debut_year}</li>
					<li>SNS : <a href="${vo.sns_link}">${vo.sns_link}</a></li>
					<li id="author_fan_count">팔로워 : </li>
					<li>작가소개</li>
					<li>${vo.author_msg}</li>
					<li>
						<c:choose>
							<c:when test="${vo.member_no == logNo}">
								<a href="${url}/mypage/author">마이페이지로 이동</a>
							</c:when>
							<c:when test="${followInfo == null}">
								<button name="follow" data-author="${vo.author}" data-author_no="${vo.no}" class="a_follow_btn"><span>FOLLOW</span></button>
							</c:when>
							<c:otherwise>
								<button name="unfollow" data-author="${vo.author}" data-author_no="${vo.no}" class="a_following_btn"><span>FOLLOWING</span></button>
							</c:otherwise>
						</c:choose>
							
					</li>
					<li>
						<a href="${url}/online_exhibition/onlineAuthorList">&#60;목록으로 돌아가기&#62;</a>
					</li>
				</ul>
			</li>
			<li id="author_works">
				<h2>작가의 작품</h2>
				<ul>
					<c:forEach var="vv" items="${workList}">
						<li>
							<img src="${url}/upload/${vo.member_no}/author/exhibition/${vv.exhibition_no}/${vv.work_thumbnail}"
							data-member_no="${vo.member_no}"
							data-exhibition_no="${vv.exhibition_no }" data-work_thumbnail="${vv.work_thumbnail}" data-work_subject="${vv.work_subject}" data-start_date="${vv.start_date }" data-end_date="${vv.end_date}" data-work_content="${vv.work_content}" >
							</li>
					</c:forEach>
				</ul>
				<!-- 페이지네이션 -->
				<div class="pagination">
					<ol>
						<!-- 이전페이지  -->
						<c:choose> 
							<c:when test="${pvo.currentPage==1 }">
				    			<li><a href="">&#60;</a></li> <!-- < 기호 -->
				    		</c:when>
				    		<c:otherwise>
				    				<li><a href="${url}/online_exhibition/onlineAuthorView?no=${vo.no}&currentPage=${pvo.currentPage-1}">&#60;</a></li> <!-- < 기호 -->
				    		</c:otherwise>
				    	</c:choose>
				    	<!-- 페이지 번호 -->
				    	<c:forEach var="p" begin="${pvo.startPage}" end="${pvo.startPage+pvo.onePageCount-1}">
				    		<c:if test ="${p <= pvo.totalPage}">
								<c:if test="${p==pvo.currentPage }">
									<li><a href="${url}/online_exhibition/onlineAuthorView?no=${vo.no}&currentPage=${p}">${p}</a></li>
								</c:if>
								<c:if test="${p!=pvo.currentPage }">
									<li><a href="${url}/online_exhibition/onlineAuthorView?no=${vo.no}&currentPage=${p}">${p}</a></li>
								</c:if>
							</c:if>
						</c:forEach>
						<!-- 다음페이지 -->
						<c:choose> 
							<c:when test="${pvo.currentPage==pvo.totalPage }">
				    				<li><a href="">&#62;</a></li> <!-- > 기호 -->
				    		</c:when>
				    		<c:otherwise>
				    				<li><a href="${url}/online_exhibition/onlineAuthorView?no=${vo.no}&currentPage=${pvo.currentPage+1}">&#62;</a></li> <!-- < 기호 -->
				    		</c:otherwise>
				    	</c:choose>
				    
				    </ol>
				</div>
			</li>
		</ul>
	</div>
</div>

	<!-- 작품 상세 페이지 모달 -->
	<div id="workDetail_bg" class="modal">
    	<div id="workDetail_wrap" class="modal_wrap">
    		<h3>작품 상세</h3>
    		<ul>
    			<li>
    				<ul>
	    				<li><figure class="workDetail_img"><img id="modal_work_thumbnail" src="/img/exhibition/test_img.jpg"></figure></li>    		
		    			<li class="workDetail_info">
		    				<ul>
								<li>작가 : ${vo.author}</li>
								<li id="modal_subject">작품명 : </li>
								<li id="modal_start_date">전시기간 : </li>
								<li>작품설명</li>
								<li><p id="modal_content" ></p></li>
							</ul>
						</li>
    				</ul>
    			</li> 
    		</ul>
    		<i class="fa-solid fa-xmark"></i>
    	</div>
    </div>
    <div id="imgZoom">
    	<i class="fa-solid fa-xmark"></i>
    	<img class="pop" src="">
    </div>