<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/css/home.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r75/three.min.js"></script>
<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/175711/pnltri.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.18.0/TweenMax.min.js"></script>
<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/175711/bas.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/js/home_main_visual.js"></script>
<script src="/js/home.js"></script>
<style>
	footer {position:absolute; left:0; bottom:0}
	html {-ms-overflow-style: none;}
	html::-webkit-scrollbar{display:none}
</style>

<script>
	/*스크롤 무빙*/
	var html = $('html');
	var page = 1;
	html.animate({scrollTop:0}, 10);
	$(window).on("wheel", function(e) {
	    if(html.is(":animated")) return;
	    if(e.originalEvent.deltaY > 0) {
	        if(page == 4) return;
	        page++;
	    } else if(e.originalEvent.deltaY < 0) {
	        if(page == 1) return;
	        page--;
	    }
	    var posTop =(page-1) * $(window).height();
	    html.animate({scrollTop : posTop});
	});
</script>

<style>
	main {width:100vw; height:400vh;}
	section{
		width:100vw; height:100vh;
		display:block;
		position:relative
	}
	header {background-color:rgba(0,0,0,0.5);}
	header:hover {background-color:rgba(255,255,255,0.8);}
	nav > ul > li > ul {background-color:rgba(255,255,255,0.8);}
</style>
	<main id="home_main_container">
		<h1 class="hidden">본문보기</h1>
		<section id="home_visual">
			<c:if test="${grade == null}">
				<h2 class="hidden">share your cultural life</h2>
				<div id="three-container"></div>
				<button class="fun-btn" onclick="location.href='/login'">JOIN US</button>
	        </c:if>
	        <c:if test="${grade != null}">
	        	<div class="text-effect">
			        <span>W</span>
					<span>E</span>
					<span>L</span>
					<span>C</span>
					<span>O</span>
					<span>M</span>
					<span>E</span>
					<span>!</span>
			    </div>
	        </c:if>
    	</section>
		<section id="home_entertain">
			<h2>영화, 연극, 콘서트, 뮤지컬을 한 곳에서</h2>
			<ul>
				<li onmouseover="movieplay('/img/Reality - From La Boum_cut.mp3')" onmouseleave="movieplay('')">
					<a href="/movie/movieList">영화</a>
					<em>마우스 오버 시 오디오 재생</em>
					<span class="skew_box1"></span>
					<span class="skew_box2"></span>
					<audio id='movie_audio' controls><source src="" type="audio/mp3" /></audio>
				</li>				
				<li onmouseover="musicalplay('/img/웃는남자_일단와_cut.mp3')" onmouseleave="musicalplay('')">
					<a href="/theater/theaterList">공연<br/>(연극 / 콘서트 / 뮤지컬)</a>
					<em>마우스 오버 시 오디오 재생</em>
					<span class="skew_box1"></span>
					<span class="skew_box2"></span>
					<audio id='musical_audio' controls><source src="" type="audio/mp3" /></audio>
				</li>
			</ul>
		</section>
		<section id="home_exhibition">
			<h2>온라인에서 만나는 전시회 작품</h2>
			<button class="fun-btn" id="home_author_regi" onclick="location.href='/online_exhibition/onlineList'">전시회 가기</button>
			<ul>
				<li id="home_sec3_img1"></li>
				<li id="home_sec3_img2"></li>
				<li id="home_sec3_img3"></li>
				<li id="home_sec3_img4"></li>
				<li id="home_sec3_img5"></li>
				<li id="home_sec3_img6"></li>
			</ul>
		</section>
		<section id="home_notice">
			<div id="home_notice_wrap">
				<div id="home_commu">
					<h2>자유게시판</h2>
					<ul>
						<c:forEach var="vo" items="${list}">
						<li>
							<ul>
								<li>${vo.subject}</li>
								<li>${vo.nickname }</li>
								<li>${vo.write_date }</li>
							</ul>
							<a href="/board/freeBoardView?no=${vo.no}"></a>
						</li>
						</c:forEach>
					</ul>
					<a href="/board/freeBoardList">+ 더보기</a>
				</div>
				<div id="home_help">
					<p><img src="/img/logo_w.png" alt="로고"></p>
					<c:if test="${grade == null}">
						<button onclick="alert('로그인이 필요한 서비스 입니다.');">문의하기</button>
					</c:if>
					<c:if test="${grade != null }">
						<button onclick="location.href='/board/help/helpBoardWrite'">문의하기</button>
					</c:if>
				</div>
			</div>
		</section>
		<ul id="home_pagination">
			<li class="hidden">페이지네이션</li>
			<li>
				<h3 class="hidden">첫번째 페이지</h3>
				<span id="home_tab1" class="home_tab_filled"></span>
			</li>
			<li>
				<h3 class="hidden">두번째 페이지</h3>
				<span id="home_tab2"></span>
			</li>
			<li>
				<h3 class="hidden">세번째 페이지</h3>
				<span id="home_tab3"></span>
			</li>
			<li>
				<h3 class="hidden">네번째 페이지</h3>
				<span id="home_tab4"></span>
			</li>
		</ul>
	</main>
