<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${url}/css/movie/movieView.css"
	type="text/css" />
	
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
	    <div class="stars">
	      <form action="">
	      	 <input type="checkbox" name="checkbox" id="checkbox" />
      		 <label for="checkbox">스포체크</label>
	        <input class="star star-5" id="star-5-2" type="radio" name="star" />
	        <label class="star star-5" for="star-5-2"></label>
	        <input class="star star-4" id="star-4-2" type="radio" name="star" />
	        <label class="star star-4" for="star-4-2"></label>
	        <input class="star star-3" id="star-3-2" type="radio" name="star" />
	        <label class="star star-3" for="star-3-2"></label>
	        <input class="star star-2" id="star-2-2" type="radio" name="star" />
	        <label class="star star-2" for="star-2-2"></label>
	        <input class="star star-1" id="star-1-2" type="radio" name="star" />
	        <label class="star star-1" for="star-1-2"></label>
	        <div class="review_box">
	          <textarea class="review" col="30" name="review" placeholder="평점을 남겨주세요."></textarea>
	          <label class="review" for="review"></label>
	        </div>
	        <input type="submit" value="등록" class="review_submit" />
	      </form>
	    </div>
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
                    <p class="header_review_start"><i class="fa-solid fa-star"></i></p>
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
   
</script>
</html>