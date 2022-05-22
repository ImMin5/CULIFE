<c:set var="url" value="<%=request.getContextPath()%>"/>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="${url}/css/mypage/mypage.css">
<script src="/js/mypage/alert.js"></script>
<style>
	footer {position:fixed; left:0; bottom:0; background-color:black;}
	ul {margin-bottom: 0;}
</style>
<script>
	$(function(){
		//글자수 계산
		$("#author_msg").on("keyup",function(){
			var length= $(this).val().length;
			console.log(length);
			$("#max_text_length").text("작가소개 "+ length+"/100");
		})
		$("#thumbnail_member_btn").on("click",function(){
			$("#formFile_member").trigger("click");
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
		
		//작가 정보 수정
		$("#authorForm_author_edit_btn").on("click",function(){
			var url = "${url}/mypage/author/info";
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
					<div class="col" id="my_page_col">
						<!-- 작가 대표 사진 -->
						<div id="mypage_member_thumbnail_container">
							<img id="thumbnail_member" src="${url}/upload/${logNo}/author/${avo.author_thumbnail}"/>
							<img class="thumbnail_btn" id="thumbnail_member_btn" src="${url}/img/member/thumbnail_btn.png"/>
						</div>
						<div class="mb-3" style="display:none;">
							<label for="formFile" class="form-label">작가 사진</label>
							<input type="text" name="author_thumbnail" value="${avo.author_thumbnail}">
							<input class="form-control" type="file" multiple="multiple" name="file" id="formFile_member" >
						</div>
						<div class="form-floating mb-3" style="margin:0 auto; width:50%; font-size:2.1rem;" >
						  	<input type="text" class="form-control" id="author" name="author" value="${avo.author}" placeholder="작가이름" style=" font-size:2.4rem; height:75px;"readonly>
						  	<label >작가 이름</label>
						</div>
						<div class="form-floating mb-3" style="margin:0 auto; width:50%; font-size:2.1rem;">
	  						<input type="text" class="form-control" id="sns_link" name="sns_link" value="${avo.sns_link}" placeholder="닉네임" style=" font-size:2.4rem; height:75px;">
						  	<label >sns 주소</label>
						  	
						</div>
						<div class="form-floating mb-3" style="margin:0 auto; width:50%; font-size:2.1rem;">
	  						<input type="text" class="form-control" name="debut_year" value="${avo.debut_year}" placeholder="닉네임" style=" font-size:2.4rem; height:75px;">
						  	<label >데뷔 연도</label>
						  	
						</div>
						<div class="form-floating mb-3"  style="margin:0 auto; width:50%; font-size:2.1rem;">
							<textarea class="form-control" name="author_msg" id="author_msg" maxlength="100" style="resize:none; padding-top:30px; font-size:2.4rem; height:100px;">${avo.author_msg}</textarea>
							<label id="max_text_length" for="floatingTextarea">작가소개 ${fn:length(avo.author_msg)}/100</label>
						</div>
						
						<div class=" mb-3" style="margin:30px auto; width:50%; text-align:center; font-size:2.1rem;">
						  <button id="authorForm_author_edit_btn" class="btn btn-outline-secondary"  style="font-size:2.1rem;" type="button">수정</button>
				
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
								  <ul style="width:15vw;" id="mypage_notification_ul" class="dropdown-menu dropdown-menu-dark" aria-labelledby="dropdownMenuClickableInside">
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
						<li><a  class="selected_menu" href="${url}/mypage/author" style="color:#9DC3E6">작가 정보</a></li>
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
