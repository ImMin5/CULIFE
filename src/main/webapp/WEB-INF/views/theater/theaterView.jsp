<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="${url}/css/theater/theaterView.css"
	type="text/css" />
<script src="${url}/js/theater/theaterView.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c6a67ea9b7a46ee55b3b3ccaaf230569"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c6a67ea9b7a46ee55b3b3ccaaf230569&libraries=services,clusterer,drawing"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<script>
//API(공연/지도)
$(document).ready(function () {
	$.ajax({
		url: '/theater/theaterView', //통신을 원하는 URL주소를 입력합니다
		type: 'POST', //통신 방식을 지정합니다
		data:{seq:'${param.seq}'},
		
		dataType: 'xml',//서버로부터 받을 데이터 타입을 입력합니다.
		success: function (response) { // 통신 성공시 호출해야할 함수
		  xmlParsing(response);
		},
		error: function (xhr, status, msg) { // 통신 실패시 호출해야하는 함수
		  console.log('상태값 : ' + status + ' Http에러메시지 : ' + msg);
		},
	});
	
		 function xmlParsing(data){
			var midDetail = '';
			var topDetail = '';
			$(data).find('perforInfo').each(function(index, item){
				title=$(this).find('title').text()
				thumb=$(this).find('imgUrl').text()
				start=$(this).find('startDate').text()
				end=$(this).find('endDate').text()
				place=$(this).find('place').text()
				area=$(this).find('area').text()
				subTitle=$(this).find('subTitle').text()
				price=$(this).find('price').text()
				contents1=$(this).find('contents1').text()
				contents2=$(this).find('contents2').text()
				url=$(this).find('url').text()
				phone=$(this).find('phone').text()
				gpsX=$(this).find('gpsX').text()
				gpsY=$(this).find('gpsY').text()
							
		
		
				
					topDetail += `						
						<ul>						
							<li><img src="`+thumb+`" id="thePoster"/></li>
						</ul>
						<ul>						
						<li>`+area+`</li>
					</ul>
					`;
	
					midDetail += `
						
						<ul>
							<li>`+title+`</li>
							<li>`+subTitle+`</li>
						</ul>
						<ul>
							<li>`+start+`</li>
							<li>`+end+`</li>
						</ul>
						<ul>
						<li>`+url+`</li>
						<li>`+phone+`</li>
						</ul>
						<ul>
						<li>`+price+`</li>
						</ul>
						<ul>
							<li>`+contents1+`</li>
							<li>`+contents2+`</li>
						</ul>
						<ul>
							<li>`+place+`</li>
						</ul>
						<ul>
							<li id='map'></li>
						</ul>
					`;		
					var container=$('#map')[0];
					var options = {
							center: new kakao.maps.LatLng(gpsY, gpsX),
							level: 3
						};
					

					// 마커 생성
					var marker = new kakao.maps.Marker({
					    position: markerPosition
					});
					var markerPosition  = new kakao.maps.LatLng(gpsY, gpsX); 
					var map = new kakao.maps.Map(container, options);
					$('#topDetail').empty().append(topDetail);
					$('#midDetail').empty().append(midDetail);
				
			});
		}
});
</script>
<script>
//댓글등록
$(function(){
	//댓글목록
	function reviewListAll(){
		var params = "title="+$('#no').val();
		var url= "/review/reviewList?"+params;
		
		$.ajax({
			type:'get',
			url:url,
			data:params,
			success:function(result){
				var $result = $(result);
				var len = $result.length;
				$("h3 span").text(len);
				var tag = "<ul>"
				
				$result.each(function(ide, vo){
					tag += "<li><div>"+vo.nickname;
					tag += " (" + vo.writedate + ")";
					
					if(vo.member_no=='${logId}'){
						tag += "<input type='button' class='edit-review' value='수정'/>";
						tag += "<input type='button' class='del-review' value='삭제' title='" + vo.no + "'/'";
					}
					tag += "<br/>" + vo.content + "</div>";
					
					if(vo.no=='${logNo}'){
						tag += "<div style='display:none'><form method='post'>";
						tag += "<input type='hidden' name='no' value='" + vo.no + "'/>";
						tag += "<div class='edit_content><input name='content' class='input-content' value='" + vo.content + "'/>";
						tag += "<input type='submit' class='edit_content' value='수정'/></div>";
						tag += "</form></div>";
					}
					tag += "<hr style='height:0.5px; border:none; color:#ebebeb; background-color;#ebebeb;'/></li>";
				});
				tag += "</ul>";
				
				$("#reviewList").html(tag);
			},error:function(e){
				console.log(e.responseText);
			}
		});
	}
	//댓글등록
	$("#reviewFrm").submit(function(){
		event.preventDefault();
		if($("#content").val()==''){
			alert("리뷰를 입력 후 등록하세요.");
			return false;
		}else{
			var params = $("#reviewFrm").serialize();
			$.ajax({
				url:'/review/reviewWriteOk',
				data:params,
				type:'POST',
				success:function(r){
					$("#content").val("");
					reviewListAll();
				},
				error:function(e){
					console.log(e.responseText);
				}
			});
		}
	});
	//댓글수정
	$(document).on('click','#reviewList input[value=수정]', function(){
		$(this).parent().css("display","none");
		$(this).parent().next().css("display","block");
	});
	$(document).ont('submit','#reviewList form', function(){
		event.preventDefault();
		var params = $(this).serialize();
		var url= '/review/reviewEditOk';
		$.ajax({
			url:url,
			data:params,
			type'POST',
			success:function(result){
				console.log(result);
				reviewListAll();
			},error:function(e){
				console.log('수정에러');
			}
		});
	});
	//댓글삭제
	$(document).on('click','#reviewList input[value=삭제]', function(){
		if(confirm('댓글을 삭제하시겠습니까?')){
			var params = "no" + $(this).attr("title");
			$.ajax({
				url:'/review/reviewDel',
				data:params,
				success:function(result){
					console.log(result);
					reviewListAll();
				},error:function(){
					console.log("댓글삭제에러");
				}
			});
		}
	});
	reviewListAll();
});
</script>
<script>
//별점
var locked = 0;
function show(star){
	if(locked)
		return;
	var i;
	var grade;
	var el;
	var e = document.getElementById('startext');
	var stateMsg;
	
	for(i=1; i<=star; i++){
		
	}
	switch(star){
	case1:
		stateMsg = "별로입니다.";
		break;
	case2:
		stateMsg = "기대하지마세요.";
		break;
	case3:
		stateMsg = "보통입니다.";
		break;
	case4:
		stateMsg = "기대해도좋아요";
		break;
	case 5:
		stateMsg = "최고입니다.";
		break;
	default:
		stateMsg="";
	}
	e.innerHTML = stateMsg;
}

function noshow(star){
	if(locked)
		return;
	var i;
	var image;
	var el;
	
	for(i=1; i<= star; i++){
		grade ='grage' + i;
		el = documnet.getElementById(grade);
		el.src="~~~`";
	}
}

function lock(star){
	show(star);
	locked=1;
}
function mark(star){
	lock(star);
	alert("선택2"+star);
	document.cmtform.star.value=star;
}
</script>
<div id="detail_container">
	<div id="topDetail"></div>
	<div id="detail">
		<div id="midDetail"></div>
		<div id="map" style="width: 500px; height: 400px;"></div>
		<div id="review">
			<form method="post" id="reviewFrm">
				<input type="hidden" value="${vo.id}">
				<div class="review_submit">
					<div>
						<span class="material-icons">grade</span>
						<span class="material-icons">star_outline</span>
						<span class="material-icons">grade</span>
						<span class="material-icons">grade</span>
						<span class="material-icons">grade</span>
					</div>
					<input name="review" class="input_review" id="review" placeholder="리뷰를 남겨주세요."/>
					<input type="submit" class="submit_review" value="등록"/>
				</div>				
			</form>
		</div>
	</div>
	
</div>