<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="${url}/css/movie/movieSearch.css" type="text/css"/>

    <main id="main"></main> 
  
</body>
<script>
$(function(){
   searchMovies(SEARCHAPI)
})
const key = "52048cb9f5d2b1983acc31ecdadd5b4d";
const base_url = "https://image.tmdb.org/t/p/w300/";
const SEARCHAPI =
    "https://api.themoviedb.org/3/search/movie?&api_key="+key+"&language=ko-KR&query=${searchMovie}";
  const main = document.querySelector("#main");
  const form = document.querySelector("#form");
  const search = document.querySelector("#searchMovie");

  // searchMovies(apiUrl);
  function searchMovies(url) {
    // alert(url)
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
          const div_box = document.createElement("div");
          const h1 = document.createElement("h1");
          const date = document.createElement("p");
          const overview = document.createElement("p");
          

          //console.log(element.title)
          
          div.className = "search_box";
          div_box.className = "search_div_box";
          h1.className = "search_title"
          date.className = "search_date"
          overview.className = "search_overview"

          h1.innerHTML = element.title;
          date.innerHTML = element.release_date;
          overview.innerHTML = element.overview;
          
          image.src =  base_url + element.poster_path;
          image.setAttribute("data-id", element.id);
          image.setAttribute("onClick", "openView(this)"); 
    
          main.appendChild(div);
          div.appendChild(image);
          div.appendChild(div_box);
          div_box.appendChild(h1); 
          div_box.appendChild(date);
          div_box.appendChild(overview);
        
        });
      });

  }
  
  function openView(event) {
     const movieId = event.getAttribute("data-id");
     location.href="/movie/movieView?movieId="+movieId
  }

  /*form.addEventListener("submit", (event) => {
    event.preventDefault();
    main.innerHTML = "";

    const searchTerm = search.value;
    if (searchTerm) {
      searchMovies(SEARCHAPI + searchTerm);
      search.value = "";
    }
  });
  */
</script>
</html>