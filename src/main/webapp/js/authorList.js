$(document).ready(function(){
	$('.finder__input').focus(function(){
		$('.finder').addClass('active');
	})
	$('.finder__input').blur(function(){
		if ($('.finder__input').val().length === 0){
			$('.finder').removeClass('active');
		}
	})
	$('#authorSearchFrm').submit(function(ev){
		ev.preventDefault();
		$('.finder').addClass('processing');
		$('.finder').removeClass('active');
		$('.finder__input').disabled = true;
		setTimeout(function(){
			$('.finder').removeClass('processing');
			$('.finder__input').disabled = false;
			if($('.finder__input').val().length > 0){
				$('.finder').addClass('active');
			}
		}, 1000);
	})
})