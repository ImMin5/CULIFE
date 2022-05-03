<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/css/home.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r75/three.min.js"></script>
<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/175711/pnltri.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.18.0/TweenMax.min.js"></script>
<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/175711/bas.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/js/home_main_visual.js"></script>
<script>
	var tab1 = function() {
		$("#home_tab1").addClass('home_tab_filled');
		$("#home_tab2").removeClass('home_tab_filled');
		$("#home_tab3").removeClass('home_tab_filled');
		$("#home_tab4").removeClass('home_tab_filled');
	}
	var tab2 = function() {
		$("#home_tab2").addClass('home_tab_filled');
		$("#home_tab1").removeClass('home_tab_filled');
		$("#home_tab3").removeClass('home_tab_filled');
		$("#home_tab4").removeClass('home_tab_filled');
	}
	var tab3 = function() {
		$("#home_tab3").addClass('home_tab_filled');
		$("#home_tab1").removeClass('home_tab_filled');
		$("#home_tab2").removeClass('home_tab_filled');
		$("#home_tab4").removeClass('home_tab_filled');
	}
	var tab4 = function() {
		$("#home_tab4").addClass('home_tab_filled');
		$("#home_tab1").removeClass('home_tab_filled');
		$("#home_tab3").removeClass('home_tab_filled');
		$("#home_tab2").removeClass('home_tab_filled');
	}
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
	
	/* 중앙 하단 화살표 버튼 */
	$(document).ready(function(){
			$("#home_scrolldown1").on('click', function(){
				$('html').animate({scrollTop : $(window).height()});
			})
			$("#home_scrolldown2").on('click', function(){
				$('html').animate({scrollTop : $(window).height()*2});
			});
	});	
	
	/* 오른쪽 pagination 버튼 기능 */
	$(window).scroll(function () {
		var height = $(document).scrollTop();
		var wHeight = $(window).height();
		$(document).ready(function(){
			if(height < wHeight*1){$(document).ready(tab1);}
			else if(height < wHeight*2){$(document).ready(tab2);}
			else if(height < wHeight*3){$(document).ready(tab3);}
			else if(height < wHeight*4){$(document).ready(tab4);}
		});
	});
	
	$(document).ready(function(){
		$("#home_tab1").click(tab1,function(){
			$('html').animate({scrollTop : $(window).height()*0});
		});
		$("#home_tab2").click(tab2,function(){
			$('html').animate({scrollTop : $(window).height()*1});
		});
		$("#home_tab3").click(tab3,function(){
			$('html').animate({scrollTop : $(window).height()*2});
		});
		$("#home_tab4").click(tab4,function(){
			$('html').animate({scrollTop : $(window).height()*3});
		});
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
    		<button class="fun-btn">JOIN US</button>
    		<img class="home_scrolldown" id="home_scrolldown1" src="/img/scrolldown.png">
		</section>
		<section id="home_entertain">
			<h2>영화, 연극, 뮤지컬을 한 곳에서</h2>
			<ul>
				<li>
					<a href=""><em>영화</em></a>
					<span class="skew_box1"></span>
					<span class="skew_box2"></span>
				</li>				<li>
					<a href=""><em>연극 / 뮤지컬</em></a>
					<span class="skew_box1"></span>
					<span class="skew_box2"></span>
				</li>
			</ul>
			<img class="home_scrolldown" id="home_scrolldown2" src="/img/scrolldown.png">
		</section>
		<section>
		
		</section>
		<section>
		
		</section>
		<ul id="home_pagination">
			<li class="hidden">페이지네이션</li>
			<li>
				<h3 class="hidden">첫번째 페이지</h3>
				<span id="home_tab1"></span>
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
