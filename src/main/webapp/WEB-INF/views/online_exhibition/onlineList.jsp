<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/css/exhibition/onlineList.css">
<script src="/js/modal.js"></script>
<script src="/js/online_exhibition.js"></script>

<style>
	header {background-color:#000}
	html {-ms-overflow-style: none;}
	html::-webkit-scrollbar{display:none}
	input:focus {
		border:2px solid orange;
		border-color:orange;
	    outline: none;
	}
	textarea:focus {
		border:2px solid orange;
		border-color:orange;
	    outline: none;
	}
	#modal_search {-ms-overflow-style: none;}
	#modal_search::-webkit-scrollbar{display:none}
</style>
<script>

$(function(){
	//프로필 이미지 미리
	$(document).on("change","input[name=filename]", function(){
		/* console.log($(this)); */
		var count = $(this).attr("data-count");
		/* console.log(count);
		console.log($(this).val()); */
		//fileReader
		var reader = new FileReader();
		reader.onload = function(e) {
			document.getElementById("workPreview"+count).src = e.target.result;
		};
		reader.readAsDataURL(this.files[0]);
		var format = this.files[0].name.split(".").pop();
		$("#work_thumbnail"+count).val(count+"."+format);
	});
	
	
	$("#submit_btn").on("click", function(){
		var len = $("form[name=ex_work_form]").length;
        for(var i=1; i<=len;i++){
            var url = "${url}/upload/exhibition/workCreateOk";
            var data = new FormData($("form[name=ex_work_form]")[i-1]);
           /*  console.log(data)
			console.log("i => " + i + " work_subject => "+$("#work_subject"+i).val())
			console.log("i => " + i + " work_content => "+$("#work_content"+i).val())
			console.log("i => " + i + " work_file => "+$("#work_thumbnail"+i).val()) */
			
            if($("#work_subject"+i).val() == ""){
            	alert(i+"작품 명을 입력해 주세요.");
    			return false;
            }
            if($("#work_content"+i).val() == ""){
            	alert(i+"작품 설명을 입력해 주세요.");
    			return false;
            }
            if($("#work_thumbnail"+i).val() == ""){
            	alert(i+"파일을 입력해 주세요.");
    			return false;
            }
           $.ajax({
                url: url,
                processData: false,
                contentType: false,
                type : "POST",
                data : data,
                async : false,
                success : function(data){
                },
                error : function(){
                    
                }
            });
        }
        location.reload();
    });

    $("#submitDel_btn").on("click", function(){
    	var len = $("form[name=ex_work_form]").length;
    	var form = $("#ex_work_form"+len);
    	var work_no = form.attr("data-work_no");
    	if(work_no < 0){
    		form.remove();
    		return;
    	}												
    	/* console.log($("#ex_work_form"+len).remove()); */
    	var url = "/exhibition/workDel";
    	$.ajax({
    		url: url,
    		type : "POST",
    		data : {
    			"work_no" : work_no,
    		},
    		success: function(){
    			form.remove();
    		},
    		error : function(error){
    			console.log(error);
    		}

    	})
    });
  //스크롤 위치 
    $("#modal_search").scroll(function(){
    	var scrollT = $(this).scrollTop(); //스크롤바의 상단위치
    	var scrollH = $(this).height(); //스크롤바를 갖는 div의 높이
    	var contentH = $(".table").height(); //문서 전체 내용을 갖는 div의 높이
    	if(scrollT + scrollH +1 >= contentH) { // 스크롤바가 아래 쪽에 위치할 때
    	     pagination();
    	}
    });
	

	//전시 등록
	$("#ex_reg_form").submit(function(){
		var today = new Date();
		var year = today.getFullYear();
		var month = ('0' + (today.getMonth() + 1)).slice(-2);
		var day = ('0' + today.getDate()).slice(-2);
		var dateString = year + '-' + month  + '-' + day;

		if(dateString > $("#startDate").val() == true){
			alert("전시 시작일은 내일부터 가능합니다.");
			return false;
		}
		if($("#startDate").val() > $("#endDate").val() == true){
			alert("전시 시작일과 종료일을 확인 후 재등록 바랍니다.");
			return false;
		}
		if($("#startDate").val()==""){
			alert("전시 시작 날짜를 입력해 주세요.");
			return false;
		}
		if($("#endDate").val()==""){
			alert("전시 마감 날짜를 입력해 주세요.");
			return false;
		}
		if($("#subject").val()==""){
			alert("전시 명을 입력해 주세요.");
			return false;
		}
		if($("#content").val()==""){
			alert("전시 내용을 입력해 주세요");
			return false;
		}
	return true;
  })
})
</script>
<script>
	$(function(){
		//온라인전시회리스트 페이징
		var total_page = ${pVO.totalPage};
		onlineListPaging(0, total_page);

		//전시회 클릭시 미리보기 사진 가져오기
		$(document).on("click","p[name=get_exhibition]",function(){
			var exhibition_no = $(this).attr("data-exhibition_no");
			getExhibitionWork(exhibition_no);
			select_ExhibitionReviewList(exhibition_no);
		});
		
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
		// 댓글 등록하기
		$(document).on('submit',"#ex_reviewForm", function(exhibition_no){
			//event.preventDefault();
	
			if($("#ex_reviewComent").val()==""){ // 댓글 입력 안함
				alert("댓글을 입력 후에 등록해주세요");
			}else{ // 댓글 입력
				let data = $("#ex_reviewForm").serialize(); // form데이터 보내기
				$.ajax({
					url :'/ex_review/writeOk',
					data : data,
					type : 'POST',
					success : function(result){
						$("#ex_reviewComent").val("");
						select_ExhibitionReviewList(result);
						console.log(result);
					},error : function(e){
						alert("로그인 후 이용해주세요");
					}
				});
			}
			return false;
		});
			
	
		// 수정버튼 누르면 수정폼 보이게 하기
		$(document).on('click','#ex_reviewList input[value=수정]',function(){ // 수정버튼을 누르면      
			$(this).parent().parent().css("display","none");                    // 댓글 폼 안보이게
			$(this).parent().parent().next().css("display", "block");  // 수정폼 보이게
		});
		
		// 수정하기 DB연결
		$(document).on('submit','#ex_reviewList form',function(){
			event.preventDefault();
			console.log($("#exhibition_no").val());
			$.ajax({
				url:'/ex_review/editOk',
				data: $(this).serialize(),
				type: 'POST',
				success:function(data){
					select_ExhibitionReviewList(exhibition_no);
					console.log(data);
				},error:function(){
					console.log('수정에러');
				}
			});
		});
	
		// 댓글 삭제하기 
		$(document).on('click', "#ex_reviewList input[value=삭제]", function(){
			
			if(confirm('댓글을 삭제하시겠어요?')){
				let ex_reviewData = $(this).attr("title").split(",");
				let data = "exhibition_no="+ex_reviewData[0]+"&member_no="+ex_reviewData[1];
				console.log(ex_reviewData);
				$.ajax({
					url:'/ex_review/delOk',
					data:data,
					success:function(result){
						select_ExhibitionReviewList(exhibition_no);
					},error:function(){
						console.log('삭제에러');
					}
				});
			}
		});

		//이전 페이지 
		$(document).on("click", "#online_ex_prev",function(){
			onlineListPaging(-1,total_page);
		});
		
		//다음 페이지 
		$(document).on("click", "#online_ex_next",function(){
			onlineListPaging(1,total_page);
		});	
	});
</script>    
    <div id="online_exhibition_container">
    	<h2 class="hidden">온라인 전시회</h2>
    	<audio controls="controls" loop id="audio_player" 
    	src="/img/exhibition/audio/𝗖. 𝗗𝗲𝗯𝘂𝘀𝘀𝘆 - Suite Bergamasque, L.75 - Ⅲ. Clair de lune .mp3"
    	 onended="nextPlay()"></audio>
    	<a href="/online_exhibition/onlineAuthorList">작가 목록</a>
	    <c:if test="${grade == '1'}"> <!-- 작가 : 1 -->
		   	<a href="javascript:;" id="reg_ex">전시 등록</a>
		   	<a href="javascript:;" id="reg_work">작품 등록</a>
		</c:if>
	    <img id="online_ex_searchIcon" src="/img/exhibition/magnifying_glass.png" alt="검색 아이콘">
    	<div id="online_ex_search">
    		<h3>전시 작품 검색</h3>
	    	<form id="ex_searchFrm">
		    	<select id="ex_search" name="ex_search">
		    		<option value="exhibition_subject">전시명</option>
		    		<option value="author">작가</option>
		    	</select>
		    	<input type="text" name="ex_searchWord" id="ex_searchWord"/>
		   </form>
		    <div id="table_container">
			    <table>
			    	<tbody>
				    	<tr>
					    	<th>전시이름</th>
					    	<th>작가명</th>
					    	<th>전시기간</th>
				    	</tr>
				    </tbody>
			    	<tbody id="modal_search">
			    		
			    	</tbody>
			    </table>
		    </div>
		    <ol>
		    	<li><a href="">&#60;</a></li> <!-- < 기호 -->
		    	<li><a href="">1</a></li>
		    	<li><a href="">2</a></li>
		    	<li><a href="">3</a></li>
		    	<li><a href="">&#62;</a></li> <!-- > 기호 -->
		    </ol>
		    <img id="online_search_close" src="/img/exhibition/close.png" alt="닫기">
	    </div>
    	<div id="online_ex_wrap">
	    	<div id="room">
	    		<ul>
	    			<li>
	    				<span></span>
	    				<img id="exhibition_thumnail_first" src="/img/exhibition/texture_img.png" alt="첫번째 작품">
		    		</li>
	    			<li>
	    				<span></span>
	    				<img id="exhibition_thumnail_second" src="/img/exhibition/texture_img.png" alt="두번째 작품">
	    			</li>
	    		</ul>
	    		<button class="workView_btn" type="button">V I E W</button>
	    	</div>
	    	
	    	<!-- 페이지네이션 -->
	    	<div id="online_ex_pagination">
		    	<a href="#"><img id="online_ex_prev" src="/img/exhibition/arrow_left.png" alt="이전"></a>
		        <div id="ex_pagination_box">
	    			<%-- <c:forEach var="exvo" items="${exhibitionList}" varStatus="status">
	    				<p onclick="location.href='${url}/online_exhibition/onlineList?currentPage=${pVO.currentPage}&select=${status.count}'"><span>${exvo.author}</span><img src="${url}/upload/${exvo.member_no}/author/exhibition/${exvo.no}/${exvo.work_thumbnail}"></p>	    			
	    			</c:forEach> --%>
	    		</div>
	    		<a href="#"><img id="online_ex_next" src="/img/exhibition/arrow_right.png" alt="다음"></a>
		    </div>
    	</div>
    </div>
    
    <!-- 전시등록 모달 -->
    <div id="exhibition_reg_bg" class="modal">
    	<div id="exhibition_wrap" class="modal_wrap">
    		<h3>전시 등록</h3>
    		<ul>
    			<li>
    				<figure id="ex_reg_img"></figure>
    				<span>어서오세요 작가님,<br/>즐거운 전시회 시간을 가져보세요.</span>
    			</li>    		
    			<li>
    				<form id="ex_reg_form" method="post" action="/exhibition/exhibitionWriteOk" enctype="multipart/form-data">
						<ul class="exhibitionWriteContent">
							<li class="exhibitionWriteTitle">
								<p>전시 기간</p>
								<input type="date" name="start_date" id="startDate" class="ridingDate"> - <input type="date" name="end_date" id="endDate" class="ridingDate">
							</li>
							<li class="exhibitionWriteDate">
								<p>전시명</p>
								<input type="text" name="subject" id="subject">
							</li>
							<li class="exhibitionWriteContent">
								<p>전시 설명</p>
								<textarea name="content" id="content"></textarea>
							</li>
							<li class="exhibitionWriteType">
								<p>전시 유형</p>
								<div><input id="exhibitionRadio" type="radio" name="type" value="1" checked> <span>그림 전시</span>
								<input id="exhibitionRadio" type="radio" name="type" value="2"> <span>글 전시</span></div>
							</li>
						</ul>
						<input type="submit" value="등록하기" id="exhibitionSubmit"/>
					</form>
    			</li>    		
    		</ul>
    		<i class="fa-solid fa-xmark"></i>
    	</div>
    </div>
    
    <!-- 작품등록 모달 -->
    <div id="ex_work_bg" class="modal">
    	<div id="ex_work_wrap" class="modal_wrap" style="overflow:auto;">
    		<h3>작품 등록</h3>
    		<a href="javascript:;" id="addWork"><i class="fa-solid fa-plus"></i>작품 추가</a>
    		<div id="form_box">
				<c:if test="${workList != null}">
					<c:forEach var="vo" items="${workList}" varStatus="status">
			    		<form name="ex_work_form" id="ex_work_form${status.count}" method="post" action="/exhibition/workCreateOk" data-work_no="${vo.no}" enctype="multipart/form-data">
							<ul id="ex_work_box">
								<li class="exhibitionWorkContent">
									<ul>
										<li class="workThumbnail">
											<p class="hidden">작품 썸네일</p>
											<figure><img src="${url}/upload/${logNo}/author/exhibition/${vo.exhibition_no}/${vo.work_thumbnail}" id="workPreview${status.count}" name="workPreview${status.count}"/></figure>
											<input type="hidden" name="no" value="${vo.no}"/>
											<input class="work_upload-name" name="work_thumbnail" placeholder="첨부파일" id="work_thumbnail${status.count}" value="${vo.work_thumbnail}"readonly>
											<input type="file" name="filename" id="work_file${status.count}" class="workFile" data-count="${status.count}"/>
											<label for="work_file${status.count}">파일찾기</label> 
											
										</li>
										<li class="exhibitionApplyTitle">
											<p>작품 명</p>
											<input type="text" name="work_subject" value="${vo.work_subject}" id="work_subject${status.count}">
										</li>
										<li class="exhibitionApplyContent">
											<p>작품 설명</p>
											<textarea name="work_content" id="work_content${status.count}">${vo.work_content}</textarea>
										</li>
									</ul>
								</li>
							</ul>
						</form>					
					</c:forEach>
				</c:if>
			</div>	
			<input type="button" value="등록하기" id="submit_btn"/>
			<input type="button" value="삭제하기" id="submitDel_btn"/>
			<i class="fa-solid fa-xmark"></i>
    	</div>
    </div>
    
    <!-- 작품 상세 페이지 모달 -->
	<div id="ex_detail_bg" class="modal">
    	<div id="ex_detail_wrap" class="modal_wrap">
    		<h3>작품 상세</h3>
    		<div id="ex_reg_detail">
    			<h4 id="ex_reg_subject">${exhibition.subject}</h4>
    			<p id="ex_reg_content">${exhibition.content}</p>
    		</div>
    		<ul id="ex_reg_detail_work">
    			<%-- <c:forEach var="wk" items="${exhibition.workList}">
    			<li>
	    			<ul>
		    			<li><figure class="ex_detail_img"><img class="ex_work_thumbnail" src="${url}/upload/${exhibition.member_no}/author/exhibition/${wk.exhibition_no}/${wk.work_thumbnail}"></figure></li>    		
			    		<li class="ex_detail_info">
			    			<ul>
								<li>작가 : <span></span></li>
								<li>작품 명 : <span></span></li>
								<li>전시 기간 : <span></span> - <em></em></li>
								<li>작품 설명</li>
								<li><p></p></li>
							</ul>
						</li>
					</ul>
	    		</li>
   				</c:forEach> --%>
   				<%-- <li id="ex_review">
   					<h4>&nbsp;&nbsp;감상평</h4>
   					<span id="review_close">▼</span>
   					<span id="review_open">▲</span>
				</li>
				<!-- 댓글 목록 표시 -->
				<li id="ex_reviewList"></li>
	    		<li id="ex_reviewForm_wrap">
		    		<form method="post" id="ex_reviewForm">
						<input type="hidden" name="exhibition_no" id="exhibition_no" value="${exhibition.no}">
						<div id="ex_review_box">
							<textarea name="content" id="ex_reviewComent" class="ex_reivewComent" placeholder="내용을 입력하세요"></textarea>
							<span id="ex_reviewBtn"><input type="submit" id="ex_reviewInsert" value="등록"/></span>
						</div>
					</form>
	    		</li> --%>
	    	</ul>
	    	<i class="fa-solid fa-xmark"></i>
    	</div>
    </div>
    
    <div id="imgPopup">
    	<i class="fa-solid fa-xmark"></i>
    	<img class="pop" src="">
    </div>