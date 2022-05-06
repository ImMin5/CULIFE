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
<script>
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
					

					// 마커를 생성합니다
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

<div id="detail_container">
	<div id="topDetail"></div>
	<div id="detail">
		<div id="midDetail"></div>
		<div id="map" style="width: 500px; height: 400px;"></div>
	</div>
	
</div>