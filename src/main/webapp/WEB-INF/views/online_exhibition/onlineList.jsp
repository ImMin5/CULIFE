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
                success : function(data){
                },
                error : function(){
                    
                }
            });
        }
        location.reload();
    });
    $("#submitDel_btn").on("click", function(){
    	var len = $("form[name=ex_work_form]").length;
    	var form = $("#ex_work_form"+len);
    	var work_no = form.attr("data-work_no");
    	if(work_no < 0){
    		form.remove();
    		return;
    	}												
    	console.log($("#ex_work_form"+len).remove());
    	var url = "/exhibition/workDel";
    	$.ajax({
    		url: url,
    		type : "POST",
    		data : {
    			"work_no" : work_no,
    		},
    		success: function(){
    			form.remove();
    		},
    		error : function(error){
    			console.log(error);
    		}

    	})
    });
  //스크롤 위치 
    $("#table_container").scroll(function(){
    	var scrollT = $(this).scrollTop(); //스크롤바의 상단위치
    	var scrollH = $(this).height(); //스크롤바를 갖는 div의 높이
    	var contentH = $(".table").height(); //문서 전체 내용을 갖는 div의 높이
    	if(scrollT + scrollH +1 >= contentH) { // 스크롤바가 아래 쪽에 위치할 때
    	     pagination();
    	}
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
		    	<select id="ex_search" name="ex_search">
		    		<option value="exhibition_subject">전시명</option>
		    		<option value="author">작가</option>
		    	</select>
		    	<input type="text" name="ex_searchWord" id="ex_searchWord"/>
		        <input type="submit" value="검색"/>
		    </form>
		    <div id="table_container" style="height:6vh; overflow:scroll;">
			    <table >
			    	<th>전시이름</th>
			    	<th>작가명</th>
			    	<th>전시기간</th>
			    	<tbody id="modal_search">
			    		
			    	</tbody>
			    </table>
		    </div>
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
	    		<button class="workView_btn" type="button">V I E W</button>
	    	</div>
	    	
	    	<!-- 페이지네이션 -->
	    	<div id="online_ex_pagination">
	    		<c:if test="${pVO.currentPage==1}">
		    		<img id="online_ex_prev" src="/img/exhibition/arrow_left.png" alt="이전"> <!-- < 기호 -->
		    	</c:if>
		    	<c:if test="${pVO.currentPage>1}">
		        	<a href="/online_exhibition/onlineList?currentPage=${pVO.currentPage-1}<c:if test='${pVO.searchWord!=null}'>&searchWord=${pVO.searchWord}</c:if>"><img id="online_ex_prev" src="/img/exhibition/arrow_left.png" alt="이전"></a>
		        </c:if>
	    		<div>
	    			<c:forEach var="exvo" items="${exhibitionList}" >
	    				<p><img src="${url}/upload/${exvo.member_no}/author/exhibition/${exvo.no}/${exvo.work_thumbnail}"></p>	    			
	    			</c:forEach>
	    		</div>
	    		<c:if test="${pVO.currentPage==pVO.totalPage}">
		    		<img id="online_ex_next" src="/img/exhibition/arrow_right.png" alt="다음">
		    	</c:if>
		    	<c:if test="${pVO.currentPage<pVO.totalPage}">
		        	<a href="/online_exhibition/onlineList?currentPage=${pVO.currentPage+1}<c:if test='${pVO.searchWord!=null}'>&searchWord=${pVO.searchWord}</c:if>"><img id="online_ex_next" src="/img/exhibition/arrow_right.png" alt="다음"></a>
		        </c:if>
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
    		<div id="form_box">
				<c:if test="${workList != null}">
					<c:forEach var="vo" items="${workList}" varStatus="status">
			    		<form name="ex_work_form" id="ex_work_form${status.count}" method="post" action="/workCreateOk" data-work_no="${vo.no}" enctype="multipart/form-data">
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
						</form>					
					</c:forEach>
				</c:if>
			</div>	
			<input type="button" value="등록하기" id="submit_btn"/>
			<input type="button" value="삭제하기" id="submitDel_btn"/>
			<i class="fa-solid fa-xmark"></i>
    	</div>
    </div>
    
    <!-- 작품 상세 페이지 모달 -->
	<div id="ex_detail_bg" class="modal">
    	<div id="ex_detail_wrap" class="modal_wrap">
    		<h3>작품 상세</h3>
    		<div id="ex_reg_detail">
    			<h4>${exhibition.subject}</h4>
    			<p>${exhibition.content}</p>
    		</div>
    		<ul>
    			<c:forEach var="wk" items="${exhibition.workList}">
    			<li>
	    			<ul>
		    			<li><figure class="ex_detail_img"><img class="ex_work_thumbnail" src="${url}/upload/${exhibition.member_no}/author/exhibition/${wk.exhibition_no}/${wk.work_thumbnail}"></figure></li>    		
			    		<li class="ex_detail_info">
			    			<ul>
								<li>작가 : ${exhibition.author}</li>
								<li>작품명 : ${wk.work_subject} </li>
								<li>전시기간 : ${exhibition.start_date} - ${exhibition.end_date}</li>
								<li>작품설명</li>
								<li><p>${wk.work_content}</p></li>
							</ul>
						</li>
					</ul>
	    		</li>
   				</c:forEach>
	    	</ul>
	    	<div id="ex_review">
	    	
	    	</div>
    		<i class="fa-solid fa-xmark"></i>
    	</div>
    </div>
    
    <div id="imgPopup">
    	<i class="fa-solid fa-xmark"></i>
    	<img class="pop" src="">
    </div>