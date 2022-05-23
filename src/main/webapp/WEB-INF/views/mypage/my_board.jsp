<c:set var="url" value="<%=request.getContextPath()%>"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${url}/css/mypage/mypage.css">
<link rel="stylesheet" type="text/css" href="${url}/css/mypage/mypage_board.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="/js/mypage/alert.js"></script>
<style>
	footer {position:fixed; left:0; bottom:0; background-color:black;}
	ul {margin-bottom: 0;}
</style>
<script>
	$(function(){
		//글자색 바꾸기
		$(".selected_menu").css("color","#9DC3E6");
		
		//게시판 타입 선택
		$("#select_container").on("change",function(){
			window.location.href="${url}/mypage/board?category="+$(this).val();
		});
		
		$(document).ready(function(){
			var category = "${pvo.category}";
			$("#select_container").val(category).prop("selected",true);
		});
		
		//검색

		 $("#search_word").on("keyup",function(key){
	        if(key.keyCode==13) {
	           var searchWord = $(this).val();
	           window.location.href='${url}/mypage/board?category=${pvo.category}&searchWord='+searchWord;
	            
	        }
    	});

		
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
				  		<select id="select_container">
							<option value="free">자유게시판</option>
						 	<option value="help">문의사항</option>
						</select>
					</div>
				</div>
			</div> <!-- row end -->
			<div id="mypage_board_contatiner" class="container">
				<div class="table-responsive">
			  		<table class="table table-striped table-hover">
			  			<thead class="sticky-top" style="background-color:gray">
			  				<tr>	
			  					<th style="width:5%">번호</td>
			  					<th>제목</td>
			  					<th>닉네임</td>
			  					<th style="width:8%">조회수</td>
			  					<th style="width:18%">작성일</td>
			  				</tr>
			  			</thead>
			  			<tbody>
			  				<c:forEach var="vo" items="${boardList}">
			  					<c:choose>
			  						<c:when test ="${pvo.category == 'free' }">
			  							<tr class="tr_record" onclick="location.href='${url}/board/freeBoardView?no=${vo.no}'">
			  						</c:when>
			  						<c:otherwise>
			  							<tr class="tr_record" onclick="location.href='${url}/board/help/helpBoardView?no=${vo.no}'">
			  						</c:otherwise>
			  					</c:choose>
				  			
				  					<th scope="row">${vo.no}</td>
				  					<td>${vo.subject}</td>
				  					<td>${vo.nickname}</td>
				  					<td>${vo.view}</td>
				  					<td>${vo.write_date}</td>
				  				</tr>
			  				</c:forEach>
			  				
			  				
			  			</tbody>
					</table>
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
								    		<li class="page-item"><a style="color:#9DC3E6"class="page-link" href=${url}/mypage/board?pageNo=${p}&category=${pvo.category}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>>${p}</a></li>
								    	</c:if>
								    	<c:if test="${p!=pvo.currentPage && p<=pvo.totalPage}">	
								    		<li class="page-item"><a class="page-link" href=${url}/mypage/board?pageNo=${p}&category=${pvo.category}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>>${p}</a></li>
								   		</c:if>
								   	</c:when>
							    	<c:otherwise>
								    	<c:if test="${p==pvo.currentPage && p<= pvo.totalPage}">
								    		<li class="page-item"><a style="color:#9DC3E6"class="page-link" href=${url}/mypage/board?pageNo=${p}&category=${pvo.category}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>>${p}</a></li>
								    	</c:if>
								    	<c:if test="${p!=pvo.currentPage && p<= pvo.totalPage}">	
								    		<li class="page-item"><a class="page-link" href=${url}/mypage/board?pageNo=${p}&category=${pvo.category}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>>${p}</a></li>
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
					    			<li class="page-item"><a style="color:#9DC3E6"class="page-link" href=${url}/mypage/board?pageNo=${p}&category=${pvo.category}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>>${p}</a></li>
								</c:if>
								<c:if test="${p!=pvo.currentPage }">	
									<li class="page-item"><a class="page-link" href=${url}/mypage/board?pageNo=${p}&category=${pvo.category}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>>${p}</a></li>
								</c:if>
							</c:forEach>
				    	</c:otherwise>
				    </c:choose>
				   
					<!-- 다음 페이지  -->
					<c:choose>
						<c:when test="${pvo.currentPage < pvo.totalPage }">
							<li class="page-item">
							      <a class="page-link" href="${url}/mypage/board?pageNo=${pvo.currentPage+1}&category=${pvo.category}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>" aria-label="Next">
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
						<div class="col-6">
							<h1 class="h1" style="margin:0 auto; margin-top:5px; text-align:right; vertical-align:bottom;">${logNickname}님</h1>
						</div>
						<div class="col-3">
							<div class="btn-group">
								  <button class="btn dropdown-toggle" type="button" id="dropdownMenuClickableInside" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
								    <img id="mypage_notification" src="${url}/img/member/mypage_notification.png"><b id="mypage_notification_count" style="font-size:2rem;"></b>	
								  </button>
								  <ul id="mypage_notification_ul" class="dropdown-menu dropdown-menu-dark" aria-labelledby="dropdownMenuClickableInside">
								  </ul>
							</div>				
						</div>
					</div>
				</div>
				<hr/>
				<ul>
					<li><a href="${url}/mypage/review/movie">리뷰</a></li>
					<li><a href="${url}/mypage/review">감상평</a></li>
					<li><a class="selected_menu" href="${url}/mypage/board">작성글</a></li>
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
					<li><a href="https://kauth.kakao.com/oauth/logout?client_id=f20eb18d7d37d79e45a5dff8cb9e3b9e&logout_redirect_uri=${logoutUri}/logout/kakao">로그아웃</a></li>
					
				</ul>
			</div>
			
			
		</div>
		
	</div>
</main>
