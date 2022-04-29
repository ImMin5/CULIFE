<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<c:set var="url" value="<%=request.getContextPath()%>"/>
<c:set var="servletUrl" value="<%=request.getServletContext()%>"/>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<style>
#mypage_member_thumbnail_container{
	margin : 0 auto;
	border-radius : 70%;
	width:150px;
	height:150px;
	border: 1px solid black;
	z-index : -20;
	text-align:center;
}

#mypage_author_thumbnail_container> img{
	object-fit: contain;
	width:100%;
	height: 100%;
	top: 60%;
}


#mypage_member_thumbnail_container> #thumbnail_member{
	border-radius : 70%;
	object-fit: contain;
	width:100%;
	height: 100%;
	top: 60%;
}

#mypage_member_thumbnail_container> .thumbnail_btn{
	position : relative;
	top: -18%;
	left : 36%;
	width:15%;
	height: 15%;
	z-index : 20;
	border-radius : 20%;
	background-color:white;
}

#mypage_author_thumbnail_container > #thumbnail_member{
	margin : 0 auto;
	border-radius : 70%;
	width:150px;
	height:150px;
	background-color: gray;

}

</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	$(function(){
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
</head>
<body>
<main id="mypage_member" class="container-fluid">
	<div class="row">
		<div class="col-8">
			<form id="memberForm">
			<div id="mypage_member_thumbnail_group" class="row">
				<div class="col">
					<!-- 회원 대표 사진 -->
					<div id="mypage_member_thumbnail_container">
					<c:if test="${mvo.thumbnail == Null}">
						<img id="thumbnail_member" src="${url}/img/member/default_thumbnail.png"/>
					</c:if>
					<c:if test="${mvo.thumbnail != Null}">
						<img id="thumbnail_member" src="${url}/upload/${mvo.no}/thumbnail/${mvo.thumbnail}"/>
					</c:if>
						<img class="thumbnail_btn" id="thumbnail_member_btn" src="${url}/img/member/thumbnail_btn.png"/>
					</div>
					<div class="mb-3" style="display:none;">
						<label for="formFile" class="form-label">회원 사진</label>
						<input type="text" name="thumbnail">
						<input class="form-control" type="file" multiple="multiple" name="file" id="formFile_member">
					</div>
					<div class="form-floating mb-3" style="margin:0 auto; width:50%;" >
					  	<input type="email" class="form-control" value="${mvo.email}" placeholder="name@example.com" readonly>
					  	<label>이메일</label>
					</div>
					<div class="form-floating mb-3" style="margin:0 auto; width:50%;">
  						<input type="text" class="form-control" id="" value="${mvo.nickname}" placeholder="닉네임" readonly>
					  	<label >닉네임</label>
					  	
					</div>
					<div class=" mb-3" style="margin:0 auto; width:50%; text-align:center;">
					  <button id="memberForm_member_edit_btn" class="btn btn-outline-secondary" type="button">수정</button>
					  <button id="memberForm_member_delete_btn" class="btn btn-outline-secondary" type="button">회원 탈퇴</button>
					</div>
				</div>
				
				
				
			</div>
			
			</form>
		</div>
		<div class="col-4">
			${mvo.nickname} 님 반갑습니다.
			<hr/>
			<ul>
				<li>리뷰</li>
				<li>감상평</li>
				
				<li>작성글</li>
				
				<li>팔로잉 작가</li>
				<li>작가등록 신청</li>
				<li>작가 정보</li>
				
			</ul>
		</div>
		
	</div>
</main>

</body>
</html>