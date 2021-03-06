<c:set var="url" value="<%=request.getContextPath()%>"/>
<style>
@font-face {
    font-family: 'SuncheonR';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2202-2@1.0/SuncheonR.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
a {font-family: 'SuncheonR' !important;}
body{
	width:100wv;
	height:100vh;
	background-image : url("${url}/img/main_visual_1.png");
	background-size: 100vw 100vh;
	background-position: center;
	}
main{
	max-width:1200px;
	height:100vh;
} 
#login_logo_container{
	margin : 0 auto;
	background-color: black;
	border-radius : 70%;
	width:180px;
	height:180px;
	text-align:center;
	margin-top : 43vh;
}
#login_logo_container> #login_logo{
	object-fit: contain;
	width:100%;
	height: 100%;
}
#login_btn_container{margin-top:40px;}
#login_btn_img{text-align:center;}
.row{height:100%;}
footer {display:none}
</style>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<main class="container">
  <div class="row">
    <div class="col">
      Column
    </div>
    <div class="col" style="text-align:center;">
    	<div id="login_logo_container">
    		<img id="login_logo" src="${url}/img/login/culife_logo.png"  onclick="location.href='${url}/'">
    	</div>
    	<div id="login_btn_container" >
	    	<a href="#0" id="kakaoLogin"><img  id="login_btn_img" src="${url}/img/login/kakao_login_medium_narrow.png" alt="카카오계정 로그인"/></a>
	    	
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
		        			if(data.status=="201"){
		        				alert(data.msg);
		        			}
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
