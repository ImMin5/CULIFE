<c:set var="url" value="<%=request.getContextPath()%>"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${url}/css/mypage/mypage.css">
<link rel="stylesheet" type="text/css" href="${url}/css/mypage/mypage_fan.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="/js/mypage/alert.js"></script>
<style>
	footer {position:fixed; left:0; bottom:0; background-color:black;}
	ul {margin-bottom: 0;}
</style>
<script>
let pageNo = 1;
let totalPage = 1;
let is_paging= true;
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
    		$("[name=thumbnail]").val(this.files[0].name);
		});
		
		//팔로우
		$(document).on("click","button[name=unfollow]",function(){
			var author = $(this).attr("data-author");
			var url ="${url}/author/follow";
			var button = $(this);
			
			$.ajax({
				url : url,
				type : "DELETE",
				dataType : "JSON",
				data :{
					author:author
				},
				success : function(data){
					if(data.status=="200"){
						button.attr("name","follow");
						button.attr("class", "btn btn-primary");
						button.text("팔로우");
					}
					
				},
				error : function(error){
					console.log(error);
				}
			});
		});
		//언팔로우
		$(document).on("click","button[name=follow]",function(){
			var author = $(this).attr("data-author");
			var url ="${url}/author/follow";
			var button = $(this);
			$.ajax({
				url : url,
				type : "POST",
				dataType : "JSON",
				data :{
					author:author
				},
				success : function(data){
					console.log(data);
					if(data.status=="200"){
						button.attr("name","unfollow");
						button.attr("class", "btn btn-secondary");
						button.text("팔로잉");
					}
					else{
						alert(data.msg);
					}
					
				},
				error : function(error){
					alert(error);
				}
			})
		});
		//스크롤 위치 파악
		$(".table-responsive").scroll(function(){
			var scrollT = $(this).scrollTop(); //스크롤바의 상단위치
	        var scrollH = $(this).height(); //스크롤바를 갖는 div의 높이
	        var contentH = $(".table").height(); //문서 전체 내용을 갖는 div의 높이
	        if(scrollT + scrollH +1 >= contentH) { // 스크롤바가 아래 쪽에 위치할 때
	        	pagination();
	        }
		});
		search();
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
			search(searchWord);
		})
		
		// 검색 함수
		function search(searchWord){
			if(pageNo != 1 && parseInt(totalPage) < parseInt(pageNo)){
				is_loading=false;
				return;
			}
			
			var url = "${url}/mypage/fan/search";
			var table = $("#myapge_table_body");
			$.ajax({
				url : url,
				type : "GET",
				dataType:"JSON",
				data : {
					pageNo : pageNo,
					searchWord : searchWord,
				},
				success : function(data){
					if(!is_paging)table.empty();
					if(data.items == null) return;
					data.items.forEach(function(element, index){
						$("#myapge_table_body").append(`
									<tr>
				  					<td onclick="location.href='/online_exhibition/onlineAuthorView?no=${'${element.no}'}'" style="width:20%; min-width:150px;"><img class="table_author_thumbnail" src="${url}/upload/${'${element.member_no}'}/author/${'${element.author_thumbnail}'}"/></td>
				  					<td onClick="location.href='/online_exhibition/onlineAuthorView?no=${'${element.no}'}'" style="width:40%;">${'${element.author}'}</td>
				  					<td style="width:20%;">${'${element.debut_year}'}</td>
				  					<td style="width:20%; text-align:center;">
				  						<button type="button" name="unfollow" data-author="${'${element.author}'}" class="btn btn-secondary" data-bs-toggle="tooltip" data-bs-placement="top" title="${'${element.author_msg}'}">
				  							팔로잉
				  						</button>
				  					</td>
				  				</tr>
						`);
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
			<div class="input-group mb-3" id="search_container">
				<img id="search_btn" src="${url}/img/member/search.png">
	  			<input type="text" class="form-control" id="search_word" placeholder="검색" style=" font-size:2.3rem;">
			</div>
			<div class="table-responsive" style=" overflow: scroll;">
		  		<table class="table">
		  			<tbody id="myapge_table_body">
		  			</tbody>
		  			
		   		</table>
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
					<li><a href="${url}/mypage/board">작성글</a></li>
					<li class="selected_menu"><a href="${url}/mypage/fan" style="color:#9DC3E6" >팔로잉 작가</a></li>
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
