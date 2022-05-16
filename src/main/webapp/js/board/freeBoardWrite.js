$(function(){
	CKEDITOR.replace("writeContent", {
		height:'400px',
		startupFocus : false,
	});
	
	$("#freeForm").submit(function(){
		if($("#freeBoardTitle").val()==''){
			alert("🚫 제목을 입력해주세요");
			return false;
		}
		if(CKEDITOR.instances.writeContent.getData()==''){
			alert("🚫 내용을 입력해주세요");
			return false;
		}
	});
	$("#resetBtn").on('click', function(){
		CKEDITOR.instances.writeContent.setData("");
	});
	
	$("#backList").click(function(){
		location.href="/board/freeBoardList";
	});
});