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
		background-size:100vw 100vh;
	}
</style>
	
	<main id="home_main_container">
		<section id="home_visual">
			<div id="three-container"></div>
    		<button class="fun-btn">JOIN US</button>
		</section>
	</main>
