
//模态窗口
function modalinOpen(obj){
	var resizeable = obj.resizeable ===true ? "Yes" : "No";
	var scrollable = obj.scrollable ===true ? "Yes" : "No";
	var height = obj.height;
	var width = obj.width;
	var left =  window.screen.width/2 - width/2;
	var top = window.screen.height/2 -height/2;
	var returnVal = window.showModalDialog(obj.url,obj.name,"dialogHeight: "+height+"px; dialogWidth: "+width+"px;" +
			" dialogTop: "+top+"px; dialogLeft: "+left+"px; edge: Raised; center: Yes; help: No;" +
					" resizable: "+resizeable+";scroll: "+scrollable+"; status: No;");
	return returnVal;
}