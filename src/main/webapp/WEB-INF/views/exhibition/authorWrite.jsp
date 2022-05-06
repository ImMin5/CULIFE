<link rel="stylesheet" href="/css/exhibition/authorWrite.css" type="text/css" />

<main>
	<div class="container">
        <div class="containerWrap">
			<div class="exhibitionContainer">
			<form name="authorWrite" id="authorWrite">
				<div class="authorWriteTitle">
					<h1>작가 등록 ${mvo.no}</h1>
				</div>
				<div class="authorWriteContent">
					<div class="authorWriteID">
						<div>닉네임</div>
						<div>${mvo.nickname}</div>
						
					</div>
					<div class="authorWriteName">
						<div>작가명</div>
						<div><input type="text" id="authorWriteName" placeholder='작가명 입력'></div>
						<span id="chk"></span>
						<!-- <div><input type ="text" id="authorchk" value ="N" style="visibility:hidden"/></div> -->
					</div>
					<div class="authorWriteSNS">
						<div>SNS 주소</div>
						<div><input type="text" id="authorWriteSNS"></div>
					</div>
					<div class="authorWriteThumbnail">
						<div>프로필 사진</div>
						<input type="file" name="authorThumbnail" id="authorThumbnail"/>
					</div>
					<div class="authorDebutYear">
						<div>데뷔년도</div>
						<div><input type="text" id="authorDebutYear"></div>
					</div>
				</div>
				<div>
					<input type="button" value="작가 신청" onclick="authorSubmit()"/>
				</div>
				냥냥~
				 </form>
			</div>
		</div>
	</div>
</main>
<script type="text/javascript">
$(function(){
	console.log("중복검사")
	
	$("#authorWriteName").keyup(function(){
		var author = $("#authorWriteName").val();
		if(author != ''){
			console.log(author);
			var url = "/authorNameCheck";
			
			$.ajax({
				url: url,
				data: "author="+author,
				type: "POST",
				success: function(result){
					if(result==author){
						$("#chk").html("이미 사용중인 닉네임 입니다.");
						$("#authorchk").val("N");
						$("#chk").css("color","red");
					}else{//사용가능
						$("#chk").html("사용 가능한 닉네임 입니다.");
						$("#authorchk").val("Y");
						$("#chk").css("color","blue");
					}
				}
			});
		}
	});
});

	function authorSubmit() {
		var authorNickname = "${mvo.nickname}";
		var params = "nickname=" + "${mvo.nickname}";
		var author = $("#authorWriteName").val();
		var sns_link = $("#authorWriteSNS").val();
		var author_thumbnail = $("#authorThumbnail").val();
		var debut_year = $("#authorDebutYear").val();
		console.log(authorNickname);
		console.log(params);
		console.log(author);
		console.log(debut_year);
		if (author == '' ) {
			alert("작가명을 입력해 주세요")
		} 
		else if (sns_link == '' ) {
			alert("sns링크를 입력해 주세요")
		}
		else if (author_thumbnail == '' ) {
			alert("프로필사진을 첨부해 주세요")
		}
		else if (debut_year == '' ) {
			alert("데뷔년도를 입력해 주세요")
		} else {
		$.ajax({
			url: '/authorWriteOk',
			type: 'POST', 
			dataType: 'json',
			enctype: 'multipart/form-data',
			data : {
				nickName: '${mvo.nickname}',
				member_no: '${mvo.no}',
				author: $("#authorWriteName").val(),
				sns_link: $("#authorWriteSNS").val(),
				author_thumbnail: $("#authorThumbnail").val(),
				debut_year: $("#authorDebutYear").val()
			},
			success: function(result) {
				if (result) {
					alert("작가 신청 완료되었습니다.");
				} else {
					alert("작가 신청 실패");
				}
				
			}
		});
	}
}

</script>