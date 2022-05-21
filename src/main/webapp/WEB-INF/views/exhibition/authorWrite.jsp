<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="url" value="<%=request.getContextPath()%>"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="${url}/css/mypage/mypage.css">

<link rel="stylesheet" href="/css/exhibition/authorWrite.css" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<style>
	footer {position:fixed; left:0; bottom:0; background-color:black;}
	ul {margin-bottom: 0;}
	#mypage_sidebar{
		background-color:rgba(0,0,0,0.5);
		color:white;
		text-align:center;
		font-size:2.4rem;
		height:100%;
		position:fixed; right:0;
	}
	#mypage_sidebar>#mypage_sidebar_container{
		position:relative; top:50%;
		transform:translateY(-50%)
	}
</style>
<script>
let authorch = false;

$(function(){
	console.log(${avo.getAuthor_status()});
	$("#thumbnail_btn").on("click",function(){
		$("#authorThumbnail").trigger("click");
	})
	$("#authorWriteName").keyup(function(){
		var author = $("#authorWriteName").val();
		authorch = false;
		if(author != ''){
			console.log(author);
			var url = "/authorNameCheck";
				
			$.ajax({
				url: url,
				data: "author="+author,
				type: "POST",
				success: function(result){
					if(result==author){
						$("#chk").html("이미 사용중인 작가명 입니다.");
						$("#authorchk").val("N");
						$("#chk").css("color","red");
						authorch = false;
					}else{//사용가능
						$("#chk").html("사용 가능한 작가명 입니다.");
						$("#authorchk").val("Y");
						$("#chk").css("color","blue");
						authorch = true;
					}
				}
			});
		}
	});
	
	$("#authorThumbnail").change(function(){
	    setImageFromFile(this, '#preview');
	});

	function setImageFromFile(input, expression) {
	    if (input.files && input.files[0]) {
	    var reader = new FileReader();
	    reader.onload = function (e) {
	    $(expression).attr('src', e.target.result);
	  }
	  reader.readAsDataURL(input.files[0]);
	  }
	}
	
});


function authorSubmit() {
	if(!authorch) {
		alert("작가명을 확인해 주세요");
		return false;
	}
	
	var pattern_num = /^[0-9]*$/;
	var authorNickname = "${mvo.nickname}";
	var params = "nickname=" + "${mvo.nickname}";
	var author = $("#authorWriteName").val();
	var sns_link = $("#authorWriteSNS").val();
	var author_thumbnail = $("#authorThumbnail").val();
	var debut_year = $("#authorDebutYear").val();
	var author_msg = $("#authorMsg").val();
	var author_status = "${avo.author_status}";
	console.log(authorNickname);
	console.log(author);
	console.log(author_status);
	if (author == '' ) {
		alert("작가명을 입력해 주세요")
	} 
	else if (sns_link == '' ) {
		alert("sns링크를 입력해 주세요")
	}
	else if (author_thumbnail == '' ) {
		alert("프로필사진을 첨부해 주세요")
	}
	else if (debut_year == '' ) {
		alert("데뷔년도를 입력해 주세요")
	}  
	else if (!pattern_num.test(debut_year)) {
		alert("데뷔년도에 숫자만 입력해 주세요")
	} 
	else if (author_msg == '') {
		alert("자기소개를 입력해 주세요")
	}
	/* else if (author_status != '' ) {
		alert("작가 신청 심사 중입니다.")
	} */
	else {
		var data = new FormData($("#authorWrite")[0]);
		$.ajax({
			url: '/authorWriteOk',
			type: 'POST', 
			processData: false,
			contentType: false,
			data : data,
			success: function(result) {
				console.log("작가 신청 완료")
				console.log(result)
				if (result) {
					alert(result)
					window.location.href='/mypage/authorWrite';
				} else {
					alert("작가 신청 실패")
				}
			},
			error: function(request, status, error) {
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
}
</script>
<main id="mypage_member" class="container-fluid">
	<div class="row" style="height: 100%;">
		<div class="col-9" id="mypage_col">
			<div class="containerWrap">
				<div class="exhibitionContainer">
					<form name="authorWrite" id="authorWrite" enctype="multipart/form-data">
						<div class="authorWriteThumbnail">
							<img src="/img/member/default_thumbnail.png" id="preview"
								style="width: 170px; height: 170px;" /> 
							<img class="thumbnail_btn" id="thumbnail_btn" src="${url}/img/member/thumbnail_btn.png" style="cursor: pointer;"/>
							<input type="file" multiple="multiple" name="file" class="files" id="authorThumbnail"
								style="display:none;">
						</div>
						
						<div class="form-floating mb-3" style="margin:0 auto; width:65%; font-size:2rem;" >
						  	<input type="text" value="${mvo.nickname}" class="form-control" style=" font-size:2.4rem; height:70px;" readonly>
						  	<label >닉네임</label>
						</div>
						<div class="form-floating mb-3" style="margin:0 auto; width:65%; font-size:1.8rem;" >
						  	<input type="text" class="form-control" name="author" id="authorWriteName" placeholder='작가명 입력' style=" font-size:2rem; height:70px;">
						  	<label >작가 이름</label>
						  	<span id="chk"></span>
						</div>
						<div class="form-floating mb-3" style="margin:0 auto; width:65%; font-size:1.8rem;" >
							  <input type="text" class="form-control" name="sns_link" id="authorWriteSNS" placeholder='데뷔년도 입력 ex) 2018'style=" font-size:2rem; height:70px;">
							  <label >SNS 주소</label>
						</div>

						<div class="form-floating mb-3" style="margin:0 auto; width:65%; font-size:1.8rem;" >
							  <input type="text" class="form-control" name="debut_year" id="authorDebutYear" placeholder='데뷔년도 입력 ex) 2018'style=" font-size:2rem; height:70px;">
							  <label >데뷔년도</label>
						</div>
						<div class="form-floating mb-3" style="margin:0 auto; width:65%; font-size:1.8rem;" >
							  <textarea class="form-control" name="author_msg" id="authorMsg" style=" font-size:2rem; height:100px; resize: none; padding-top: 25px;"></textarea>
							  <label for="floatingTextarea">자기소개</label>
						</div>
						<div class="mb-3" style="margin:0 auto; width:65%; text-align:center; font-size:1.8rem;">
							<input type="button" id="memberForm_member_edit_btn" class="btn btn-outline-secondary" value="작가 신청" onclick="authorSubmit()" style="display:block; margin:30px auto 0 auto; font-size:1.6rem"/>
						</div>
					</form>
				</div>
			</div>
		</div>
			<!-- mypage_container end -->
		<div class="col-3" id="mypage_sidebar">
			<div class="container" id="mypage_sidebar_container">
				<h1 class="h1">${mvo.nickname}님
					반갑습니다.<img id="mypage_notification"
						src="${url}/img/member/mypage_notification.png">
				</h1>
				<hr />
				<ul>
					<li><a href="${url}/mypage/review/movie">리뷰</a></li>
					<li><a href="${url}/mypage/review">감상평</a></li>
					<li><a href="${url}/mypage/board">작성글</a></li>
					<li><a href="${url}/mypage/fan">팔로잉 작가</a></li>
					<c:if test="${grade == 0}">
						<li><a class="selected_menu" style="color: #9DC3E6"
							href="${url}/mypage/authorWrite">작가등록 신청</a></li>
					</c:if>
					<c:if test="${grade == 1}">
						<li><a href="${url}/mypage/author">작가 정보</a></li>
					</c:if>
				</ul>
				<hr />
				<ul>
					<li><a href="${url}/mypage/member">내정보</a></li>
					<li><a
						href="https://kauth.kakao.com/oauth/logout?client_id=f20eb18d7d37d79e45a5dff8cb9e3b9e&logout_redirect_uri=http://localhost:8080/logout/kakao">로그아웃</a></li>
				</ul>
			</div>
		</div>
	</div>
</main>