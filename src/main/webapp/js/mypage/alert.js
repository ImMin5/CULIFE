$(function(){
	getAlert();
	
	$(document).on("click","button[name=alert_delete]",function(){
		var alert_no = $(this).attr("data-alert_no");
		var alert = $("#mypage_alert"+alert_no);
		var url = "/api/alert";
		$.ajax({
			url : url,
			type : "DELETE",
			data :{
				no : alert_no,
			},
			success : function(data){
				alert.remove();
			},error : function(){
				
			}
		})
	})
});
function getAlert(){
	var container = $("#mypage_notification_ul");
	var url = "/mypage/alert"
	$.ajax({
		url : url,
		type: "GET",
		success:function(data){
			container.empty();
			$("#mypage_notification_count").text("("+data.items.length+")");
			data.items.forEach(function(element, index){
				if(index > 0){
					container.append(`
					<div id="mypage_alert${element.no}">
					<li style="margin:0 auto;"><hr class="dropdown-divider"></li>
					<li style="margin-left:15px; margin-right:8px; font-size:1.4rem;">
						${element.content}<small style="color:gray"> ${element.create_date} days ago</small>
						<button style="font-size:1.3rem; float:right;"type="button" name="alert_delete" data-alert_no=${element.no} class="btn-close"></button>
					</li>
					</div>
					`)

				}
				else{
					container.append(`
					<div id="mypage_alert${element.no}">
					<li style="margin-left:15px; margin-right:8px; font-size:1.4rem;">
						${element.content} <small style="color:gray"> ${element.create_date} days ago</small>
						<button style="font-size:1.3rem; float:right;"type="button" name="alert_delete" data-alert_no=${element.no} class="btn-close"></button>
					</li>
					</div>
					`)
				}
			
			});
		},error : function(error){
			console.log(error);
		}
	});
}
$(document).on("click","#dropdownMenuClickableInside",function(){
	getAlert();
});