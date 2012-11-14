/**
*
* 如果客户端是非IE浏览器，则为dom对象添加loadXML方法.
* @author:qiaozheng
* 
*/
if(!window.ActiveXObject){
	Document.prototype.loadXML = function(xmlStr){
		var doc = (new DOMParser()).parseFromString(xmlStr, 'text/xml');
		while(this.hasChildNodes()){
			this.removeChild(this.lastChild);
		}
		for(var i=0, il=doc.childNodes.length; i<il;){
			this.appendChild(this.importNode(doc.childNodes[i++], true));
		}
	};
}
/**
* 将XML字符串转为dom对象
* @param string xmlStr
* @return Dom
* @author:qiaozheng
*/
function func_asXMLDom(xmlStr){
	var xmlDoc = null;
	if(window.ActiveXObject){
		xmlDoc = new ActiveXObject('Microsoft.XMLDOM');
	}else if(document.implementation && document.implementation.createDocument){
		xmlDoc = document.implementation.createDocument('', '', null);
	}
	xmlDoc.loadXML(xmlStr);
	return xmlDoc;
}

/**
 * 弹出模态窗口
 * @param String URL
 * @param String name
 * @param String height
 * @param String width
 * @return
 */
function showModalPopup(URL, name, height, width) {
	var properties = "resizable=no;center=yes;help=no;status=no;scroll=no;dialogHeight = " + height;
	properties = properties + ";dialogWidth=" + width;
	var leftprop, topprop, screenX, screenY, cursorX, cursorY, padAmt;
	screenY = document.body.offsetHeight;
	screenX = window.screen.availWidth;

	leftvar = (screenX - width) / 2;
	rightvar = (screenY - height) / 2;
	leftprop = leftvar;
	topprop = rightvar;

	properties = properties + ", dialogLeft = " + leftprop;
	properties = properties + ", dialogTop = " + topprop;

	return window.showModalDialog(URL,name,properties);
}
/**
 * 判断是否包含特殊字符
 * @param String value
 * @return boolean
 */
function common_strInvalid(str){
	var patrn = /[\"\'<>``!@#$%^&*+\/\/\/\\//?,.]/;   //这里禁止<和>的输入
	if (patrn.exec(str)){
		return true;
	}
	return false;
}
/**
 * 判断是否包含特殊字符
 * @param String value
 * @param String specialChar 要过滤的特殊字符
 * @return boolean
 */
function common_specialChar(value, specialChar){
	var patrn = specialChar;   //这里禁止<和>的输入
	if (patrn.exec(value)){
		return true;
	}
	return false;
}
/**
* 判断是否大于当前系统日期
* param Date date
* return boolean
*/
function compareDateWithSysDate(date){
	/*
	var oneMonth = dataStr.substring(5,dataStr.lastIndexOf ("-"));
	var oneDay = dataStr.substring(dataStr.length,dataStr.lastIndexOf ("-")+1);
	var oneYear = dataStr.substring(0,dataStr.indexOf ("-"));

	var oneDate = Date.parse(oneMonth+"/"+oneDay+"/"+oneYear);
	*/
	if (date > new Date().getTime()){
		return true;
	}else{
		return false;
	}
}
/**
* 判断文件是否存在
* param String filespec 文件路径
* return boolean
*/
function common_fileExists(filespec){
	var result = false;
	var fso = new ActiveXObject("Scripting.FileSystemObject"); 
	if(fso.FileExists(filespec)){
		result = true;
	}else{
		result = false;
	}
	return result; 
}
