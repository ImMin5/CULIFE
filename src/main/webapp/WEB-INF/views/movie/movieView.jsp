<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${url}/css/movie/movieView.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>


<script>
$(function(){
	mreviewListAll();
	$(document).on("click","input[name=readspo]",function(){
        var review_no = $(this).attr("data-review_no");
        var spocontent_element = $("#spocontent"+review_no)
        if(spocontent_element.css("display") == "block"){
            spocontent_element.css("display","none");
            $(this).val("리뷰보기");
        }
        else{
            spocontent_element.css("display","block");
            $(this).val("리뷰숨기기");
        }
	});
});
function editForm(idx){
	$('#editDiv'+idx).show()
}
//영화리뷰리스트
	function mreviewListAll(){
		var url = "/mreview/mreviewList";
		var params = "movie_id=" + movieId;
		var logNo = '${logNo}';
		//console.log(logNo);
		$.ajax({
			url:url,
			data:params,
			success:function(result){
				//alert(JSON.stringify(result))
				var score = result.star_avg;
					$('#avg').html(score);
				var cnt = result.review_cnt;
					$("#mreviewCnt").html("<h1>"+cnt+"</h1>") 
				var $result = $(result.reviewList);
				var tag = "<ul>";
				
				$result.each(function(idx, vo){
					//alert(vo.nickname);
					tag += "<li><div id='reviewOne'>" + vo.nickname;
					tag += "("+ vo.write_date+")";
					for(var i=0;i<vo.score_star;i++){
						tag+= "★";
					}
					tag += " ("+vo.score_star+")";
					if(logNo != "" && logNo !=vo.member_no){
						tag += "<input class='warning' type='button' value='신고' onclick='warning(" + vo.no +")'/>";						
					}	
					if(vo.member_no=='${logNo}'){
						tag += "<input type='button' value='수정' class='review_edit'/>"; 
						tag += "<input type='button' value='삭제' class='review_delete' title='"+vo.no+"'/>";	
					}
					if(vo.spo_check==1){
						tag+="<p class='spoiler'>스포일러</p>";
/* 						tag+="<li style='margin-left: -20%; color:#e75959; font-size:23px; padding-bottom:5px;'>스포일러</li>" */
							tag+="<div id='spocontent"+vo.no+"' class='spo'>"+ vo.content +"</div></div>";
						if(vo.spo_check==1){
							tag+="<input id='more' class='more' type='button' value='리뷰보기' name='readspo' data-review_no='"+vo.no+"'/>";
						}
					}else{
						tag += "<br/>" + vo.content + "</div>";
					}
													
				
				if(vo.member_no=='${logNo}'){
					
					tag +="<div class='stars_edit'>"
					tag += "<form method='post'  action='/mreview/mreviewWriteOk' id='editFrm'>"
					tag += "<input type='hidden' name='no' value='"+vo.no+"'/>";
					tag += "<input type='hidden' name='score_star' id='score_star_edit'>";
					
					tag += "<div class='stars'>	"
						if(vo.spo_check==1){
							tag += "<input type='checkbox' name='spo_check' id='spo_check' value='1' checked/>";
							tag += "<label for='spo_check'>스포체크</label>"
						}else{
							tag += "<input type='checkbox' name='spo_check' id='spo_check' value='1'/>";
							tag += "<label for='spo_check'>스포체크</label>"
						}
					//console.log(vo.score_star);
					var str1, str2, str3, str4, str5;
					if(vo.score_star==1){
						str1="checked";
					}else if(vo.score_star==2){
						str2="checked";
					}
					else if(vo.score_star==3){
						str3="checked";
					}
					else if(vo.score_star==4){
						str4="checked";
					}
					else if(vo.score_star==5){
						str5="checked";
					}
					tag += `
						<input class="star star-5" id="star-5-2" type="radio" `+str5+` name="score_star" value="5" title="5점"/>
				        <label class="star star-5" for="star-5-2"></label>
				        <input class="star star-4" id="star-4-2" type="radio" `+str4+` name="score_star" value="4" title="4점"/>
				        <label class="star star-4" for="star-4-2"></label>
				        <input class="star star-3" id="star-3-2" type="radio" `+str3+` name="score_star" value="3" title="3점"/>
				        <label class="star star-3" for="star-3-2"></label>
				        <input class="star star-2" id="star-2-2" type="radio" `+str2+` name="score_star" value="2" title="2점"/>
				        <label class="star star-2" for="star-2-2"></label>
				        <input class="star star-1" id="star-1-2" type="radio" `+str1+` name="score_star" value="1" title="1점"/>
				        <label class="star star-1" for ="star-1-2"></label>
				       </div>`
				    tag += "<div class='Ereview_box'>"
				    tag += "<textarea class='review' name='content'>"+vo.content+"</textarea>";				    
				    tag += "<label class='review' for='review'></label>"
				    	
					tag += "<input type='submit' value='수정' class='review_edit_edit' />";	
				    tag += "</div>"		
				    tag += "</form>"
				    tag += "</div>"
				    
				}
				tag += "<hr class='hr_style'/></li>";
				score_star = vo.score_star;	
				});
				tag+="</ul>";
				
				$("#mreviewList").html(tag);
			}, error:function(e){
				console.log(e.responseText);
			}
		});
	}
	
//영화리뷰등록
$(function(){
	$("#mreviewFrm").submit(function(){
		event.preventDefault();
		if($("#content").val()==''){
			alert("리뷰를 입력 후 등록하세요.");
			return false;
		}else{
			var params = $("#mreviewFrm").serialize();
			
			$.ajax({
				url:'/mreview/mreviewWriteOk',
				data:params,
				type:'POST',
				success:function(r){
					if(parseInt(r)==-1){
						alert('이미 리뷰를 작성하였습니다.');
						$('#content').val("");
					}
					$("#stars").val("");
					mreviewListAll();
				},error:function(e){
					console.log(e.responseText);
				}
			});
		}
	});
});
//영화리뷰수정
$(document).on('click','#mreviewList input[value=수정]', function(){
	$('#mDiv').css("display","none");	
	$('#reviewOne').css("display","none");
	$('.stars_edit').css("display","block");
});
$(document).on('submit','#editFrm',function(){
	event.preventDefault();
	$("#score_star_edit").val($("input[name=score_star]:checked").val());
	var params = $(this).serialize();
	//alert(params)
	var url = '/mreview/mreviewEditOk';
	$.ajax({
		url:url,
		data:params,
		type:'POST',
		success:function(result){
			console.log(result);
			mreviewListAll();
		},error:function(e){
			console.log('수정에러발생');
		}
	});
});
$(document).ready(function(){
	$("input[name='score_star']:radio").click(function () { 
		//alert('a')
		$("input:radio[name='score_star']").removeAttr('checked');
		
		var editStar = $(this).val();
		$("input:radio[name='score_star']:radio[value='"+editStar+"']").prop("checked",true);
		//alert(editStar)
		//console.log(editStar);			
		$('#score_star_edit').val(editStar)
	});
});	

/* $("input[name='score_star']:radio").each(function(i, obj){
console.log(editStar+": "+$(obj).val());
if(editStar>=$(obj).val()){
	console.log(">>>"+$(obj).val())
	$(obj).prop("checked", false)
	//$('~:radio',obj).css('background-color','yellow')
}else{
	$('~:radio',obj).css('background-color','#444')
}
}); */
//영화리뷰삭제
$(document).on('click','#mreviewList input[value=삭제]', function(){
	if(confirm('리뷰를 삭제하시겠습니까?')){
		var params = "no=" + $(this).attr("title");
		$.ajax({
			url:'/mreview/mreviewDel',
			data:params,
			success:function(result){
				//console.log(result);
				mreviewListAll();
			}, error:function(e){
				console.log("리뷰삭제에러발생");
			}
		});
	}
});

//영화리뷰신고기능
function warning(no){
	if(confirm('해당 댓글을 신고하시겠습니까?')){
		//alert(no);
		var params = no;
		$.ajax({
			type:'get',
			url:'/mwarning/'+no,			
			success:function(result){
				if(parseInt(result)>0){
					alert('신고가 완료되었습니다.');
					mreviewListAll();
				}else{
					alert('이미 신고 처리되었습니다.')
				}				
			},error:function(e){				
				console.log("신고에러발생 "+JSON.stringify(e));
			}
		});
	}
}

</script>

<body>
   <div class="movieView_container">
      <div class="movieDetail_container">
         <!-- 모달 시작 -->
         <div id="myModal" class="modal">
            <div class="modal_content">
               <iframe src="" id="video" allowscriptaccess="always"
                  allow="autoplay"
                  style="border: none; width: 840px; height: 560px; max-width: 90%;">
               </iframe>
            </div>
         </div>
      </div>


      <div class="movieCreadits_container">
         <h4 class="h4Text">주요 출연진</h4>
         <div class="slider"></div>
      </div>
      
      <h4 class="h4Text review_h4Text">평점 작성</h4>
      <div class="review_container">
	    <div class="stars" id="mDiv">
	    <c:if test="${logNo != null}">
	      <form method="post" id="mreviewFrm" action="/mreview/mreviewWriteOk">
	      	<input type="hidden" name="movie_title" id="movie_title" value="${vo.movie_title}"/>
	      	<input type="hidden" name="poster_path" id="poster_path" value="${vo.poster_path}"/>
	      	<input type="hidden" name="vote_count" id="vote_count" value="${vo.vote_count}"/>
	      	<input type="hidden" name="movie_id" id="movie_id" value="${vo.movie_id}"/>
	      	 <input type="checkbox" name="spo_check" id="checkbox" value='1'/>
      		 <label for="checkbox">스포체크</label>
	        <input class="star star-5" id="star-5-2" type="radio" name="score_star" value="5" title="5점"/>
	        <label class="star star-5" for="star-5-2"></label>
	        <input class="star star-4" id="star-4-2" type="radio" name="score_star" value="4" title="4점"/>
	        <label class="star star-4" for="star-4-2"></label>
	        <input class="star star-3" id="star-3-2" type="radio" name="score_star" value="3" title="3점"/>
	        <label class="star star-3" for="star-3-2"></label>
	        <input class="star star-2" id="star-2-2" type="radio" name="score_star" value="2" title="2점"/>
	        <label class="star star-2" for="star-2-2"></label>
	        <input class="star star-1" id="star-1-2" type="radio" name="score_star" value="1" title="1점"/>
	        <label class="star star-1" for ="star-1-2"></label>
	        <div class="review_box">
	          <textarea id="content" class="review" col="30" name="content" placeholder="평점을 남겨주세요."></textarea>
	          <label class="review" for="review"></label>
	        </div>
	        <input type="submit" value="등록" class="review_submit" />
	      </form>
	      </c:if>
	    </div>
	    <div id="mstarAvg"></div>
	    <div id="mreviewList"></div>	   
  	</div>
      
   </div>
</body>

<script
   src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
<script>
      let movieCredits_container;
      const key = "52048cb9f5d2b1983acc31ecdadd5b4d";
      
      let base_url = "https://image.tmdb.org/t/p/w300/";
      let bg = "https://image.tmdb.org/t/p/w500";
      let youtube = "https://www.youtube.com/embed/";
      let tmdb =
        "https://api.themoviedb.org/3/search/movie?api_key=52048cb9f5d2b1983acc31ecdadd5b4d&query=";
      
      const movieId='${movieId}'
      //alert(movieId)
      function openView2(){
          //console.log(movieId);
        
          const movieDetailUrl = "https://api.themoviedb.org/3/movie/"+movieId+"?api_key="+key+"&language=ko-KR";
          //console.log(movieDetailUrl)
          fetch(movieDetailUrl)
            .then(res => res.json())
            .then(function(res){
             //console.log(res)
            $('#movie_title').val(res.title)
            $('#poster_path').val(res.poster_path)
            $('#vote_count').val(res.vote_count)
            $('#movie_id').val(movieId)
            $(".movieDetail_container").append(`
                <div id="${movieId}" class="movie_card shadow">
                <div class="info_section">
                  <div class="movie_header">
                    <img class="poster" src=${'${base_url + res.poster_path}'} />
                    <h1>${'${res.title}'}</h1>
                    <h5>${'${res.original_title}'}</h5>
                    <span class="minutes">${'${res.runtime}'}분</span>
                    <p class="type">장르 : ${'${res.genres[0].name}'}</p>
                    <h4>개봉 : ${'${res.release_date}'}</h4>
                    <p class="header_review_start"><i class="fa-solid fa-star">  ${mstar_avg}</i></p>
                  </div>
                  <div class="movie_desc">
                    <p class="text">
                    ${'${res.overview}'}
                    </p>
                  </div>
                  <div class="movie_youtube">
                      <a class="preview" title="예고편" href="#">
                         <i class="fa-brands fa-youtube"></i> 
                      </a>
                  </div>
                </div>
                <div class="blur_back"></div>
              </div>
               `) ;
               
               return fetch(
                     "https://api.themoviedb.org/3/movie/"+movieId+"?api_key=52048cb9f5d2b1983acc31ecdadd5b4d&language=ko-KR")
               .then((response) => {
                   return response.json();
                 })
                 .then((response) => {
                    //console.log(response)
                   $(".blur_back").css({
                     background: `url(${'${bg + response.backdrop_path}'})`,
                     "background-repeat": "no-repeat",
                     "background-size": "cover"
                   });
      
                   $(".preview").on("click", function () {
                      loadVideo(`${'${response.id}'}`);
                     return false;
                   });
                 });
             });
         }
      
         function loadVideo(movieId) {
           fetch("https://api.themoviedb.org/3/movie/"+movieId+"/videos?api_key="+key)
             .then((response) => response.json())
             .then((data) => {
                //console.log(data);
               for (let x = 0; x < data.results.length; x++) {
                 if (
                   data.results[x].type == "Trailer" &&
                   data.results[x].site == "YouTube"
                 ) {
                   var modal = document.getElementById("myModal");
                   modal.style.display = "flex";
                   $("#video").attr(
                     "src",
                     youtube +
                       data.results[x].key +
                       "?autoplay=1" //&amp;modestbranding=1&amp;showinfo=0
                   );
                   break;
                 }
               }
             });
         }
         

      $(function(){
         movieCredits_container = document.querySelector(".slider");
      
            // 모달 시작
            let modal = document.getElementById("myModal");
         
            // 모달 종료
            window.onclick = function (event) {
            //   console.log(event.target)
            //  if (event.target == modal) {
                modal.style.display = "none";
                $("#video").attr("src", "");
              
            };
      
         });
      
         function movieCredits (event) {
             fetch("https://api.themoviedb.org/3/movie/"+movieId+"/credits?api_key="+key+"&language=ko-KR")
                .then((res) => res.json())
                .then((data) => {
                     const movies = data.cast;
                   // console.log(movies.length)
                    movies.map(function(credits){
                       // console.log(credits);
                          let imgTag;              
                        // console.log(credits.profile_path);
         
                            if (credits.profile_path != null ) {
                               div = document.createElement("div");
                       
                               imgTag = document.createElement("img");// <img class="item" src="경로"></img>
                               textTag = document.createElement("p");
                               
                               div.className = "itemDiv";
                             
                              imgTag.className = "item";
                             imgTag.src = base_url + credits.profile_path;
                             // imgTag.title = "";
                               textTag.innerText = credits.name;
                               textTag.className = "textTag"
                               
                          movieCredits_container.appendChild(div);
                      
                          div.appendChild(imgTag);
                          div.appendChild(textTag);
                             }        
                        });                
                   });
            }
      
         const slides = document.querySelectorAll(".item");

         observer = new IntersectionObserver((entries) => {
           entries.forEach((entry) => {
             if (entry.isIntersecting) {
               // if (entry.intersectionRatio > 0) {
               entry.target.classList.add("active");
             } else {
               entry.target.classList.remove("active");
             }
           });
         });

         slides.forEach((image) => {
           observer.observe(image);
         });
      
   
      window.addEventListener("load", openView2)
      window.addEventListener("load", movieCredits)
      
   /*    window.onload=openView2 */
    
	    	/* $('input[name="star"]').click(function(){
	    		alert('a')
	    		if($(this).is(':checked')){
	    		$('#vote_count).val($(this).val());
	    		}
	    	}) */
   
</script>
</html>