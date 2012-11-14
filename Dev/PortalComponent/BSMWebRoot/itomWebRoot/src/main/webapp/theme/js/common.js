
function openwindow(str_url,width,height,target){
	if(str_url=='') return false;
	
	if(target=='') target = "_blank";
	if(height==null) height = screen.height;
	if(width==null) width = screen.width;
	

	var left = (screen.width - width)/2;
	var top = (screen.height - height)/2;
	
	var str_style = "toolbar=0, menubar=0, scrollbars=1, resizable=1, width=" + width + ", height=" + height + ", left=" + left + ", top=" + top;
	window.open(str_url,target,str_style);
}
function openwindowNoResizeScroll(str_url,width,height,target){
	if(str_url=='') return false;
	
	if(target=='') target = "_blank";
	if(height==null) height = screen.height;
	if(width==null) width = screen.width;
	
	
	var left = (screen.width - width)/2;
	var top = (screen.height - height)/2;
	
	var str_style = "toolbar=0, menubar=0, scrollbars=0, resizable=0, width=" + width + ", height=" + height + ", left=" + left + ", top=" + top;
	window.open(str_url,target,str_style);
}

function openwindowNoScroll(str_url,width,height,target){
	if(str_url=='') return false;
	
	if(target=='') target = "_blank";
	if(height==null) height = screen.height;
	if(width==null) width = screen.width;
	
	
	var left = (screen.width - width)/2;
	var top = (screen.height - height)/2;
	
	var str_style = "toolbar=0, menubar=0, scrollbars=0, resizable=1, width=" + width + ", height=" + height + ", left=" + left + ", top=" + top;
	window.open(str_url,target,str_style);
}

function openwindowNoResizable(str_url,width,height,target){
	if(str_url=='') return false;
	
	if(target=='') target = "_blank";
	if(height==null) height = screen.height;
	if(width==null) width = screen.width;
	
	
	var left = (screen.width - width)/2;
	var top = (screen.height - height)/2;
	
	var str_style = "toolbar=0, menubar=0, scrollbars=1, resizable=0, width=" + width + ", height=" + height + ", left=" + left + ", top=" + top;
	window.open(str_url,target,str_style);
}

var owin = null;
function openwindowNoScrolld(str_url,width,height,target){
	if(str_url=='') return false;
	
	if(target=='') target = "_blank";
	if(height==null) height = screen.height;
	if(width==null) width = screen.width;
	
	
	var left = (screen.width - width)/2;
	var top = (screen.height - height)/2;
	
	var str_style = "toolbar=0, menubar=0, scrollbars=0, resizable=1, width=" + width + ", height=" + height + ", left=" + left + ", top=" + top;
	if(owin==null||owin.closed)
		owin = window.open(str_url,target,str_style);
}
var oldHrefObj = null;
function focusNodeFont(hrefElement){		
		var newHrefElement = document.getElementById(hrefElement);
		if(oldHrefObj){	
			oldHrefObj.style.fontWeight="normal";	
		}
		if(newHrefElement){
			newHrefElement.style.fontWeight="bolder";			
			oldHrefObj = newHrefElement;
		}
		
		if(parent.clearNodeFont){
			parent.focusNodeFont();		
		}
}

function LTrim(str)

{

var whitespace = new String(" \t\n\r");

var s = new String(str);



if (whitespace.indexOf(s.charAt(0)) != -1)

{

var j=0, i = s.length;

while (j < i && whitespace.indexOf(s.charAt(j)) != -1)

{

j++;

}

s = s.substring(j, i);

}

return s;

}

function RTrim(str)

{

var whitespace = new String(" \t\n\r");

var s = new String(str);



if (whitespace.indexOf(s.charAt(s.length-1)) != -1)

{

var i = s.length - 1;

while (i >= 0 && whitespace.indexOf(s.charAt(i)) != -1)

{

i--;

}

s = s.substring(0, i+1);

}

return s;

}


function Trim(str)

{

return RTrim(LTrim(str));

}
function winClose() {
	window.close();
}
function changeDisplayName(id,dispalyName,name){
             var obj = document.getElementById("dis"+id);
             if(obj){
             obj.parentNode.title=name;
             if(obj.innerHTML!=dispalyName){
              obj.innerHTML = dispalyName;
             }
	}	
}

function goToFirst(isUserExist,firstHref,prompt){
	if("true" != isUserExist.toString()){
		window.showModalDialog('window.jsp?promptType=longAlert&prompt='+prompt+'&scriptCmd=',window,'dialogWidth:419px;dialogHeight:165px;help:no;center:yes;resizable:no;status:no;scroll:no');
		var rootWindow = getFirstTopWindow(window);
		rootWindow.location.href = firstHref;
	}
}

function getFirstTopWindow(theWindow){
	if(theWindow.parent && theWindow != theWindow.parent ){
		return getFirstTopWindow(theWindow.parent);
	}
	return theWindow;		
}

/**
 * 检查数据是否为空.
 * field:当前属性.
 * promptType:提示窗口类别;
 * prompt:提示窗口信息;
 * scriptCmd:javascript命令行(注:在命令行前加window.opener);
 * 提示窗口大小规定为三种197,119;419,135;419,105
 * */
function checkNullField3(field,promptType,prompt,scriptCmd,width,height){
	if(field.value.trim()==""){
		openSystemModalWindow(promptType,prompt,scriptCmd,width,height);	   	
		field.focus();
		return false;
	}else{
		return true;
	}
}
/**检查数据是否合法(字符串)*/
function checkLawlessChar3(field,promptType,prompt,scriptCmd,width,height){
	var srcStr = "[#<>()%'*/\\\\:?|;\"]";
	var v=field.value.match(srcStr);
	if(v !=null){
		openSystemModalWindow(promptType,prompt,scriptCmd,width,height);
		field.focus();
		return false;
	}
	else{
		return true;
	}
}
/**检查数据是否合法(数字)*/
function checkNum3(field,promptType,prompt,scriptCmd,width,height){
	var nonnumeric = /[^0-9^:]/;
	v = field.value.match(nonnumeric);
	if ((field.value != "") && (v != null)) {
		openSystemModalWindow(promptType,prompt,scriptCmd,width,height);
		field.value="";
		field.focus();
		return false;
	}
	return true;
}
/**检查数据范围-tangyj*/
function checkMidValue3(field,MaxValue,MinValue,promptType,prompt,scriptCmd,width,height){
	if (parseInt(field.value) > parseInt(MaxValue) || parseInt(field.value) < parseInt(MinValue)){
		openSystemModalWindow(promptType,prompt,scriptCmd,width,height);
		field.value="";
		field.focus();
		return false;
	}
	return true;
}
/**检查数据长度-tangyj*/
function checkLength3(field, MaxValue,promptType,prompt,scriptCmd,width,height){
	var j=0;
	if (field!=null&&field.length>0){
		for(var i=0;i<field.length;i++){
			if(field.charCodeAt(i)>255){
				j+=2;
			}else{
				j++;
			}
		}
	if(j>MaxValue){
		openSystemModalWindow(promptType,prompt,scriptCmd,width,height);
		return false;      
	}
	return true;
	}
	return true;
}
/**检查数据是否包括汉字*/
function checkChinese3(field,promptType,prompt,scriptCmd,width,height){
	var s=field.value;
	for(i=0;i<s.length;i++){
		if(s.charCodeAt(i)>255){
			openSystemModalWindow(promptType,prompt,scriptCmd,width,height);
			field.focus();
			return false;
		}
	}
	return true;
}
/**检查E-mail地址是否有效*/
function checkEmail3(field,promptType,prompt,scriptCmd,width,height){
	var i = 1;
	var len = field.value.length;
   
	pos1 = field.value.indexOf("@");
	pos2 = field.value.indexOf(".");
	pos3 = field.value.lastIndexOf("@");
	pos4 = field.value.lastIndexOf(".");
  
	if ((pos1 <= 0)||(pos1 == len-1)||(pos2 <= 0)||(pos2 == len-1)){
		openSystemModalWindow(promptType,prompt,scriptCmd,width,height);
		field.focus();
		return false;
	}else{
		if( (pos1 == pos2 - 1) || (pos1 == pos2 + 1)
          || ( pos1 != pos3 )  
          || ( pos4 < pos3 ) ) 
		{
			openSystemModalWindow(promptType,prompt,scriptCmd,width,height);
			field.focus();
			return false;
		}
	}
	return true;
}
/**
 * 打开模式窗口.
 * promptType:提示窗口类别;
 * prompt:提示窗口信息;
 * scriptCmd:javascript命令行(注:在命令行前加window.opener);
 * 提示窗口大小规定为三种197,119;419,135;419,135;
 * */
function openSystemModalWindow(promptType,prompt,scriptCmd,width,height){
	return window.showModalDialog('window.jsp?promptType='+promptType+'&prompt='+prompt+'&scriptCmd='+scriptCmd+'',window,'dialogWidth:'+width+'px;dialogHeight:'+height+'px;help:no;center:yes;resizable:no;status:no;scroll:no');
}

function runChgbgColor(TabID){
	function ChgbgColor(TabID){
		//var oRows=document.all(TabID).all.tags("TR");
		var oRows=document.all(TabID).rows;
		for(var i=1;i<oRows.length;i++) {
			oRows[i].onmouseover=function(){
				this.oBgc=this.bgColor;
				this.bgColor="#CCFFCC";
			}
			oRows[i].onmouseout=function(){
				this.bgColor=this.oBgc;
			}
		}
	}
	ChgbgColor(TabID);
}

function openPreWindow(str_url,width,height,target){
	if(str_url=='') return false;

	if(target=='') target = "_blank";
	if(height==null) height = screen.height;
	if(width==null) width = screen.width;


	var left = (screen.width - width)/2;
	var top = (screen.height - height)/2;

	var str_style = "toolbar=0, menubar=0, scrollbars=1, resizable=1, width=" + width + ", height=" + height + ", left=" + left + ", top=" + top;
	window.open(str_url,target,str_style);
}

