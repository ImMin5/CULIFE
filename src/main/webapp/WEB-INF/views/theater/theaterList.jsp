<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="${url}/css/theater/theaterList.css" type="text/css"/>
<script>
$(document).ready(function () {
	$.ajax({
		url: '/theater/theaterList', //통신을 원하는 URL주소를 입력합니다
		type: 'POST', //통신 방식을 지정합니다
		dataType: 'xml',//서버로부터 받을 데이터 타입을 입력합니다.
		success: function (response) { // 통신 성공시 호출해야할 함수
		  xmlParsing(response);
		},
		error: function (xhr, status, msg) { // 통신 실패시 호출해야하는 함수
		  console.log('상태값 : ' + status + ' Http에러메시지 : ' + msg);
		},
	});

	function xmlParsing(data) {
		var infoList = ``;
		$(data).find('perforList').each(function(index, item){
			title=$(this).find('title').text()
			thumb=$(this).find('thumbnail').text()
			genre=$(this).find('realmCode').text()			
				console.log(title)
				infoList += `
					<ul>						
						<li><img src="`+thumb+`" id="thePoster"/></li>
						<li>`+title+`</li>
					</ul>
				`;
			
			$('#info').empty().append(infoList);
			$('ul:first').css('background', 'darkgray').css('color', 'white')
		});
	}
});
</script>
<div id="info">
hello 
</div>
<div>

</div>