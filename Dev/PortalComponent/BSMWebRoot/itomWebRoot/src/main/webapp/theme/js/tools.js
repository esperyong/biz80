/**
* @creator dinglb
* @lastUpdate 06-03-10
* @desc 主要是存放js相关的工具类的函数，如果需要增加和修改都需要做好记录，并通知相应的负责人,同时更新api手册
* @history 03-10 firstCreate
*
*/

//start 定义整个应用的全局变量,在所有的子页面中不允许定义与以下变量名重复，防止覆盖。

//_webPath="/mochaitam"; //定义网站的应用访问路径

var _path=window.location.pathname;

	_path=_path.substring(0,_path.indexOf('/',1));
	
	
	if(_path.indexOf('/')!=0)  //可能获取到的路径不带有/，需要强制的增加/
	   _path="/"+_path;
 
_webPath=window.location.protocol+"//"+window.location.host+_path //定义网站的应用访问路径


_inforPath="/jsp/comm/infor.jsp"; //定义模态窗口的路径

var _param; //定义传递用的数组

var _curwin;//定义当前被打开的窗口

//end 定义整个应用的全局变量

function setFocus(){
	var inputs = document.body.getElementsByTagName("input");
	for(var i=0;i<inputs.length;i++){
		var input = inputs[i];
		try{
		//使焦点在每页的第一个文本输入框上
		 if(input.type == "text" && i==0){
				input.focus();
				//break;
		 }
		 if(input.type != "checkbox" && input.type != "radio"){
		    input.className="input";
		 }
		
		}catch(e){
		}
	}
}

//取得 页面中 对象的X坐标
 function   GetDefineX(ObjectID)   
  {   
	  var   iPositionX=ObjectID.offsetLeft;   
	  while(ObjectID=ObjectID.offsetParent)   
	  {   
	  iPositionX+=ObjectID.offsetLeft;   
	  }   
	  return   iPositionX;   
  } 
  
//取得 页面中 对象的Y坐标    
  function   GetDefineY(ObjectID)   
  {   
	  var   iPositionY=ObjectID.offsetTop;   
	  while(ObjectID=ObjectID.offsetParent)   
	  {   
	        iPositionY+=ObjectID.offsetTop;   
	  }   
	  return   iPositionY;   
  } 

function selectDept(name,id){
 showModalWin(_webPath+"/department.action?_ACTION=_SELECT&name="+name+"&id="+id,"340px","395px");
 //window.open(_webPath+"/department.action?_ACTION=_SELECT&name="+name+"&id="+id,"","toolbar=no,scrollbars=no,resizable=yes,width=350,height=370,left=400,top=200");
} 

//打开模式对话框
function showModalWin(url,width,height) 
{
	var winWidth=screen.availWidth/2 - width/2;
	var winHeight=screen.availHeight/2 - height/2;
    strFeatures="dialogWidth="+width+";dialogHeight="+height+";dialogTop:"+winHeight+";dialogLeft:"+winWidth+";help=no;status=no;scroll=yes";    
     var url,strReturn; 
           
      if(url.indexOf("?")==-1){
       url+="?time="+getCurTime()+Math.random()
       }else{
        url+="&time="+getCurTime()+Math.random()
       }
  	   
      strReturn=window.showModalDialog(url,window,strFeatures); 
       return strReturn;
}

//全屏幕打开 IE 窗口
function openFullWin(url,title){

	var newwindow = window.open(url,title,"toolbar=no,scrollbars=yes,resizable=yes,center:yes,statusbars=yes");
	newwindow.focus();
	if(!newwindow.closed)
	{
	  newwindow.moveTo(0,0)
      newwindow.resizeTo(screen.availWidth, screen.availHeight)
    }
    
    return newwindow;
}

function openWin(url,title,width,height){
	showx = screen.availWidth / 2 - width / 2;
	showy = screen.availHeight / 2 - height / 2; 
	_curwin=window.open(url,title,"toolbar=no,width="+ width  +",height="+ height  +", top=" + showy +" left=" + showx + " center=yes,middle=yes,scrollbars=yes,resizable=no,center=yes,statusbars=yes");
	
	return _curwin;
}

//选择日期
	 function selectDate(ctrlobj)
{	
		if(ctrlobj.disabled){
			return false;
		}
		//ctrlobj.value="";
	 	showx = event.screenX - event.offsetX - 4 - 110 ;
	 	showy = event.screenY - event.offsetY + 18; 
	 	newWINwidth = 210 + 4 + 18;
	        tt1="px;help:no; status:no; directories:yes;scrollbars:no;Resizable=no;"  
	        tt2="dialogWidth:210px; dialogHeight:210px; dialogLeft:"
		 retval = window.showModalDialog(_dateUrlPath, "", tt2+showx+"px; dialogTop:"+showy+tt1);
	 	if( retval != null ){
	  		ctrlobj.value = retval;
		 }
  	}

//弹出显示消息的模态窗口
function showAlert(msg,funName){
 _param=new Array()	

 _param[0]=msg; 
 _param[1]=0; 
 if(funName) _param[2]=funName;

return showModalWin(_webPath+_inforPath,"300px","250px");
}

//显示License信息
function showAlertLicense(msg,funName){
 _param=new Array()	

 _param[0]=msg; 
 _param[1]=0; 
 if(funName) _param[2]=funName;

return showModalWin(_webPath+_inforPath+"?license=error","450px","260px");
}

//弹出error窗口
function showError(msg,funName){

 _param=new Array()	
 _param[0]=msg; 
 _param[1]=1;
  if(funName) _param[2]=funName;
 
return showModalWin(_webPath+_inforPath,"300px","250px");

}

//弹出confirm窗口

function showConfirm(msg,funName){
 _param=new Array()	
 _param[0]=msg; 
 _param[1]=2;
  if(funName) _param[2]=funName;
return showModalWin(_webPath+_inforPath,"300px","250px");
}

//刷新父窗口，当前页面是通过模态窗口打开的
function refreshOpener(){
	var parentWin=window.dialogArguments
	window.close();
	parentWin.location.href=parentWin.location.href;
}

//刷新父窗口，当前页面是通过模态窗口打开的(---专门提供给报告模块使用---)
function refreshReportOpener(actiontype, type){
	var parentWin=window.dialogArguments;
	var t_href = parentWin.location.href;
	if (t_href.indexOf("&type") == -1){
		parentWin.location.href= t_href + "?actiontype=" + actiontype + "&type=" + type;
	} else {
		parentWin.location.href=parentWin.location.href;
	}
	
	window.close();
}


//通过xmlhttp不刷新页面的到该页面的返回值
function getResonseFromUrl(url){

	var xmlhttp=false;
	 try {
	  xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
	 } catch (e) {
	  try {
	   xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	  } catch (e) {
	   xmlhttp = false;
	  }
	 }
	
	if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
	  xmlhttp = new XMLHttpRequest();
	}

 		if(url.indexOf("?")==-1){
     	  url+="?time="+getCurTime()+Math.random()
       }else{
        url+="&time="+getCurTime()+Math.random()
       }

	 xmlhttp.open("GET",url,false);
	 xmlhttp.SetRequestHeader ("Content-Type","text/xml; charset=utf-8"); 
	 xmlhttp.send(null);
	 
	 
	 if (xmlhttp.readyState==4) {
 		return xmlhttp.responseText	 
 	 }

	return null;
}

//通过xmlhttp不刷新页面的到该页面的返回值
function getXMLResonseFromUrl(url){

	var xmlhttp=false;
	 try {
	  xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
	 } catch (e) {
	  try {
	   xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	  } catch (e) {
	   xmlhttp = false;
	  }
	 }
	
	if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
	  xmlhttp = new XMLHttpRequest();
	}

 		if(url.indexOf("?")==-1){
     	  url+="?time="+getCurTime()+Math.random()
       }else{
        url+="&time="+getCurTime()+Math.random()
       }

	 xmlhttp.open("GET",url,false);
	 xmlhttp.SetRequestHeader ("Content-Type","text/xml; charset=utf-8"); 
	 xmlhttp.send(null);
	 
	 
	 if (xmlhttp.readyState==4) {
 		return xmlhttp.responseXML;	 
 	 }

	return null;
}
//

/*
===========================================
*页面里回车到下一控件的焦点
*调用方式 document.onkeydown = Enter2Tab;
===========================================
*/
function Enter2Tab()
{
	var e = document.activeElement;
	if(e.tagName == "INPUT" &&(
	e.type == "text"     ||
	e.type == "password" ||
	e.type == "checkbox" ||
	e.type == "radio"
	)   ||
	e.tagName == "SELECT")

	{
	if(window.event.keyCode == 13) window.event.keyCode = 9;

	}
}



/*
******************************************
字符串函数扩充 
******************************************
*/

/*
===========================================
//去除左边的空格
===========================================

*/
String.prototype.ltrim = function()
{
return this.replace(/(^\s*)/g, "");
}




/*
===========================================
//去除右边的空格
===========================================
*/
String.prototype.rtrim = function()
{
return this.replace(/(\s*$)/g, "");
}

 

/*
===========================================
//去除前后空格
===========================================
*/
String.prototype.trim = function()
{
return this.replace(/(^\s*)|(\s*$)/g, "");
}

/*
//去掉所有的空格
*/
String.prototype.trimall = function()
{
return this.replace(/(\s*)/g, "");
}

/*
===========================================
//得到左边的字符串
===========================================
*/
String.prototype.left = function(len)
{

if(isNaN(len)||len==null)
{
len = this.length;
}
else
{
if(parseInt(len)<0||parseInt(len)>this.length)
{
len = this.length;
}
}

return this.substring(0,len);
}


/*
===========================================
//得到右边的字符串
===========================================
*/
String.prototype.right = function(len)
{

if(isNaN(len)||len==null)
{
len = this.length;
}
else
{
if(parseInt(len)<0||parseInt(len)>this.length)
{
len = this.length;
}
}

return this.substring(this.length-len,this.length);
}


/*
===========================================
//得到中间的字符串,注意从0开始
===========================================
*/
String.prototype.mid = function(start,len)
{
if(isNaN(start)||start==null)
{
start = 0;
}
else
{
if(parseInt(start)<0)
{
start = 0;
}
}

if(isNaN(len)||len==null)
{
len = this.length;
}
else
{
if(parseInt(len)<0)
{
len = this.length;
}
}

return this.substring(start,start+len);
}


/*
===========================================
//在字符串里查找另一字符串:位置从0开始
===========================================
*/
String.prototype.inStr = function(str)
{

if(str==null)
{
str = "";
}

return this.indexOf(str);
}

/*
===========================================
//在字符串里反向查找另一字符串:位置0开始
===========================================
*/
String.prototype.inStrRev = function(str)
{

if(str==null)
{
str = "";
}

return this.lastIndexOf(str);
}

 

/*
===========================================
//计算字符串打印长度
===========================================
*/
String.prototype.lengthW = function()
{
return this.replace(/[^\x00-\xff]/g,"**").length;
}

/*
===========================================
//是否是正确的IP地址
===========================================
*/
String.prototype.isIP = function()
{

var reSpaceCheck = /^(\d+)\.(\d+)\.(\d+)\.(\d+)$/;

if (reSpaceCheck.test(this))
{
this.match(reSpaceCheck);
if (RegExp.$1 <= 255 && RegExp.$1 >= 0 
 && RegExp.$2 <= 255 && RegExp.$2 >= 0 
 && RegExp.$3 <= 255 && RegExp.$3 >= 0 
 && RegExp.$4 <= 255 && RegExp.$4 >= 0) 
{
return true;     
}
else
{
return false;
}
}
else
{
return false;
}
   
}

/*
===========================================
//是否是正确的网段地址
===========================================
*/
String.prototype.isSubnet = function()
{

var reSpaceCheck = /^(\d+)\.(\d+)\.(\d+)$/;

if (reSpaceCheck.test(this))
{
this.match(reSpaceCheck);
if (RegExp.$1 <= 255 && RegExp.$1 >= 0 
 && RegExp.$2 <= 255 && RegExp.$2 >= 0 
 && RegExp.$3 <= 255 && RegExp.$3 >= 0) 
{
return true;     
}
else
{
return false;
}
}
else
{
return false;
}
   
}


/*
===========================================
//检查是否是小数或整数
===========================================
*/
String.prototype.isDecimal = function()
{
var reSpaceCheck
if(this.indexOf(".")>-1)
 reSpaceCheck = /^\d+\.+\d+$/;
 else
reSpaceCheck = /^\d+$/;

return reSpaceCheck.test(this)
   
}

/*
===========================================
//检查是否是整数
===========================================
*/
String.prototype.isInteger = function()
{
  var reSpaceCheck = /^\d+$/;
  return reSpaceCheck.test(this)  
}

//检查是否包含特殊字符
String.prototype.hasSpecChar=function(){
//var reSpaceCheck = /['"%()/\\:?<>|#*]/ ;
//var reSpaceCheck = /['"%()/\\:?<>|#*【『：？÷§“‘』《～·◎＃￥％……※×（）＄＾＆》】]/
var reSpaceCheck = /['"%()/\\:?<>|#*]/
return reSpaceCheck.test(this);
}

//检查是否包含特殊字符,比上一方法多验证了中文，英文空格
String.prototype.hasSpecChar1=function(){
//var reSpaceCheck = /['"%()/\\:?<>|#*]/ ;
//var reSpaceCheck = /['"%()/\\:?<>|#*【『：？÷§“‘』《～·◎＃￥％……※×（）＄＾＆》】\s]/
var reSpaceCheck = /['"%()/\\:?<>|#*\s]/
return reSpaceCheck.test(this);
}

//检查是否包含特殊字符,比第上一方法少验证'\'
String.prototype.hasSpecChar2=function(){
//var reSpaceCheck = /['"%()/\\:?<>|#*]/ ;
//var reSpaceCheck = /['"%()/\\:?<>|#*【『：？÷§“‘』《～·◎＃￥％……※×（）＄＾＆》】]/
var reSpaceCheck = /['"%()/:?<>|#*]/
return reSpaceCheck.test(this);
}

//检查是否包含特殊字符,比第上一方法少验证'/'
String.prototype.hasSpecChar3=function(){
var reSpaceCheck = /['"%()\\:?<>|#*]/
return reSpaceCheck.test(this);
}

//检查输入的字符是否只是英文或数字,如果包含除英文或数字外的其他字符则返回true
String.prototype.hasSpecCharPortal=function(){

var reSpaceCheck = /^[A-Za-z0-9]+$/
return !reSpaceCheck.test(this);
}

//用于校验系统管理-配置信息维护-域管理员账号
String.prototype.hasSpecCharDomain=function(){

var reSpaceCheck = /^[A-Za-z0-9 _ - ( )]+$/
return !reSpaceCheck.test(this);
}

/*
===========================================
//是否是正确的长日期
===========================================
*/
String.prototype.isDate = function()
{
var r = this.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/); 
if(r==null)
{
return false; 
}
var d = new Date(r[1], r[3]-1,r[4],r[5],r[6],r[7]); 
return (d.getFullYear()==r[1]&&(d.getMonth()+1)==r[3]&&d.getDate()==r[4]&&d.getHours()==r[5]&&d.getMinutes()==r[6]&&d.getSeconds()==r[7]);

}

/*
===========================================
//是否是手机
===========================================
*/
String.prototype.isMobile = function()
{
return /^0{0,1}13[0-9]{9}$/.test(this);
}
String.prototype.isTel =function()
{
	return /((^((\d){3,4}(\-)?)?(\d){7,8}$)|(^[1][3](\d){9,}$))|^[d]{1,}(\-)?(\d)$/.test(this);
}
/*
===========================================
//是否是邮件
===========================================
*/
String.prototype.isEmail = function()
{
return /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/.test(this);
}

//是否是portal需要的邮件地址，开头不能为数字
String.prototype.isPEmail = function()
{
return /^\D\w*((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/.test(this);
}

/*
===========================================
//是否是有汉字
===========================================
*/
String.prototype.existChinese = function()
{
//[\u4E00-\u9FA5]為漢字﹐[\uFE30-\uFFA0]為全角符號
return ! /^[\x00-\xff]*$/.test(this);
}

/*
===========================================
//是否是合法的文件名/目录名
===========================================
*/
String.prototype.isFileName = function()
{
return !/[\\\/\*\?\|:"<>]/g.test(this);
}

/*
===========================================
//是否是数字
===========================================
*/
String.prototype.isNumeric = function(flag)
{
//验证是否是数字
if(isNaN(this))
{

return false;
}

switch(flag)
{

case null://数字
case "":
return true;
case "+"://正数
return/(^\+?|^\d?)\d*\.?\d+$/.test(this);
case "-"://负数
return/^-\d*\.?\d+$/.test(this);
case "i"://整数
return/(^-?|^\+?|\d)\d+$/.test(this);
case "+i"://0和正整数
return/(^\d+$)|(^\+?\d+$)/.test(this);
case "++i"://正整数
//return/(^[1-9]+$)/.test(this);
return/(^[1-9][0-9]*$)/.test(this);
case "-i"://负整数
return/^[-]\d+$/.test(this);
case "f"://浮点数
return/(^-?|^\+?|^\d?)\d*\.\d+$/.test(this);
case "+f"://正浮点数
return/(^\+?|^\d?)\d*\.\d+$/.test(this);
case "-f"://负浮点数
return/^[-]\d*\.\d$/.test(this);
case "+z"://0-100的正整数
return /(^\d{1,2}$)|(^100$)/.test(this);
default://缺省
return true;
}
}

/*
===========================================
//转换成全角
===========================================
*/
String.prototype.toCase = function()
{
var tmp = "";
for(var i=0;i<this.length;i++)
{
if(this.charCodeAt(i)>0&&this.charCodeAt(i)<255)
{
tmp += String.fromCharCode(this.charCodeAt(i)+65248);
}
else
{
tmp += String.fromCharCode(this.charCodeAt(i));
}
}
return tmp
}

//'*********************************************************
// ' Purpose: 判断输入是否含有空格
// ' Inputs:   String
// ' Returns:  True, False
//'*********************************************************
function checkblank(str)
{
var strlength;
var k;
var ch;
strlength=str.length;
for(k=0;k<=strlength;k++)
  {
     ch=str.substring(k,k+1);
     if(ch==" ")
      {
      alert("对不起　不能输入空格　");  
      return false;
      }
  }
return true;
}
//'*********************************************************


function getCurTime(){
var  now  =  new  Date()
var  hours  =  now.getHours()
var  minutes  =  now.getMinutes()
var  seconds  =  now.getSeconds()
var  timeValue  =  hours
timeValue  +=  ((minutes  <  10)  ?  ":0"  :  ":")  +  minutes
timeValue  +=  ((seconds  <  10)  ?  ":0"  :  ":")  +  seconds
return timeValue  
}

/**
*得到两个时间的差，返回格式为 时：分：秒
*/
function dateDiff(date1,date2) {
var diff=new Date()
// sets difference date to difference of first date and second date
diff.setTime(Math.abs(date1.getTime() - date2.getTime()));
timediff = diff.getTime();
hours = Math.floor(timediff / (1000 * 60 * 60)); 
timediff -= hours * (1000 * 60 * 60);
mins = Math.floor(timediff / (1000 * 60)); 
timediff -= mins * (1000 * 60);
secs = Math.floor(timediff / 1000); 
timediff -= secs * 1000;

return  hours+":"+ mins+":"+secs;

}

/**
 * 返回选中的Radio对象值, 如果没有选中返回null
 * 参数: RadoiGroup
 */
function getRadioValue(radioGroup)
{
	if(null == radioGroup[0])
	{
		if(radioGroup.checked)
		{
			return radioGroup.value;
		}
	} 
	else 
	{
        for(i=0;i<radioGroup.length;i++)
        {
            if(radioGroup[i].checked)
            {
     	        return radioGroup[i].value;
             }
        }

	}
	
	return null;
}

/**
 * 返回选中的CheckBox对象值, 如果没有选中返回''
 * 参数: CheckBoxGroup
 */
function getCheckboxValue(checkboxGroup)
{
	if(null == checkboxGroup[0])
	{
		if(checkboxGroup.checked)
		{
			return checkboxGroup.value;
		}
	} 
	else 
	{
	    var retValue = '';
	
        for(i=0;i<checkboxGroup.length;i++)
        {
            if(checkboxGroup[i].checked)
            {
     	        retValue = retValue + '&' + checkboxGroup[i].value;
             }
        }
        
        return retValue;

	}
	
	return '';
}
/**
 *因为'&' 是get方式传参数的特殊字符,所以不能用来往服务器端传参数
 * 返回选中的CheckBox对象值, 如果没有选中返回''
 * 参数: CheckBoxGroup
 */
function getCheckboxValueS(checkboxGroup)
{
	if(null == checkboxGroup[0])
	{
		if(checkboxGroup.checked)
		{
			return checkboxGroup.value;
		}
	} 
	else 
	{
	    var retValue = '';
	
        for(i=0;i<checkboxGroup.length;i++)
        {
            if(checkboxGroup[i].checked)
            {
     	        retValue = retValue + ';' + checkboxGroup[i].value;
             }
        }
        
        return retValue;

	}
	
	return '';
}
/**
 * 返回选中的CheckBox对象数组, 如果没有选中返回null
 * 参数: CheckBoxGroup
 */
function getCheckedCheckbox(checkboxGroup)
{
     var retArray = null;
    
	if(null == checkboxGroup[0])
	{
		if(checkboxGroup.checked)
		{
		    retArray = new Array(1);
		    retArray[0] = checkboxGroup;
		}
	} 
	else 
	{
	    var count = 0;
	
        for(i=0;i<checkboxGroup.length;i++)
        {
            if(checkboxGroup[i].checked)
            {
     	        count++;
             }
        }
        
        retArray = new Array(count);
        count = 0
        
        for(i=0;i<checkboxGroup.length;i++)
        {
            if(checkboxGroup[i].checked)
            {
     	        retArray[count] = checkboxGroup[i];
     	        count++;
             }
        }
	}
	
    return retArray;
}

//在进行日期比对时调用,区分中英文: t_ischs(是否是中文) t_date(待转化的日期)
function getCompareDate(t_ischs, t_date) {

	if (t_date == '') {
		return t_date;
	}

	if (t_ischs==true) {
		return t_date;
	} else {
		var t_year = t_date.substring(t_date.length-4, t_date.length);
		var t_monanday = t_date.substring(0, t_date.length-4);
		return t_year + t_monanday;
	}
}
