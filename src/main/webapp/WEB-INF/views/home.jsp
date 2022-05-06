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
</style>
	
	<main id="home_main_container">
		<h1 class="hidden">본문보기</h1>
		<section id="home_visual">
			<h2 class="hidden">share your cultural life</h2>
			<div id="three-container"></div>
    		<button class="fun-btn" onclick="location.href='/login'">JOIN US</button>
    		<img class="home_scrolldown" id="home_scrolldown1" src="/img/scrolldown.png">
		</section>
		<section id="home_entertain">
			<h2>영화, 연극, 뮤지컬을 한 곳에서</h2>
			<ul>
				<li>
					<a href="">영화</a>
					<em></em>
					<span class="skew_box1"></span>
					<span class="skew_box2"></span>
				</li>				
				<li>
					<a href="">연극 / 뮤지컬</a>
					<em></em>
					<span class="skew_box1"></span>
					<span class="skew_box2"></span>
				</li>
			</ul>
			<img class="home_scrolldown" id="home_scrolldown2" src="/img/scrolldown.png">
		</section>
		<section id="home_exhibition">
			<h2>온라인에서 만나는 전시회 작품</h2>
			<button class="fun-btn" id="home_author_regi">전시하기</button>
			<button class="fun-btn" id="home_online_ex">작품보기</button>
			<ul>
				<li id="home_sec3_img1"></li>
				<li id="home_sec3_img2"></li>
				<li id="home_sec3_img3"></li>
				<li id="home_sec3_img4"></li>
				<li id="home_sec3_img5"></li>
				<li id="home_sec3_img6"></li>
			</ul>
			<img class="home_scrolldown" id="home_scrolldown3" src="/img/scrolldown.png">
		</section>
		<section>
			<h2>커뮤니티</h2>
			<ul>
				<li></li>
				<li></li>
			</ul>
			<h2>작가 검색</h2>
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
