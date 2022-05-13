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
	$("#reg_ex").click(function(){
		$("#exhibition_reg_bg").css({"display" : "block"});
		$('footer').css({"display" : "none"});
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

/* 작품 등록 버튼 - 모달 띄우기*/
$(document).ready(function(){
	$("#reg_work").click(function(){
		$("#ex_work_bg").css({"display" : "block"});
		$('footer').css({"display" : "none"});
	});	
});

$(document).ready(function(){
	var count = 1;
	/* 작품 추가 등록 */
	$("#addWork").on('click',function(){
		count ++;
		if(count<=5){
			var addWork = 
				/* 임시 */
				"<li class='exhibitionWorkContent'>" +
					"<ul>"+
						"<li class='workThumbnail'>"+
							"<p class='hidden''>작품 썸네일</p>"+
							"<figure class='image_container'></figure>"+
							"<input class='work_upload-name' value='첨부파일' placeholder='첨부파일' readonly>"+
							"<input type='file' name='filename' id='work_file"+ count +"' class='workFile'/>"+
							"<label for='work_file"+ count +"'>파일찾기</label>"+ 
						"</li>"+
						"<li class='exhibitionApplyTitle'>"+
							"<p>작품명</p>"+
							"<input type='text'>"+
						"</li>"+
						"<li class='exhibitionApplyContent'>"+
							"<p>작품 설명</p>"+
							"<textarea></textarea>"+
						"</li>"+
					"</ul>"+
				"</li>";
			$("#ex_work_box").append(addWork);
		} else {
			alert("죄송합니다.\n작품은 최대 5개까지 게시할 수 있습니다.");
		}
	});	
})
