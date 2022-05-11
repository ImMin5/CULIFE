<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
 @font-face {
   font-family: 'RixYeoljeongdo_Regular';
   src:
      url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2102-01@1.0/RixYeoljeongdo_Regular.woff')
      format('woff');
   font-weight: normal;
   font-style: normal;
}

* {
   box-sizing: border-box;
}

header {
   width: 100vw;
   height: 100px;
   background-color: rgba(0, 0, 0, 0.5);
   position: fixed;
   z-index: 999;
   text-align: center;
   top: 0;
}

body {
   background: black;
   -webkit-user-select: none;
   -moz-user-select: none;
   -ms-user-select: none;
   user-select: none;
   position: relative;
}

.movieView_container {
   margin: 0 auto;
   margin-top: 160px;
   max-width: 1500px;
   height: 4000px;
}

.movieDetail_container {
   position: relative;
   margin: 0px auto;
   width: 1300px;
   height: 700px;
   margin: 0px auto;
}

.movie_card {
   position: relative;
   margin: 0 auto;
   display: block;
   width: 100%;
   height: 600px;
   margin-top: 100px;
   overflow: hidden;
   border-radius: 12px;
   /* transition: all 0.4s ease-in-out; */
}

.movie_card .info_section {
   position: relative;
   width: 100%;
   height: 100%;
   background-blend-mode: multiply;
   border-radius: 10px;
   z-index: 10;
}

.movie_card .info_section .movie_header {
   position: relative;
   display: inline-block;
   padding: 15px;
   height: 45%;
}

.movie_card .info_section .movie_header h1 {
   font-family: 'RixYeoljeongdo_Regular';
   margin-top: 50px;
   color: white;
   font-size: 30px;
}

.movie_card .info_section .movie_header h5 {
   margin-bottom: 15px;
   color: white;
   font-weight: 200;
}

.movie_card .info_section .movie_header h4 {
   margin: 2px;
   color: #cee4fd;
   font-size: 18px;
}

.movie_card .info_section .movie_header .minutes {
   display: inline-block;
   margin: 10px 0 5px 0;
   padding: 9px;
   color: #fff;
   border-radius: 5px;
   border: 1px solid rgba(255, 255, 255, 0.33);
   font-size: 18px;
}

.movie_card .info_section .movie_header .type {
   display: block;
   margin: 2px;
   color: #cee4fd;
   font-size: 18px;
}

.movie_card .info_section .movie_header .poster {
   position: relative;
   float: left;
   margin-right: 20px;
   height: 300px;
   box-shadow: 0 0 20px -10px rgba(0, 0, 0, 0.5);
}

.movie_card .info_section .movie_desc {
   display: flex;
   align-items: center;
   margin-top: 15px;
   padding: 15px;
   height: 45%;
}

.movie_card .info_section .movie_desc .text {
   color: #cfd6e1;
   line-height: 21px;
}

/*
.movie_card .info_section .movie_social {
   height: 10%;
   padding-left: 15px;
   padding-bottom: 20px;
   bottom: 0;
   position: absolute;
}

.movie_card .info_section .movie_social ul {
   padding: 0;
   list-style: none;
}

.movie_card .info_section .movie_social ul li {
   display: inline-block;
   margin: 0 10px;
   color: rgba(255, 255, 255, 0.4);
   transition: color 0.3s;
   transition-delay: 0.15s;
}

.movie_card .info_section .movie_social ul li:hover {
   color: rgba(255, 255, 255, 0.8);
   transition: color 0.3s;
}

.movie_card .info_section .movie_social ul li i {
   font-size: 19px;
   cursor: pointer;
}
*/
.movie_card .info_section .movie_youdube {
   display: inline-block;
   width: 150px;
   height: 100px;
   padding: 0 15px;
   position: relative;
}

.movie_card .info_section .movie_youdube a {
   color: white;
   text-decoration: none;
}

.fa-youtube {
   position: absolute;
   right: 47%;
   bottom: 50%;
   margin-left: 12px;
   color: #ffffff7b;
   font-size: 80px;
}

.fa-youtube:hover {
   background-image: linear-gradient(-20deg, #d558c8 0%, #24d292 100%);
   -webkit-background-clip: text;
   -webkit-text-fill-color: transparent;
}

.movie_card .blur_back {
   position: absolute;
   top: 1px;
   right: 0;
   height: calc(100% - 2px);
   z-index: 1;
   background-size: cover;
   border-radius: 11px;
}

@media screen and (min-width: 768px) {
   .movie_header {
      width: 55%;
   }
   .movie_desc {
      width: 50%;
   }
   .info_section {
      background: linear-gradient(to right, #0d0d0c 50%, transparent 100%);
   }
   .blur_back {
      width: 80%;
      background-position: -100% 10% !important;
   }
}

@media screen and (max-width: 768px) {
   .movie_card {
      width: 98%;
      height: auto;
      margin: 70px auto;
   }
   .blur_back {
      width: 100%;
      background-position: 50% 50% !important;
   }
   .movie_header {
      width: 100%;
      margin-top: 85px;
   }
   .movie_desc {
      width: 100%;
   }
   .info_section {
      background: linear-gradient(to top, #141413 50%, transparent 100%);
      display: inline-grid;
   }
}

.shadow {
   box-shadow: 0px 30px 190px -45px rgba(19, 160, 134, 0.6);
}
/*
.shadow:hover {
   box-shadow: 0px 0px 120px -55px rgba(19, 160, 134, 0.6);
}
*/
.modal {
   display: none;
   justify-content: center;
   align-items: center;
   position: absolute;
   z-index: 9999;
   left: 55px;
   top: 100px;
   width: 1100px;
   height: 600px;
   overflow: hidden;
   background-color: black;
   background-color: rgba(50, 50, 50, 0.6);
   animation-name: fadeIn;
   animation-duration: 0.4s;
   outline: 0;
}

.modal_content {
   text-align: center;
}

@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

.movieCreadits_container {
   background: #f1f3f5;
   padding: 0;
   max-width: 1300px;
   height: 360px;
   margin: 25px auto;
   position: relative;
   /* background-color: darkgoldenrod; */
}

.slider {
   display: flex;
   height: 100%;
   width: 100%;
   overflow-x: auto;
   overflow-y: hidden;
   position: relative;
   scroll-behavior: auto;
   -webkit-overflow-scrolling: touch;
   -ms-scroll-snap-type: x proximity;
   scroll-snap-type: x proximity;
   -ms-scroll-chaining: none;
   overscroll-behavior: contain;
   -webkit-overflow-scrolling: touch;
   -ms-overflow-style: -ms-autohiding-scrollbar;
   scrollbar-width: thin;
   scrollbar-color: #adb5bd transparent;
   background-color: black;
}

.slider::-webkit-scrollbar {
   height: 13px;
   width: 6px;
}

.slider::-webkit-scrollbar-track {
   background-color: transparent;
   border-radius: 10px;
}

.slider::-webkit-scrollbar-thumb {
   background-image: linear-gradient(-20deg, #d558c8 0%, #24d292 100%);
   border-radius: 10px;
   cursor: pointer;
   -webkit-transition: all 200ms ease-in-out;
   transition: all 200ms ease-in-out;
}

.slider::-webkit-scrollbar-thumb:hover {
   background-image: linear-gradient(to right, #43e97b 0%, #38f9d7 100%);
}

.slider::-webkit-scrollbar-thumb:active {
   background-image: linear-gradient(to right, #43e97b 0%, #38f9d7 100%);
}

.slider::-webkit-scrollbar-thumb:vertical {
   min-height: 30px;
}

.slider::-webkit-scrollbar-thumb:horizontal {
   min-width: 30px;
}

.itemDiv .item {
   display: flex;
   width: 164px;
   height: 230px;
   position: relative;
   padding: 0;
   margin: 32px 22px 17px 0px;
   -moz-border-radius: 13px 13px 13px 13px;
   -webkit-border-radius: 13px 13px 13px 13px;
}

.textTag {
   color: white;
   font-size: 18px;
   font-weight: 500;
   text-align: center;
}

.h4Text {
   font-family: 'RixYeoljeongdo_Regular';
   background-color: black;
   color: white;
   font-size: 32px;
   color: white;
}

@-webkit-keyframes show {
  0% {
    transform: translateY(-10px);
    opacity: 0;
  }
  50% {
    transform: translateY(10px);
  }
  100% {
    transform: translateY(0);
    opacity: 1;
  }
}
@keyframes show {
  0% {
    transform: translateY(-10px);
    opacity: 0;
  }
  50% {
    transform: translateY(10px);
  }
  100% {
    transform: translateY(0);
    opacity: 1;
  }
}
</style>

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