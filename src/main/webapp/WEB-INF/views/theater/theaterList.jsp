<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="${url}/css/theater/theaterList.css" type="text/css"/>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>

<script>
$(document).ready(function () {
   $.ajax({
      url: '/theater/theaterList', //통신을 원하는 URL주소를 입력합니다
      type: 'POST', //통신 방식을 지정합니다
      dataType: 'xml',//서버로부터 받을 데이터 타입을 입력합니다.
      success: function (response) { // 통신 성공시 호출해야할 함수
        xmlParsing(response);
      },
      error: function (xhr, status, msg) { // 통신 실패시 호출해야하는 함수
        console.log('상태값 : ' + status + ' Http에러메시지 : ' + msg);
      },
   });
   $.ajax({
      url: '/theater/theaterList2', //통신을 원하는 URL주소를 입력합니다
      type: 'POST', //통신 방식을 지정합니다
      dataType: 'xml',//서버로부터 받을 데이터 타입을 입력합니다.
      success: function (response) { // 통신 성공시 호출해야할 함수
        xmlParsing(response);
      },
      error: function (xhr, status, msg) { // 통신 실패시 호출해야하는 함수
        console.log('상태값 : ' + status + ' Http에러메시지 : ' + msg);
      },
   });

   function xmlParsing(data) {
      var playList = ``;
      var musicalList = ``;
      $(data).find('perforList').each(function(index, item){
         title=$(this).find('title').text()
         thumb=$(this).find('thumbnail').text()
         genre=$(this).find('realmName').text()   
         seq=$(this).find('seq').text()
         if(genre=='연극'){
            //alert(genre);
            playList += `
               <ul id="box">                              
                  <li><a href='/theater/theaterView?seq=`+seq+`'><img src="`+thumb+`" id="thePoster"/></a></li>
                  <li><a href='/theater/theaterView?seq=`+seq+`'>`+title+`</a></li>                  
               </ul>
            `;         
            $('#play').empty().append(playList);   
         }else if(genre=='음악'){
            console.log(title);
            musicalList += `
               <ul id="box">               
                  <li><a href='/theater/theaterView?seq=`+seq+`'>   <img src="`+thumb+`" id="thePoster"/></a></li>
                  <li><a href='/theater/theaterView?seq=`+seq+`'>   `+title+`</a></li>               
               </ul>
            `;         
            $('#musical').empty().append(musicalList);
         }
      });
   }
});

</script>
  <script>
    $(function () {
      $(window).load(function () {
        var hash = location.hash;
        hash = (hash.match(/^#tab\d+$/) || [])[0];
        var tabname = hash.slice(4);
        var tabname = tabname - 1;
        var tabbar = tabname;
        $(".tabContent").addClass("disnon");
        $(".tabContent").eq(tabname).removeClass("disnon");
        $(".tabMenu > li").removeClass("select");
        $(".tabMenu > li").eq(tabbar).addClass("select");
      });

     
      $(".tabMenu > li").click(function () {
        var num = $(".tabMenu > li").index(this);
        $(".tabContent").addClass("disnon");
        $(".tabContent").eq(num).removeClass("disnon");
        $(".tabMenu > li").removeClass("select");
        $(this).addClass("select");
      });
    });

  </script>
<div class="theater_video_container">
      <video muted autoplay loop>
        <source src="https://video.wixstatic.com/video/a1b577_ed328276c65f404db5da47a7d1cd1a1c/480p/mp4/file.mp4" type="video/mp4">
      </video>
</div>
<div id="theater_container">


        <ul class="tabMenu" id="theaterSub">
        <li class="select">
          <a href="#tab1">연극</a>
        </li>
        <li>
          <a href="#tab2">공연</a>
        </li>
      </ul>

   <div id="list">
     <div class="tabContent" id="play">
    
      </div>
     
      <div class="tabContent disnon" id="musical">
     
     
      </div>
   </div>
</div>