<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<HTML><HEAD><TITLE><s:text name="roommonitor.video.InquiriesAndPlay" /></TITLE>
<STYLE>BODY {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; BACKGROUND: #ffffff; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px
}
BODY {
	FONT-SIZE: 12px; COLOR: #000000; WORD-BREAK: break-all
}
TABLE {
	FONT-SIZE: 12px; COLOR: #000000; WORD-BREAK: break-all
}
SELECT {
	FONT-SIZE: 10px; WIDTH: 200px; FONT-FAMILY: verdana,tahoma,arial
}
INPUT.l {
	FONT-SIZE: 10px; WIDTH: 70px; FONT-FAMILY: verdana,tahoma,arial
}
INPUT.m {
	FONT-SIZE: 10px; WIDTH: 60px; FONT-FAMILY: verdana,tahoma,arial
}
INPUT.s {
	FONT-SIZE: 10px; WIDTH: 30px; FONT-FAMILY: verdana,tahoma,arial
}
INPUT.imgbtn {
	BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BACKGROUND-IMAGE: url(${ctx}/images/room/video/play.png); BORDER-BOTTOM-WIDTH: 0px; WIDTH: 25px; CURSOR: hand; HEIGHT: 24px; BACKGROUND-COLOR: #ffffff; BORDER-RIGHT-WIDTH: 0px
}
A {
	COLOR: #008000; TEXT-DECORATION: none
}
A:hover {
	COLOR: #6fb340
}
A.a1 {
	COLOR: #ffffff
}
A.a1:hover {
	COLOR: #eeeaea
}
A.a2 {
	COLOR: #ffffff
}
A.a2:hover {
	COLOR: #6fb340
}
A.a3 {
	COLOR: #000000
}
#search_pan {
	WIDTH: 100%; COLOR: #ffffff; HEIGHT: 25px
}
#td1 {
	PADDING-RIGHT: 10px; PADDING-LEFT: 10px; FONT-WEIGHT: bold; BACKGROUND: #000000; PADDING-BOTTOM: 0px; PADDING-TOP: 1px; FONT-FAMILY: verdana,tahoma,arial; WHITE-SPACE: nowrap; LETTER-SPACING: 2px
}
#td2 {
	PADDING-RIGHT: 10px; PADDING-LEFT: 10px; BACKGROUND: #7f4d80; PADDING-BOTTOM: 0px; PADDING-TOP: 1px; WHITE-SPACE: nowrap; LETTER-SPACING: 1px
}
#div1 {
	PADDING-RIGHT: 12px; PADDING-LEFT: 12px; FONT-SIZE: 12px; PADDING-BOTTOM: 24px; LINE-HEIGHT: 18px; PADDING-TOP: 24px; FONT-FAMILY: verdana,tahoma,arial
}
#div2 {
	PADDING-TOP: 20px; BORDER-BOTTOM: #666666 1px solid
}
#span1 {
	FONT-WEIGHT: bold; FONT-SIZE: 18px; WIDTH: 254px; LINE-HEIGHT: 24px; FONT-FAMILY: verdana,tahoma,arial
}
.span2 {
	COLOR: #c00000
}
#div3 {
	BORDER-TOP: #000000 1px solid; LINE-HEIGHT: 15px; PADDING-TOP: 8px
}
#span3 {
	FONT-SIZE: 10px
}
.span4 {
	COLOR: #c000c0
}
.ie {
	COLOR: #0000ff
}
.ns {
	COLOR: #b8860b
}
.no {
	COLOR: #ff3300
}
.wc {
	COLOR: #008000
}
A.ie {
	COLOR: #0000ff
}
A.ns {
	COLOR: #b8860b
}
A.no {
	COLOR: #ff3300
}
TABLE.meme {
	FONT-SIZE: 11px; BACKGROUND: #000000; FONT-FAMILY: tahoma,verdana,arial
}
TABLE.meme TH {
	PADDING-RIGHT: 8px; PADDING-LEFT: 8px; BACKGROUND: #ffffff; PADDING-BOTTOM: 6px; VERTICAL-ALIGN: middle; PADDING-TOP: 6px; TEXT-ALIGN: left
}
TABLE.meme TD {
	PADDING-RIGHT: 8px; PADDING-LEFT: 8px; BACKGROUND: #ffffff; PADDING-BOTTOM: 6px; VERTICAL-ALIGN: middle; PADDING-TOP: 6px; TEXT-ALIGN: left
}
TABLE.meme TH {
	BACKGROUND: #fafad2
}
.index {
	FONT-WEIGHT: bold; FONT-SIZE: 12px; FONT-FAMILY: tahoma,arial
}
</STYLE>

<SCRIPT language=JavaScript>
<!--
var g_host = new Array();
var g_date = new Array();
var g_size = new Array();
var g_file = new Array();
function aff_dis(obj_list, obj_hint)
{
    obj_list.style.visibility = "visible";
    obj_hint.style.visibility = "hidden";
}
function fucCheckNUM(NUM)
{
	var i,j,strTemp;
	strTemp="0123456789";
	if ( NUM.length== 0)
	return 0
	for (i=0;i<NUM.length;i++)
	{
		j=strTemp.indexOf(NUM.charAt(i));
		if (j==-1)
		{
			//˵�����ַ�������
			return 0;
		}
	}
		//˵��������
		return 1;
}
function init_date()
{
    var todayName = new Date();
    document.all.t_year.value = todayName.getFullYear();
    document.all.t_month.value = (todayName.getMonth()+1);
    document.all.t_day.value = todayName.getDate();
}
function call_player(name)
{
    var file_id = name.substr(3);
    var obj = new Object();
    obj.name=g_file[file_id];
    window.showModalDialog("player.html",obj,"dialogWidth=800px;dialogHeight=670px");
}
function result_com(url, date, time, length, filename)
{
    g_host.push(url);
    g_date.push(date);
    g_size.push(length);
    g_file.push(filename);
}
function search_file()
{
    var itm_search = new Array(document.all.t_year.value,
        document.all.t_month.value,
        document.all.t_day.value,
        document.all.t_bgnHour.value,
        document.all.t_bgnMin.value,
        document.all.t_endHour.value,
        document.all.t_endMin.value);
    var itm = new Array();
    for(i=0; i<7; i++)
    {
        if(fucCheckNUM(itm_search[i])){
            itm[i] = parseFloat(itm_search[i]);
        }
        else{
            alert("Need a correct search request!");
            return false;
        }
     }
     Camera0.SearchFile(itm[0], itm[1], itm[2], itm[3], itm[4], itm[5], itm[6]);
     return true;
}
function rebuilt()
{
    var temp = document.all.tb_list;
    while(temp.rows.length>1)
    {
        temp.deleteRow(temp.rows.length-1)
    }
}
function callback_result(obj_list, obj_hint)
{
    g_host.length = 0;
    g_date.length = 0;
    g_size.length = 0;
    g_file.length = 0;
    rebuilt();

    if(search_file()){
        obj_hint.style.visibility = "visible";
	    setTimeout("aff_dis(thumb_list, pre_hint);",800);

	    var i = 0;
	    var temp = document.all.tb_list;
	    var c_text;
		for(i=0; i<g_date.length; i++){
			c_text = "<input type='button' name='frm"+i+"' class='imgbtn' onclick='javascript:call_player(this.name)'>";
			temp.insertRow();
			temp.rows.item(temp.rows.length -1).insertCell(0);
			temp.rows.item(temp.rows.length -1).insertCell(1);
			temp.rows.item(temp.rows.length -1).insertCell(2);
			temp.rows.item(temp.rows.length -1).insertCell(3);
			temp.rows.item(temp.rows.length -1).insertCell(4);
			temp.rows.item(temp.rows.length-1).cells.item(0).innerText = g_host[i];
			temp.rows.item(temp.rows.length-1).cells.item(1).innerText = g_date[i];
			temp.rows.item(temp.rows.length-1).cells.item(2).innerText = g_size[i];
			temp.rows.item(temp.rows.length-1).cells.item(3).innerText = g_file[i];
			temp.rows.item(temp.rows.length-1).cells.item(4).innerHTML = c_text;
		}
	}
	else
	    err_hint.style.visibility = "visible";
}
-->
</SCRIPT>

<SCRIPT language=javascript event="SearchRet(url, date, time, length, filename)"
for=Camera0>
result_com(url, date, time, length, filename);
</SCRIPT>

<SCRIPT language=javascript event="ClickSel(url, channel)" for=Camera0>
  alert(channel);
</SCRIPT>

<META content="MSHTML 6.00.2900.3354" name=GENERATOR></HEAD>
<BODY onload=init_date();>
<TABLE id=search_pan cellSpacing=0 cellPadding=0 border=0>
  <TBODY>
  <TR>
    <TD id=td1 align=left>
      <P class=a2><s:text name="roommonitor.video.InquiriesPlaylist" /></P></TD>
    <TD id=td2 align=right><s:text name="roommonitor.video.DateYear" /><INPUT class=l value=2004 name=t_year> <s:text name="roommonitor.video.Month" /><INPUT
      class=s value=11 name=t_month> <s:text name="roommonitor.video.Day" /><INPUT class=s value=20
      name=t_day>&nbsp;|&nbsp; <s:text name="roommonitor.video.StartTimeHour" /><INPUT class=s value=01 name=t_bgnHour>
      <s:text name="roommonitor.video.Minutes" /><INPUT class=s value=00 name=t_bgnMin> <s:text name="roommonitor.video.EndTimeHour" /><INPUT class=s value=23
      name=t_endHour>&nbsp;|&nbsp; <s:text name="roommonitor.video.Minutes" /><INPUT class=s value=50
      name=t_endMin>&nbsp;|&nbsp; <IMG
      onmouseup="this.src='${ctx}/images/room/video/123.png'; callback_result(thumb_list, pre_hint);"
      onmousedown="this.src='${ctx}/images/room/video/234.png'" style="CURSOR: hand" height=24
      alt=<s:text name="roommonitor.video.Search" /> src="${ctx}/images/room/video/123.png" width=25 border=0> </TD></TR></TBODY></TABLE>
<DIV id=thumb_list
style="LEFT: 90px; VISIBILITY: hidden; WIDTH: 700px; POSITION: absolute; TOP: 32px; HEIGHT: 86px"
name="thumb_list">
<TABLE class=meme id=tb_list cellSpacing=1 cellPadding=0 width=700 border=0>
  <TBODY>
  <TR>
    <TH><s:text name="roommonitor.video.ServerIPAddress" /> </TH>
    <TH><s:text name="roommonitor.video.Date" /> </TH>
    <TH><s:text name="roommonitor.video.FileLength" /></TH>
    <TH><s:text name="roommonitor.video.FileName" /> </TH>
    <TH width=24>&nbsp;</TH></TR></TBODY></TABLE></DIV>
<DIV id=pre_hint
style="LEFT: 90px; VISIBILITY: hidden; WIDTH: 700px; POSITION: absolute; TOP: 32px; HEIGHT: 24px"
name="pre_hint">
<TABLE class=meme cellSpacing=1 cellPadding=0 width=524 border=0>
  <TBODY>
  <TR>
    <TH><s:text name="roommonitor.video.SearchingWait" /></TH></TR></TBODY></TABLE></DIV>
<DIV id=err_hint
style="LEFT: 90px; VISIBILITY: hidden; WIDTH: 524px; POSITION: absolute; TOP: 32px; HEIGHT: 24px"
name="pre_hint">
<TABLE class=meme cellSpacing=1 cellPadding=0 width=524 border=0>
  <TBODY>
  <TR>
    <TH><s:text name="roommonitor.video.SearchError" /></TH></TR></TBODY></TABLE></DIV>
<OBJECT id=Camera0 codeBase=NetViewX.cab height=0 width=0
classid=CLSID:0C615F36-0C1C-497B-B9E4-833B0D7AA8CA
name=Camera0></OBJECT></BODY></HTML>
