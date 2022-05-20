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
				seq=$(this).find('seq').text()
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
				$('input[name="poster"]').val(thumb)
				$('input[name="seq"]').val(seq)
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
							<li>공연기간 : `+start+``+~end+`</li>
			
						</ul>
						<ul>
						<li>문의사항 : `+phone+`</li>
						<li>`+url+`</li>
						</ul>
						<ul>
						<li>`+price+`</li>
						</ul>
						<ul>
							<li>`+contents1+`</li>
							<li>`+contents2+`</li>
						</ul>
						<ul>
							<li>장소 : `+place+`</li>
						</ul>
						<ul>
							<li id='map'></li>
						</ul>
					`;		
					var container=$('#map')[0];
					var options = {
							center: new kakao.maps.LatLng(gpsY, gpsX),
							level: 2
						};
					

					// 마커 생성
					var markerPosition  = new kakao.maps.LatLng(gpsY, gpsX); 
					var marker = new kakao.maps.Marker({
					    position: markerPosition
					});
					var map = new kakao.maps.Map(container, options);
					marker.setMap(map);
					$('#topDetail').empty().append(topDetail);
					$('#midDetail').empty().append(midDetail);
					reviewListAll();
					
			});
		}
});
</script>
<script>
function editForm(idx){
	$('#editDiv'+idx).show()
}

//리뷰리스트
	function reviewListAll(){
		var url = "/review/reviewList";
		var params = "title="+encodeURIComponent(mtitle)
		//alert(params)
		$.ajax({
			url:url,
			data:params,
			success:function(result){
				//alert(JSON.stringify(result))
				var score = result.star_avg;
					$('#starAvg').html("<h1>"+score+"</h1>") //별점 평균 불러오기
				var cnt = result.review_cnt;
					$("#reviewCnt").html("<h1>"+cnt+"</h1>") //리뷰 개수 불러오기
				//alert(score)
				var $result = $(result.reviewList);
				var tag = "<ul>";
				
				$result.each(function(idx, vo){
					tag += "<li><div id='reviewOne'>"+vo.nickname;
					tag += " ("+vo.write_date+")";
					for(var i=0;i<vo.score_star;i++){
					tag+= "★";
					}
					tag += " ("+vo.score_star+")";
					
					if(vo.member_no=='${logNo}'){
						tag += "<input type='button' value='수정'/>"; 
						tag += "<input type='button' value='삭제' title='"+vo.no+"'/>";	
					}
					//console.log("vo.spo_check: "+vo.spo_check)
					if(vo.spo_check==1){
						tag+="<h2>스포일러</h2>"
						tag+="<div class='spo'>"+ vo.content + "</div></div>"
					}else{
						tag += "<br/>" + vo.content + "</div>";
					}
					if(vo.member_no!='${logNo}'){
						tag += "<input type='button' value='신고' onclick='warning(" + vo.no +")'/>";
					}
					

				if(vo.member_no=='${logNo}'){
					tag += "<div class='stars_edit'>"
					tag += "<form method='post' action='/review/reviewWriteOk' id='editFrm'>";
					tag += "<input type='hidden' name='no' value='"+vo.no+"'/>";
					tag += "<input type='hidden' name='score_star' id='score_star_edit'>";
					tag += "<div class='stars'>	"
						if(vo.spo_check==1){
							tag += "<input type='checkbox' name='spo_check' id='spo_check' value='1' checked/>";
							tag += "<label for='spo_check'>스포체크</label>"
						}else{
							tag += "<input type='checkbox' name='spo_check' id='spo_check' value='1'/>";
							tag += "<label for='spo_check'>스포체크</label>"
						}
					var str1, str2, str3, str4, str5;
					if(vo.score_star==1){
						str1="checked";
					}else if(vo.score_star==2){
						str2="checked";
					}
					else if(vo.score_star==3){
						str3="checked";
					}
					else if(vo.score_star==4){
						str4="checked";
					}
					else if(vo.score_star==5){
						str5="checked";
					}
					tag += `
					<input class="star star-5" id="star-5-2" type="radio" `+str5+` name="score_star" value="5" title="5점"/>					
					<label class="star star-5" for="star-5-2"></label>
			        <input class="star star-4" id="star-4-2" type="radio" `+str4+` name="score_star" value="4" title="4점"/>
			        <label class="star star-4" for="star-4-2"></label>
			        <input class="star star-3" id="star-3-2" type="radio" `+str3+` name="score_star" value="3" title="3점"/>
			        <label class="star star-3" for="star-3-2"></label>
			        <input class="star star-2" id="star-2-2" type="radio" `+str2+` name="score_star" value="2" title="2점"/>
			        <label class="star star-2" for="star-2-2"></label>
			        <input class="star star-1" id="star-1-2" type="radio" `+str1+` name="score_star" value="1" title="1점"/>
			        <label class="star star-1" for ="star-1-2"></label>
			       </div>`
			      	tag += "<div class='Ereview_box'>"
				    tag += "<textarea class='review' name='content'>"+vo.content+"</textarea>";				    
				    tag += "<label class='review' for='review'></label>"
					tag += "<input type='submit' value='수정'/>";									
					tag += "</form></div>";
				}
				tag += "<hr/></li>";
				score_star = vo.score_star;		
				//alert(score_star)
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
					if(parseInt(r)==-1){
						alert('이미 리뷰를 작성하였습니다.');	
						$('#content').val("");
					}
					$("#stars").val("");
					reviewListAll();
				},
				error:function(e){
					console.log(e.responseText);
				}
			});
		}
	});
})

//리뷰 수정
$(document).on('click','#reviewList input[value=수정]', function(){
	$('#mDiv').css("display","none");	
	$('#reviewOne').css("display","none");
	$('.stars_edit').css("display","block");
});
$(document).on('submit','#editFrm', function(){
	event.preventDefault();
	var params = $(this).serialize();
 	//console.log(params);
	var url = "/review/reviewEditOk";
	$.ajax({
		url:url,
		data:params,
		type:'POST',
		success:function(result){
			//console.log(result);
			reviewListAll();
		},error:function(e){
			console.log("수정에러발생");
		}
	});
});
$(document).ready(function(){
	$("input[name='score_star']:radio").click(function () { 
		//alert('a')
		$("input:radio[name='score_star']").removeAttr('checked');
		
		var editStar = $(this).val();
		$("input:radio[name='score_star']:radio[value='"+editStar+"']").prop("checked",true);
		//alert(editStar)
		console.log(editStar);			
		$('#score_star_edit').val(editStar)
	});
});	
//리뷰삭제
$(document).on('click','#reviewList input[value=삭제]', function(){
	if(confirm('리뷰를 삭제하시겠습니까?')){
		var params = "no="+$(this).attr("title");
		$.ajax({
			url:'/review/reviewDel',
			data:params,
			success:function(result){
				//console.log(result);
				reviewListAll();
			}, error:function(e){
				console.log("리뷰삭제에러발생");
			}
		});
	}
});

//신고기능
function warning(no){
	if(confirm('해당 댓글을 신고하시겠습니까?')){
		//alert(no);
		var params = no;
		$.ajax({
			type:'get',
			url:'/warning/'+no,			
			success:function(result){
				if(parseInt(result)>0){
					alert('신고가 완료되었습니다.');
					reviewListAll();
				}else{
					alert('이미 신고 처리되었습니다.')
				}
				
			},error:function(e){
				
				console.log("신고에러발생 "+JSON.stringify(e));
			}
		});
	}
}
</script>
<div id="detail_container">
	<div id="topDetail"></div>
	<div id="detail">
		<div id="midDetail"></div>
		<div id="map" style="width: 500px; height: 400px;"></div>
				
		 	<div class="review_container">
	    	<div class="stars" id="mDiv">
	    	<c:if test="${logNo != null}">
				<form method="post" id="reviewFrm" action="/review/reviewWriteOk">						
					<input type="checkbox" name="checkbox" id="checkbox" />
      		 		<label for="checkbox">스포체크</label>	 
				    <input class="star star-5" id="star-5-2" type="radio" name="score_star" value="5" title="5점"/>
			        <label class="star star-5" for="star-5-2"></label>
			        <input class="star star-4" id="star-4-2" type="radio" name="score_star" value="4" title="4점"/>
			        <label class="star star-4" for="star-4-2"></label>
			        <input class="star star-3" id="star-3-2" type="radio" name="score_star" value="3" title="3점"/>
			        <label class="star star-3" for="star-3-2"></label>
			        <input class="star star-2" id="star-2-2" type="radio" name="score_star" value="2" title="2점"/>
			        <label class="star star-2" for="star-2-2"></label>
			        <input class="star star-1" id="star-1-2" type="radio" name="score_star" value="1" title="1점"/>
			        <label class="star star-1" for ="star-1-2"></label>
		            <div class="review_box">
				          <textarea id="content" class="review" col="30" name="content" placeholder="평점을 남겨주세요."></textarea>
				          <label class="review" for="review"></label>
				    </div>	
		            <input type="hidden" name="title" value="${vo.title}">            
		            <input type="hidden" name="poster" value="${vo.poster}">  
		            <input type="hidden" name="seq" value="${vo.seq}">  		           
					<input type="submit" value="등록" class="review_submit" />
			</form>
			</c:if>
		</div>
			
			<div id="starAvg"></div>
			<div id="reviewList"></div>
			<h3>
				리뷰 개수 : <span id="reviewCnt"></span>
			</h3>
		</div>
	
</div>
</div>