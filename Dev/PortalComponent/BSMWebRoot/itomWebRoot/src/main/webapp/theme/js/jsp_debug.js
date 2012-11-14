/*
 * Used for jsp debug framework, do not modify it.
 * author: shilz
 */
  
function _jsp_register() {
	document.attachEvent('onkeydown', _jsp_showall);   // show special comments, ALT + p
	document.attachEvent('onkeydown', _jsp_framesall); // show window hierarchy, ALT + o
}

function _jsp_showall(event){ 
	// ALT + p
	if (event.altKey && (String.fromCharCode(event.keyCode) == "P")) { 
		alert(_jsp_show_comments(document));
	}
} 
function _jsp_framesall(event){ 
	// ALT + o
	if (event.altKey && (String.fromCharCode(event.keyCode) == "O")) { 
		alert(_jsp_frames());
	}
} 
	
function _jsp_show_comments(obj) {
	var objarray = new Array();
	_jsp_comments(obj, objarray);
	var comments = "";
	for(var i=0; i<objarray.length; i++) {
		if (_jsp_trim(objarray[i]).length>0) {
			comments+=(_jsp_replaceall(objarray[i], '\t', '') + "\n\n");
		}
 	 }
	return comments;
}
function _jsp_trim(str) {
	var j = 0, k = str.length - 1;
	while (j < str.length && str.charAt(j) <= ' ') ++j;
	while (k >= j && str.charAt(k) <= ' ') --k;
	return j > k ? "": str.substring(j, k + 1);
}
function _jsp_replaceall(str, fromchar, tochar){    
	return str.replace(new RegExp(fromchar,"gm"),tochar);    
}   

function _jsp_comments(ele, objarray) {
 if(ele != null && ele.hasChildNodes()) {
	var nl = ele.childNodes;
	for(var i=0; i<nl.length; i++) {
		if(nl[i].nodeName=="#comment") { //only the comment node startwith (jspdebug) is the matter.
			if (nl[i].nodeValue.indexOf('(jspdebug)') >=0) {
				objarray.push(nl[i].nodeValue);
			}
		}
		if(nl[i].nodeType == 1){
			if (nl[i].nodeName=='IFRAME') { // IFRAME tag is a special tag
				var _name1 = nl[i].getAttribute('name');
				if(_name1 != null) {
					try{
					 	var _ele1 = document.frames(_name1).document;//not use getElementById
						if (_ele1 != null) {
							_jsp_comments(_ele1, objarray);
						}
					}catch(e){}
				}
			} else {
				_jsp_comments(nl[i], objarray);
			}
		} 
	}
  }
}
		
/*
 * Used to show the window hierarchy.
 */		
function _jsp_frames() {
	var top = window.top;
	var objarray = new Array();
	{
		var tmparray = new Array();
		tmparray[0] = 0;
		tmparray[1] = "top:"+ top.location;
		objarray.push(tmparray);
	}
	_jsp_findall(top, 0, objarray);
	var str = "";
	for (var i=0; i<objarray.length; i++) {
		var tmparray = objarray[i];
		for (var j=0;j<tmparray[0];j++) {
			str += '\t';
		}
		str += (tmparray[1]+'\n\n');
	}
	return str;
}	
	
function _jsp_findall(win, level, objarray) {
	try{
		var all = win.frames;
		if (all != null && all.length>0) {
			var tmplevel = level + 1;
			for (var i=0; i<all.length; i++) {
				var tmparray = new Array();
				tmparray[0] = tmplevel;
				tmparray[1] = all[i].name+ ":" +all[i].location;
				objarray.push(tmparray);
	
				_jsp_findall(all[i], tmplevel, objarray)
			}
		}
	}catch(e) {
	}
}		

/*
 *----------------------------------------------------------------------------------------------------------------------
 */
function GetObj(objName){
	if(document.getElementById){
		return eval('document.getElementById("'+objName+'")')
	}else if(document.layers){
		return eval("document.layers['"+objName+"']")
	}else{
		return eval('document.all.'+objName)
	}
}
function SetObj(objName, objValue) {
	var e = GetObj(objName);
	if (e != null) {
		e.value = objValue;
	}
}
function hiddenObj(ObjId){
	GetObj(ObjId).style.display="none"
}
function showObj(ObjId){
	GetObj(ObjId).style.display="block"
}

function g(win, URL){
	eval(win+'.location.href')=URL;
}




