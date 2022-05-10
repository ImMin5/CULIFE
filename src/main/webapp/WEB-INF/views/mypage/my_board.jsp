<c:set var="url" value="<%=request.getContextPath()%>"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${url}/css/mypage/mypage.css">
<link rel="stylesheet" type="text/css" href="${url}/css/mypage/mypage_board.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script>
	$(function(){
		//글자색 바꾸기
		$(".selected_menu").css("color","#9DC3E6");
		
		$("#select_container").on("change",function(){
			console.log($(this).val());
			//window.location.href="${url}/mypage/review/"+$(this).val();
		})
		
		$("#thumbnail_member_btn").on("click",function(){
			$("#formFile_member").trigger("click");
		})
		
		//회원 탈퇴
		$("#memberForm_member_delete_btn").on("click", function(){
			var url = "${url}/mypage/member"
			if(!confirm("정말 탈퇴하시겠습니까?")) return;
			$.ajax({
				url : url,
				type : "Delete",
				success : function(data){
					alert(data.msg);
					window.location.href=data.redirect;
				},
				error : function(error){
					alert(error);
				}
			});
		})

		//프로필 이미지 미리보기
		$("#formFile_member").change(function(){
			console.log(this.files[0]);
			//fileReader
			var reader = new FileReader();
    		reader.onload = function(e) {
      			document.getElementById('thumbnail_member').src = e.target.result;
    		};
    		reader.readAsDataURL(this.files[0]);
    		console.log(this.files[0].name)
    		$("[name=thumbnail]").val(this.files[0].name);
		});
		
		//프로필 이지미 바꾸기 요청
		$("#memberForm_member_edit_btn").on("click",function(){
			var url = "${url}/mypage/member/thumbnail";
			var data = new FormData($("#memberForm")[0]);
			console.log(data.thumbnail);
			$.ajax({
				url : url,
				processData: false,
				contentType: false,
				type : "POST",
				data : data,
				success:function(data){
					console.log(data);
				},error : function(error){
					alert(error);
				}
			});
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
				  		<input type="text" class="form-control" id="search_word" placeholder="검색" style=" font-size:2.3rem;">
				  		<select id="select_container">
							<option value="movie" selected>자유게시판</option>
						 	<option value="theater">문의사항</option>
						</select>
					</div>
				</div>
			</div> <!-- row end -->
			<div id="mypage_board_contatiner" class="container">
				<div class="table-responsive">
			  		<table class="table table-striped table-hover">
			  			<thead class="sticky-top" style="background-color:gray">
			  				<tr>	
			  					<td style="width:5%">번호</td>
			  					<td>제목</td>
			  					<td>닉네임</td>
			  					<td style="width:8%">조회수</td>
			  					<td style="width:18%">작성일</td>
			  				</tr>
			  			</thead>
			  			<tbody>
			  				<tr>
			  					<td>1</td>
			  					<td>제목111111111111111</td>
			  					<td>고무마</td>
			  					<td>1</td>
			  					<td>2022-02-02 11:11:11</td>
			  				</tr>
			  				<tr>
			  					<td>1</td>
			  					<td>제목111111111111111</td>
			  					<td>고무마</td>
			  					<td>1</td>
			  					<td>2022-02-02 11:11:11</td>
			  				</tr>
			  				<tr>
			  					<td>1</td>
			  					<td>제목111111111111111</td>
			  					<td>고무마</td>
			  					<td>1</td>
			  					<td>2022-02-02 11:11:11</td>
			  				</tr>
			  				<tr>
			  					<td>1</td>
			  					<td>제목111111111111111</td>
			  					<td>고무마</td>
			  					<td>1</td>
			  					<td>2022-02-02 11:11:11</td>
			  				</tr>
			  				<tr>
			  					<td>1</td>
			  					<td>제목111111111111111</td>
			  					<td>고무마</td>
			  					<td>1</td>
			  					<td>2022-02-02 11:11:11</td>
			  				</tr>
			  				<tr>
			  					<td>1</td>
			  					<td>제목111111111111111</td>
			  					<td>고무마</td>
			  					<td>1</td>
			  					<td>2022-02-02 11:11:11</td>
			  				</tr>
			  				<tr>
			  					<td>1</td>
			  					<td>제목111111111111111</td>
			  					<td>고무마</td>
			  					<td>1</td>
			  					<td>2022-02-02 11:11:11</td>
			  				</tr>
			  				<tr>
			  					<td>1</td>
			  					<td>제목111111111111111</td>
			  					<td>고무마</td>
			  					<td>1</td>
			  					<td>2022-02-02 11:11:11</td>
			  				</tr>
			  				<tr>
			  					<td>1</td>
			  					<td>제목111111111111111</td>
			  					<td>고무마</td>
			  					<td>1</td>
			  					<td>2022-02-02 11:11:11</td>
			  				</tr>
			  				<tr>
			  					<td>2</td>
			  					<td>제목111111111111111</td>
			  					<td>고무마</td>
			  					<td>1</td>
			  					<td>2022-02-02 11:11:11</td>
			  				</tr>
			  				
			  			</tbody>
					</table>
				</div>
				<nav id="mypage_board_pagination" class="container">
				  <ul class="pagination">
				    <li class="page-item">
				      <a class="page-link" href="#" aria-label="Previous">
				        <span aria-hidden="true">&laquo;</span>
				      </a>
				    </li>
				    <li class="page-item"><a class="page-link" href="#">1</a></li>
				    <li class="page-item"><a class="page-link" href="#">2</a></li>
				    <li class="page-item"><a class="page-link" href="#">3</a></li>
				    <li class="page-item">
				      <a class="page-link" href="#" aria-label="Next">
				        <span aria-hidden="true">&raquo;</span>
				      </a>
				    </li>
				  </ul>
				</nav>
			</div>
				
		</div>
		<div class="col-3" id="mypage_sidebar">
			<div class="container" id="mypage_sidebar_container">
				<h1 class="h1">${mvo.nickname}님 반갑습니다.<img id="mypage_notification" src="${url}/img/member/mypage_notification.png"></h1>
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
					<li><a href="https://kauth.kakao.com/oauth/logout?client_id=f20eb18d7d37d79e45a5dff8cb9e3b9e&logout_redirect_uri=http://localhost:8080/logout/kakao">로그아웃</a></li>
					
				</ul>
			</div>
			
			
		</div>
		
	</div>
</main>
