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
<script>
$(function(){
	//프로필 이미지 미리
	$(document).on("change","input[name=filename]", function(){
	            console.log($(this));
	            var count = $(this).attr("data-count");
	            console.log(count);
	            console.log($(this).val());
	            //fileReader
	            var reader = new FileReader();
	            reader.onload = function(e) {
	                  document.getElementById("workPreview"+count).src = e.target.result;
	            };
	            reader.readAsDataURL(this.files[0]);
	            var format = this.files[0].name.split(".").pop();
	            $("#work_thumbnail"+count).val(count+"."+format);
	});
	
	
    $("#submit_btn").on("click", function(){
    	console.log("fffff")
        var len = $("form[name=ex_work_form]").length;
        for(var i=0; i<len;i++){
            var url = "${url}/workCreateOk";
            var data = new FormData($("form[name=ex_work_form]")[i]);
            console.log(data)
            
            $.ajax({
                url: url,
                processData: false,
                contentType: false,
                type : "POST",
                data : data,
                async : false,
                success : function(){
        
                },
                error : function(){
                    
                }
            });
        }
    });
    $("#submitDel_btn").on("click", function(){
    	var len = $("form[name=ex_work_form]").length;
    	console.log(len)
    	
    	var url = "/exhibition/workDel";
    	$.ajax({
    		url: url,
    		type : "POST"
    	})
    });
})
</script>
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
								<input type="date" name="start_date" id="startDate" class="ridingDate"> - <input type="date" name="end_date" id="endDate" class="ridingDate">
							</li>
							<li class="exhibitionWriteDate">
								<p>전시명</p>
								<input type="text" name="subject">
							</li>
							<li class="exhibitionWriteContent">
								<p>전시 설명</p>
								<textarea name="content"></textarea>
							</li>
							<li class="exhibitionWriteType">
								<p>전시 유형</p>
								<div><input id="exhibitionRadio" type="radio" name="type" value="1"> <span>그림 전시</span>
								<input id="exhibitionRadio" type="radio" name="type" value="2"> <span>글 전시</span></div>
							</li>
						</ul>
						<input type="submit" value="등록하기" id="exhibitionSubmit"/>
					</form>
    			</li>    		
    		</ul>
    		<i class="fa-solid fa-xmark"></i>
    	</div>
    </div>
    
    <!-- 작품등록 모달 -->
    <div id="ex_work_bg" class="modal">
    	<div id="ex_work_wrap" class="modal_wrap" style="overflow:auto;">
    		<h3>작품등록</h3>
    		<a href="javascript:;" id="addWork"><i class="fa-solid fa-plus"></i>작품추가</a>
    		<!-- 
    		<form name="ex_work_form" id="ex_work_form" method="post" action="/workCreateOk" enctype="multipart/form-data">
				<ul id="ex_work_box">
					<li class="exhibitionWorkContent">
						<ul>
							<li class="workThumbnail">
								<p class="hidden">작품 썸네일</p>
								<figure><img src="" id="workPreview1"/></figure>
								<input class="work_upload-name" value="첨부파일" placeholder="첨부파일" readonly>
								<input type="file" name="filename" id="work_file1" class="workFile"/>
								<label for="work_file1">파일찾기</label> 
								
							</li>
							<li class="exhibitionApplyTitle">
								<p>작품명</p>
								<input type="text" name="work_subject">
							</li>
							<li class="exhibitionApplyContent">
								<p>작품 설명</p>
								<textarea name="work_content"></textarea>
							</li>
						</ul>
					</li>
				</ul>
				<a href="javascript:;" id="addWork"><i class="fa-solid fa-plus"></i>작품추가</a>
			</form>
			-->
			<c:if test="${workList != null}">
				<c:forEach var="vo" items="${workList}" varStatus="status">
		    		<form name="ex_work_form" id="ex_work_form" method="post" action="/workCreateOk" enctype="multipart/form-data">
						<ul id="ex_work_box">
							<li class="exhibitionWorkContent">
								<ul>
									<li class="workThumbnail">
										<p class="hidden">작품 썸네일</p>
										<figure><img src="${url}/upload/${logNo}/author/exhibition/${vo.exhibition_no}/${vo.work_thumbnail}" id="workPreview${status.count}" name="workPreview${status.count}"/></figure>
										<input type="hidden" name="no" value="${vo.no}"/>
										<input class="work_upload-name" name="work_thumbnail" placeholder="첨부파일" id="work_thumbnail${status.count}" value="${vo.work_thumbnail}"readonly>
										<input type="file" name="filename" id="work_file${status.count}" class="workFile" data-count="${status.count}"/>
										<label for="work_file${status.count}">파일찾기</label> 
										
									</li>
									<li class="exhibitionApplyTitle">
										<p>작품명</p>
										<input type="text" name="work_subject" value="${vo.work_subject}">
									</li>
									<li class="exhibitionApplyContent">
										<p>작품 설명</p>
										<textarea name="work_content">${vo.work_content}</textarea>
									</li>
								</ul>
							</li>
						</ul>
						<a href="javascript:;" id="addWork"><i class="fa-solid fa-plus"></i>작품추가</a>
					</form>					
				</c:forEach>
			</c:if>
			<input type="button" value="등록하기" id="submit_btn"/>
			<input type="button" value="삭제하기" id="submitDel_btn"/>
			<i class="fa-solid fa-xmark"></i>
    	</div>
    </div>