<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>加入监控</title>
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript">
$(document).ready(function() {
   
  $("#closeId").bind("click", function() {
    window.close();
  });
  
})
</script>
</head>
<body class="pop-window">

<page:applyDecorator name="popwindow"  title="加入监控">
  
  <page:param name="width">500px</page:param>
  <page:param name="height">190px</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">closeId</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="topBtn_title_1">关闭</page:param>
  
  <page:param name="content">

	<s:if test="result == 2">
	  <div style="padding:5px;margin-top:60px;"></h1>
	   <SPAN class="promp-win-ico promp-win-ico-alert"><SPAN class="txt" style="margin-top:5px;">产品监控的资源数量已超过限额，请联络摩卡软件获取购买支持更多数量License的信息。</SPAN></SPAN>
	  </div>
	</s:if>
	<s:else>
  <span class="margin8 bold lineheight21">监控结果：<s:property value="result" /></span>
	<ul>
	  <li class="margin8 bold lineheight21">
	    <table class="gray-table table-width100 table-grayborder">
	      <tr>
	        <th style="width:35%;">预计加入监控</th><th>：<s:property value="total" /></th>
	      </tr>
	      <tr>
	        <td class="underline">加入监控成功</td>
	        <td class="underline">：<s:property value="success" /></td>
	      </tr>
	      <tr>
	        <td class="underline">加入监控失败</td>
	        <td class="underline">：<span class="txt-red"><s:property value="failure" /></span></td>
	      </tr>
        <tr>
          <td class="underline">已被监控</td>
          <td class="underline">：<span><s:property value="monitored" /></span></td>
        </tr>
        <tr>
          <td class="underline">无法加入监控(PC)</td>
          <td class="underline">：<span><s:property value="pc" /></span></td>
        </tr>
	    </table>
	  </li>
	</ul>
  </s:else>
  </page:param>
</page:applyDecorator>

</body>
</html>