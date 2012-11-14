<!-- 机房-机房监控-机房视频iframe  roomVideoIframeInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%
	
	String ip = "192.168.17.6";

	//boolean isadmin = rr.tobool(rr.param("isadmin", null), false);
	boolean isadmin = true;
	String display = "block";
	if(!isadmin) {
		display = "none";
	}
%>
<meta name="Author" content="LinLee">
<meta name="Keywords" content="4 channel IPVS">
<meta name="Description" content="Launch Digital Tech">
<meta http-equiv="pragma" content="no-cache">
<HTML xmlns:sn>
<HEAD>
<TITLE>机房视频</TITLE>
<link href="${ctx}/css/video_style.css" rel="stylesheet" type="text/css">

<STYLE>
sn\:2k3Slider {
	WIDTH: 100%;
	BACKGROUND-COLOR: transparent;
	buttonImage: ${ctx}/images/room/video/2k3SliderButton.gif;
	buttonImageOver: ${ctx}/images/room/video/2k3SliderButtonOver.gif;
	buttonImageDown: ${ctx}/images/room/video/2k3SliderButtonDown.gif;
}

.unnamed1 {
 font-family: Arial, Helvetica, sans-serif;
 font-size: 12px;
 color: #666666;
 background-color: EFEFEF;
 border: 1px solid A6ACAA;
}

</STYLE>
<SCRIPT language=javascript>
<!--
var max_ch  = 1;
var wscrsz  = 352;
var hscrsz  = 288;
var ptz_spd = 5;
var ort_ptz   = new Array(0, 0, 0, 0);//up ,down, left, right
var ptz_off   = new Array("left_off.gif", "right_off.gif","up_off.gif", "down_off.gif", "auto_off.gif");
var ptz_on    = new Array("left_on.gif", "right_on.gif", "up_on.gif", "down_on.gif", "auto_on.gif");
var play_on   = new Array("on_0.gif", "on_1.gif", "on_2.gif", "on_3.gif");
var play_off  = new Array("off_0.gif", "off_1.gif", "off_2.gif", "off_3.gif");
var is_play   = new Array(0, 0);
var is_talk   = 0;
var is_aud    = 0;
var is_rec    = 0;
var is_aux    = new Array(0, 0, 0, 0);
var is_auto   = 0;
var cur_ch    = 0;
var serverport = "<s:property value='firstPort'/>";
var ipads = "<s:property value='firstIp'/>";
function initpage()
{
    wscrsz = Camera0.ImageWidth();
    hscrsz = Camera0.ImageHeight();
    view0.style.border = "2px solid #ffff80";
    if(wscrsz > 360) {
        document.all.radiobutton[1].checked = true;
        chgsize(2);
    }
    setTimeout('cnt_all(1);',500);
}
function cnt_all(onff) {
    Cmr = Camera0;
	if(onff){
	    Cmr.url         = ipads;      //ip
	    Cmr.wServerPort = serverport; //port default 3000
	    Cmr.channel     = cur_ch;     //channel number
	    Cmr.username    = '888888';   //user
	    Cmr.password    = '888888';   //pwd
	    Cmr.trantype    = document.all.linktype[0].checked ? 3 : 2; //3 is TCP
	    Cmr.StartView();

        is_play = 1;
	    setTimeout("Cmr.SoundOff();", 800);
        playall.src = "${ctx}/images/room/video/off_start.gif";
	    stpall.src = "${ctx}/images/room/video/on_stop.gif";
	}
	else
	{
	    Cmr.StopView();
        is_play = 0;
        is_aud  = 0;
        bt_audio.btpress(0);
        is_rec  = 0;
        bt_rec.btpress(0);
        playall.src = "${ctx}/images/room/video/on_start.gif";
	    stpall.src = "${ctx}/images/room/video/off_stop.gif";
	}
}
function ctrl_rcd(opt, obj)
{//opt: 0 is switch ctrl; 1 is button ctrl.
    Cmr = eval("Camera"+cur_ch);
    if(is_play)
    {if(opt && is_play)
	    {
		    if(is_rec == 0)
		    {
		    	var p = document.getElementById('videopath').value;

		    	//var filename = "c:/temp/video_"+splitDate()+".asf";
		    	var filename = p + "/video_"+splitDate()+".asf";

		        Cmr.StartRecord(filename);
		        is_rec = 1;
		        obj.btpress(1);
		    } else  {
		        Cmr.StopRecord();
		        is_rec = 0;
		        obj.btpress(0);
		    }
	    } else {
	        obj.btpress((is_rec == 0)?0:1);
	    }
    }
    else return;
}
function ctrl_audio(obj)
{//opt: 0 is switch ctrl; 1 is button ctrl.
    Cmr = eval("Camera"+cur_ch);
    if(is_play)//还没有判断一下是否连接已经打开。。。。。。
    {
	    if(!is_aud)
	    {//button's action
	        Cmr.SoundOn();
	        is_aud = 1;
	        obj.btpress(1);
	    }
	    else
	    {
	        Cmr.SoundOff();
	        is_aud = 0;
	        obj.btpress(0);
	    }
    }
    else return;
}
function ctrl_talk(obj)
{
    Cmr = eval("Camera"+cur_ch);
	if(is_play)
	{
	    if(!is_talk)
	    {
	        Cmr.StartTalk();
	    }
	    else
	    {
	        Cmr.StopTalk();
	        is_talk = 0;
	        obj.btpress(0);
	    }
	}
	else return;

}
function event_talk(i)
{
	var obj = document.getElementById("bt_talk");
	if(i == 0)
	{
        window.status = "<s:text name='roommonitor.video.calling' />";
        obj.btpress(1);
        is_talk = 1;
    }
	else if(i == 1)
	{
		is_talk = 0;
        window.status = "<s:text name='roommonitor.video.callingWithOthers' />";
    }
    else
//    	document.getElementById("bt_talk").disabled = true;
    {
    	is_talk = 0;
    	window.status = "<s:text name='roommonitor.video.unknownRequestFail' />";
    }
}
function ctrl_param(obj)
{
    //location="http://<%=ip%>/configure.html";
    openWin("http://'<s:property value='firstIp'/>'/configure.html", 850, 620);
}
function openWin(url, width, height){
		var left = (screen.width - width)/2;
		var top = (screen.height - height)/2;
		window.open(url,"","left=" + left + ",top= " + top + ",width=" + width + ",height=" + height +",toolbar=no");
	}
function ptz_speed(i)
{
    ptz_spd =  Math.round(i/10);
    window.status = "PTZ Speed is " + ptz_spd;
}
function ptz_mv(i, obj_name, act)
{
    var host = eval("document.all." + obj_name);
    if(act != 0){
	    if(ort_ptz[i] != 0){
	        host.src = "${ctx}/images/room/video/"+ptz_off[i];
	        ort_ptz[i] = 0;
	    }else{
	        host.src = "${ctx}/images/room/video/"+ptz_on[i];
	        ort_ptz[i] = 1;
	        Camera0.PTZCtrl(i, ptz_spd);
	    }
	}else{
	    ort_ptz[i] = 0;
        host.src = "${ctx}/images/room/video/"+ptz_off[i];
        Camera0.PTZCtrl(13, ptz_spd);
	}
}
function ptz_iris(i, act)
{//i: action or stop action; act: zoom98, iris45, focus67;
    if(i)
    {
        Camera0.PTZCtrl(act, ptz_spd);
    }
    else
    {
        Camera0.PTZCtrl(13, ptz_spd);
    }
}
function presetPoint(i, n)
{
	 Camera0.PTZCtrl(i, n);
}
function status_alm(i)
{
    var obj = new Array("document.all.almout0", "document.all.almout1", "document.all.almout2", "document.all.almout3");
    var host;
    for(x=0; x<4; x++)
    {
        if(i & Math.pow(2, x)){
            is_aux[x] = 1;
            host = eval("document.all.almout" + x);
            host.src = "${ctx}/images/room/video/alarm_on.gif";
        }
        else{
            is_aux[x] = 0;
            host = eval("document.all.almout" + x);
            host.src = "${ctx}/images/room/video/alarm_off.gif";
        }
    }
}
function set_aux(i, obj_name)
{
    Cmr = eval("Camera"+cur_ch);
    var host = eval("document.all." + obj_name);
    if(is_aux[i] != 0){
        Cmr.CtrolAlarmOut(i, 0);
        host.src = "${ctx}/images/room/video/alarm_off.gif";
        is_aux[i] = 0;
    }
    else{
        Cmr.CtrolAlarmOut(i, 1);
        host.src = "${ctx}/images/room/video/alarm_on.gif";
        is_aux[i] = 1;
    }
}
function chgsize(sz)
{
    Cmr  = eval("Camera" + cur_ch);
    view = lens_bg;
    dom = document.getElementById("vbox");
    if(sz == 0)
    {
        Cmr.FullScreen();
	}
    else if(sz == 1)
    {
        dom.width = 368;
        dom.height = 288;
	    Camera0.width  = 365;
	    Camera0.height = 288;
	    view0.style.left  =  "100px";
	    view0.style.top  =  "6px";
	}
	else
	{
        dom.width = 560;
        dom.height = 500;
	    Camera0.width  = 572;
	    Camera0.height = 500;
	    view0.style.left  =  "0px";
	    view0.style.top  =  "0px";
	}

}
function cruise(obj)
{
    Cmr = eval("Camera"+cur_ch);
	if (is_auto)
	{
		Cmr.PTZCtrl(12, 0);
		is_auto = 0;
	}
	else
	{
		Cmr.PTZCtrl(12, 1);
		is_auto = 1;
	}
}
function ctrl_cpt(obj) {

	var p = document.getElementById('imgpath').value;

	//var filename = "c:/temp/image_"+splitDate()+".bmp";

	var filename = p+"/image_"+splitDate()+".bmp";

    Cmr = eval("Camera"+cur_ch);

    var flag = Cmr.CaptureBmp(filename);
}


function splitDate(d){
	var d = new Date();
    var yyyy,MM,dd,hh,mm,ss;
    if(true){
         yyyy=d.getYear();
         MM=(d.getMonth()+1)<10?"0"+(d.getMonth()+1):d.getMonth()+1;
         dd=d.getDate()<10?"0"+d.getDate():d.getDate();
         hh=d.getHours()<10?"0"+d.getHours():d.getHours();
         mm=d.getMinutes()<10?"0"+d.getMinutes():d.getMinutes();
         ss=d.getSeconds()<10?"0"+d.getSeconds():d.getSeconds();
    }else{
         yyyy=d.getYear();
         MM=d.getMonth()+1;
         dd=d.getDate();
         hh=d.getHours();
         mm=d.getMinutes();
         ss=d.getSeconds();
    }
    return yyyy + "" + MM + "" + dd + "" + hh + "" + mm + "" + ss;
}

//-->

</SCRIPT>

<SCRIPT language=javascript event=ExOutPutStatus(i) for=Camera0>
status_alm(i);
</SCRIPT>

<SCRIPT language=javascript event=TalkStatus(i) for=Camera0>
event_talk(i);
</SCRIPT>

<BODY bgColor=white leftMargin=0 topMargin=0 onload="setHeight(getTotalHeight()); return initpage();" marginwidth="0" marginheight="0">

<div>	
<TABLE cellSpacing=0 cellPadding=0 border=0>
  <TBODY>
  <TR>
    <TD style="VERTICAL-ALIGN: top; TEXT-ALIGN: center" width=98% height=490>
      <TABLE id=vbox borderColor=white height=295 cellSpacing=2 cellPadding=3 width=368 border=1>
        <TBODY>
        <TR>
          <TD align=middle bgColor=white height=295>
            <DIV id=view0 style="LEFT: 194px; WIDTH: 352px; POSITION: absolute; TOP: 16px; HEIGHT: 288px">
            <OBJECT id=Camera0 codeBase="${ctx}/video/NetViewX.cab" height=288 width=352 classid="CLSID:0C615F36-0C1C-497B-B9E4-833B0D7AA8CA" name=Camera0></OBJECT></DIV></TD></TR></TBODY></TABLE></TD>
    <TD width=10>&nbsp;</TD>
    <TD>
      <TABLE height=597  cellSpacing=0 cellPadding=0 width=215 border=0 background="${ctx}/images/room/video/main.jpg">
        <TBODY>
        <TR>
          <TD width=20 rowSpan=11>&nbsp;</TD>
          <TD height=20>&nbsp;</TD>
          <TD width=20 rowSpan=11>&nbsp;</TD>
        </TR>
        <TR>
          <TD style="position:relative;top:-10px"><INPUT id=tcp type=radio CHECKED value=3 name=linktype> <LABEL for=tcp><B><s:text name="roommonitor.video.TCP" /></B></LABEL>
          <INPUT id=mul type=radio value=2 name=linktype> <LABEL for=mul><B><s:text name="roommonitor.video.MultiCast" /></B></LABEL></TD></TR>
        <TR>
          <TD height=25>&nbsp;</TD>
         </TR>
        <TR style='display:<%=display %>'>
          <TD height=65>
            <TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
              <TBODY>
              <TR>
                <TD colSpan=1>
                  <CENTER><INPUT language=javascript id=playall onclick="return cnt_all(1);" type=image src="${ctx}/images/room/video/on_start.gif" name=playall> </CENTER></TD>
                <TD colSpan=1>
                  <CENTER><INPUT language=javascript id=stpall onclick="return cnt_all(0);" type=image src="${ctx}/images/room/video/off_stop.gif" name=stpall>
              </CENTER></TD>
              </TR>
               <TR>
                <TD colSpan=1></TD>
                </TR>
			  <TR style='display:none'>
				<TD height=1 colspan="4">
				  <TABLE style="BACKGROUND: url(${ctx}/images/room/video/split.gif) no-repeat" height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
					  <TBODY>
						  <TR>
						    <TD width="100%">&nbsp;</TD>
						  </TR>
					  </TBODY>
				  </TABLE>
				</TD>
			  </TR>
              </TBODY></TABLE>
          </TD>
        </TR>
        <TR style='display:none'>
          <TD height=90>
            <TABLE height="100%" cellSpacing=4 cellPadding=0 border=0>
              <TBODY>
              <TR valign='top'>
                <TD bgcolor="#EEEEEE"><?import namespace ="sn" implementation = "${ctx}/video/sn_bt.html" />
                	<span><sn:bt id=bt_cpt onclick=ctrl_cpt(this); name="bt_cpt" fontsize="12" width="40" color="#FFFFFF" height="20"><s:text name="roommonitor.video.catchPicture" /></sn:bt></span>
                </TD>
                <TD colspan="3" align='left'>
                	<INPUT TYPE='text' name='imgpath' value='c:\temp' height="20" size=20 style='font-family: Arial, Helvetica, sans-serif;font-size: 12px; color: #666666; background-color: EFEFEF; border: 1px solid A6ACAA;'>
                </TD>
              </TR>
              <TR valign='top'>
                <TD bgcolor="#EEEEEE">
                	<sn:bt id=bt_rec onclick="ctrl_rcd(1, this);" fontsize="12" width="40" color="#FFFFFF" height="20"><s:text name="roommonitor.video.Video" /></sn:bt>
                </TD>
                <TD colspan="3" align='left'>
                	<INPUT TYPE='text' name='videopath' value='c:\temp' size=20 height=20 style='font-family: Arial, Helvetica, sans-serif;font-size: 12px; color: #666666; background-color: EFEFEF; border: 1px solid A6ACAA;'>
                </TD>
              </TR>
              <TR>
              	<TD height=1 colspan="4">
              		<TABLE height="100%" cellSpacing=4 cellPadding=0 border=0>
	              		<TR>
			                <TD bgcolor="#EEEEEE">
			                	<sn:bt onclick="javascript: showModalDialog('${ctx}/roomDefine/RoomVideoVisit!childForword.action', window, 'dialogWidth:828px; dialogHeight:400px; status:no; help:no; resizable:no;');" fontsize="12" width="40" color="#FFFFFF" height="20"><s:text name="roommonitor.video.Playback" /></sn:bt>
			                </TD>
			                <TD bgcolor="#E1E1E1">
			                	<sn:bt id=bt_audio onclick=ctrl_audio(this); fontsize="12" width="40" color="#FFFFFF" height="20"><s:text name="roommonitor.video.Audio" /></sn:bt>
			                </TD>
			                <TD bgcolor="#D8D8D8">
			                	<sn:bt id=bt_talk onclick=ctrl_talk(this); fontsize="12" width="40" color="#FFFFFF" height="20"><s:text name="roommonitor.video.Talk" /></sn:bt>
			                </TD>
			                <TD bgcolor="#D4D4D4" style="display:none">
			                	<sn:bt onclick=ctrl_param(this); fontsize="12" width="40" color="#FFFFFF" height="20"><s:text name="roommonitor.video.Parameters" /></sn:bt>
			                </TD>
	              		</TR>
	              	</TABLE>
                </TD>
              </TR>

			  <TR style='display:<%=display %>'>
				<TD height=1 colspan="4">
				  <TABLE style="BACKGROUND: url(${ctx}/images/room/video/split.gif) no-repeat" height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
					  <TBODY>
						  <TR>
						    <TD width="100%">&nbsp;</TD>
						  </TR>
					  </TBODY>
				  </TABLE>
				</TD>
			  </TR>

             </TBODY></TABLE></TD>
        </TR>
        <TR style='display:<%=display %>'>
          <TD height=5>
            <TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
              <TBODY>
              <TR>
                <TD colSpan=4 height=1>
                  <TABLE style="BACKGROUND: url(${ctx}/images/room/video/split.gif) no-repeat" height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
                    <TBODY>
                    <TR>
                      <TD>&nbsp;</TD></TR></TBODY></TABLE></TD></TR>
              <TR>
                <TH colSpan=4>
                  <DIV align=left><s:text name="roommonitor.video.OutputControl" /></DIV></TH></TR>
              <TR>
                <TD>
                  <CENTER><INPUT language=javascript id=almout0 onclick="set_aux(0, 'almout0');" type=image src="${ctx}/images/room/video/alarm_off.gif" name=almout0></CENTER></TD>
                <TD>
                  <CENTER><INPUT language=javascript id=almout1 onclick="set_aux(1, 'almout1');" type=image  src="${ctx}/images/room/video/alarm_off.gif" name=almout1></CENTER></TD>
                <TD>
                  <CENTER><INPUT language=javascript id=almout2 onclick="set_aux(2, 'almout2');" type=image src="${ctx}/images/room/video/alarm_off.gif" name=almout2></CENTER></TD>
                <TD>
                  <CENTER><INPUT language=javascript id=almout3 onclick="set_aux(3, 'almout3');" type=image src="${ctx}/images/room/video/alarm_off.gif" name=almout3></CENTER></TD>
              </TR></TBODY></TABLE></TD></TR>
        <TR style='display:<%=display %>'>
          <TD height=10>
            <TABLE style="BACKGROUND: url(${ctx}/images/room/video/split.gif) no-repeat"
            height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
              <TBODY>
              <TR>
                <TD>&nbsp;</TD></TR></TBODY></TABLE></TD></TR>
        <TR>
          <TD height=45>
            <TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
              <TBODY>
              <TR>
                <TH colSpan=3><DIV align=left><s:text name="roommonitor.video.ImageSize" /></DIV></TH></TR>
              <TR>
                <TD><INPUT id=1x onclick="return chgsize(1);" type=radio
                  CHECKED value=radiobutton name=radiobutton> <LABEL for=1x><s:text name="roommonitor.video.1X" /></LABEL></TD>
                <TD><INPUT id=2x onclick="return chgsize(2);" type=radio
                  value=radiobutton name=radiobutton> <LABEL for=2x><s:text name="roommonitor.video.2X" /></LABEL></TD>
                <TD><INPUT id=ax onclick="return chgsize(0);" type=radio
                  value=radiobutton name=radiobutton> <LABEL for=ax><s:text name="roommonitor.video.FullScr" /></LABEL></TD></TR></TBODY>
             </TABLE>
           </TD>
        </TR>
        <TR>
          <TD height=10>
            <TABLE style="BACKGROUND: url(${ctx}/images/room/video/split.gif) no-repeat"
            height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
              <TBODY>
              <TR>
                <TD>&nbsp;</TD></TR></TBODY></TABLE></TD></TR>
        <TR style='display:none'>
          <TD height=38>
            <TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%"
            border=0>
              <TBODY>
              <TR>
                <TH>
                  <DIV align=left><A
                  onclick="lens_bg.style.visibility = 'visible'"
                  href="http://192.168.17.6/content/advc.asp#"><s:text name="roommonitor.video.LensControl" /></A></DIV>
                  <DIV id=lens_bg
                  style="Z-INDEX: 1; LEFT: 760px; VISIBILITY: hidden; WIDTH: 170px; POSITION: absolute; TOP: 370px; HEIGHT: 180px">
                  <TABLE style="BACKGROUND: url(${ctx}/images/room/video/lens_bg.jpg) no-repeat"
                  height="100%" cellSpacing=0 cellPadding=0 width="100%"
                  border=0>
                    <TBODY>
                    <TR>
                      <TD colSpan=4 height=18>
                        <DIV align=right><INPUT language=javascript id=close_wnd onclick="lens_bg.style.visibility = 'hidden'" type=image
                        src="${ctx}/images/room/video/closebtn.gif" name=close_wnd>
                        </DIV></TD>
                      <TD width=5>&nbsp;</TD></TR>
                    <TR>
                      <TD colSpan=5 height=18></TD></TR>
                    <TR>
                      <TD width=10 height=40></TD>
                      <TD style="VERTICAL-ALIGN: middle"><CENTER><INPUT language=javascript id=w_preset onclick="presetPoint(11, document.all.preset.value)" type=image src="${ctx}/images/room/video/preset_w.gif"
                        name=w_preset> </CENTER></TD>
                      <TD style="VERTICAL-ALIGN: middle">
                        <CENTER><INPUT id=preset maxLength=3 size=6 value=12 name=preset> </CENTER></TD>
                      <TD style="VERTICAL-ALIGN: middle">
                        <CENTER><INPUT language=javascript id=c_preset onclick="presetPoint(10, document.all.preset.value)"
                        type=image src="${ctx}/images/room/video/preset_c.gif"
                        name=c_preset> </CENTER></TD>
                      <TD height=30></TD></TR>
                    <TR>
                      <TD height=40></TD>
                      <TD>
                        <CENTER><INPUT language=javascript
                        onmouseup="ptz_iris(0, 4)" onmousedown="ptz_iris(1, 4);" id=i_add type=image src="${ctx}/images/room/video/on_plus.gif"
                        name=i_add> </CENTER></TD>
                      <TD>
                        <CENTER><s:text name="roommonitor.video.IRIS" /></CENTER></TD>
                      <TD>
                        <CENTER><INPUT language=javascript
                        onmouseup="ptz_iris(0, 5)" onmousedown="ptz_iris(1, 5);" id=i_min type=image src="${ctx}/images/room/video/off_minus.gif"
                        name=i_min> </CENTER></TD>
                      <TD height=30></TD></TR>
                    <TR>
                      <TD height=40></TD>
                      <TD>
                        <CENTER><INPUT language=javascript
                        onmouseup="ptz_iris(0, 6)" onmousedown="ptz_iris(1, 6);" id=f_add type=image src="${ctx}/images/room/video/off_plus.gif"
                        name=f_add> </CENTER></TD>
                      <TD>
                        <CENTER><s:text name="roommonitor.video.FOCUS" /></CENTER></TD>
                      <TD>
                        <CENTER><INPUT language=javascript
                        onmouseup="ptz_iris(0, 7)" onmousedown="ptz_iris(1, 7);" id=f_min type=image src="${ctx}/images/room/video/off_minus.gif"
                        name=f_min> </CENTER></TD>
                      <TD height=30></TD></TR>
                    <TR>
                      <TD colSpan=5></TD></TR></TBODY></TABLE></DIV></TH></TR>
         <TR style='display:none'>
                <TD>
                  <TABLE style="BACKGROUND: url(${ctx}/images/room/video/split.gif) no-repeat" height="100%" cellSpacing=0 cellPadding=0 width="100%"
                  border=0>
                    <TBODY>
                    <TR>
                      <TD>&nbsp;</TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR>
        <TR>
          <TD height=105>
            <TABLE height=105 cellSpacing=0 cellPadding=0 width="100%"
              border=0><TBODY>
              <TR>
                <TH colSpan=2>
                  <DIV align=left><s:text name="roommonitor.video.YuntaiControl" /></DIV></TH>
                <TH>&nbsp;</TH></TR>
              <TR>
                <TD>
                  <DIV align=right><INPUT language=javascript onmouseup="ptz_iris(0, 8);" onmousedown="ptz_iris(1, 8);" id=zm_add type=image src="${ctx}/images/room/video/z_plus.gif" name=zm_add></DIV></TD>
                <TD width=15 rowSpan=3>&nbsp;</TD>
                <TD rowSpan=3>
                  <TABLE style="BACKGROUND: url(${ctx}/images/room/video/ptz_bg.gif) no-repeat" height=80 cellSpacing=0 cellPadding=0 width=80 border=0>
                    <TBODY>
                    <TR>
                      <TD>&nbsp;</TD>
                      <TD>
                        <CENTER><INPUT language=javascript onmouseup="ptz_mv(2, this.name, 0);" onmousedown="ptz_mv(2, this.name, 1);" id=tilt_up type=image src="${ctx}/images/room/video/up_off.gif"
                        name=tilt_up> </CENTER></TD>
                      <TD>&nbsp;</TD></TR>
                    <TR>
                      <TD>
                        <CENTER><INPUT language=javascript onmouseup="ptz_mv(0, this.name, 0);" onmousedown="ptz_mv(0, this.name, 1);" id=span_left type=image src="${ctx}/images/room/video/left_off.gif" name=span_left> </CENTER></TD>
                      <TD>
                        <CENTER><INPUT language=javascript id=d_auto onclick=cruise(this); type=image alt=<s:text name="roommonitor.video.Automatic" /> src="${ctx}/images/room/video/autopan.gif" name=d_auto>
                      </CENTER></TD>
                      <TD>
                        <CENTER><INPUT language=javascript onmouseup="ptz_mv(1, this.name, 0);" onmousedown="ptz_mv(1, this.name, 1);" id=span_right type=image src="${ctx}/images/room/video/right_off.gif"
                        name=span_right> </CENTER></TD></TR>
                    <TR>
                      <TD>&nbsp;</TD>
                      <TD>
                        <CENTER><INPUT language=javascript
                        onmouseup="ptz_mv(3, this.name, 0);"onmousedown="ptz_mv(3, this.name, 1);" id=tilt_down type=image src="${ctx}/images/room/video/down_off.gif"
                        name=tilt_down> </CENTER></TD>
                      <TD>&nbsp;</TD></TR></TBODY></TABLE></TD></TR>
              <TR>
                <TD>&nbsp;</TD></TR>
              <TR>
                <TD>
                  <DIV align=right><INPUT language=javascript
                  onmouseup="ptz_iris(0, 9);" onmousedown="ptz_iris(1, 9);" id=zm_add type=image src="${ctx}/images/room/video/z_minus.gif"
                  name=zm_add></DIV></TD></TR></TBODY></TABLE></TD></TR>
        <TR>
          <TD rowSpan=2>&nbsp;</TD>
          <TD height=60 style="display:none">
            <TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
              <TBODY>
              <TR>
                <TD><s:text name="roommonitor.video.SPEED" /></TD>
                <TD>&nbsp;</TD>
                <TD>&nbsp;</TD></TR>
              <TR>
                <TD colSpan=3 ><?import namespace = "sn" implementation = "${ctx}/video/2k3Slider.html" /><sn:2k3Slider id="mySlider" value="10"
                  onchange="ptz_speed(this.value);"></sn:2k3Slider></TD></TR></TBODY></TABLE></TD>
          <TD rowSpan=2>&nbsp;</TD></TR>
        <TR>
          <TD>&nbsp;</TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
<div id="theEnd" style="position:relative"></div>
</div>
<SCRIPT LANGUAGE="JavaScript">
<!--
function setHeight(theHeight){
	//We do not need it anywhere
	try {
		if (parent != this){
			parent.setHeight(theHeight);
		}
	}catch(e){
	}
} 

function getTotalHeight(){
	var ele = document.getElementById("theEnd");
	// check it first.
	if (ele != null) {
		return ele.offsetTop;
	}
	return 0;
}


//-->
</SCRIPT>
</BODY>
</HTML>
