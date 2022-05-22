<c:set var="url" value="<%=request.getContextPath()%>"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${url}/css/mypage/mypage.css">
<link rel="stylesheet" type="text/css" href="${url}/css/mypage/mypage_board.css">

<link rel="stylesheet" href="/css/exhibition/onlineList.css">
<script src="/js/modal.js"></script>
<script src="/js/mypage/my_review.js "></script>
<script src="/js/mypage/alert.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<style>
	footer {position:fixed; left:0; bottom:0; background-color:black;}
	ul {margin-bottom: 0;}
</style>
<script>
//모달 띄우기 
/* 작품보기 - 모달 띄우기*/
function exhibition_modal(){
	$("#ex_detail_review_bg").css({"display" : "block"});
};

$(function(){

	// 댓글 수정 버튼 클릭
	$("button[name=review_edit_btn]").on("click",function(){
		var type = $(this).attr("data-type");
		var no = $(this).attr("data-no");
		if(type =="edit"){
			var review_content = $("#review_content"+no).text();
			$(this).text("저장");
			$(this).attr("data-type","save");
			$("#review_content"+no).replaceWith("<p><textarea id='review_content"+no+"' value='"+review_content+"'></textarea></p>");
		}else if(type == "save"){
			var review_content = $("#review_content"+no).val();
			var review_btn = $(this);
			var url ="${url}/ex_review";
			$.ajax({
				url : url,
				type:"PATCH",
				data : {
					no : no,
					content : review_content,
				},
				success : function(data){
					console.log(data);
					review_btn.text("수정");
					review_btn.attr("data-type","edit");
					$("#review_content"+no).replaceWith("<p id='review_content"+no+"'>"+review_content +"</p>");
					alert(data.msg);
				},
				error: function(error){
					console.log(error);
					//location.reload();
				}
				
			});
		}
	});
	
	//글자색 바꾸기
		$(".selected_menu").css("color","#9DC3E6");
		
		$("#search_word").on("keyup",function(key){
	        if(key.keyCode==13) {
	           var searchWord = $(this).val();
	           window.location.href='${url}/mypage/review?searchWord='+searchWord;
	            
	        }
    	});
		
		//전시회 정보 불러오기
		$("button[name=exhibition_modal_btn]").on("click",function(){
			var no = $(this).attr("data-no");
			var review_no = $(this).attr("data-review_no");
			var review_content = $("#review_content"+review_no).text();
			var author = $(this).attr("data-author");
			var url ="${url}/exhibitionwithwork/"+ no;
			$.ajax({
				url : url,
				tpye : "GET",
				dataType:"JSON",
				success: function(data){
					console.log(data);
					console.log(data.items[0].subject);
					$("#modal_exhibition_subject").text(data.items[0].subject);
					$("#modal_exhibition_content").text(data.items[0].content);
					$("#modal_exhibition_review").text("내가 남긴 댓글 : " + review_content);
					var modal_work_container = $("#modal_exhibition_workList");
					modal_work_container.empty();
					data.items[0].workList.forEach(function(element, index){
						console.log(element);
						modal_work_container.append(`
								<li>
				    			<ul>
					    			<li><figure class="ex_detail_img"><img class="ex_work_thumbnail" src="${url}/upload/${'${data.items[0].member_no}'}/author/exhibition/${'${element.exhibition_no}'}/${'${element.work_thumbnail}'}"></figure></li>    		
						    		<li class="ex_detail_info">
						    			<ul>
											<li>작가 : ${'${data.items[0].author}'}</li>
											<li>작품명 : ${'${element.work_subject}'} </li>
											<li>전시기간 : ${'${data.items[0].start_date}'} - ${'${data.items[0].end_date}'}</li>
											<li>작품설명</li>
											<li><p>${'${element.work_content}'}</p></li>
										</ul>
									</li>
								</ul>
				    		</li>
						`);
					});
					var myReview = "<li id='modal_exhibition_review'><p>내가 남긴 감상평</p><span>"+review_content+"</span></li>";
					exhibition_modal();
					$("#modal_exhibition_workList").append(myReview);
				},error : function(){
					
				}
			})
		})

		
	});
</script>
<main id="mypage_member" class="container-fluid">
	<div class="row" style="height:100%;">
		<div class="col-9" id="mypage_col">
			<div class="row">
				<div class="col">
					<div class="input-group mb-3" id="search_container">
						<img id="search_btn" src="${url}/img/member/search.png">
				  		<input type="text" class="form-control" id="search_word" value="${pvo.searchWord}" placeholder="검색" style=" font-size:2.3rem;">
					</div>
				</div>
			</div> <!-- row end -->
			<div id="mypage_board_contatiner" class="container">
				<div class="table-responsive">
			  		<ul class="sticky-top">
			  			<li>번호</li>
			  			<li>전시명</li>
			  			<li>내용</li>
			  			<li>닉네임</li>
			  			<li>작성일</li>
			  			<li>비고</li>
			  		</ul>
			  		<ul class="sticky-bottom">
			  			<c:forEach var="vo" items="${reviewList}">
				  			<li class="tr_record">
				  				<p scope="row">${vo.no}</td>
				  				<p>${vo.subject}</td>
				  				<p id="review_content${vo.no}">${vo.content}</p>
				  				
				  				<p>${logNickname}</p>
				  				<p>${vo.write_date}</p>
				  				<p>
				  					<button class="btn" id="review_save_btn${vo.no}" name="review_edit_btn" data-no="${vo.no}" data-type="edit">수정</button>
				  					<button class="btn" name="exhibition_modal_btn" data-no="${vo.exhibition_no}" data-review_no="${vo.no}">보기</button>
				  				</p>
				  			</li>
			  			</c:forEach>
			  		</ul>
				</div>
						<!-- 페이징 -->
				<nav id="mypage_board_pagination" class="container">
				  <ul class="pagination">
				  <!-- 이전 페이지 -->
				  <c:choose>
				  	<c:when test="${pvo.currentPage>1}">
					    <li class="page-item">
					      <a class="page-link" href="${url}/mypage/board?pageNo=${pvo.currentPage-1}&category=${pvo.category}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
				    </c:when>
				    <c:otherwise>
				    	<li class="page-item">
				    		<a class="page-link" href="#" aria-label="Previous">
					        	<span aria-hidden="true">&laquo;</span>
					        </a>
					    </li>
				   </c:otherwise>
				  </c:choose>

				    <!-- 페이지 번호 -->
				    <!-- totalPage 가 onePageCount 보다 클때 -->
				    <c:choose>
				    	<c:when test="${pvo.totalPage > pvo.onePageCount and pvo.currentPage - pvo.onePageCount/2 > 0 and pvo.currentPage <= pvo.totalPage}">
				    		<c:choose>
				    			<c:when test="${pvo.totalPage- pvo.onePageCount/2 == pvo.currentPage}">
				    				<c:set var="endPage" value="${pvo.totalPage}"/>
				    			</c:when>
				    			<c:otherwise>
				    				<c:set var="endPage" value="${pvo.currentPage+pvo.onePageCount/2}"/>
				    			</c:otherwise>		
				    		</c:choose>
				    		<c:forEach var="p" begin="${pvo.currentPage- pvo.onePageCount/2 + 1}" end="${endPage}">
						    	<c:choose>
							    	<c:when test ="${pvo.totalPage <= pvo.onePageCount}">
								    	<c:if test="${p==pvo.currentPage && p<= pvo.totalPage}">
								    		<li class="page-item"><a style="color:#9DC3E6"class="page-link" href=${url}/mypage/review?currentPage=${p}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>>${p}</a></li>
								    	</c:if>
								    	<c:if test="${p!=pvo.currentPage && p<=pvo.totalPage}">	
								    		<li class="page-item"><a class="page-link" href=${url}/mypage/review?currentPage=${p}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>>${p}</a></li>
								   		</c:if>
								   	</c:when>
							    	<c:otherwise>
								    	<c:if test="${p==pvo.currentPage && p<= pvo.totalPage}">
								    		<li class="page-item"><a style="color:#9DC3E6"class="page-link" href=${url}/mypage/review?currrentPage=${p}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>>${p}</a></li>
								    	</c:if>
								    	<c:if test="${p!=pvo.currentPage && p<= pvo.totalPage}">	
								    		<li class="page-item"><a class="page-link" href=${url}/mypage/review?currentPage=${p}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>>${p}</a></li>
								   		</c:if>
								   	</c:otherwise>
							   	</c:choose>
							</c:forEach>
				    	</c:when>
				    	<c:otherwise>
				    		<c:choose>
				    			<c:when test ="${pvo.totalPage <= pvo.onePageCount}">
				    		 		<c:set var="endPage" value="${pvo.totalPage}"/>
				    			</c:when>
				    			<c:otherwise>
				    				<c:set var="endPage" value="${pvo.onePageCount}"/>
				    			</c:otherwise>
				    			
				    		</c:choose>
				    		<c:forEach var="p" begin="1" end="${endPage}">
					    		<c:if test="${p==pvo.currentPage }">
					    			<li class="page-item"><a style="color:#9DC3E6"class="page-link" href=${url}/mypage/review?currentPage=${p}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>>${p}</a></li>
								</c:if>
								<c:if test="${p!=pvo.currentPage }">	
									<li class="page-item"><a class="page-link" href=${url}/mypage/review?currentPage=${p}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>>${p}</a></li>
								</c:if>
							</c:forEach>
				    	</c:otherwise>
				    </c:choose>
				   
					<!-- 다음 페이지  -->
					<c:choose>
						<c:when test="${pvo.currentPage < pvo.totalPage }">
							<li class="page-item">
							      <a class="page-link" href="${url}/mypage/review?currentPage=${pvo.currentPage+1}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>" aria-label="Next">
							        <span aria-hidden="true">&raquo;</span>
							      </a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="page-item">
							      <a class="page-link" href="#" aria-label="Next">
							        <span aria-hidden="true">&raquo;</span>
							      </a>
							</li>
						</c:otherwise>
					</c:choose>
				  </ul>
				</nav>
			</div>
				
		</div>
		<div class="col-3" id="mypage_sidebar">
			<div class="container" id="mypage_sidebar_container">
				<div class="container">
					<div class="row">
						<div class="col-1">
						</div>
						<div class="col-7">
							<h1 class="h1" style="margin:0 auto; margin-top:5px; text-align:right; vertical-align:bottom;">${mvo.nickname}님 반갑습니다.</h1>
						</div>
						<div class="col-2">
							<div class="btn-group">
								  <button class="btn dropdown-toggle" type="button" id="dropdownMenuClickableInside" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
								    <img id="mypage_notification" src="${url}/img/member/mypage_notification.png"><b id="mypage_notification_count" style="font-size:2rem;"></b>	
								  </button>
								  <ul style="width:15vw;" id="mypage_notification_ul" class="dropdown-menu dropdown-menu-dark" aria-labelledby="dropdownMenuClickableInside">
								  </ul>
							</div>				
						</div>
					</div>
				</div>
				<hr/>
				<ul>
					<li><a href="${url}/mypage/review/movie">리뷰</a></li>
					<li><a class="selected_menu" href="${url}/mypage/review">감상평</a></li>
					<li><a href="${url}/mypage/board">작성글</a></li>
					<li><a href="${url}/mypage/fan">팔로잉 작가</a></li>
					<c:if test="${grade == 0}">
						<li><a href="${url}/mypage/authorWrite">작가등록 신청</a></li>
					</c:if>
					<c:if test="${grade == 1}">
						<li><a href="${url}/mypage/author">작가 정보</a></li>
					</c:if>
				</ul>
				<hr/>
				<ul>
					<li><a href="${url}/mypage/member">내정보</a></li>
					<li><a href="https://kauth.kakao.com/oauth/logout?client_id=f20eb18d7d37d79e45a5dff8cb9e3b9e&logout_redirect_uri=http://localhost:8080/logout/kakao">로그아웃</a></li>
					
				</ul>
			</div>
			
			
		</div>
		
	</div>
</main>

 <!-- 작품 상세 페이지 모달 -->
	<div id="ex_detail_review_bg" class="modal" style="z-index:1500;">
    	<div id="ex_detail_wrap" class="modal_wrap">
    		<h3>작품 상세</h3>
    		<div id="ex_reg_detail">
    			<h4 id="modal_exhibition_subject"></h4>
    			<p id="modal_exhibition_content"></p>
    		</div>
    		<ul id="modal_exhibition_workList">
    		
    		</ul>
	    	<i class="fa-solid fa-xmark"></i>
    	</div>
    </div>
