/**
 * 模态窗口.
 * @author sunjun.
 * @deprecated 例子.
 *  var winOpenObj = {};
 * 	winOpenObj.height = '350';
 * 	winOpenObj.width = '600';
 * 	winOpenObj.name = name;
 * 	winOpenObj.url = src;
 * 	winOpenObj.scrollable = true;
 * 	winOpenObj.resizeable = false;
 * 	modalinOpen(winOpenObj);
 * @param obj
 * @return
 */
var returnValue="";
function modalinOpen(obj){
	var resizeable = obj.resizeable ===true ? "Yes" : "No";
	var scrollable = obj.scrollable ===true ? "Yes" : "No";
	var height = obj.height;
	var width = obj.width;
	var left =  window.screen.width/2 - width/2;
	var top = window.screen.height/2 -height/2;
	
	returnValue = window.showModalDialog(obj.url,obj.name,"dialogHeight: "+height+"px; dialogWidth: "+width+"px;" +
			" dialogTop: "+top+"px; dialogLeft: "+left+"px; edge: Raised; center: Yes; help: No;" +
					" resizable: "+resizeable+";scroll: "+scrollable+"; status: No;");
	//window.showModalDialog(obj.url,obj.name,"dialogHeight:"+height+"px; dialogWidth: "+width+"px; dialogTop: "+top+"px; dialogLeft: "+left+"px; edge: Raised; center: Yes; help: Yes; resizable: "+resizeable+"; status: No; scroll: No");
	if(returnValue=="true"){
		parent.window.location.href=parent.window.location;
	}
}