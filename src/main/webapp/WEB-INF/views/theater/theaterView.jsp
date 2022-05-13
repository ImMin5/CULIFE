<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="${url}/css/theater/theaterView.css"
	type="text/css" />
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c6a67ea9b7a46ee55b3b3ccaaf230569"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c6a67ea9b7a46ee55b3b3ccaaf230569&libraries=services,clusterer,drawing"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<script>
//API(공연/지도)
var mtitle;
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
							
				$('input[name="title"]').val(title)
				mtitle=title;
				
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
					reviewListAll();
			});
		}
});
</script>
<script>
//리뷰리스트
	function reviewListAll(){
		var url = "/review/reviewList";
		var params = "title="+mtitle
		//alert(params)
		$.ajax({
			url:url,
			data:params,
			success:function(result){
				//alert(JSON.stringify(result))
				var $result = $(result);
				var tag = "<ul>";
				
				$result.each(function(idx, vo){
					tag += "<li><div>"+vo.nickname;
					tag += " ("+vo.write_date+")";
					tag += " ("+vo.score_star+")";
					
					if(vo.member_no=='${logNo}'){
						tag += "<input type='button' value='수정'/>";
						tag += "<input type='button' value='삭제' title='"+vo.no+"'/>";	
					}
					tag += "<br/>" + vo.content + "</div>";

				if(vo.member_no='${logNo}'){
					tag += "<div style='display:none'><form method='post'>";
					tag += "<input type='hidden' name='no' value='"+vo.no+"'/>";
					tag += "<textarea name='content' style='width:400px'>"+vo.content+"</textarea>";
					tag += "<input type='submit' value='수정'/>";									
					tag += "</form></div>";
				}
				tag += "<hr/></li>";		
			});
			tag+="</ul>";
			
			$("#reviewList").html(tag);
		}, error:function(e){
			console.log(e.responseText)
		}
	});
}//--------------------------------

$(function(){
	//리뷰등록
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
					$("#review").val("");
					reviewListAll();
				},
				error:function(e){
					console.log(e.responseText);
				}
			});
		}
	});
})

//리뷰수정
$(document).on('click','#reviewList input[value=수정]', function(){
	$(this).parent().css("display","none");
	$(this).parent().next().css("display","block");
});
$(document).on('submit','#reviewList form', function(){
	event.preventDefault();
	var params = $(this).serialize();
	var url = "/review/reviewEditOk";
	$.ajax({
		url:url,
		data:params,
		type:'POST',
		success:function(result){
			console.log(result);
			reviewListAll();
		},error:function(e){
			console.log("수정에러발생");
		}
	});
});

//리뷰삭제
$(document).on('click')
</script>
<script>
//별클릭 radio
function Rating(){};
Rating.prototype.rate = 0;
Rating.prototype.setRate = function(newrate){
    this.rate = newrate;
    let items = document.querySelectorAll('.rate_radio');
    items.forEach(function(item, idx){
        if(idx < newrate){
            item.checked = true;
        }else{
            item.checked = false;
        }
    });
}
let rating = new Rating();

document.addEventListener('DOMContentLoaded', function(){
    document.querySelector('.rating').addEventListener('click',function(e){
        let elem = e.target;
        if(elem.classList.contains('rate_radio')){
            rating.setRate(parseInt(elem.value));
            document.getElementById('score_star').value
    	    = elem.value;
        }
    })
});
</script>
<div id="detail_container">
	<div id="topDetail"></div>
	<div id="detail">
		<div id="midDetail"></div>
		<div id="map" style="width: 500px; height: 400px;"></div>
		
		
		<div id="review">
			<form method="post" id="reviewFrm" action="/review/reviewWriteOk">	
			<input type="hidden" name="score_star" id="score_star">		
					<div class="rating">
		                <!-- 해당 별점을 클릭하면 해당 별과 그 왼쪽의 모든 별의 체크박스에 checked 적용 -->
		                <input type="checkbox" name="score_star2" id="rating1" value="1" class="rate_radio" title="1점">
		                <label for="rating1"></label>
		                <input type="checkbox" name="score_star2" id="rating2" value="2" class="rate_radio" title="2점">
		                <label for="rating2"></label>
		                <input type="checkbox" name="score_star2" id="rating3" value="3" class="rate_radio" title="3점">
		                <label for="rating3"></label>
		                <input type="checkbox" name="score_star2" id="rating4" value="4" class="rate_radio" title="4점">
		                <label for="rating4"></label>
		                <input type="checkbox" name="score_star2" id="rating5" value="5" class="rate_radio" title="5점">
		                <label for="rating5"></label>
		            </div>		
		            <input type="hidden" name="title" value="${vo.title}">            
		            <textarea name="content" id="input_review" placeholder="리뷰를 남겨주세요." ></textarea>
					<!-- <input type="checkbox" class="spo_check" value="스포"/> -->
					<input type="submit" value="등록"/>
			</form>
		</div>
		
		<div id="reviewList"></div>
	</div>
	
</div>