let current_page = 1;
/* 온라인 전시회 리스트 페이징 */
function onlineListPaging(page_num,total_page,member_no){
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
			member_no : member_no,
		},
		success : function(data){
			$("#review_container").empty();
			console.log(data);
			
			let paging = "";
						
			data.items.forEach(function(e, index){
			
			});
			
			$('#ex_pagination_box').html(paging);
			//성공했을 떄 페이지 변화
			current_page = current_page +  page_num;
		}, error:function() {
			console.log("페이징 보이기 실패!");
		}
	});
	
}