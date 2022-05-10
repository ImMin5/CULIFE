<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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

body {
   background: black;
   -webkit-user-select: none;
   -moz-user-select: none;
   -ms-user-select: none;
   user-select: none;
    position: relative;
 }
    
 
 .movie_container {
    margin: 100px auto 0 auto;
    width: 1500px;
    height: 4000px;

 }
 
  .mainBox_slider {
     width: 100%;
     height: 700px;
     background-image: url(/img/movie/bg.png);
     background-repeat: no-repeat;
     background-size:100vw 700px;
     margin: auto;
     margin-top: 100px;
     overflow: hidden;
     position: relative;
     
   }

   .mainBox_slider .boxSlides {
     display: flex;
   }
   .mainBox_slider .boxSlides_slide {
     width: 258px;
   }

   .boxSlides_slide {
     margin: 80px;
     position: relative;
     left: 35%;
   }

   .boxSlides_slide > img {
     width: 320px;
     height: 450px;
     -webkit-box-shadow: 9px 2px 50px 14px #ff0000;
     box-shadow: 9px 2px 50px 14px #ff0000;
     border-radius: 10px;
     cursor: pointer;
   }

    .rank_container {
      background: black;
      max-width: 1400px;
      height: 400px;
      margin: 80px auto;
      /* background-color: darkgoldenrod; */
    }
    
    .rank_container_text {
        font-family: 'RixYeoljeongdo_Regular';
      margin-bottom: 10px;
       background-color: black;
       font-size: 38px;
       color: white;   
    }
    
    .rank_container.populary_playing {
       margin-top: 140px;
       position: relative;
    }
    
    .rank_container.now_playing {
        margin-top: 150px;
       position: relative;
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
    .slider.slider_now_playing::-webkit-scrollbar-thumb {
      background-color: #adb5bd;
      border-radius: 10px;
      cursor: pointer;
      -webkit-transition: all 200ms ease-in-out;
      transition: all 200ms ease-in-out;
    }
    .slider.slider_now_playing::-webkit-scrollbar-thumb:hover {
      background-image: linear-gradient(-225deg, #2CD8D5 0%, #C5C1FF 56%, #FFBAC3 100%);
    }
    .slider.slider_now_playing::-webkit-scrollbar-thumb:active {
      background-image: linear-gradient(-225deg, #2CD8D5 0%, #C5C1FF 56%, #FFBAC3 100%);
    }
    .slider.slider_now_playing::-webkit-scrollbar-thumb:vertical {
      min-height: 30px;
    }
    .slider.slider_now_playing::-webkit-scrollbar-thumb:horizontal {
      min-width: 30px;
    }

    .item {
      display: flex;
      align-items: center;
      justify-content: space-around;
      background: #212529;
      flex: 1 0 19.87%;
      text-align: center;
      color: rgba(255, 255, 255, 0.7);
      position: relative;
      padding: 0;
      margin: 10px 1px;
      border: 5px solid black;
      border-radius: 14px;
      transition: all 2s ease-in-out;
      counter-increment:list-number;
      margin-bottom: 18px;
      cursor: pointer;
    }

    .innerNum1 {
     font-family: 'RixYeoljeongdo_Regular';
      font-size: 90px;
      font-style: italic;
      color: rgba(163, 180, 180, 0.788);
      position: absolute;
      left: 0px;
      bottom: -60px;
      z-index: 11;
    }

    .innerNum2 {
     font-family: 'RixYeoljeongdo_Regular';
     font-size: 90px;
      font-style: italic;
      color: rgba(163, 180, 180, 0.788);
      position: absolute;
      left: 285px;
      bottom: -60px;
      z-index: 11;
    }

    .innerNum3 {
     font-family: 'RixYeoljeongdo_Regular';
     font-size: 90px;;
      font-style: italic;
      color: rgba(163, 180, 180, 0.788);
      position: absolute;
      left: 566px;
      bottom: -60px;
      z-index: 11;
    }

    .innerNum4 {
     font-family: 'RixYeoljeongdo_Regular';
     font-size: 90px;
      font-style: italic;
      color: rgba(163, 180, 180, 0.788);
      position: absolute;
      left: 848px;
      bottom: -60px;
      z-index: 11;
    }

    .innerNum5 {
     font-family: 'RixYeoljeongdo_Regular';
     font-size: 90px;
      font-style: italic;
      color: rgba(163, 180, 180, 0.788);
      position: absolute;
      left: 1126px;
      bottom: -60px;
      z-index: 11;
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
    .arrows {
      position: absolute;
      top: 60%;
      transform: translateY(-60%);
      display: flex;
      justify-content: space-between;
      width: 112%;
      z-index: 255;
      left: -6%;

      
    }
    .arrows .prev,
    .arrows .next {
      width: 48px;
      height: 48px;
      /* background: rgba(255, 255, 255, 0.7); */
      color: #adb5bd;
      text-align: center;
      line-height: 46px;
      display: block;
      font-size: 32px;
      font-weight: 700;
      cursor: pointer;
      border-radius: 50%;
      transition: all 200ms ease-in-out;
      font-size: 48px;
    }
    .arrows .prev:hover,
    .arrows .next:hover {
   background-image: linear-gradient(-225deg, #69EACB 0%, #EACCF8 48%, #6654F1 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    transform: scale(1.4);
    
    }
    
    
    
      .search_container {
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
        margin: 50px 0 70px 0;
      }

      #searchMovie {
        background-color: black;
        float: right;
        margin-top: 1px;
        margin-right: 8px;
        padding: 6px 10px;
        width: 320px;
        color: white;
        border: none;
        border-bottom: white solid 4px;
        font-size: 24px;
        font-weight: bold;
        transition: 0.3s;
      }

      #searchMovie:focus {
        
        width: 480px;
  
        font-size: 24px;
        font-weight: bold;
        transition: 0.3s;
        border-bottom: white solid 4px;
        outline: none;
      }

      #searchMovie::placeholder {
        color: white;
        font-size: 1em;
        font-weight: bold;
      }

      main {
        width: 100%;
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
      }
      main div {
        width: 250px;
        height: 320px;
        margin: 19px 15px;
      }
      img {
        width: 100%;
        height: 100%;
      
      }
      .search_text {
        margin: 0;
        font-size: 20px;
        font-weight: bold;
        text-align: center;
        color: pink;
      }

      .fa-magnifying-glass {
        color: white;
        font-size: 32px;
      }

  </style>
  <body>
    <div class="mainBox_slider">
        <div class="boxSlides" id="boxSlides"></div>
     </div>
     <div class="movie_container">
             <div class="rank_container populary_playing">
               <p class="rank_container_text">인기 상영중</p>
               <p class="innerNum1">1</p>
                <p class="innerNum2">2</p>
                <p class="innerNum3">3</p>
                <p class="innerNum4">4</p>
                <p class="innerNum5">5</p>
         
            <div class="slider slider_populary_playing">
            </div>
          </div>
          
          
            <div class="rank_container now_playing">
              <p class="rank_container_text">역대 흥행작</p>
               <div class="arrows">
                   <div class="prev">
                      <i class="fa-solid fa-caret-left"></i>
                   </div>
                     <div class="next">
                     <i class="fa-solid fa-caret-right"></i>
                   </div>
               </div>
            <div class="slider slider_now_playing">
            </div>
          </div>

      <div class="search_container">
        <form id="form">
          <input
            type="text"
            id="searchMovie"
            placeholder="영화를 검색해주세요"
            class="searchMovie"
          />
        </form>
        <i class="fa-solid fa-magnifying-glass"></i>
      </div>
    

    <main id="main"></main>      
      
    </div>
    <script>
      const slider = document.querySelector(".slider");
      const slider1 = document.querySelector(".slider_now_playing");
      const slider2 = document.querySelector(".slider_populary_playing");
      let scrollAmount = 0;
      let scrollMax = slider2.clientWidth; //현재상영중만 적용

      let page = 1;
      const key = "52048cb9f5d2b1983acc31ecdadd5b4d";
      const base_url = "https://image.tmdb.org/t/p/w300/";
      const section = document.querySelector(".boxSlides");
    
      function fetchMainBox() {
         const url ="https://api.themoviedb.org/3/movie/now_playing?api_key="+key+"&language=ko-KR&region=KR&page=1";
         
          fetch(url)
            .then((res) => res.json())
            .then(function (res) {
              const movies = res.results;
              movies.map(function (movie) {
                //console.log(movie.title);
                const div = document.createElement("div");
                div.className = "boxSlides_slide";
                const output = `
                          <img src= ${'${base_url + movie.poster_path}'} loading="lazy" data-id=${'${movie.id}'} onClick= 'openView(this)' >
                     `;
                div.innerHTML = output;
                section.appendChild(div);
              });
            })
            .catch((err) => console.log(err));
        }

        let xOffset = 0;
        let isMouseIn = false;
        const boxSlides = document.getElementById("boxSlides");

        setInterval(translate, 0);

        function translate() {
          let offsetIncrement = isMouseIn ? 0.001 : 0.1;
          if (xOffset >= 258 * 7) xOffset = 0;
          else xOffset = xOffset + offsetIncrement;
          boxSlides.style.transform = "translateX(-" + xOffset + "px)";
        }

        boxSlides.addEventListener("mouseover", function (event) {
          isMouseIn = true;
        });

        boxSlides.addEventListener("mouseout", function (event) {
          isMouseIn = false;
        });
      

      function fetchMovie1(page) {
       // 역대 흥행작 API
         const url ="https://api.themoviedb.org/3/movie/top_rated?api_key="+key+"&language=ko-KR&region=KR&page=1";
        fetch(url)
          .then((res) => res.json())
          .then(function (res) {
            const movies = res.results;
            movies.map(function (movie) {
              //console.log(movie.title);
              const img = document.createElement("img");
              img.className = "item";
              img.src = base_url + movie.poster_path;
              img.setAttribute("data-id", movie.id);
              img.setAttribute("onClick", "openView(this)"); 
        
              slider1.appendChild(img);
            });
          })
          .catch((err) => console.log(err));
      }

      function fetchMovie2(page) {
          // 인기 상영중 API
          const url ="https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key="+key+"&language=ko-KR&page=1"; 
          fetch(url)
            .then((res) => res.json())
            .then(function (res) {
              const movies = res.results;
              movies.map(function (movie) {
                //console.log(movie.title);
                const img = document.createElement("img");
                img.className = "item";
                img.src = base_url + movie.poster_path;
                img.setAttribute("data-id", movie.id);
                img.setAttribute("onClick", "openView(this)"); 
          
                slider2.appendChild(img);
             
              });
            })
            .catch((err) => console.log(err));
        }
      
      function openView(event) {
        const movieId = event.getAttribute("data-id");
        location.href="/movie/movieView?movieId="+movieId
      }
      window.addEventListener("load", fetchMainBox());
      window.addEventListener("load", fetchMovie1());
      window.addEventListener("load", fetchMovie2());

      // 스크롤 >
      document.querySelector(".next").onclick = function () {
        slider1.scrollTo({
          top: 0,
          left: scroll("right"),
          behavior: "smooth",
        });
      };

      // 스크롤 <
      document.querySelector(".prev").onclick = function () {
        slider1.scrollTo({
          top: 0,
          left: scroll("left"),
          behavior: "smooth",
        });
      };

      // 스크롤 되감기
      function scroll(dir) {
        switch (dir) {
          case "left":
            scrollAmount > 0
              ? (scrollAmount -= scrollMax)
              : (scrollAmount = slider.scrollWidth - scrollMax);
            return scrollAmount;
            break;
          case "right":
            scrollAmount <= slider.scrollWidth - scrollMax
              ? (scrollAmount += scrollMax)
              : (scrollAmount = 0);
            return scrollAmount;
            break;
        }
      }

      
      const slides = document.querySelectorAll(".item");

      // scroll 이벤트와 가시성 관찰, 루트 요소와 타겟 요소의 교차점을 관찰
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
      
      // const apiUrl =
      //   "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=04c35731a5ee918f014970082a0088b1&language=ko-KR&page=1";

      const SEARCHAPI =
        "https://api.themoviedb.org/3/search/movie?&api_key=52048cb9f5d2b1983acc31ecdadd5b4d&language=ko-KR&query=";
      const main = document.querySelector("#main");
      const form = document.querySelector("#form");
      const search = document.querySelector("#searchMovie");

      // searchMovies(apiUrl);
      function searchMovies(url) {
        fetch(url)
          .then((res) => res.json())
          .then(function (data) {
            if (data.results.length == 0) {
              const div = document.createElement("div");
              const text = document.createElement("p");
              text.className = "search_text";
              text.innerHTML = "검색결과가 없습니다.";
              main.appendChild(div);
              div.appendChild(text);
            }
            data.results.forEach((element) => {
              console.log(element);

              const div = document.createElement("div");
              const image = document.createElement("img");
              const text = document.createElement("p");

              text.innerHTML = `${element.title}`;
              text.className = "search_text";
              image.src =  base_url + element.poster_path;
              div.appendChild(image);
              div.appendChild(text);
              main.appendChild(div);
            });
          });
      }

      form.addEventListener("submit", (event) => {
        event.preventDefault();
        main.innerHTML = "";

        const searchTerm = search.value;
        if (searchTerm) {
          searchMovies(SEARCHAPI + searchTerm);
          search.value = "";
        }
      });
      
      
    </script>
  </body>
</html>