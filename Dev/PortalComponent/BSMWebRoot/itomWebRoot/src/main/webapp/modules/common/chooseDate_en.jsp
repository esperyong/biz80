<%@ page language="java" contentType="text/html;charset=UTF-8" errorPage="/modules/common/error.jsp"%>
<jsp:directive.page import="com.mocha.dev.ReqRes"/>
<%@ include file="/modules/common/security.jsp"%>
<%
   	ReqRes rqre = new ReqRes(request, response);
   	rqre.encoding("UTF-8").nocache().security();
	
	String isTime = rqre.param("isTime","");
	String riqishijian =rqre.param("isDate","");
    String riqi="", shijian="", nian="", yue="", ri="", shi="", fen="", miao="";
     if(!"".equals(riqishijian) && riqishijian!=null){
       riqi=riqishijian.substring(0,10);
	   //shijian=riqishijian.substring(11,19);
	
      nian=riqi.substring(6,10);
      yue =riqi.substring(0,2);
	  ri  =riqi.substring(3,5);
	  //shi =shijian.substring(0,2);
	  //fen =shijian.substring(3,5);
	  //miao=shijian.substring(6,8);
     }
%>	
<HTML>
<HEAD>
<TITLE>Select Time</TITLE>
<META content="text/html; charset=utf-8" http-equiv=Content-Type>
<style>
DIV { SCROLLBAR-FACE-COLOR: Gainsboro; SCROLLBAR-HIGHLIGHT-COLOR: gray; SCROLLBAR-SHADOW-COLOR: gray; SCROLLBAR-3DLIGHT-COLOR: Gainsboro; SCROLLBAR-DARKSHADOW-COLOR: Gainsboro; SCROLLBAR-ARROW-COLOR: gray;}
td { font-size: 12px}
input, textarea { font-size: 12px; border-width:1px}
select { font-size: 12px; border-width:1px}
a:link, a:visited { color: #333333;text-decoration:none}
a:hover { color: #333333; text-decoration:underline}
</style>

<SCRIPT language="Javascript">

var riqi;
var shijian;
var nian='';
var yue='';
var dCalDate;
var iDayOfFirst;
var iDaysInMonth;
var iOffsetLast;
var aMonth;
//var ri;
//var shi;
//var fen;
//var miao;
var riqishijian='<%=riqishijian%>';

if(riqishijian!=""){
    riqi=riqishijian.substring(0,10);
	//shijian=riqishijian.substring(11,19);
	nian='<%=nian%>';
	yue='<%=yue%>';

}else{
    riqi="";
	shijian="";
	nian='';
	yue='';
}

var DateTime = "";
var check='0';//作为判断条件，如果对控件不做任何改动，则关闭控件页面，如果选择了时间、值为1，则重新赋值并且关闭控件页面
var iDate;
var iiYear='0';  //初始话
var iiMonth='0';
var iiDay='0';
var gdCtrl = new Object();
var goSelectTag = new Array();
var gcGray = "#808080";
var gcToggle = "#FFCC66";
var gcBG = "#F0F9FF";
var gdBG = "#000000";
var gcBlur="#0000ff";
var previousObject = null;
var gdCurDate = new Date();
var giYear = gdCurDate.getFullYear();  //当前年
var giMonth = gdCurDate.getMonth()+1;  //当前月
var giDay = gdCurDate.getDate();       //当前日
var gCalMode = "";
var gCalDefDate = "";

var CAL_MODE_NOBLANK = "2";

//将获取的年月日进行组合处理
function fSetDate(iYear, iMonth, iDay)
{   
	//VicPopCal.style.visibility = "hidden";
	iiYear=iYear;
	iiMonth=iMonth;
	iiDay=iDay;
	check='1';
	
  	
 	iMonth = iMonth + 100 + "";
  	iMonth = iMonth.substring(1); //进行转换，将 2 变成02
  	iDay   = iDay + 100 + "";
  	iDay   = iDay.substring(1);   //进行转换，将 3 变成03
  	//iDate = iYear+"/"+iMonth+"/"+iDay;
          iDate = iMonth+"/"+iDay+"/"+iYear;
	for (i in goSelectTag)
	goSelectTag[i].style.visibility = "visible";
	goSelectTag.length = 0;
     if((iYear == 0) && (iMonth == 0) && (iDay == 0))
	{
		if(riqi!=""){  //当第一次选择日期,而第二次没有选择日期直接选择时间,将上次日期与时间相加
		  	<%if(Boolean.TRUE.toString().equals(isTime)){%>
			Time = Hour + ":" + Minute + ":" + Second;
			DateTime = riqi + " " + Time;
		   <%}else{%>
			DateTime = riqi;
		   <%}%>
		}else{
		  DateTime = "";
		}
	}
}

//确定
function OK(){
	var Hour;
	var Minute;
	var Second;
    var Time;
    Hour = document.all.item("hour").value;
	Minute = document.all.item("minute").value;
	Second = document.all.item("second").value;
	 
	 if((iiYear == 0) && (iiMonth == 0) && (iiDay == 0))
	{   
		if(riqi!=""){  //当第一次选择日期,而第二次没有选择日期直接选择时间,将上次日期与时间相加
		  	<%if(Boolean.TRUE.toString().equals(isTime)){%>
			Time = Hour + ":" + Minute + ":" + Second;
			DateTime = riqi;
			check='1';
			//alert(DateTime);
		   <%}else{%>
			DateTime = riqi;
		<%}%>
		}else{
		   DateTime = "";
		}
	}
	 else if(Hour == "00" && Minute == "00" && Second =="00")
	{   
		
		if(shijian!=""){  //当只选择日期时，没有选择时间，需要将这个日期与上次时间进行相加
		  DateTime = iDate;
		  check='1';
		}else{
		  DateTime = iDate;
		}
		//window.returnValue = DateTime;
		//window.close();
	}
	else if(Hour !="" && Minute != "" && Second != "")
	{   
		<%if(Boolean.TRUE.toString().equals(isTime)){%>
			Time = Hour + ":" + Minute + ":" + Second;
			DateTime = iDate;
		<%}else{%>
			DateTime = iDate;
		<%}%>
		
	}
	
	if(check=='1'){
	//alert('zhixing');
    window.returnValue = DateTime;
    window.close();
    }else if(check=='0'){
    window.close();
    }
}

//取消
function cancel(){
    window.returnValue = "";
    window.close();
}

function HiddenDiv()
{
  var i;
  VicPopCal.style.visibility = "hidden";
  for (i in goSelectTag)
  	goSelectTag[i].style.visibility = "visible";
    goSelectTag.length = 0;

}
//根据触发事件与所选日期修改 年,月值
function fSetSelected(aCell){
  var iOffset = 0;
  var iYear = parseInt(tbSelYear.value);
  var iMonth = parseInt(tbSelMonth.value);
  
   //yeqw
    var calCellnamelist = document.getElementsByTagName('td');  //修改没有触发日期点的背景色
    for(i=0;i<calCellnamelist.length;i++){
	if(calCellnamelist[i].id == 'calCell')
		calCellnamelist[i].bgColor = gcBG;
    }
  
  //aCell.bgColor = gcBG;
    aCell.bgColor = gcToggle;
    with (aCell.children["cellText"]){
  	var iDay = parseInt(innerText);  //给innerText.cellText值赋给日
  	
  	if (color==gcGray)
		iOffset = (Victor<10)?-1:1;
	/*** below temp patch by maxiang ***/
	if (color==gcGray){              //对于灰色部分时间进行判断
		iOffset = (iDay < 15 )?1:-1;
	}
	/*** above temp patch by maxiang ***/

	iMonth += iOffset;  //如果是上月时间则当前取得月份值减1，如果是下月时间则当前取得月份值加1
	
	if (iMonth<1) {  //如果当前年月份<1的话设置年份为上一年
		iYear--;
		iMonth = 12;
	}else if (iMonth>12){  //如果当前年月份>12的话设置年份为下一年
		iYear++;
		iMonth = 1;
	}
  }

  fSetDate(iYear, iMonth, iDay);
}

function Point(iX, iY){
	this.x = iX;
	this.y = iY;
}

function fBuildCal(iYear, iMonth) {
  aMonth=new Array();
  for(i=1;i<7;i++)
  aMonth[i]=new Array(i);
     
  dCalDate=new Date(iYear, iMonth-1, 1);
  
  iDayOfFirst=dCalDate.getDay(); //返回星期中的第几天
        
  iDaysInMonth=new Date(iYear, iMonth, 0).getDate();  //返回月份中第几天
     
  iOffsetLast=new Date(iYear, iMonth-1, 0).getDate()-iDayOfFirst+1;
         //alert('iOffsetLast====='+iOffsetLast);
  var iDate = 1;
  var iNext = 1;

  for (d = 0; d < 7; d++){
	aMonth[1][d] = (d<iDayOfFirst)?-(iOffsetLast+d):iDate++;
    //alert((d<iDayOfFirst)?-(iOffsetLast+d):iDate++);
  }
  for (w = 2; w < 7; w++){
  	for (d = 0; d < 7; d++){
		aMonth[w][d] = (iDate<=iDaysInMonth)?iDate++:-(iNext++);
        //alert((iDate<=iDaysInMonth)?iDate++:-(iNext++));
    }
   }
    return aMonth;
}


function fUpdateCal(iYear, iMonth) {
  
  myMonth = fBuildCal(iYear, iMonth);
  //fDrawCal(iYear, iMonth, 8, '12');
  var i = 0;
  for (w = 0; w < 6; w++)
	for (d = 0; d < 7; d++)
	 
		with (cellText[(7*w)+d]) {  
			Victor = i++;
			if (myMonth[w+1][d]<0) {  //显示灰色部分(非本月日期)
				color = gcGray;
				innerText = -myMonth[w+1][d];
			}else{                   //显示本月日期
				// Modified by maxiang for we need 
				// Saturday displayed in blue font color.
				//color = ((d==0)||(d==6))?"red":"black";
				if( d == 0 ){
					color = "red";
				}else if( d == 6 ){
					color = "#3A6EA5";
				}else{
					color = "black";
				}
				// End of above maxiang
				  innerText = myMonth[w+1][d];
				    
				    if(riqishijian!=''){
				    
				    <% 
				    if(ri!=""){ //日期不为空时，将字符串02修改成2
				       int rr=Integer.parseInt(ri);
				       ri=String.valueOf(rr);
				       }
				    %>
				       if(innerText=='<%=ri%>'){
				         color = gcBlur;
				       }
				     }
			}
		}
  }

function fDrawCal(iYear, iMonth, iCellHeight, sDateTextSize) {
  var WeekDay = new Array("<font color='red'>SUN</font>","MON","TUE","WED","THU","FRI","SAT");
  var styleTD = " bgcolor='"+gcBG+"' bordercolor='"+gcBG+"' valign='middle' align='center' height='"+iCellHeight+"' style='font-size:12px; ";
  var styleTDt = " bgcolor='#E4E4E4' bordercolor='"+gcBG+"' valign='middle' align='center' height='"+iCellHeight+"' style='font-size:12px; ";

  with (document) {
	write("<tr>");
	for(i=0; i<7; i++)
		write("<td "+styleTDt+" color:#000000' >" + WeekDay[i] + "</td>");
	write("</tr>");

  	for (w = 1; w < 7; w++) {
		write("<tr>");
		for (d = 0; d < 7; d++) {
		    //write("<td id=calCell "+styleTD+"cursor:hand;' onMouseOver='this.bgColor=gcToggle' onMouseOut='this.bgColor=gcBG' onclick='fSetSelected(this)'>");
		     write("<td id=calCell "+styleTD+"cursor:hand;' onclick='fSetSelected(this)','this.bgColor=gcToggle'>");
			 write("<font face=tahoma id=cellText ><b> </b></font>");
			 write("</td>")
		}
		write("</tr>");
	}
  }
}


//设置年月初始值
function fSetYearMon(iYear, iMon,y){
 
  if(yue!=""){
    if(y!=""){
      tbSelMonth.options[iMon-1].selected = true;
    }else{ 
      tbSelMonth.options[yue-1].selected = true; //如果是以前的纪录则选中
     }
  }else{
    tbSelMonth.options[iMon-1].selected = true;
  }
  
  if(nian!=""){ //如果是以前选中的纪录则选中
   if(y!=""){
      for (i = 0; i < tbSelYear.length; i++)
	  if (tbSelYear.options[i].value == iYear)
		tbSelYear.options[i].selected = true;
	}else{
	   for (i = 0; i < tbSelYear.length; i++)
	   if (tbSelYear.options[i].value == nian)
		tbSelYear.options[i].selected = true;
	}	
  }else{
    for (i = 0; i < tbSelYear.length; i++)
	  if (tbSelYear.options[i].value == iYear)
		tbSelYear.options[i].selected = true;
  }
		
  fUpdateCal(iYear, iMon);
}

function fPrevMonth(){
  var iMon = tbSelMonth.value;
  var iYear = tbSelYear.value;
  
  if (--iMon<1) {
	  iMon = 12;
	  iYear--;
  }
  
  fSetYearMon(iYear, iMon,'y');
}

function fNextMonth(){
  var iMon = tbSelMonth.value;
  var iYear = tbSelYear.value;
  
  if (++iMon>12) {
	  iMon = 1;
	  iYear++;
  }
  
  fSetYearMon(iYear, iMon,'y');
}

function fToggleTags(){
  with (document.all.tags("SELECT")){
 	for (i=0; i<length; i++)
 		if ((item(i).Victor!="Won")&&fTagInBound(item(i))){
 			item(i).style.visibility = "hidden";
 			goSelectTag[goSelectTag.length] = item(i);
 		}
  }
}

function fTagInBound(aTag){
  with (VicPopCal.style){
  	var l = parseInt(left);
  	var t = parseInt(top);
  	var r = l+parseInt(width);
  	var b = t+parseInt(height);
	var ptLT = fGetXY(aTag);
	return !((ptLT.x>r)||(ptLT.x+aTag.offsetWidth<l)||(ptLT.y>b)||(ptLT.y+aTag.offsetHeight<t));
  }
}

function fGetXY(aTag){
  var oTmp = aTag;
  var pt = new Point(0,0);
  do {
  	pt.x += oTmp.offsetLeft;
  	pt.y += oTmp.offsetTop;
  	oTmp = oTmp.offsetParent;
  } while(oTmp.tagName!="BODY");
  return pt;
}

// Main: popCtrl is the widget beyond which you want this calendar to appear;
//       dateCtrl is the widget into which you want to put the selected date.
// i.e.: <input type="text" name="dc" style="text-align:center" readonly><INPUT type="button" value="V" onclick="fPopCalendar(dc,dc);return false">
function fPopCalendar(popCtrl, dateCtrl, mode, defDate){
	gCalMode = mode;
	gCalDefDate = defDate;
	
  if (popCtrl == previousObject){
	  	if (VicPopCal.style.visibility == "visible"){
  		//HiddenDiv();
  		return true;
  	}
  	
  }
  previousObject = popCtrl;
  gdCtrl = dateCtrl;
  fSetYearMon(giYear, giMonth,''); 
  var point = fGetXY(popCtrl);

	if( gCalMode == CAL_MODE_NOBLANK ){
		document.all.CAL_B_BLANK.style.visibility = "hidden";	
	}else{
		document.all.CAL_B_BLANK.style.visibility = "visible";
	}	

  with (VicPopCal.style) {
  	left = point.x+6;
	top  = point.y+popCtrl.offsetHeight;
	width = VicPopCal.offsetWidth;
	height = VicPopCal.offsetHeight;
	fToggleTags(point); 	
	visibility = 'visible';
  }
}

var gMonths = new Array("JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC");

with (document) {
write("<Div id='VicPopCal' align='center' style='OVERFLOW:hidden;POSITION:absolute;VISIBILITY:hidden;border:0px ridge;width:100%;height:100%;top:0;left:0;z-index:100;overflow:hidden'>");
write("<table width=0 border=0 cellspacing=0 cellpadding=0 >");
write("<tr>");
write("<th height=3 scope=row></th>");
write("</tr>");
write("</table>");
write("<table align='center' border='0' cellspacing='0' cellpadding='0' bgcolor='#E4E4E4' style='border-collapse: collapse' bordercolor='#808080'>");
write("<TR>");
write("<td valign='middle' align='center'><input type='button' name='PrevMonth' value='<' style='height:20;width:20;FONT:bold' onClick='fPrevMonth()'>");
write("&nbsp;<SELECT name='tbSelYear' onChange='fUpdateCal(tbSelYear.value, tbSelMonth.value)' Victor='Won'>");
for(i=giYear-10;i<giYear+10;i++) {
	//write("<OPTION value='"+i+"' >"+i+"</OPTION>");
	write("<OPTION value='"+i+"'");
	if(i=='<%=nian%>'){
		write(" selected ");
	}
	write(" >"+i+"</OPTION>");
	}
write("</SELECT>");
write("&nbsp;<select name='tbSelMonth' onChange='fUpdateCal(tbSelYear.value, tbSelMonth.value)' Victor='Won'>");
for (i=0; i<12; i++){
	write("<option value='"+(i+1)+"'") 
	   var jj=i+1;
	   if(jj==yue){
	      write(" selected ");
	   }
	write(" >"+gMonths[i]+"</option>");
	}
write("</SELECT>");
write("&nbsp;<input type='button' name='PrevMonth' value='>' style='height:20;width:20;FONT:bold' onclick='fNextMonth()'>");
write("</td>");
write("</TR><TR>");
write("<td align='center'>");
write("<DIV align='center' style='background-color:#000066'><table width='100%' border='0' cellspacing='1' cellpadding='0'>");
fDrawCal(giYear, giMonth, 8, '12');
write("</table></DIV>");
write("</td>");
write("</TR><TR><TD align='center'>");
write("<TABLE width='100%'>");
//TimeInputBegin
write("<tr><td colspan='3' width='100%' align='left'>");
write("<div style='color:black; font-size:12px'>Time: ");
write("<select <%if(!Boolean.TRUE.toString().equals(isTime)){%> disabled <%}%> name='hour' id='hour' Victor='Won' ><option value='00'>00</option><option value='01'>01</option><option value='02'>02</option><option value='03'>03</option><option value='04'>04</option><option value='05'>05</option><option value='06'>06</option><option value='07'>07</option><option value='08'>08</option><option value='09'>09</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option></select>");
  for(var s=0;s<hour.options.length;s++){
    if(hour.options[s].value=='<%=shi%>'){
       hour.options[s].selected = true;
	   break;
    }
  }
write(":");
write("<select <%if(!Boolean.TRUE.toString().equals(isTime)){%> disabled <%}%> name='minute' id='minute' Victor='Won' ><option value='00'>00</option><option value='05'>05</option><option value='10'>10</option><option value='15'>15</option><option value='20'>20</option><option value='25'>25</option><option value='30'>30</option><option value='35'>35</option><option value='40'>40</option><option value='45'>45</option><option value='50'>50</option><option value='55'>55</option></select>");
  for(var f=0;f<minute.options.length;f++){
    if(minute.options[f].value=='<%=fen%>'){
       minute.options[f].selected = true;
	   break;
    }
  }
write(":");
write("<select <%if(!Boolean.TRUE.toString().equals(isTime)){%> disabled <%}%> name='second' id='second' Victor='Won'><option value='00'>00</option><option value='05'>05</option><option value='10'>10</option><option value='15'>15</option><option value='20'>20</option><option value='25'>25</option><option value='30'>30</option><option value='35'>35</option><option value='40'>40</option><option value='45'>45</option><option value='50'>50</option><option value='55'>55</option></select>");
    for(var m=0;m<second.options.length;m++){
    if(second.options[m].value=='<%=miao%>'){
       second.options[m].selected = true;
	   break;
    }
  }
//write("00<input type='hidden' name='second' maxlength='2' style='width:20; height:20; font-family:tahoma; font-size:9pt' onblur=\"CheckValue(this.value,'second');\" value=00>");
write("</div>");
write("</td></tr>");
//TimeInputEnd
write("<TR><TD width='64%' align='left'>");
write("<div style='color:black;cursor:hand; font-size:12px' onclick='fSetDate(giYear,giMonth,giDay)' onMouseOver=\"this.style.color='#8B0000'\" onMouseOut='this.style.color=gdBG'>Today: <font face='tahoma'>"+giYear+"/"+giMonth+"/"+giDay+"</font></div>");
write("</td><td width='18%' align='center'>");
write("<div ID=\"CAL_B_OK\" style='color:#ff2521; visibility:visible; cursor:hand; font-size:12px' onclick='OK()' onMouseOver=\"this.style.color='#8B0000'\" onMouseOut=\"this.style.color='#ff2521'\">Confirm</div>");
write("</td><td width='18%' align='left'>");
write("<div ID=\"CAL_B_BLANK\" style='color:#ff2521; visibility:visible; cursor:hand; font-size:12px' onclick='cancel()' onMouseOver=\"this.style.color='#8B0000'\" onMouseOut=\"this.style.color='#ff2521'\">Clear</div>");
write("</td></tr>");
write("</table>");
write("</TD></TR>");
write("</TABLE>");
write("<DIV>");
}


function fload()
{
	fPopCalendar(document.all.txt1, document.all.txt1);
}

function fkeydown()
{
	if(event.keyCode==27){
		event.returnValue = null;
		window.returnValue = null;
		window.close();
	}
}

document.onkeydown=fkeydown;
</SCRIPT>
</HEAD>
<BODY bgColor="#E4E4E4" onload="fload();">
<INPUT id="txt1" style="display: none">
</BODY>
</HTML>