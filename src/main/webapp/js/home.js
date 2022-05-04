 /* 스크롤 */
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
	$("#home_scrolldown3").on('click', function(){
		$('html').animate({scrollTop : $(window).height()*3});
	});
});	

/* 오른쪽 pagination 버튼 기능 */
$(window).scroll(function () {
	var height = $(document).scrollTop();
	var wHeight = $(window).height();
	$(document).ready(function(){
		console.log("scroll : "+height+" / window : "+wHeight*2);
		if(height <= wHeight*0){$(document).ready(function(){
			$(tab1);
			$(function(){
				$("#home_exhibition ul li").css({
					"position" : "absolute",
			   		"left" : "0px",
			   		"bottom" : "-50%",
			   		"opacity" : "0",
			 		"transition" : "all 0.5s"
				})
				$("#home_exhibition button").css({
					"position" : "absolute",
			   		"left" : "60%",
			   		"bottom" : "-200px",
			   		"opacity" : "0",
			 		"transition" : "all 0.5s"
				})
			})
		})}
		else if(height <= wHeight*1){$(document).ready(function(){
			$(tab2);
			$(function(){
				$("#home_exhibition ul li").css({
					"position" : "absolute",
			   		"left" : "0px",
			   		"bottom" : "-50%",
			   		"opacity" : "0",
			 		"transition" : "all 0.5s"
				})
				$("#home_exhibition button").css({
					"position" : "absolute",
			   		"left" : "60%",
			   		"bottom" : "-200px",
			   		"opacity" : "0",
			 		"transition" : "all 0.5s"
				})
			})
		})}
		else if(height <= wHeight*2){$(document).ready(function(){
			$(tab3);
			$(function(){
				$("#home_exhibition ul li").css({
					"position" : "absolute",
			   		"left" : "0px",
			   		"bottom" : "0px",
			   		"opacity" : "1",
			 		"transition" : "all 1s"
				})
				$("#home_sec3_img2").css({"transition-delay" : "1s"})
				$("#home_sec3_img3").css({"transition-delay" : "1.5s"})
				$("#home_sec3_img4").css({"transition-delay" : "2s"})
				$("#home_sec3_img5").css({"transition-delay" : "2.5s"})
				$("#home_sec3_img6").css({"transition-delay" : "3s"})
				$("#home_author_regi").css({
					"position" : "absolute",
			   		"left" : "60%",
			   		"bottom" : "200px",
			   		"opacity" : "1",
			 		"transition-delay" : "3.5s"
				})
				$("#home_online_ex").css({
					"position" : "absolute",
			   		"left" : "55%",
			   		"bottom" : "100px",
			   		"opacity" : "1",
			 		"transition-delay" : "4s"
				})
			})
		})}
		else if(height <= wHeight*3){$(document).ready(function(){
			$(tab4);
			$(function(){
				$("#home_exhibition ul li").css({
					"position" : "absolute",
			   		"left" : "0px",
			   		"bottom" : "-50%",
			   		"opacity" : "0",
			 		"transition" : "all 0.5s"
				})
				$("#home_exhibition button").css({
					"position" : "absolute",
			   		"left" : "60%",
			   		"bottom" : "-200px",
			   		"opacity" : "0",
			 		"transition" : "all 0.5s"
				})
			})
		})}
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

/*window.onscroll = function() {moving()};
function moving() {
if (document.body.scrollTop >  || document.documentElement.scrollTop > 400) {
	document.getElementById("a1_title1").className = "title_style1";
 }  else {
    document.getElementById("a1_title1").className = "";
  }*/
/* $(document).ready(function(){
	if(height < wHeight*3){
		$('#home_exhibition li').css({
			"position" : "absolute",
   			"left" : "0px",
   			"top" : "0px",
   			"opacity" : "1"
		});
	}
})*/