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
						button.attr("class", "btn btn-primary");
						button.text("팔로우");
					}
					
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
						button.attr("class", "btn btn-secondary");
						button.text("팔로잉");
					}
					else{
						alert(data.msg);
					}
					
				},
				error : function(error){
					alert(error);
				}
			})
		});