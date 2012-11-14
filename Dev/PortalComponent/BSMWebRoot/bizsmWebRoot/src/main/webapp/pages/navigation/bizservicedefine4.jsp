<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@taglib prefix="decorator"
 uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<%@ page import="com.mocha.bsm.bizsm.core.util.LicenseUtil"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%
	int operateCount = LicenseUtil.getBizServiceOperateCount();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<title>bsm8.0</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
    window.open(theURL,winName,features);
}

function MM_jumpMenu(targ,selObj,restore){ //v3.0
    eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
    if (restore) selObj.selectedIndex=0;
}
function frameResize(){
document.getElementById("RightFrame").style.height=RightFrame.document.body.scrollHeight+"px";
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function closeWindow(){
	window.close();
}
//-->
</script>
<style type="text/css">
<!--
#Layer1 {
	position:absolute;
	left:380px;
	top:276px;
	width:161px;
	height:109px;
	z-index:1;
}
#Layer6 {
	position:absolute;
	left:406px;
	top:292px;
	width:345px;
	height:110px;
	z-index:3;
	visibility: hidden;
}
#Layer {
	position:absolute;
	left:515px;
	top:221px;
	width:345px;
	height:110px;
	z-index:3;
	visibility: hidden;
}
-->
</style>
</head>

<body onload="MM_preloadImages('${ctx}/images/navigation/fx0101.jpg','${ctx}/images/navigation/fx0102.jpg','${ctx}/images/navigation/fx0103.jpg','${ctx}/images/navigation/fx0104.jpg','${ctx}/images/navigation/fx0105.jpg','${ctx}/images/navigation/guide-nav-step-01-on.gif','${ctx}/images/navigation/guide-nav-step-02-on.gif','${ctx}/images/navigation/guide-nav-step-03-on.gif','${ctx}/images/navigation/guide-nav-step-04-on.gif','${ctx}/images/navigation/bizservice-step-01-on.jpg','${ctx}/images/navigation/bizservice-step-02-on.jpg','${ctx}/images/navigation/bizservice-step-03-on.jpg','${ctx}/images/navigation/bizservice-step-04-on.jpg','${ctx}/images/navigation/bizservice-step-05-on.jpg')" scroll="auto">
<map name="MapMap" id="Map2">
  <area shape="rect" coords="48,547,122,567" href="../discovery/excel.htm" />
</map>
<table width="900" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><img src="${ctx}/images/navigation/tanchu0101.jpg" width="8" height="30" /></td>
    <td background="${ctx}/images/navigation/tanchu03.jpg"><table width="100%" cellspacing="0" cellpadding="0">
      <tr>
        <td width="2%"><img src="${ctx}/images/navigation/tanchu02.jpg" width="10" height="30" hspace="4" /></td>
        <td width="95%" class="txt-white"><strong>业务服务定义向导</strong></td>
        <td width="3%"><img src="${ctx}/images/navigation/tanchu04.jpg" width="24" height="30" style="cursor:hand;" onclick="javascript:closeWindow()"/></td>
      </tr>
    </table></td>
    <td><img src="${ctx}/images/navigation/tanchu05.jpg" width="6" height="30" /></td>
  </tr>
  <tr>
    <td background="${ctx}/images/navigation/tanchu06.jpg">&nbsp;</td>
    <td valign="top"><table width="884" cellpadding="0" cellspacing="0">
      <tr>
        <td width="185" height="500" align="center" valign="top" background="${ctx}/images/navigation/guide-nav-bg-185.gif"><table width="175" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td background="${ctx}/images/navigation/guide-nav-bg.gif"><table width="175" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><table width="175" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td><a href="bizservicedefine1.jsp" onmouseover="MM_swapImage('step01','','${ctx}/images/navigation/bizservice-step-01-on.jpg',1)" onmouseout="MM_swapImgRestore()"><img src="${ctx}/images/navigation/bizservice-step-01-off.jpg" name="step01" width="175" height="55" border="0" id="step01" /></a></td>
                  </tr>
                  <tr>
                    <td height="15"></td>
                  </tr>
                  <tr>
                    <td><a href="bizservicedefine2.jsp" onmouseover="MM_swapImage('step02','','${ctx}/images/navigation/bizservice-step-02-on.jpg',1)" onmouseout="MM_swapImgRestore()"><img src="${ctx}/images/navigation/bizservice-step-02-off.jpg" name="step02" width="175" height="55" border="0" id="step02" /></a></td>
                  </tr>
                  <tr>
                    <td height="15"></td>
                  </tr>
                  <tr>
                    <td><a href="bizservicedefine3.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('step03','','${ctx}/images/navigation/bizservice-step-03-on.jpg',1)"><img src="${ctx}/images/navigation/bizservice-step-03-off.jpg" name="step03" width="175" height="55" border="0" id="step03" /></a></td>
                  </tr>
                  <tr>
                    <td height="15"></td>
                  </tr>
                  <tr>
                    <td><a href="bizservicedefine4.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('step04','','${ctx}/images/navigation/bizservice-step-04-on.jpg',1)"><img src="${ctx}/images/navigation/bizservice-step-04-on.jpg" name="step04" width="175" height="55" border="0" id="step04" /></a></td>
                  </tr>
                  <tr>
                    <td height="15"></td>
                  </tr>
                  <tr>
                    <td><a href="bizservicedefine5.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('step05','','${ctx}/images/navigation/bizservice-step-05-on.jpg',1)"><img src="${ctx}/images/navigation/bizservice-step-05-off.jpg" name="step05" width="175" height="55" border="0" id="step05" /></a></td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table></td>
        <td width="699" valign="top" bgcolor="#FFFFFF"><table width="100%" cellspacing="0" cellpadding="0">
          <tr>
            <td width="100%" height="30" background="${ctx}/images/navigation/xiala01.jpg"><strong>&nbsp; 第四步：设置告警规则</strong></td>
          </tr>
        </table>
              <table width="100%" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="100%" align="center" valign="top"><table width="99%" cellpadding="6" cellspacing="0">
                    <tr>
                      <td colspan="2" align="left">1.在‘监控设置-&gt;事件定义’页面设置需要告警的事件。</td>
                    </tr>
                    <tr>
                      <td width="3%" align="left">&nbsp;</td>
                      <td width="97%" align="left"><img src="${ctx}/images/navigation/help-shijian.jpg" width="629" height="245" /></td>
                    </tr>
                    <tr>
                      <td colspan="2" align="left">2.在‘监控设置-&gt;告警定义’页面设置告警规则。</td>
                    </tr>
                    <tr>
                      <td align="left" valign="top">&nbsp;</td>
                      <td align="left" valign="top"><img src="${ctx}/images/navigation/help-alert.jpg" width="663" height="220" /></td>
                    </tr>
                  </table>
                  <a href="../jiankong/xinjiangjcl-tanchu01.htm"></a></td>
                </tr>
            </table></td>
      </tr>
    </table></td>
    <td background="${ctx}/images/navigation/tanchu07.jpg"><img src="${ctx}/images/navigation/tanchu07.jpg" width="6" height="4" /></td>
  </tr>
  <tr>
    <td><img src="${ctx}/images/navigation/tanchu08.jpg" width="8" height="26" /></td>
    <td align="right" background="${ctx}/images/navigation/tanchu09.jpg"><table width="100%" cellpadding="0" cellspacing="0">
      <tr>
        <td width="86%">&nbsp;</td>
        <td width="14%">&nbsp;</td>
      </tr>
    </table></td>
    <td><img src="${ctx}/images/navigation/tanchu10.jpg" width="6" height="26" /></td>
  </tr>
</table>
<map name="Map" id="Map">
  <area shape="rect" coords="47,546,121,566" href="../discovery/link.htm" />
  <area shape="rect" coords="45,595,125,617" href="../discovery/excel.htm" />
  <area shape="rect" coords="41,444,117,516" href="../discovery/IP.htm" />
  <area shape="rect" coords="43,283,119,355" href="../discovery/globale.htm" />
  <area shape="rect" coords="40,109,116,181" href="../discovery/home.htm" />
  <area shape="rect" coords="41,34,117,106" href="../discovery/network.htm" />
</map>
</body>
</html>
