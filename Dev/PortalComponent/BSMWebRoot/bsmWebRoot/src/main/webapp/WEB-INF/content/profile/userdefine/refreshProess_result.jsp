<%@page import="com.mocha.bsm.profile.type.alarm.SendAlarmFreqEnum"%>
<%@page import="com.mocha.bsm.commonrule.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
</head>
<body>
<p>获取结果</p>
<table  class="grayhead-table grayborder table-width100" id="result_table">
	<thead>
	<tr>
		<th width="5%" class="fold-top-title"><input id="proessId" type="checkbox"/></th>
		<th width="80%" class="fold-top-title">进程名称</th>
		<th width="15%" class="fold-top-title">加入策略</th>
	</tr>
	</thead>
	<tbody>
	<s:iterator id="obj" value="processList" status="st">
		<tr class="fold-greybg">
			<td width="5%" class="gray-bottom"><div style="text-overflow: ellipsis; overflow: hidden;">
				<input name="processPath" type="checkbox" value="<s:property value="#obj.Lan"/>"
  <s:if test="#obj.monitored==true">checked disabled</s:if>
  /></div>
			</td>
			<td width="80%" class="gray-bottom">
				<div style="text-overflow: ellipsis; overflow: hidden;">
				<nobr><font title="<s:property value="#obj.Lan"/>"><s:property value="#obj.Lan"/></font></nobr>
				</div>
			</td>
			<td width="15%" class="gray-bottom">
				<div style="text-overflow: ellipsis; overflow: hidden;">
				<nobr><font title="<s:property value="#obj.profileState"/>"><s:property value="#obj.profileState"/></font></nobr></div>
			</td>
		</tr>
	</tbody>
	</s:iterator>
</table>
 <script>
  $(function(){
        $("#proessId").click(function() {
	    	  $("input[name=processPath]:enabled").attr("checked",$(this).attr("checked"));
	      });
  });
  </script>
</body>
</html>