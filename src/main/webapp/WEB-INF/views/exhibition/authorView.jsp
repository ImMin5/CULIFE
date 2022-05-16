<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/exhibition/authorWrite.css" type="text/css" />

<main>
   <div class="container">
        <div class="containerWrap">
         <div class="exhibitionContainer">
         <form name="authorWrite" id="authorWrite">
            <div class="authorWriteTitle">
               <h1>작가 등록 ${mvo.no}</h1>
            </div>
            <div class="authorWriteContent">
               <div class="authorWriteID">
                  <div>닉네임</div>
                  <div>${mvo.nickname}</div>
                  
               </div>
               <div class="authorWriteName">
                  <div>작가명</div>
                  <div>${vo.author }</div>
               </div>
               <div class="authorWriteSNS">
                  <div>SNS 주소</div>
                  <div><a href="https://www.instagram.com/h__us__h/" style="color: #000;">SNS링크</a></div>
               </div>
               <div class="authorWriteThumbnail">
                  <div>프로필 사진</div>
                  <input type="file" name="authorThumbnail" id="authorThumbnail"/>
               </div>
               <div class="authorDebutYear">
                  <div>데뷔년도</div>
                  <div>${vo.debut_year }</div>
               </div>
            </div>
            <div>
               <input type="button" value="작가 신청" onclick="authorSubmit()"/>
            </div>
            냥냥~
             </form>
         </div>
      </div>
   </div>
</main>
<script type="text/javascript">

</script>