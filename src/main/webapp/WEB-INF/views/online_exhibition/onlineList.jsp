<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/css/exhibition/onlineList.css">
<script src="/js/modal.js"></script>
<script src="/js/online_exhibition.js"></script>

<style>
	header {background-color:#000}
	html {-ms-overflow-style: none;}
	html::-webkit-scrollbar{display:none}
	input:focus {
		border:2px solid orange;
		border-color:orange;
	    outline: none;
	}
	textarea:focus {
		border:2px solid orange;
		border-color:orange;
	    outline: none;
	}
</style>

    <div id="online_exhibition_container">
    	<h2 class="hidden">온라인 전시회</h2>
    	<a href="/online_exhibition/onlineAuthorList">작가목록</a>
	    <c:if test="${grade == '1'}"> <!-- 작가 : 1 -->
		   	<a href="javascript:;" id="reg_ex">전시등록</a>
		   	<a href="javascript:;" id="reg_work">작품등록</a>
		</c:if>
	    <img id="online_ex_searchIcon" src="/img/exhibition/magnifying_glass.png" alt="검색 아이콘">
    	<div id="online_ex_search">
    		<h3>전시작품 검색</h3>
	    	<form id="ex_searchFrm">
		    	<select name="ex_search">
		    		<option>작품명</option>
		    		<option>작가</option>
		    	</select>
		    	<input type="text" name="ex_searchWord" id="ex_searchWord"/>
		        <input type="submit" value="검색"/>
		    </form>
		    <ol>
		    	<li><a href="">&#60;</a></li> <!-- < 기호 -->
		    	<li><a href="">1</a></li>
		    	<li><a href="">2</a></li>
		    	<li><a href="">3</a></li>
		    	<li><a href="">&#62;</a></li> <!-- > 기호 -->
		    </ol>
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
	    		<button class="w-btn-neon2" type="button">작품보기</button>
	    	</div>
	    	<div id="online_ex_pagination">
	    		<img id="online_ex_prev" src="/img/exhibition/arrow_left.png" alt="이전">
	    		<div>
	    			<p></p>
	    			<p></p>
	    			<p></p>
	    			<p></p>
	    			<p></p>
	    			<p></p>
	    			<p></p>
	    		</div>
	    		<img id="online_ex_next" src="/img/exhibition/arrow_right.png" alt="다음">
	    	</div>
    	</div>
    </div>
    
    <!-- 전시등록 모달 -->
    <div id="exhibition_reg_bg" class="modal">
    	<div id="exhibition_wrap" class="modal_wrap">
    		<h3>전시등록</h3>
    		<ul>
    			<li>
    				<figure id="ex_reg_img"></figure>
    				<span>어서오세요 작가님,<br/>즐거운 전시회 시간을 가져보세요.</span>
    			</li>    		
    			<li>
    				<form id="ex_reg_form" method="post" action="/exhibitionWriteOk" enctype="multipart/form-data">
						<ul class="exhibitionWriteContent">
							<li class="exhibitionWriteTitle">
								<p>전시 기간</p>
								<input type="date" name="startDate" id="startDate" class="ridingDate"> - <input type="date" name="endDate" id="endDate" class="ridingDate">
							</li>
							<li class="exhibitionWriteDate">
								<p>전시명</p>
								<input type="text">
							</li>
							<li class="exhibitionWriteContent">
								<p>전시 설명</p>
								<textarea></textarea>
							</li>
						</ul>
						<input type="submit" value="등록하기" />
					</form>
    			</li>    		
    		</ul>
    		<i class="fa-solid fa-xmark"></i>
    	</div>
    </div>
    
    <!-- 작품등록 모달 -->
    <div id="ex_work_bg" class="modal">
    	<div id="ex_work_wrap" class="modal_wrap">
    		<h3>작품등록</h3>
    		<form id="ex_work_form" method="post" action="" enctype="multipart/form-data">
				<ul id="ex_work_box">
					<li class="exhibitionWorkContent">
						<ul>
							<li class="workThumbnail">
								<p class="hidden">작품 썸네일</p>
								<figure><img src="" id="workPreview1"/></figure>
								<input class="work_upload-name" value="첨부파일" placeholder="첨부파일" readonly>
								<input type="file" name="work_name" id="work_file1" class="workFile"/>
								<label for="work_file1">파일찾기</label> 
							</li>
							<li class="exhibitionApplyTitle">
								<p>작품명</p>
								<input type="text">
							</li>
							<li class="exhibitionApplyContent">
								<p>작품 설명</p>
								<textarea></textarea>
							</li>
						</ul>
					</li>
				</ul>
				<a href="javascript:;" id="addWork"><i class="fa-solid fa-plus"></i>작품추가</a>
				<input type="submit" value="등록하기" />
			</form>
			<i class="fa-solid fa-xmark"></i>
    	</div>
    </div>