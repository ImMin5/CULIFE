/* 전시 등록 버튼 - 모달 띄우기*/

$(document).ready(function(){
	$("#author_works > ul > li > img").click(function(){
		$("#workDetail_bg").css({"display" : "block"});
		$("#authorView_container").addClass("authorView_modal");
		$('footer').css({"display" : "none"});
		
		//모달에 정보 전달
		var member_no;
		var exhibition_no
		$("#modal_subject").text("작품명 : "+$(this).attr("data-work_subject"));
		$("#modal_start_date").text("전시기간 : "+$(this).attr("data-start_date") + " ~ " + $(this).attr("data-end_date"));
		$("#modal_content").text($(this).attr("data-work_content"));
		$("#modal_work_thumbnail").attr("src","/upload/"+$(this).attr("data-member_no")+"/author/exhibition/"+$(this).attr("data-exhibition_no")+"/"+$(this).attr("data-work_thumbnail"));
	});	
});

		//팔로우
		$(document).on("click","button[name=unfollow]",function(){
			var author = $(this).attr("data-author");
			var url ="/author/follow";
			var button = $(this);
			var author_no =$(this).attr("data-author_no");
			
			$.ajax({
				url : url,
				type : "DELETE",
				dataType : "JSON",
				data :{
					author:author
				},
				success : function(data){
					console.log(data);
					if(data.status=="200"){
						button.attr("name","follow");
						button.attr("class", "a_follow_btn");
						button.html("<span>FOLLOW</span>");
					}
					get_author_fan(author_no);
					
				},
				error : function(error){
					console.log(error);
				}
			});
		});
		//언팔로우
		$(document).on("click","button[name=follow]",function(){
			var author = $(this).attr("data-author");
			var url ="/author/follow";
			var button = $(this);
			var author_no =$(this).attr("data-author_no");
			
			$.ajax({
				url : url,
				type : "POST",
				dataType : "JSON",
				data :{
					author:author
				},
				success : function(data){
					console.log(data);
					if(data.status=="200"){
						button.attr("name","unfollow");
						button.attr("class", "a_following_btn");
						button.html("<span>FOLLWING</span>");
						get_author_fan(author_no);
					}
					else{
						alert(data.msg);
					}
					
				},
				error : function(error){
					console.log(error);
				}
			})
		});
		
/* 작품보기 이미지 줌인 */
$(document).ready(function(){
	$(".workDetail_img").on('click', (function(){
		var a = $(this).children().attr("src");
		$(".pop").replaceWith("<img class='pop' src='" + a + "'/>");
		$("#imgZoom").css({"display":"block"});
		setTimeout(function(){
			$(".pop").css({
			"transform" : "translate(-50%,-50%) scale(1)",
			})
		})		
	}))	
	$("#imgZoom > .fa-xmark").click(function(){
		$("#workDetail_bg").css({"display" : "block"});
		$('footer').css({"display" : "none"});
		$("#imgZoom").css({"display":"none"});
	});	
})

function get_author_fan(author_no){
	var url = "/api/authorfan/follow";
		$.ajax({
			url : url,
			type: "GET",
			dataType :"JSON",
			data : {
				author_no : author_no,
			},
			success : function(data){
				$("#author_fan_count").text("팔로워 : " + data.count);
			},
			error : function(error){
				alert(error);
			}
			
		})
}



		