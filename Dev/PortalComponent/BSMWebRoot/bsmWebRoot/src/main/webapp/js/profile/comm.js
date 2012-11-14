function closeWin(){
	window.opener = null;
	window.open("", "_self");
	window.close();
}
$(function(){
	$('#cancel_button').click(function(){closeWin()});
	$('#win-close').click(function(){closeWin()});
})