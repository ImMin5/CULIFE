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
//작푸등록시 등록 작품 수 판별
$(document).ready(function(){

	$("#addWork").on("click", function(){
		var url = "/exhibition/work/count";
		var workCount = $("form[name=ex_work_form]").length;
		
		if(workCount >=5){
			alert("최대 5개 까지 등록할 수 있습니다.");
			return;
		}
		console.log(workCount);
		$.ajax({
			url : url,
			tyle : "GET",
			success : function(data){
				workCount++;
					var addWork = 
						/* 임시 */
		               `<form name="ex_work_form" id="ex_work_form" method="post" action="/workCreateOk" enctype="multipart/form-data">
						<ul id="ex_work_box">
							<li class="exhibitionWorkContent">
								<ul>
									<li class="workThumbnail">
										<p class="hidden">작품 썸네일</p>
										<figure><img src="" id="workPreview${workCount}" name="workPreview${workCount}"/></figure>
										<input type="hidden" name="no" value=""/>
										<input class="work_upload-name" name="work_thumbnail" placeholder="첨부파일" id="work_thumbnail${workCount}" value=""readonly>
										<input type="file" name="filename" id="work_file${workCount}" class="workFile" data-count="${workCount}"/>
										<label for="work_file${workCount}">파일찾기</label> 
										
									</li>
									<li class="exhibitionApplyTitle">
										<p>작품명</p>
										<input type="text" name="work_subject" value="">
									</li>
									<li class="exhibitionApplyContent">
										<p>작품 설명</p>
										<textarea name="work_content"></textarea>
									</li>
								</ul>
							</li>
						</ul>
						<a href="javascript:;" id="addWork"><i class="fa-solid fa-plus"></i>작품추가</a>
					</form>	`
           			 $("#ex_work_wrap").append(addWork);
			},
			error : function(error){
				alert(error.responseJSON.msg);
			}
		});
	});	
});
