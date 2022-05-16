/* 모달 닫기 */
$(document).ready(function(){
	$(".fa-xmark").click(function(){
		$(".modal").css({"display" : "none"});
		$('footer').css({"display" : "block"});
		$("#authorView_container").removeClass("authorView_modal");
	});	
});

/* 모달 css */
$(document).ready(function(){
	/*모달 배경*/
	$(".modal").css({
		"width" : "100vw",
		"height" : "100vh",
		"position" : "fixed",
		"left" : "0",
		"top" : "0",
		"z-index" : "1000",
		"background-color" : "rgba(0,0,0,0.8)",
		"display" : "none",
		"overflow" : "hidden"
	});
	/*모달 제목*/
	$(".modal_wrap > h3").css({
		"display" : "inline-block",
		"font-size" : "3.2rem",
		"font-weight" : "bold",
		"line-height" : "100px",
		"margin" : "0 0 20px 50px"
	});
	/*모달 닫기 버튼*/
	$(".fa-xmark").css({
		"position" : "absolute",
		"right" : "30px",
		"top" : "30px",
		"cursor" : "pointer",
		"font-size" : "30px"
	});
});