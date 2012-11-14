<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/WEB-INF/common/meta.jsp"%>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/master.css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/css/public.css" />
	<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css"/>
	<title><s:text name="detail.info.usability" /></title>
</head>
<body>
<s:set var="vToday" value="%{@com.mocha.bsm.detail.business.AvailStatisticsMgr@AVAIL_TODAY}" />
<s:set var="vYesterday" value="%{@com.mocha.bsm.detail.business.AvailStatisticsMgr@AVAIL_YESTERDAY}" />
<s:set var="v7Days" value="%{@com.mocha.bsm.detail.business.AvailStatisticsMgr@AVAIL_7_DAYS}" />
<s:set var="vMonth" value="%{@com.mocha.bsm.detail.business.AvailStatisticsMgr@AVAIL_MONTH}" />
<s:set var="vYear" value="%{@com.mocha.bsm.detail.business.AvailStatisticsMgr@AVAIL_YEAR}" />
<s:set var="P_SIZE" value="%{@com.mocha.bsm.detail.business.AvailStatisticsMgr@PAGE_SIZE}" />

<page:applyDecorator name="popwindow">
  <page:param name="title"><s:text name="detail.info.usability" /></page:param>
  <page:param name="width">300px;</page:param>
  <page:param name="height">180px;</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">win_close</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="topBtn_title_1"><s:text name="i18n.close" /></page:param>
  
  <page:param name="content">
    <div class="h2"><span class="lineheight21"><s:text name="detail.info.usability" />&nbsp;&nbsp;</span><span class="ico ico-what" title="<s:text name="avail.statistics.help" />" style="cursor:default;"></span><span id="availPie" class='ico ico-pie' title='<s:text name="detail.info.usability" />'></span></div>
    <ul class="fieldlist">
      <li><span class="field">&nbsp;&nbsp;<s:text name="detail.typical.today" /></span><s:text name="i18n.colon" /><s:property value="availValueMap[#vToday]" default="-"/><s:if test="availValueMap[#vToday]!=null && availValueMap[#vToday]!='-'">%</s:if></li>
      <li><span class="field">&nbsp;&nbsp;<s:text name="detail.typical.yesterday" /></span><s:text name="i18n.colon" /><s:property value="availValueMap[#vYesterday]" default="-"/><s:if test="availValueMap[#vYesterday]!=null && availValueMap[#vYesterday]!='-'">%</s:if></li>
      <li><span class="field">&nbsp;&nbsp;<s:text name="detail.typical.sevendays" /></span><s:text name="i18n.colon" /><s:property value="availValueMap[#v7Days]" default="-"/><s:if test="availValueMap[#v7Days]!=null && availValueMap[#v7Days]!='-'">%</s:if></li>
      <li><span class="field">&nbsp;&nbsp;<s:text name="detail.typical.month" /></span><s:text name="i18n.colon" /><s:property value="availValueMap[#vMonth]" default="-"/><s:if test="availValueMap[#vMonth]!=null && availValueMap[#vMonth]!='-'">%</s:if></li>
      <li><span class="field">&nbsp;&nbsp;<s:text name="detail.typical.year" /></span><s:text name="i18n.colon" /><s:property value="availValueMap[#vYear]" default="-"/><s:if test="availValueMap[#vYear]!=null && availValueMap[#vYear]!='-'">%</s:if></li>
    </ul>
  </page:param>

</page:applyDecorator>
<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript" src="${ctxJs}/component/comm/winopen.js"></script> 
<script type="text/javascript" src="${ctxJs}/component/popwindow/popwin.js"></script>
<script>
  $(function(){
    var ctxpath = "${ctx}";
    $('#win_close').click(function(){
      window.close();
    });

    $("#availPie").click(function(){
      var url = ctxpath + "/detail/availstatistics!typicalAvailDetail.action?instanceId=${instanceId}";
      winOpen({url:url,width:600,height:660,name:'availdetailwindow'});
    });
  });
</script>
</body>
</html>