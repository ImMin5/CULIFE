<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<c:set var="url" value="<%=request.getContextPath()%>"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>

body{
	background-image : url("${url}/img/login/login_background.jpg");
	background-size: cover;
	background-position: center;
	}
main{
	max-width:1200px;
} 
#login_logo_container{
	margin : 45% auto;
	background-color: black;
	border-radius : 70%;
	width:180px;
	height:180px;
}
#login_logo_container> #login_logo{
	text-align:center;
	object-fit: contain;
	width:100%;
	height: 100%;
	top: 60%;
}
#login_btn_container{
	margin : 0 auto;
}
#login_btn_img{
	text-align:center;
}
.row{
	height:100%;
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</head>
<body>

<main class="container">
  <div class="row">
    <div class="col">
      Column
    </div>
    <div class="col">
    	<div id="login_logo_container">
    		<img id="login_logo" src="${url}/img/login/culife_logo.png"  onclick="location.href='${url}/'">
    	</div>
    	<div id="login_btn_container">
	    	<a href="#0" id="kakaoLogin"><img  id="login_btn_img" src="${url}/img/login/kakao_login_medium_narrow.png" alt="카카오계정 로그인" style="height: 100px;"/></a>
	    	
	    	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	    	<script>
	    		window.Kakao.init('ad6f95c42016d0f207504edcfdb9716f');
		        function checkUser(token){
		        	var url = "${url}/login/kakao";
		        	$.ajax({
		        		url : url,
		        		type : "POST",
		        		data : {
		        			token : token,
		        		},success : function(data){
		        			console.log(data);
		        			window.location.href=data.redirect;
		        		},fail : function(error){
		        			console.log(error);
		        		}
		        		
		        	})
		        }
		        
		        function kakaoLogin() {
	            	window.Kakao.Auth.login({
	            		scope: 'profile_nickname, account_email', //동의항목 페이지에 있는 개인정보 보호 테이블의 활성화된 ID값을 넣습니다.
		                success: function(response) {
		                    checkUser(response.access_token)
		                },
		                fail: function(error) {
		                    console.log(error);
		                }
		            });
	        	};
	
	        const login = document.querySelector('#kakaoLogin');
	        login.addEventListener('click', kakaoLogin);
	    	</script>
    	</div>
    </div>
    <div class="col">
      Column
    </div>
  </div>
</main>
</body>
</html>