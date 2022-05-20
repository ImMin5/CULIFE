<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="/css/board/helpBoardView.css"	type="text/css" />
<link rel="stylesheet" href="/css/board/boardViewReply.css"	type="text/css" />
<script>
  if('${msg}'=='guest'){
    	alert('본인또는 관리자가 아닙니다.');history.back();
    }
$(function(){
	$("#helpBoardDel").click(function(){
		if(confirm("삭제하시겠어요?")){
			location.href="/board/help/helpBoardDel?no=${viewVo.no}";
		}
	});
	// 댓글 등록한 뒤 필요한 댓글 리스트 선택하는 메서드
	function selectReplyList(){
		let url = "/reply/replyList";
		let data = "no="+$('#no').val();
		$.ajax({
			url:url,
			data:data,
			success:function(result){
				let sucResult = $(result);
				
				let body = "<ul>";
				sucResult.each(function(idx,obj){
					body += "<li><div><span>"+obj.nickname+"  (" + obj.write_date + ")&nbsp;</span>"
					if(obj.member_no == ${logNo}){
						body += "<span><input type='button' class='btn' value='수정'>";
						body += "<input type='button' class='btn' value='삭제' title="+obj.reply_no+","+ obj.member_no+">";
					}
					body += "<br><br>" +obj.content+ "</span></div>"
					
					if(obj.nickname == "${logNickname}"){
						body += "<div style='display:none'><form method='post'>";
						body += "<input type='hidden' name='member_no' value="+obj.member_no+">";
						body += "<input type='hidden' name='reply_no' value="+obj.reply_no+">";
						body += "<textarea name='content' id='content'>"+obj.content+"</textarea>";
						body += "<div id='editBtn'><input type='submit' class='btn' value='수정하기'></div></form></div>";
					}
					body += "<hr/></li>";
				});
				body += "</ul>"
				$("#replyList").html(body);
				
			},error:function(){
				console.log("리스트 보이기 실패!");
			}
		});
	}

	// 댓글 등록하기
	$(document).on('submit',"#replyForm", function(){
		//event.preventDefault();

		if($("#coment").val()==""){ // 댓글 입력 안함
			alert("댓글을 입력 후에 등록해주세요");
		}else{ // 댓글 입력
			let data = $("#replyForm").serialize(); // form데이터 보내기
			$.ajax({
				url :'/reply/writeOk',
				data : data,
				type : 'POST',
				success : function(result){
					$("#coment").val("");
					selectReplyList();
				},error : function(e){
					alert("로그인 후 이용해주세요");
				}
			});
		}
		return false;
	});
		

	// 수정버튼 누르면 수정폼 보이게 하기
	$(document).on('click','#replyList input[value=수정]',function(){ // 수정버튼을 누르면      
		$(this).parent().parent().css("display","none");                    // 댓글 폼 안보이게
		$(this).parent().parent().next().css("display", "block");  // 수정폼 보이게
	});
	
	// 수정하기 DB연결
	$(document).on('submit','#replyList form',function(){
		event.preventDefault();
		
		$.ajax({
			url:'/reply/editOk',
			data: $(this).serialize(),
			type: 'POST',
			success:function(){
				selectReplyList();
			},error:function(){
				console.log('수정에러');
			}
		});
	});

	// 댓글 삭제하기 
	$(document).on('click', "#replyList input[value=삭제]", function(){
		if(confirm('댓글을 삭제하시겠어요?')){
			let replyData = $(this).attr("title").split(",");
			
			let data = "reply_no="+replyData[0]+"&member_no="+replyData[1];
			$.ajax({
				url:'/reply/delOk',
				data:data,
				success:function(){
					selectReplyList();
				},error:function(){
					console.log('삭제에러');
				}
			});
		}
	});
	
	selectReplyList();
});
</script>

<div class="container">
	<!-- 글내용 -->
	<br>
	<ul>
	<div class="parent">
		<div class="child1">작성자 : ${viewVo.nickname}</div>
		<div class="child2"><h1>제목 : ${viewVo.subject}</h1></div>
		<div class="child1">조회수 : ${viewVo.view}</div>
	</div>
	<hr/>
	<div class="edel">
	<a href="/board/help/helpBoardEdit?no=${viewVo.no}" class="btn" id="helpBoardEdit">수정</a>
	<span id="btnSpace"></span><input type="button" class="btn" id="helpBoardDel" value="삭제"/>
	</div>
		<br>
		<li>글 내용</li>
		<br>
		<div class="helpContent">
		<div>${viewVo.content}</div>
		</div>
	</ul>
	<!-- 댓글 -->
	<hr />
	<div id="replyLine">
	<br>
		<i class="fa fa-comment fa-lg"></i><span class="iconValue">댓글</span>
	</div>
	<form method="post" id="replyForm">
		<input type="hidden" name="no" id="no" value="${viewVo.no}">
		<div id="commentLine">
			<textarea name="content" id="coment" class="helpBoardComent" rows="4"
				cols="80" placeholder="내용을 입력하세요"></textarea>
			<span id="replyBtn"><input type="submit"
				id="replyInsert" value="댓글 등록"/></span>
		</div>
	</form>
	<!-- 댓글 목록 표시 -->
	<div id="replyList"></div>
</div>
<br />