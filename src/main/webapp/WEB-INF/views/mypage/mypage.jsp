<c:set var="url" value="<%=request.getContextPath()%>"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${url}/css/mypage/mypage.css">
<script src="/js/mypage/alert.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<style>
	footer {position:fixed; left:0; bottom:0; background-color:black;}
	ul {margin-bottom: 0;}
</style>
<script>
	$(function(){
		
		//알람버튼 클릭

		
		//선택된 메뉴 색 바꾸기
		$(".selected_menu").css("color","#9DC3E6");
		
		//썸네일 바꾸기 버튼 클릭
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
			//fileReader
			var reader = new FileReader();
    		reader.onload = function(e) {
      			document.getElementById('thumbnail_member').src = e.target.result;
    		};
    		reader.readAsDataURL(this.files[0]);
    		$("[name=thumbnail]").val(this.files[0].name);
		});
		
		//프로필 이지미 바꾸기 요청
		$("#memberForm_member_edit_btn").on("click",function(){
			var url = "/upload/mypage/member/thumbnail";
			var data = new FormData($("#memberForm")[0]);
			$.ajax({
				url : url,
				processData: false,
				contentType: false,
				type : "POST",
				data : data,
				success:function(data){
					alert(data.msg);
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
			<div id="mypage_container" >
				<form id="memberForm">
				<div id="mypage_member_thumbnail_group" class="row">
					<div class="col" id="mypage_col2">
						<!-- 회원 대표 사진 -->
						<div id="mypage_member_thumbnail_container">
						<c:if test="${mvo.thumbnail == Null}">
							<img id="thumbnail_member" src="${url}/img/member/default_thumbnail.png"/>
						</c:if>
						<c:if test="${mvo.thumbnail != Null}">
							<img id="thumbnail_member" src="/upload/${mvo.no}/thumbnail/${mvo.thumbnail}"/>
						</c:if>
							<img class="thumbnail_btn" id="thumbnail_member_btn" src="/img/member/thumbnail_btn.png"/>
						</div>
						<div class="mb-3" style="display:none;">
							<label for="formFile" class="form-label">회원 사진</label>
							<input type="text" name="thumbnail">
							<input class="form-control" type="file" multiple="multiple" name="file" id="formFile_member" >
						</div>
						<div class="form-floating mb-3" style="margin:30px auto; width:50%; font-size:2.1rem;" >
						  	<input type="email" class="form-control" value="${mvo.email}" placeholder="name@example.com" style=" font-size:2.4rem; height:75px;" readonly>
						  	<label >이메일</label>
						</div>
						<div class="form-floating mb-3" style="margin:30px auto; width:50%; font-size:2.1rem;">
	  						<input type="text" class="form-control" id="" value="${mvo.nickname}" placeholder="닉네임" readonly style=" font-size:2.4rem; height:75px;">
						  	<label >닉네임</label>
						  	
						</div>
						<div class=" mb-3" style="margin:30px auto; width:50%; text-align:center; font-size:2.1rem;">
						  <button id="memberForm_member_edit_btn" class="btn btn-outline-secondary"  style="font-size:2.1rem;" type="button">수정</button>
						  <button id="memberForm_member_delete_btn" class="btn btn-outline-secondary" style="font-size:2.1rem;"  type="button">회원 탈퇴</button>
						</div>
					</div>
					
					
					
				</div>
				
				</form>
			</div> <!-- mypage_container end -->
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
					<li><a href="${url}/mypage/board">작성글</a></li>
					<li><a href="${url}/mypage/fan">팔로잉 작가</a></li>
					<c:if test="${grade == 0}">
						<li><a href="${url}/mypage/authorWrite">작가등록 신청</a></li>
					</c:if>
					<c:if test="${grade == 1}">
						<li><a href="${url}/mypage/exhibition">나의 전시회</a></li>
						<li><a href="${url}/mypage/author">작가 정보</a></li>
					</c:if>					
				</ul>
				<hr/>
				<ul>
					<li><a class="selected_menu" href="${url}/mypage/member">내정보</a></li>
					<li><a href="https://kauth.kakao.com/oauth/logout?client_id=f20eb18d7d37d79e45a5dff8cb9e3b9e&logout_redirect_uri=${logoutUri}/logout/kakao">로그아웃</a></li>					
				</ul>
			</div>
			
			
		</div>
		
	</div>
</main>
