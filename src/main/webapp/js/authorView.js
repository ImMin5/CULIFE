/* 전시 등록 버튼 - 모달 띄우기*/
$(document).ready(function(){
	$("#author_works > ul > li > img").click(function(){
		$("#workDetail_bg").css({"display" : "block"});
		$("#authorView_container").addClass("authorView_modal");
		$('footer').css({"display" : "none"});
	});	
});
