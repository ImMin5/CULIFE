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
		  <form id="authorSearchFrm" name="authorSearch" autocomplete="off">
		    <div class="finder">
		      <div class="finder__outer">
		        <div class="finder__inner">
		          <div class="finder__icon"></div>
		          <input class="finder__input" type="text" onkeypress="press()"/>
		        </div>
		      </div>
		    </div>
		  </form>
		</div>
		<ul id="authorSearchResult">
			<li>
				<span class="hidden">번호</span>
				<img src="/img/exhibition/test_img_1.jpg" alt="프로필 사진">
				<div class="author_details">
					<h2>권길동</h2>
					<p>이곳은 자기소개를 보여주는 공간입니다.</p>
					<a href="">자세히보기 ></a>
				</div>
			</li>
			<li>
				<span class="hidden">번호</span>
				<img src="/img/exhibition/test_img_1.jpg" alt="프로필 사진">
				<div class="author_details">
					<h2>김길동</h2>
					<p>이곳은 자기소개를 보여주는 공간입니다.</p>
					<a href="">자세히보기 ></a>
				</div>
			</li>
			<li>
				<span class="hidden">번호</span>
				<img src="/img/exhibition/test_img_1.jpg" alt="프로필 사진">
				<div class="author_details">
					<h2>이길동</h2>
					<p>이곳은 자기소개를 보여주는 공간입니다.</p>
					<a href="">자세히보기 ></a>
				</div>
			</li>
			<li>
				<span class="hidden">번호</span>
				<img src="/img/exhibition/test_img_1.jpg" alt="프로필 사진">
				<div class="author_details">
					<h2>최길동</h2>
					<p>이곳은 자기소개를 보여주는 공간입니다.</p>
					<a href="">자세히보기 ></a>
				</div>
			</li>
			<li>
				<span class="hidden">번호</span>
				<img src="/img/exhibition/test_img_1.jpg" alt="프로필 사진">
				<div class="author_details">
					<h2>허길동</h2>
					<p>이곳은 자기소개를 보여주는 공간입니다.</p>
					<a href="">자세히보기 ></a>
				</div>
			</li>
			<li>
				<span class="hidden">번호</span>
				<img src="/img/exhibition/test_img_1.jpg" alt="프로필 사진">
				<div class="author_details">
					<h2>홍길동</h2>
					<p>이곳은 자기소개를 보여주는 공간입니다.<br/>이곳은 자기소개를 보여주는 공간입니다.이곳은 자기소개를 보여주는 공간입니다.</p>
					<a href="">자세히보기 ></a>
				</div>
			</li>
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
	</div>
</div>