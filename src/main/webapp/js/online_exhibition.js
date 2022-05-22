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
	/*console.log(workCount);*/
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
			/*console.log(data);*/
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


let current_page = 1;
/* 온라인 전시회 리스트 페이징 */
function onlineListPaging(page_num,total_page){
	let url = "/online_exhibition/onlineListPaging";
	if(current_page + page_num < 1) return;
	else if(current_page + page_num > total_page)return;
	/*console.log("cuurent page ",current_page);*/
	$.ajax({
		url:url,
		type : "GET",
		dataType :"JSON",
		data : {
			currentPage : current_page+page_num,
		},
		success : function(data){
			$("#ex_pagination_box").empty();
			/*console.log(data);*/
			
			let paging = "";
						
			data.items.forEach(function(e, index){
				paging += '<p name="get_exhibition" data-exhibition_no='+e.no+'><span>'+e.author+'</span><img src="/upload/'+e.member_no+'/author/exhibition/'+e.no+'/'+e.work_thumbnail+'"></p>';
			});
			
			$('#ex_pagination_box').html(paging);
			//성공했을 떄 페이지 변화
			current_page = current_page +  page_num;
		}, error:function() {
			console.log("페이징 보이기 실패!");
		}
	});
	
}

//전시회 작품 불러오기
function getExhibitionWork(exhibition_no){
	var url ="/exhibitionwithwork/"+ exhibition_no;
	$.ajax({
		url : url,
		type : "GET",
		success : function(data){
			var item = data.items[0];
			/*console.log(data);
			console.log(item.workList[1]);*/
						
			/* 전시회 리스트 미리보기 */
			$("#exhibition_thumnail_first").attr("src", "/upload/"+item.member_no+"/author/exhibition/"+item.no+"/"+item.workList[0].work_thumbnail);
			if(item.workList[1] != null){
				$("#exhibition_thumnail_second").attr("src", "/upload/"+item.member_no+"/author/exhibition/"+item.no+"/"+item.workList[1].work_thumbnail);
			}
			if(item.workList[1] == undefined){
				$("#exhibition_thumnail_second").attr("src", "/img/exhibition/texture_img.png");
			}
			
			$("#ex_reg_subject").html(item.subject);
			$("#ex_reg_content").html(item.content);
			var wList = "";
			$.each(data.items[0].workList,function(index, i){
				wList += "<li><ul><li>";
				wList += "<figure class='ex_detail_img'><img class='ex_work_thumbnail' src='/upload/"+item.member_no+"/author/exhibition/"+item.no+"/"+i.work_thumbnail+"'></figure></li>";
				wList += "<li class='ex_detail_info'><ul>";
				wList += "<li>작가 : "+item.author+"</li>";
				wList += "<li>작품 명 : "+i.work_subject+"</li>";
				wList += "<li>전시 기간 : "+item.start_date+"-"+item.end_date+"</li>";
				wList += "<li>작품 설명</li><li><p>"+i.work_content+"</p></li></ul></li></ul></li>"
			});
			
			wList += '<li id="ex_review">';
			wList += '<h4>&nbsp;&nbsp;감상평</h4><span id="review_close">▼</span><span id="review_open">▲</span>';
			wList += '</li>';
			/*<!-- 댓글 목록 표시 -->*/
			wList += '<li id="ex_reviewList"></li>';
			
			wList += '<li id="ex_reviewForm_wrap">';
			wList += '<form method="post" id="ex_reviewForm">';
			wList += '<input type="hidden" name="exhibition_no" id="exhibition_no" value="'+item.no+'">';
			wList += '<div id="ex_review_box">';
			wList += '<textarea name="content" id="ex_reviewComent" class="ex_reivewComent" placeholder="내용을 입력하세요"></textarea>';
			wList += '<span id="ex_reviewBtn"><input type="submit" id="ex_reviewInsert" value="등록"/></span>';
			wList += '</div></form></li>'
			$('#ex_reg_detail_work').html(wList);
			
			
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
				});
			});
			select_ExhibitionReviewList(item.no);
			},error: function(error){
			
		}
	})
	
}

// 댓글 리스트 선택
		function select_ExhibitionReviewList(exhibition_no){
			let url = "/ex_review/reviewList";
			let data = "exhibition_no="+ exhibition_no;
			console.log(data);
			$.ajax({
				url:url,
				data:data,
				success:function(result){
					let sucResult = $(result);
					console.log(result);
					let body = "<ul>";
					sucResult.each(function(idx,obj){
						let member_no = obj.member_no;
						let logNo = '${logNo}';
						body += "<li class='ex_review_wrap'><div class='ex_reivew_coment'><p>"+obj.nickname+"</p><span>"+ obj.write_date + "</span>"
						body += "<em>" +obj.content+ "</em>"
						if(member_no == logNo){
							body += "<div><input type='button' class='btn' value='수정'>";
							body += "<input type='button' class='btn' value='삭제' title="+obj.no+","+ obj.member_no+">";
						}
						body += "<br/></div></div>"
						
						if(obj.nickname == "${logNickname}"){
							body += "<div style='display:none' class='ex_edit'><form method='post'>";
							body += "<input type='hidden' name='member_no' value="+obj.member_no+">";
							body += "<input type='hidden' name='no' value="+obj.no+">";
							body += "<textarea name='content' class='ex_edit_txt'>"+obj.content+"</textarea>";
							body += "<input type='submit' class='ex_edit_btn' value='수정하기'></form></div>";
						}
						body += "<hr/></li>";
					});
					body += "</ul>"
					$("#ex_reviewList").html(body);
					
				},error:function(){
					console.log("리스트 보이기 실패!");
				}
			});
		}

