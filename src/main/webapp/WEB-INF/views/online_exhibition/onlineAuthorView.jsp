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
</style>
<div id="authorView_container">
	<div id="authorView_wrap">
		<h1 class="hidden"></h1>
		<ul>
			<li id="author_profile">
				<h2 class="hidden">상세정보</h2>
				<img src="/img/exhibition/test_img.jpg">
				<ul>
					<li>작가명 : ${vo.author}</li>
					<li>데뷔년도 : ${vo.debut_year}</li>
					<li>작가소개</li>
					<li>${vo.author_msg}</li>
				</ul>
			</li>
			<li id="author_works">
				<h2>작가의 작품</h2>
				<ul>
					<li><img src="/img/exhibition/test_img.jpg"></li>
					<li><img src="/img/exhibition/test_img_1.jpg"></li>
					<li><img src="/img/exhibition/test_img_1.jpg"></li>
					<li><img src="/img/exhibition/test_img_1.jpg"></li>
					<li><img src="/img/exhibition/test_img_1.jpg"></li>
					<li><img src="/img/exhibition/test_img_1.jpg"></li>
					<li><img src="/img/exhibition/test_img_1.jpg"></li>
					<li><img src="/img/exhibition/test_img_1.jpg"></li>
				</ul>
				<!-- 페이지네이션 -->
				<div class="pagination">
					<ol>
				    	<li><a href="">&#60;</a></li> <!-- < 기호 -->
				    	<li><a href="">1</a></li>
				    	<li><a href="">2</a></li>
				    	<li><a href="">3</a></li>
				    	<li><a href="">&#62;</a></li> <!-- > 기호 -->
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
	    				<li><figure class="workDetail_img"><img src="/img/exhibition/test_img.jpg"></figure></li>    		
		    			<li class="workDetail_info">
		    				<ul>
								<li>작가 : ${vo.author}</li>
								<li>작품명 : </li>
								<li>전시기간 : </li>
								<li>작품설명</li>
								<li><p></p></li>
							</ul>
						</li>
    				</ul>
    			</li> 
    			<li>
    				<ul>
	    				<li><figure class="workDetail_img"><img src="/img/exhibition/test_img.jpg"></figure></li>    		
		    			<li class="workDetail_info">
		    				<ul>
								<li>작가 : </li>
								<li>작품명 : </li>
								<li>전시기간 : </li>
								<li>작품설명</li>
								<li><p></p></li>
							</ul>
						</li>
    				</ul>
    			</li>
    			<li>
    				<ul>
	    				<li><figure class="workDetail_img"><img src="/img/exhibition/test_img.jpg"></figure></li>    		
		    			<li class="workDetail_info">
		    				<ul>
								<li>작가 : </li>
								<li>작품명 : </li>
								<li>전시기간 : </li>
								<li>작품설명</li>
								<li><p></p></li>
							</ul>
						</li>
    				</ul>
    			</li> 		
    		</ul>
    		<i class="fa-solid fa-xmark"></i>
    	</div>
    </div>