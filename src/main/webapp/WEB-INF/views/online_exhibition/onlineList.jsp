<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/css/exhibition/onlineList.css">

<style>
	header {background-color:#000}
	html {-ms-overflow-style: none;}
	html::-webkit-scrollbar{display:none}
</style>
<script>
/*토글 메뉴*/
	$(document).ready(function(){
	    $('#online_ex_searchIcon').on('click',function(){
	        $('#online_ex_search').removeClass('searchHide').addClass('searchShow');
	    }); 
	});
	
	$(document).ready(function(){
	    $('#online_search_close').on('click',function(){
	        $('#online_ex_search').removeClass('searchShow').addClass('searchHide');
	    }); 
	});
</script>

    <div id="online_exhibition_container">
    	<h2 class="hidden">온라인 전시회</h2>
    	<a href="">작가목록</a>
	    <c:if test="${grade == '1'}"> <!-- 작가 : 1 -->
		   	<a href="">전시등록</a>
		   	<a href="">작품등록</a>
		</c:if>
	    <img id="online_ex_searchIcon" src="/img/exhibition/magnifying_glass.png" alt="검색 아이콘">
    	<div id="online_ex_search">
	    	<form id="ex_searchFrm">
		    	<select name="ex_search">
		    		<option>작품명</option>
		    		<option>작가</option>
		    	</select>
		    	<input type="text" name="ex_searchWord" id="ex_searchWord"/>
		        <input type="submit" value="검색"/>
		    </form>
		    <div>
		    	<a href="">&#60;</a> <!-- < 기호 -->
		    	<a href="">1</a>
		    	<a href="">2</a>
		    	<a href="">3</a>
		    	<a href="">&#62;</a> <!-- > 기호 -->
		    </div>
		    <img id="online_search_close" src="/img/exhibition/close.png" alt="닫기">
	    </div>
    	<div id="online_ex_wrap">
	    	<div id="room">
	    		<ul>
	    			<li>
	    				<span></span>
	    				<img src="/img/exhibition/test_img.jpg" alt="첫번째 작품">
	    			</li>
	    			<li>
	    				<p></p>
	    				<img src="/img/exhibition/test_img_1.jpg" alt="두번째 작품">
	    			</li>
	    		</ul>
	    		<button>작품보기</button>
	    	</div>
	    	<div>
	    		<img src="/img/exhibition/arrow_left.png" alt="이전">
	    		<div>
	    			<p></p>
	    			<p></p>
	    			<p></p>
	    			<p></p>
	    			<p></p>
	    			<p></p>
	    			<p></p>
	    		</div>
	    		<img src="/img/exhibition/arrow_right.png" alt="다음">
	    	</div>
    	</div>
    </div>