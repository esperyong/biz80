String.prototype.trim = function(){

    return this.replace(/(^\s*)|(\s*$)/g, "");
}

function alltotrim(formname){
	for (var i = 0; i < formname.elements.length; i++) {
           if(formname.elements[i].type == "text"){
			formname.elements[i].value=formname.elements[i].value.trim();
		   }
	}
}

function checktextareaMaxLength(field,maxlength){
	if (field.value.length > maxlength){
		field.value = field.value.substring(0, maxlength);

	}
}

function checkChinese(field,prompt,path){
	var s=field.value;
	for(i=0;i<s.length;i++){
		if(s.charCodeAt(i)>255){
			//alert(prompt);
			openModalWindowLong(path,prompt);
			field.focus();
			return false;
		}
	}
	return true;
}
function checkChinese2(field,prompt,path){
	var s=field.value;
	for(i=0;i<s.length;i++){
		if(s.charCodeAt(i)>255){
			//alert(prompt);
			openModalWindowLong(path,prompt);
			return false;
		}
	}
	return true;
}
function checkNullField(field,prompt,path){
   if(field.value.trim()==""){
      //alert(prompt);
      openModalWindowLong(path,prompt);
      //field.focus();
      return false;
   }else{
       return true;
    }
 }
function checkNullField2(field,prompt,path){
   if(field.value.trim()==""){
      //alert(prompt);
      openModalWindowLong(path,prompt);
    	return false;
   }else{
       return true;
    }
 }

 function checklength(field,prompt,num,path){
   if(field.value.trim().length > num){
      	//alert(prompt);
      openModalWindowLong(path,prompt);
      	field.focus();
		return false;
   }else{
       return true;
    }
 }
function checkMaxLength(Field, prompt, MaxValue,path){
	  var j=0;
	 //alert(Field);
     if (Field.value.trim()!=null&&Field.value.trim().length>0){
     	for(var i=0;i<Field.value.trim().length;i++){
     		if(Field.value.charCodeAt(i)>255){
     			j+=2;
     		}else{
     			j++;
     		}
     	}
     	if(j>MaxValue){
     		//alert(prompt);
      openModalWindowLong(path,prompt);
    		//Field.focus();
     		return false;
     	}
     return true;
   	}
   return true;
}
function checktextareaMaxLength2(field,maxlength){
	var j=0;
     if (field.value.trim()!=null&&field.value.trim().length>0){
     	for(var i=0;i<field.value.trim().length;i++){
     		if(field.value.charCodeAt(i)>255){
     			j+=2;
     		}else{
     			j++;
     		}
     	}
     	if(j>maxlength){
     		field.value = field.value.substring(0, maxlength);
     		return false;
     	}
     return true;
   	}
   return true;
}
function checkLawlessChar(field,prompt,path){
    var srcStr = "[&#<>()%'/*\\\\:?|;\"\^]";
   var v=field.value.match(srcStr);
   if(v !=null){
       //alert(prompt);
      openModalWindowLong(path,prompt);
       //field.focus();
       return false;
   }
   else{
	return true;
   }
 }
 function checkLawlessChar3(field,prompt,path){
    var srcStr = "[&#<>%'*\\\\:?|;\"\^]";
   var v=field.value.match(srcStr);
   if(v !=null){
       //alert(prompt);
      openModalWindowLong(path,prompt);
       field.focus();
       return false;
   }
   else{
	return true;
   }
 }
function checkLawlessChar2(field,prompt,path){
    var srcStr = "[&#<>()%'*/\\\\:?|;\"\^]";
   var v=field.value.match(srcStr);
   if(v !=null){
       //alert(prompt);
      openModalWindowLong(path,prompt);
      return false;
   }
   else{
	return true;
   }
 }
function checkSpace(field,prompt,path){
    var srcStr = "[ ]";
   var v=field.value.match(srcStr);
   if(v !=null){
       //alert(prompt);
      openModalWindowLong(path,prompt);
       field.focus();
       return false;
   }
   else{
	return true;
   }
 }

function checkint(e) {
  if ((e.keyCode>=48) && (e.keyCode<=57))
    return true;
  else
    return false;
}

function CheckInteger(Field,prompt,path){
   if (Field.value.trim() != ""){
       for (i = 0; i < Field.value.trim().length; i++){
           ch = Field.value.trim().charAt(i);
           if(i==0){
           	if ( (ch < '1' || ch > '9')  ) {
              	//alert(prompt);
      openModalWindowLong(path,prompt);
                //Field.value="";
                Field.focus();
                return	false;
            }
           }else{
           		if ( (ch < '0' || ch > '9')  ) {
               		//alert(prompt);
      openModalWindowLong(path,prompt);
                	//Field.value="";
               		 Field.focus();
                	return	false;
           	 	}
            }
       }
   }
    return true;
 }
function CheckInteger2(Field,prompt,path){
   if (Field.value != ""){
       for (i = 0; i < Field.value.length; i++){
           ch = Field.value.charAt(i);
           if(i==0){
           	if ( (ch < '1' || ch > '9')  ) {
               //alert(prompt);
      openModalWindowLong(path,prompt);
                return	false;
            }
           }else{
           		if ( (ch < '0' || ch > '9')  ) {
               		//alert(prompt);
      openModalWindowLong(path,prompt);
               		return	false;
           	 	}
            }
       }
   }
    return true;
 }
function CheckInteger3(Field,prompt,path){
   if (Field.value != ""){
   	var state = false;
       for (i = 0; i < Field.value.length; i++){
           ch = Field.value.charAt(i);
           if(i==0){

	            if (ch == '0') {
	            	state = true;
	            } else {
	            	if ( (ch < '1' || ch > '9')  ) {
		              	//alert(prompt);
		      			openModalWindowLong(path,prompt);
		                //Field.value="";
		                Field.focus();
		                return	false;
	            	}
	            }
           }else{

           	 	if (state) {
           	 		openModalWindowLong(path,prompt);
                	//Field.value="";
               		Field.focus();
                	return	false;
           	 	} else {
           	 		if ( (ch < '0' || ch > '9') ) {
               			//alert(prompt);
	      				openModalWindowLong(path,prompt);
	                	//Field.value="";
	               		Field.focus();
	                	return	false;
           	 		}
           	 	}
            }
       }
   }
    return true;
 }

function CheckInteger65535(Field,prompt,path){
   if (Field.value != ""){
	   	if (Field.value > 65535) {
	   		openModalWindowLong(path,prompt);
            Field.focus();
            return	false;
	   	}
   }
    return true;
 }

function checkLawlessCharFormat(field,prompt,path){

	if (isNaN(field.value)) {
	 	 openModalWindowLong(path,prompt);
      	 return false;
	}
	return true;
}
function checkNumFormat(field,prompt,path){

	if((field.value).indexOf(".")!=-1){
		if((field.value).substring((field.value).indexOf(".")+1,(field.value).length).length>2){
			openModalWindowLong(path,prompt);
			return false;
		}
	}
	return true;
}
function checkNum(field,prompt,path){
	var nonnumeric = /[^0-9^:]/;
	v = field.value.match(nonnumeric);
	if ((field.value != "") && (v != null)) {
	 //alert(prompt);
     openModalWindowLong(path,prompt);
	 field.value = "";
  	 field.focus();
  	 return false;
	}
	return true;
}

function checkNum2(field,prompt,path){
	var nonnumeric = /[^0-9^:]/;
	v = field.value.match(nonnumeric);
	if ((field.value != "") && (v != null)) {
	 //alert(prompt);
      openModalWindowLong(path,prompt);
  	 return false;
	}
	return true;
}

/*?????????0*/
function delFrontZero(field){
	var tempString = field.value;
	if (null != tempString && tempString.length > 0) {
		for (i = 0; i < tempString.length; i++) {
			if (tempString.indexOf("0") == 0) {
				tempString = tempString.substring(1,tempString.length);
				i--;
			}
		}
	}
	if(tempString.length == 0) {
		tempString = "0";
	}
	return tempString;
}

function checkNumField(mItem,prompt,path){
	var nonnumeric = /[^0-9]/;
	var v = mItem.value.match(nonnumeric);
	if ((mItem.value != "") && (v != null)) {
	    	//alert(prompt);
      openModalWindowLong(path,prompt);
  		mItem.focus();
  	  	return false;
       }
     return true;
}
function checkNumField2(mItem,prompt,path){
	var nonnumeric = /[^0-9]/;
	var v = mItem.value.match(nonnumeric);
	if ((mItem.value != "") && (v != null)) {
	    //alert(prompt);
      openModalWindowLong(path,prompt);

  	  	return false;
       }
     return true;
}
function isIP(Field,prompt, path) {
	 var strIP = Field.value;
	 var re=/^(\d+)\.(\d+)\.(\d+)\.(\d+)$/g //匹配IP地址的正则表达式
	 if(re.test(strIP)&&(RegExp.$1 <256 && RegExp.$2<256 && RegExp.$3<256 && RegExp.$4<256))
	 {
	 return true;
	 }

	 openModalWindowLong(path,prompt);
	 // alert(prompt);
	 Field.focus();
	 return false;
}
function checkEmail(Field,prompt,path){

   var i = 1;
   var len = Field.value.length;

   pos1 = Field.value.indexOf("@");
   pos2 = Field.value.indexOf(".");
   pos3 = Field.value.lastIndexOf("@");
   pos4 = Field.value.lastIndexOf(".");

   if ((pos1 <= 0)||(pos1 == len-1)||(pos2 <= 0)||(pos2 == len-1)){
       //alert(prompt);
      openModalWindowLong(path,prompt);
       Field.focus();
       return false;
   }
   else{

       if( (pos1 == pos2 - 1) || (pos1 == pos2 + 1)
          || ( pos1 != pos3 )
          || ( pos4 < pos3 ) )
       {
           //alert(prompt);
      openModalWindowLong(path,prompt);
           Field.focus();
           return false;
        }
   }
   return true;
}
function CheckEmail2(Field,prompt,path){

   var i = 1;
   var len = Field.value.length;

   pos1 = Field.value.indexOf("@");
   pos2 = Field.value.indexOf(".");
   pos3 = Field.value.lastIndexOf("@");
   pos4 = Field.value.lastIndexOf(".");

   if ((pos1 <= 0)||(pos1 == len-1)||(pos2 <= 0)||(pos2 == len-1)){
       //alert(prompt);
      openModalWindowLong(path,prompt);
       return false;
   }
   else{

       if( (pos1 == pos2 - 1) || (pos1 == pos2 + 1)
          || ( pos1 != pos3 )
          || ( pos4 < pos3 ) )
       {
           //alert(prompt);
      openModalWindowLong(path,prompt);
          return false;
        }
   }
   return true;
}

/**�?查数据范�?-system*/
function checkMidValue(field,MaxValue,MinValue,prompt,path){
	if (parseInt(field.value) > parseInt(MaxValue) || parseInt(field.value) < parseInt(MinValue)){
		openModalWindowLong(path,prompt);
		//field.value="";
		field.focus();
		return false;
	}
	return true;
}
/**�?查数据长�?-system*/
function checkLength2(field, MaxValue,prompt,path){
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
		openModalWindowLong(path,prompt);
		return false;
	}
	return true;
	}
	return true;
}

/**
* @creator dinglb
* @lastUpdate 06-03-10
* @desc 主要是存放表单校验的函数，如果需要增加和修改都需要做好记录，并�?�知相应的负责人，同时更新api手册
* @history 03-10 firstCreate
*
*/


/**
*@param field �?要校验的域，传�?�的是对�?
*@param message 校验失败是否有提示信息，如果没有传�?�message,就没有提示信�?
*/
function isEmpty(field,message){
	if(field.value.trim()==""){
		if(message) showAlert(message);
		field.focus();
		return false;
	}
		return true;
}

///**
//*@desc 校验域的内容是否超长
//*@param field �?要校验的域，传�?�的是对�?
//*@param length 域的�?大长度（字节长度�?
//*@param message 校验失败是否有提示信息，如果没有传�?�message,就没有提示信�?
//*/
//function checkLength(field,length,message){
//	if(field.value.lengthW()>length){
//		if(message) showAlert(message);
//		field.focus();
//		return false;
//	}
//		return true;
//}

/**
*@desc 生成具体的一个连接地�?
*@param id 域id
*@param url 连接地址
*/
 function createLink(id,url){
     var test1 = /[d]-.*-[s]/;
     var test2 = /[d]-.*-[o]/;
     var test3 = /[d]-.*-[st]/;
     var newUrl;
     if(typeof(url) != "undefined" && url != null) {
     	var start = url.indexOf(".action?");
     	if(start != -1){
     	    newUrl = url.substring(0,start+8);
     		var parameter = url.substring(start+8,url.length);
     		var parameters = parameter.split('&');
     		for(var i=0; i<parameters.length; i++){
     			var namevalue = parameters[i].split('=');
     			//alert(parameters[i]);
     			if(namevalue != null && namevalue.length > 1){
     				if(!(test1.test(namevalue[0])||test2.test(namevalue[0])||test3.test(namevalue[0]))){
     				    newUrl = newUrl + parameters[i];
     				    if(i < parameters.length-1){
	     					newUrl = newUrl + '&';
	     				}
     				}
     			}
     		}
     	}else{
     		newUrl = url;
     	}
     }
     document.all[id].style.cursor="hand";
     document.all[id].title=document.all[id].tag
     if("a"==document.all[id].tagName.toLowerCase()){
      document.all[id].href=newUrl;
     }else{
    document.all[id].onclick=new Function('window.location.replace(\''+newUrl+'\')');
			}
 }
//将数字前的0去掉
function formatNumber(obj){
	 /*只能输入数字判断*/
	 //var nonnumeric = /[^0-9^:]/;
	 //v = obj.value.match(nonnumeric);
	 //if ((obj.value != "") && (v != null)) {
	 // 	alert("只能输入数字。");
	 //   obj.focus();
	 //   return false;
	 //}
	 var tempString = obj.value;
	 if (null != tempString && tempString.length > 0) {
	  for (i = 0; i < tempString.length; i++) {
		  if (tempString.indexOf("0") == 0) {
		    tempString = tempString.substring(1,tempString.length);
		    i--;
		  }
	  }
	 }
	 if (tempString == "") {
	  tempString = "0";
	 }
	 obj.value = tempString;
	 //return true;
}


/**
*@desc 用于翻页的调�?
*@param per_page_num 每页显示多少�?
*/
    function generNavigation(per_page_num)
    {
     //左边的信�?


     if(document.all._oneitem || document.all._allitems){
     	document.all.total_page.innerText=1;
     	document.all.cur_page.innerText=1;
     }
      if(document.all._someitem){
      var pages=document.all._someitem.innerText.split("|");
      var total=pages[0];
      var cur=pages[1];
      total=total.replace(',',''); //防止里面的科学技术法中的逗号，形式如�?1,100
      cur=cur.replace(',','');
      document.all.total_page.innerText=Math.ceil(total/per_page_num);
      document.all.cur_page.innerText=cur;

     }

     //导航信息
     if(document.all._full){
	 var pages=document.all._full.innerText.split("|");
	createLink("list_home",pages[0]);
	createLink("list_pre",pages[1]);
	createLink("list_next",pages[2]);
	createLink("list_end",pages[3]);
     }

   if(document.all._first){
	 var pages=document.all._first.innerText.split("|");
	createLink("list_next",pages[0]);
	createLink("list_end",pages[1]);
     }

  if(document.all._last){
	 var pages=document.all._last.innerText.split("|");
	createLink("list_home",pages[0]);
	createLink("list_pre",pages[1]);
     }

  }


/**
 * 根据key值打�?短模式窗�?
 * path:路径;
 * prompt:提示窗口信息;
 */
function openModalWindowShort(path,promt){
	var jspPathName = path+"/modules/common/alertWindow.jsp";
	return openModalWindow(jspPathName, 'shortAlert',promt,'','227','145','');
}

/**
 * 对弹出信息进行编码打�?短模式窗�?
 * path:路径;
 * promptCoding:提示窗口信息;
 */
function openModalWindowShortCoding(path,promptCoding){
	var jspPathName = path+"/modules/common/alertWindow.jsp";
	return openModalWindow(jspPathName, 'shortAlert','','','227','145',promptCoding);
}

/**
 * 根据key值打�?长模式窗�?
 * path:路径;
 * prompt:提示窗口信息;
 */
function openModalWindowLong(path,promt){
	var jspPathName = path+"/modules/common/alertWindow.jsp";
	return openModalWindow(jspPathName, 'longAlert',promt,'','419','159','');
}

/**
 * 对弹出信息进行编码打�?长模式窗�?
 * path:路径;
 * promptCoding:提示窗口信息;
 */
function openModalWindowLongCoding(path,promptCoding){
	var jspPathName = path+"/modules/common/alertWindow.jsp";
	return openModalWindow(jspPathName, 'longAlert','','','419','159',promptCoding);
}

/**
 * 根据key值打�?（是否）模式窗口
 * path:路径;
 * prompt:提示窗口信息;
 */
function openModalWindowYesOrNo(path,promt){
	var jspPathName = path+"/modules/common/alertWindow.jsp";
	return openModalWindow(jspPathName, 'yesOrNo',promt,'','419','159','');
}

/**
 * 对弹出信息进行编码打�?（是否）模式窗口
 * path:路径;
 * promptCoding:提示窗口信息;
 */
function openModalWindowYesOrNoCoding(path,promptCoding){
	var jspPathName = path+"/modules/common/alertWindow.jsp";
	return openModalWindow(jspPathName, 'yesOrNo','','','419','159',promptCoding);
}


/**
 * 打开模式窗口.
 * jspPathName:弹出页面的路径和名称
 * promptType:提示窗口类别;
 * prompt:提示窗口信息;
 * scriptCmd:javascript命令�?(�?:在命令行前加window.dialogArguments);
 * promptCoding:�?要编码的提示信息
 * 提示窗口大小规定为三�?197,139;419,139;419,139;
 * */
function openModalWindow(jspPathName,promptType,prompt,scriptCmd,width,height,promptCoding){
	//alert(promptCoding);
	if(isIE7Version()){
		width = width - 4;
		height = height - 4 - 20;
	}
	return window.showModalDialog(jspPathName+'?promptCoding='+promptCoding+'&promptType='+promptType+'&prompt='+prompt+'&scriptCmd='+scriptCmd+'',window,'dialogWidth:'+width+'px;dialogHeight:'+height+'px;help:no;center:yes;resizable:no;status:no;scroll:no');
}

/**
 * 检查是否为数字
 */
function onlyNum()
{
	if(!((event.keyCode>=48&&event.keyCode<=57)||(event.keyCode>=96&&event.keyCode<=105)||(event.keyCode==8)))
		event.returnValue=false;
}

/**
 * 屏蔽非法的跳转页码输入
 */
function checkPageNum(obj) {
	var val = obj.value;
	var len = val.length;
	for(var i = 0; i<len; i++){
		if((val.charAt(i)>'9') || (val.charAt(i) < '0')){
			obj.value = val.substring(0, i);
			break;
		}
	}
	if(window.event.keyCode == 13){
		goPage();
	}
}

function isIE7Version()
{
 var return_version;
 var browser=navigator.appName
 var b_version=navigator.appVersion
 var version=b_version.split(";");
 var trim_Version=version[1].replace(/[ ]/g,"");
 if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE7.0")
 {
  return true;
 }
 return false;
}
