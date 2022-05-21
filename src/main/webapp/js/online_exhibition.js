let is_paging= true;
let is_loading = false;
let currentPage = 1;
let totalPage = 1; 

/*토글 메뉴*/
	$(document).ready(function(){
		$('#online_ex_search').addClass('searchHide');
		//검색 클릭
	    $('#online_ex_searchIcon').on('click',function(){
	        $('#online_ex_search').removeClass('searchHide').addClass('searchShow');
	        currentPage = 1;
	        $("#modal_search").empty();
	        search();
	        $('footer').css({"display" : "none"});
	    }); 
	});
	
	$(document).ready(function(){
	    $('#online_search_close').on('click',function(){
	        $('#online_ex_search').removeClass('searchShow').addClass('searchHide');
	    	$('footer').css({"display" : "block"});
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
//작품등록시 등록 작품 수 판별
$(document).ready(function(){
	console.log("reg_work22222");
var workCount = $("form[name=ex_work_form]").length;
var addWork = 
	/* 임시 */
`<form name="ex_work_form" id="ex_work_form${workCount+1}" method="post" action="/exhibition/workCreateOk" data-work_no="-1" enctype="multipart/form-data">
	<ul id="ex_work_box">
		<li class="exhibitionWorkContent">
			<ul>
				<li class="workThumbnail">
					<p class="hidden">작품 썸네일</p>
					<figure><img src="" id="workPreview${workCount+1}" name="workPreview${workCount+1}"/></figure>
					<input type="hidden" name="no" value=""/>
					<input class="work_upload-name" name="work_thumbnail" placeholder="첨부파일" id="work_thumbnail${workCount+1}" value=""readonly>
					<input type="file" name="filename" id="work_file${workCount+1}" class="workFile" data-count="${workCount+1}"/>
					<label for="work_file${workCount+1}">파일찾기</label> 
											
				</li>
				<li class="exhibitionApplyTitle">
					<p>작품명</p>
					<input type="text" name="work_subject" value="" id="work_subject${workCount+1}">
				</li>
				<li class="exhibitionApplyContent">
					<p>작품 설명</p>
					<textarea name="work_content" id="work_content${workCount+1}"></textarea>
				</li>
			</ul>
		</li>
	</ul>
</form>	`
if (workCount == 0){
	$("#form_box").append(addWork);
}


$("#addWork").on("click", function() {
	var url = "/exhibition/work/count";
	var workCount = $("form[name=ex_work_form]").length;

	if (workCount >= 5) {
		alert("최대 5개 까지 등록할 수 있습니다.");
		return;
	}
	console.log(workCount);
	workCount++;
	var addWork =
		/* 임시 */
		`<form name="ex_work_form" id="ex_work_form${workCount}" method="post" action="/exhibition/workCreateOk" data-work_no="-1" enctype="multipart/form-data">
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
							<p>작품 명</p>
							<input type="text" name="work_subject" id="work_subject${workCount}">
						</li>
						<li class="exhibitionApplyContent">
							<p>작품 설명</p>
							<textarea name="work_content" id="work_content${workCount}"></textarea>
						</li>
					</ul>
				</li>
			</ul>
		</form>	`
		$("#form_box").append(addWork);
	});	
});

/* 작품보기 - 모달 띄우기*/
$(document).ready(function(){
	$(".workView_btn").click(function(){
		$("#ex_detail_bg").css({"display" : "block"});
		$('footer').css({"display" : "none"});
	});	
});


/* 작품보기 이미지 줌인 */
$(document).ready(function(){
	$(".ex_detail_img").on('click', (function(){
		var a = $(this).children().attr("src");
		$(".pop").replaceWith("<img class='pop' src='" + a + "'/>");
		$("#imgPopup").css({"display":"block"});
		setTimeout(function(){
			$(".pop").css({
			"transform" : "translate(-50%,-50%) scale(1)",
			})
		})		
	}))	
	$("#imgPopup > .fa-xmark").click(function(){
		$("#ex_detail_bg").css({"display" : "block"});
		$('footer').css({"display" : "none"});
		$("#imgPopup").css({"display":"none"});
	});	
})

//작품 검색 카테고리 변경 시 
$(document).on("change","select[name=ex_search]",function(){
	currentPage = 1;
	search();
})
//작품 검색
$(document).on("keyup","#ex_searchWord",function(){
	currentPage = 1;
	is_paging = false;
	search();
})


function search(){
	var url = "/online_exhibition/onlineList/search";
	var category = $("#ex_search").val();
	var container = $("#modal_search");
	var searchWord = $("#ex_searchWord").val();

	if(currentPage != 1 && parseInt(totalPage) < parseInt(currentPage)){
		is_loading=false;
		return;
	}
	$.ajax({
		url:url,
		type : "GET",
		dataType :"JSON",
		data : {
			category: category,
			currentPage : currentPage,
			searchWord : searchWord,
		},
		success : function(data){
			if(!is_paging){
				container.empty();	
			}
			if(data.items == null) return;
			data.items.forEach(function(element, index){
				container.append(`
					<tr>
						<td>${element.subject}</td>
						<td>${element.author}</td>
						<td>${element.start_date} ~ ${element.end_date}</td>
					</tr>
				`)
			});
			if(is_paging){
				currentPage = parseInt(data.vo.currentPage)+1;
				totalPage = data.vo.totalPage;
			}
			else{
				currentPage = 2;
				totalPage = data.vo.totalPage;
			}
			is_loading = false;
			
		},error : function(error){
			console.log(error);
			is_loading = false;
		}
	});
}
//페이지 네이션
function pagination(){
	is_paging = true;
	if(!is_loading){
		is_loading = true;
		search();
	}
}	

/* 감상평 열기/닫기 */
$(document).ready(function(){
	$('#review_close').css({"display":"none"});
	$('#review_open').click(function(){
		$('#review_close').css({"display":"block"});
		$('#review_open').css({"display":"none"});
		$('#ex_reviewList').css({"display":"none"});
	})
	$('#review_close').click(function(){
		$('#review_open').css({"display":"block"});
		$('#review_close').css({"display":"none"});
		$('#ex_reviewList').css({"display":"block"});
	})
})
