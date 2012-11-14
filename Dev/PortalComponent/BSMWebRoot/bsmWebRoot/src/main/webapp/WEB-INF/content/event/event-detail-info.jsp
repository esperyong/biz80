<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>事件详细信息</title>
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" ></link>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/combobox/simplebox.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    $("#topBtn1").click(function() {
        window.close();
    });
    $("#cancel_button").click(function() {
        window.close();
    });
});
</script>
<style type="text/css">
.focus{
      border:1px solid #f00;
      background:#fcc;
}
</style>
</head>
<body>
<div id="loading" style="display:none">加载中...</div>
<s:if test="modelType != 'notification'">
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
    <page:applyDecorator name="popwindow"  title="事件详细信息">
    
        <page:param name="width">700px</page:param>
        <page:param name="topBtn_index_1">1</page:param>
        <page:param name="topBtn_id_1">topBtn1</page:param>
        <page:param name="topBtn_css_1">win-ico win-close</page:param>
        
        <page:param name="bottomBtn_index_1">1</page:param>
        <page:param name="bottomBtn_id_1">cancel_button</page:param>
        <page:param name="bottomBtn_text_1">关闭</page:param>
        
        <page:param name="content">
        <fieldset class="blue-border" style="width:650px">
        <legend>事件信息</legend>
        <table class="fitwid"  style="table-layout: auto;">
            <tr>
                <td width="80px"><span>事件内容：</span></td><td colspan="3" width="570px"><DIV STYLE="overflow: hidden; text-overflow:ellipsis; width:550px" title="${eventDetailInfoVO.message}"><NOBR>${eventDetailInfoVO.message}</NOBR></DIV></td>
            </tr>
            <tr>
                <td width="80px"><span>平台&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：</span></td><td width="260px">${eventDetailInfoVO.dependencySystem}</td><td width="80px"><span>事件类型：</span></td><td width="230px">${eventDetailInfoVO.eventType}</td>
            </tr>
            <tr>
                <td width="80px"><span>级别&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：</span></td><td colspan="3" width="570px">${eventDetailInfoVO.serverityName}</td>
            </tr>
            <tr>
                <td width="80px"><span>产生时间：</span></td><td width="265px">${eventDetailInfoVO.occurTimePage}</td><td width="80px"><span>确认时间：</span></td><td width="225px">${eventDetailInfoVO.recoveryTimePage}</td>
            </tr>
        </table>
        </fieldset>
        <fieldset class="blue-border" style="width:650px">
        <legend>事件对象</legend>
        <!--  table class="fitwid">
            <tr>
                <td width="75px"><span>事件对象&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></td><td width="30px">：</td><td width="220px"><DIV STYLE="overflow: hidden; text-overflow:ellipsis" title="${eventDetailInfoVO.objectName}"><NOBR>${eventDetailInfoVO.objectName}</NOBR></DIV></td><td width="40px"><span>IP地址</span></td><td width="30px">：</td><td>${eventDetailInfoVO.ipAddress}</td>
            </tr>
            <tr>
                <td><span>事件对象类型</span></td><td>：</td><td>${eventDetailInfoVO.objectType}</td><td><span><DIV STYLE="overflow: hidden; text-overflow:ellipsis" title="<s:property value="@com.mocha.bsm.event.common.RangeName@rangeName()"/>"><NOBR><s:property value="@com.mocha.bsm.event.common.RangeName@rangeName()"/></NOBR></DIV></span></td><td>：</td><td>${eventDetailInfoVO.userDomainName}</td>
            </tr>
        </table>-->
        <ul class="fieldlist-n">
          <li class="twocolumn left"> <span class="field-middle"><nobr>事件对象</nobr></span><span>：</span> <span><DIV STYLE="overflow: hidden; text-overflow:ellipsis;width:200px" title="<s:property value="eventDetailInfoVO.objectName"/>"><NOBR><s:property value="eventDetailInfoVO.objectName"/></NOBR></DIV></span> </li>
          <li class="twocolumn left"> <span class="field-middle">IP地址</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>：</span>&nbsp;&nbsp;<span><s:property escape="false" value="eventDetailInfoVO.ipAddress"/></span> </li>
          <li class="twocolumn left"> <span class="field-middle"><nobr>事件对象类型</nobr></span><span>：</span> <span><s:property value="eventDetailInfoVO.objectType"/></span> </li>
          <li class="twocolumn left"> <span class="field-middle"><s:property value="@com.mocha.bsm.event.common.RangeName@rangeName()"/></span>&nbsp;&nbsp;&nbsp;&nbsp;<span>：</span> <span>
          <span STYLE='width:180px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;' title='<s:property value="eventDetailInfoVO.userDomainName"/>'><s:property value="eventDetailInfoVO.userDomainName"/></span></span> </li>
        </ul>
        </fieldset>
        <div  class="txt-blue lineheight21" style="margin-left:10px; margin-right:10px;">注：资源配置、自定义事件、脚本、日志、Syslog、SNMP Trap、IP-MAC、流量分析事件没有恢复事件，产生24小时<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;后系统自动确认。</div>
        </page:param>
    </page:applyDecorator>
</s:if>
<s:if test="modelType == 'notification'">
    <fieldset class="blue-border" style="width:650px">
        <legend>事件信息</legend>
        <table class="fitwid"  style="table-layout: auto;">
            <tr>
                <td width="80px"><span>事件内容：</span></td><td colspan="3" width="570px"><DIV STYLE="overflow: hidden; text-overflow:ellipsis; width:550px" title="${eventDetailInfoVO.message}"><NOBR>${eventDetailInfoVO.message}</NOBR></DIV></td>
            </tr>
            <tr>
                <td width="80px"><span>平台&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：</span></td><td width="260px">${eventDetailInfoVO.dependencySystem}</td><td width="80px"><span>事件类型：</span></td><td width="230px">${eventDetailInfoVO.eventType}</td>
            </tr>
            <tr>
                <td width="80px"><span>级别&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：</span></td><td colspan="3" width="570px">${eventDetailInfoVO.serverityName}</td>
            </tr>
            <tr>
                <td width="80px"><span>产生时间：</span></td><td width="265px">${eventDetailInfoVO.occurTimePage}</td><td width="80px"><span>确认时间：</span></td><td width="225px">${eventDetailInfoVO.recoveryTimePage}</td>
            </tr>
        </table>
        </fieldset>
        <fieldset class="blue-border" style="width:650px">
        <legend>事件对象</legend>
        
        
        <ul class="fieldlist-n">
          <li class="twocolumn left"> <span class="field-middle"><nobr>事件对象</nobr></span><span>：</span> <span><DIV STYLE="overflow: hidden; text-overflow:ellipsis;width:200px" title="<s:property value="eventDetailInfoVO.objectName"/>"><NOBR><s:property value="eventDetailInfoVO.objectName"/></NOBR></DIV></span> </li>
          <li class="twocolumn left"> <span class="field-middle">IP地址</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>：</span>&nbsp;&nbsp;<span><s:property escape="false" value="eventDetailInfoVO.ipAddress"/></span> </li>
          <li class="twocolumn left"> <span class="field-middle"><nobr>事件对象类型</nobr></span><span>：</span> <span><s:property value="eventDetailInfoVO.objectType"/></span> </li>
          <li class="twocolumn left"> <span class="field-middle"><s:property value="@com.mocha.bsm.event.common.RangeName@rangeName()"/></span>&nbsp;&nbsp;&nbsp;&nbsp;<span>：</span> <span>
          <span STYLE='width:180px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;' title='<s:property value="eventDetailInfoVO.userDomainName"/>'><s:property value="eventDetailInfoVO.userDomainName"/></span></span> </li>
        </ul>
        
        
        </fieldset>
    <div  class="txt-blue lineheight21" style="margin-left:10px; margin-right:10px;">注：资源配置、自定义事件、脚本、日志、Syslog、SNMP Trap、IP-MAC、流量分析事件没有恢复事件，产生24小时<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;后系统自动确认。</div>
</s:if>
</body>
<s:if test="eventDetailInfoVO == null">
    <script>
        alert("该事件已经不在此事件列表中，请刷新事件列表。");
        window.close();
    </script>
</s:if>
<script type="text/javascript">
$(function(){
    SimpleBox.renderTo([{
    id:"ipAddress",//下拉列表的id
    iconIndex:"0",//下拉列表的渲染图片的索引值
    iconClass:"combox_ico_select f-absolute",//下拉列表中的渲染图片样式
    iconTitle:"管理IP",//下拉列表的渲染图片上的提示
    width:133
    }]);
});
</script>
</html>