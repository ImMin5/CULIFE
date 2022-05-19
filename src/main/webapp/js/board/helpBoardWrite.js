$(function(){
	CKEDITOR.replace("content", {
		height:'400px',
		startupFocus : false,
	});
	$("#helpForm").submit(function(){
		if($("#helpBoardTitle").val()==''){
			alert("🚫 제목을 입력해주세요");
			return false;
		}
		if(CKEDITOR.instances.editor.getData()==''){
			alert("🚫 내용을 입력해주세요");
			return false;
		}
	});
	$("#resetBtn").on('click', function(){
		CKEDITOR.instances.editor.setData("");
	});
	
	$("#backList").click(function(){
		location.href="/board/help/helpBoardList";
	});
	
});