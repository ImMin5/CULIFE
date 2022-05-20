<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="${url}/css/movie/movieList.css"
	type="text/css" />
	
  <body>
    <div class="mainBox_slider">
        <div class="boxSlides" id="boxSlides"></div>
     </div>
     
     <div class="movie_container">
        <div class="search_container">
	        <form id="form" action="/movie/movieSearch">
	          <input
	            type="text" name="searchMovie"
	            id="searchMovie"
	            placeholder="영화를 검색해주세요"
	            class="searchMovie"
	          />
	        </form>
        	<i class="fa-solid fa-magnifying-glass"></i>
     	 </div>
  	 	 <div class="search_textbox"></div>
  	 	 
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
                const obj = ('/movie/movieMstarAvg?movieId='+movie.id);
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
          let offsetIncrement = isMouseIn ? 0.001 : 0.29;
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
      
/*
      const SEARCHAPI =
        "https://api.themoviedb.org/3/search/movie?&api_key="+key+"&language=ko-KR&query=";
      const form = document.querySelector("#form");
      const search = document.querySelector("#searchMovie");
      const text = document.querySelector(".search_textbox");

      // searchMovies(apiUrl);
      function searchMovies(url) {
        fetch(url)
          .then((res) => res.json())
          .then(function (data) {
            if (data.results.length == 0) {
              const div = document.createElement("div");
              const div_text = document.createElement("p");
              div_text.className = "search_text";
              div_text.innerHTML = "검색결과가 없습니다.";
              div_text.appendChild(div);
              div.appendChild(text);
            }

          });
      }
*/


/*
      form.addEventListener("submit", (event) => {
    	  
      
        event.preventDefault();
        search.innerHTML = "";

        const searchTerm = search.value;
        if (searchTerm) {
          searchMovies(SEARCHAPI + searchTerm);
          search.value = "";
        } 
      });
 */     
      
    </script>
  </body>
</html>