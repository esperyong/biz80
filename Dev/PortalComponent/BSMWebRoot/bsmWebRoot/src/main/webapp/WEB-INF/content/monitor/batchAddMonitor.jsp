<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>批量加入监控</title>
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
</head>
<body class="pop-window">
<page:applyDecorator name="popwindow"  title="批量加入监控">
  <page:param name="width">500px</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">closeId</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="topBtn_title_1">关闭</page:param>
  <page:param name="bottomBtn_index_1">1</page:param>
  <page:param name="bottomBtn_id_1">submitForm</page:param>
  <page:param name="bottomBtn_text_1">确定</page:param>
  <page:param name="content">
  <span class="margin8 bold lineheight21">监控结果：</span>
	<ul>
	  <li class="margin8 bold lineheight21">
	    <table class="gray-table table-width100 table-grayborder">
	      <tr>
	        <th style="width:35%;">预计加入监控</th><th>：<s:property value="expectedCount" /></th>
	      </tr>
	      <tr>
	        <td class="underline">加入监控成功</td>
	        <td class="underline">：<s:property value="successCount" /></td>
	      </tr>
	      <tr>
	        <td class="underline">加入监控失败</td>
	        <td class="underline">：<span class="txt-red"><s:property value="failureCount" /></span></td>
	      </tr>
        <tr>
          <td class="underline">已被监控</td>
          <td class="underline">：<span><s:property value="monitoringCount" /></span></td>
        </tr>
        <tr>
          <td class="underline">无法加入监控(PC)</td>
          <td class="underline">：<span><s:property value="pcCount" /></span></td>
        </tr>
	    </table>
	  </li>
	</ul>
  </page:param>
</page:applyDecorator>
<script type="text/javascript">
var successCount = <s:property value="successCount" />;
$(function() {
	if(Number(successCount) != 0){
		opener.Monitor.Resource.right.refresh('<s:property value="pointId"/>','monitor','<s:property value="whichTree"/>','<s:property value="whichGrid"/>','<s:property value="currentTree"/>','<s:property value="currentResourceTree"/>',"/monitor/monitorList.action");
	}
  $("#closeId,#submitForm").bind("click", function() {
     window.close();
  });
});
</script>
</body>
</html>