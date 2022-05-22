$(function(){
	getAlert();
});
function getAlert(){
	var container = $("#mypage_notification_ul");
	var url = "/mypage/alert"
	$.ajax({
		url : url,
		type: "GET",
		success:function(data){
			container.empty();
			console.log(data.items.length);
			$("#mypage_notification_count").text("("+data.items.length+")");
			data.items.forEach(function(element, index){
				console.log(element);
				if(index > 0){
					container.append(`
					<li><hr class="dropdown-divider"></li>
					<li style="width:15vw; margin-left:15px; margin-right:4px; font-size:1.4rem;">
						${element.content}<small style="color:gray"> ${element.create_date} days ago</small>
					</li>
					`)

				}
				else{
					container.append(`
					<li style="width:15vw; margin-left:15px; margin-right:4px; font-size:1.4rem;">
						${element.content} <small style="color:gray"> ${element.create_date} days ago</small>
					</li>
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