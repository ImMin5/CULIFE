/*토글 메뉴*/
	$(document).ready(function(){
		$('#online_ex_search').addClass('searchHide');
	    $('#online_ex_searchIcon').on('click',function(){
	        $('#online_ex_search').removeClass('searchHide').addClass('searchShow');
	    }); 
	});
	
	$(document).ready(function(){
	    $('#online_search_close').on('click',function(){
	        $('#online_ex_search').removeClass('searchShow').addClass('searchHide');
	    }); 
	});

/* 전시 등록 버튼 - 모달 띄우기*/
$(document).ready(function(){
	$(".modal").css({"display" : "none"});
	$("#reg_ex").click(function(){
		$(".modal").css({
			"display" : "block"   		
		});
	});	
});

/* 전시 등록 랜덤으로 이미지 띄우기 */
function randomNum(min, max){ 
	/*var randNum = Math.floor(Math.random()*(max-min+1)) + min; */
	var randNum = Math.floor(Math.random()*(max-min+1)+min); 
	return randNum;
}
document.addEventListener('DOMContentLoaded', () => {
	var i=randomNum(0, 8);
	var imgTag = "<img src='/img/exhibition/ex_reg/"+i+".jpg'>;";
	document.getElementById("ex_reg_img").innerHTML = imgTag;
})
