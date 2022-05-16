<c:set var="url" value="<%=request.getContextPath()%>"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${url}/css/mypage/mypage.css">
<link rel="stylesheet" type="text/css" href="${url}/css/mypage/mypage_movie.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script>
let pageNo = 1;
let totalPage = 1;
let row_num = 0;
let row_count = 0;
let is_paging= true;
let is_loading = false;
	$(function(){
		search();
		$("#select_container").on("change",function(){
			console.log($(this).val());
			window.location.href="${url}/mypage/review/"+$(this).val();
		})
		
		//스크롤 위치 파악
		$("#review_contatiner").scroll(function(){
			var scrollT = $(this).scrollTop(); //스크롤바의 상단위치
	        var scrollH = $(this).height(); //스크롤바를 갖는 div의 높이
	        var contentH = $(".table").height(); //문서 전체 내용을 갖는 div의 높이
	        if(scrollT + scrollH +1 >= contentH) { // 스크롤바가 아래 쪽에 위치할 때
	        	pagination();
	        }
		});
		//페이지 네이션
		function pagination(){
			is_paging = true;
			var searchWord = $("#search_word").val();
			if(!is_loading){
				is_loading = true;
				search(searchWord);
			}
		}
		//검색
		$(document).on("keyup","#search_word",function(){
			var searchWord = $(this).val();
			is_paging = false;
			pageNo = 1;
			row_num = 0;
			row_count = 0;
			search(searchWord);
		})
		
		// 검색 함수
		function search(searchWord){
			if(pageNo != 1 && parseInt(totalPage) < parseInt(pageNo)){
				is_loading=false;
				return;
			}
			
			var url = "${url}/mypage/review/theater/search";
			var container = $("#review_contatiner");
			$.ajax({
				url : url,
				type : "GET",
				dataType:"JSON",
				data : {
					pageNo : pageNo,
					searchWord : searchWord,
				},
				success : function(data){
					console.log(data);
					if(!is_paging)container.empty();
					if(data.items == null) return;
					data.items.forEach(function(element, index){
						if(row_count%4 == 0){
							row_num++;
							$("#review_contatiner").append(`<div name="review_row_${'${row_num}'}" class="row row-cols-1 row-cols-md-4 g-3"></div>`);
						}
						$("[name=review_row_"+row_num).append(`
								<div class="col">
								    <div class="card">
								      <img onclick="location.href='${url}/theater/theaterView?seq=${'${element.seq}'}'"src="${'${element.poster}'}" class="card-img-top">
								      <div class="card-body">
								        <h5 class="card-title">${'${element.title}'}<br/><i style="color:blue"class="bi bi-star-fill"></i>${'${element.score_star}'}</h5>
								        <p class="card-text">${'${element.content}'}</p>
								      </div>
								    </div>
								</div>
							`);
						row_count++;
					});
					if(is_paging){
						pageNo = parseInt(data.vo.currentPage)+1;
						totalPage = data.vo.totalPage;
					}
					else{
						pageNo = 2;
						totalPage = data.vo.totalPage;
					}
					is_loading = false;
				},
				error : function(error){
					console.log(error);
					is_loading = false;
				}
			});
			
		}
		
	});
</script>
<main id="mypage_member" class="container-fluid">
	<div class="row" style="height:100%;">
		<div class="col-9" id="mypage_col">
			<div class="row">
				<div class="col">
					<div class="input-group mb-3" id="search_container">
						<img id="search_btn" src="${url}/img/member/search.png">
			  			<input type="text" class="form-control" id="search_word" placeholder="검색" style=" font-size:2.3rem;">
			  			<select id="select_container">
							<option value="movie" >영화</option>
						 	<option value="theater" selected>연극/뮤지컬</option>
						</select>
					</div>
				</div>
			</div>
			<div id="review_contatiner" class="container" style=" overflow: scroll;">
		  
			</div>
				
			
		</div> <!-- col-9 -->
		<div class="col-3" id="mypage_sidebar">
			<div class="container" id="mypage_sidebar_container">
				<h1 class="h1">${mvo.nickname}님 반갑습니다.<img id="mypage_notification" src="${url}/img/member/mypage_notification.png"></h1>
				<hr/>
				<ul>
					<li><a class="selected_menu" style="color:#9DC3E6"  href="${url}/mypage/review/movie">리뷰</a></li>
					<li><a href="${url}/mypage/review">감상평</a></li>
					<li><a href="${url}/mypage/board">작성글</a></li>
					<li><a href="${url}/mypage/fan" >팔로잉 작가</a></li>
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
