/* 모달 닫기 */
$(document).ready(function(){
	$(".close").click(function(){
		$(".modal").css({
			"display" : "none"   		
		});
	});	
});

/* 모달 css */
$(document).ready(function(){
	/*모달 배경*/
	$(".modal").css({
		"width" : "100vw",
		"height" : "100vh",
		"position" : "absolute",
		"left" : "0",
		"top" : "0",
		"z-index" : "1000",
		"background-color" : "rgba(0,0,0,0.8)"
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
	$(".close").css({
		"float" : "right",
		"margin" : "30px 30px 0 0",
		"cursor" : "pointer"
	});
});