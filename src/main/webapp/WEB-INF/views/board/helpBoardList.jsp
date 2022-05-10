<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/board/board.css" type="text/css" />

<div class="container">
	<h1>문의사항 << 제목없앨까요?</h1>
	<br><br><br><br>
	<ul class='helpboardList'>
		<li>번호</li>
		<li>제목</li>
		<li>닉네임</li>
		<li>조회수</li>
		<li>작성일</li>
		<!-- 지워도되는부분 ↓↓↓ -->
		<li>01</li>
		<li><a class="disable">비밀글입니다. 어떤게 나을지</a></li>
		<li>1날다람쥐1</li>
		<li>1 회</li>
		<li>22-05-06</li>
		<li>02</li>
		<li><a href="javascript:alert('본인 또는 관리자가 아닙니다.');" onfocus="this.blur()">비밀글입니다. 확인바랍니다</a></li>
		<li>2원숭이2</li>
		<li>2 회</li>
		<li>22-05-06</li>
		<li>03</li>
		<li><a>비밀글입니다.</a></li>
		<li>3북극곰3</li>
		<li>3 회</li>
		<li>22-05-06</li>
		<li>04</li>
		<li><a href="#">3번작가님 사진이 43글자보입니다람쥐울림통나무리본사과나무주스키장독대사관입니다아아</a></li>
		<li>4산토끼4</li>
		<li>4 회</li>
		<li>22-05-06</li>
		<li>05</li>
		<li><a>비밀글입니다.</a></li>
		<li>5돌고래5</li>
		<li>5 회</li>
		<li>22-05-06</li>
		<li>06</li>
		<li><a>비밀글입니다.</a></li>
		<li>6고릴라6</li>
		<li>6 회</li>
		<li>22-05-06</li>
		<li>07</li>
		<li><a>비밀글입니다.</a></li>
		<li>7기린7</li>
		<li>7 회</li>
		<li>22-05-06</li>
		<li>08</li>
		<li><a>4번 작가님 재밌어요</a></li>
		<li>4산토끼4</li>
		<li>8 회</li>
		<li>22-05-06</li>
		<li>09</li>
		<li><a>비밀글입니다.</a></li>
		<li>1날다람쥐1</li>
		<li>9 회</li>
		<li>22-05-06</li>
		<li>10</li>
		<li><a>비밀글입니다.</a></li>
		<li>5돌고래5</li>
		<li>10 회</li>
		<li>22-05-06</li>
		<!-- 지워도되는부분 ↑↑↑ -->
		<input id="search" type="text" placeholder="검색" style="float:left">
		<button id="write" style='float:right' onclick="location.href='helpBoardWrite'">글쓰기</button>
		<ol><a href="#"> ◀ </a></ol>
		<ol><a href="#"> 1 </a></ol>
		<ol><a href="#"> 2 </a></ol>
		<ol><a href="#"> 3 </a></ol>
		<ol><a href="#"> 4 </a></ol>
		<ol><a href="#"> 5 </a></ol>
		<ol><a href="#"> ▶ </a></ol>
	</ul>
</div>