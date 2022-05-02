<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/css/home.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r75/three.min.js"></script>
<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/175711/pnltri.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.18.0/TweenMax.min.js"></script>
<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/175711/bas.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/js/home_main_visual.js"></script>

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
			<div id="three-container"></div>
    		<button class="fun-btn">JOIN US</button>
		</section>
		<section id="home_entertain">
			<h2>영화, 연극, 뮤지컬을 한 곳에서</h2>
			<ul>
				<li>
					<a href=""><em>영화</em></a>
					<span class="skew_box1"></span>
					<span class="skew_box2"></span>
				</li>
				<li>
					<a href=""><em>연극 / 뮤지컬</em></a>
					<span class="skew_box1"></span>
					<span class="skew_box2"></span>
				</li>
			</ul>
		</section>
	</main>
