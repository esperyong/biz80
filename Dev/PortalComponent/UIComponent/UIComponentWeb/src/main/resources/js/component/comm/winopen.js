function winOpen(obj){
	var resizeable = obj.resizeable ===true ? "yes" : "no";
	var scrollable = obj.scrollable ===true ? "yes" : "no";
	var height = obj.height;
	var width = obj.width;
	 var left =  window.screen.width/2 - width/2;
	 var top = window.screen.height/2 -height/2;
	 var newWin = window.open(obj.url,obj.name,'height='+height+', width='+width+', top='+top+', left='+left+', toolbar=no, menubar=no, scrollbars='+scrollable+',resizable='+resizeable+',location=no, status=no');
	 newWin.focus();
	 return newWin;
}