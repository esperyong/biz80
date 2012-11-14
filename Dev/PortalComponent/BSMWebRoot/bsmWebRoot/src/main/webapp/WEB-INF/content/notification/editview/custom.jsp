<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%--
	告警试图定制---自定义告警对象页面.
	custom.jsp
	weiyi.
 --%>

<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<div class="monitor"  id="contentDIV3">
<div class="panel-gray  table-noborder">
	<div class="panel-gray-top toplinegray">
		<span class="panel-gray-ico panel-gray-ico-close" id="del_line"></span>
		<span class="panel-gray-ico panel-gray-ico-add" id="add_line"></span>
		<span class=panel-gray-title>自定义过滤条件</span> 
	</div>
<div class="panel-gray-content padding8">
<div style="display:none;">
<select id="custom_type"><option value="INSTANCEID">告警对象</option><option value="IPADDRESS">IP地址</option></select>
<select id="object_relation"><option value="INCLUDE">包含</option><option value="NOT_INCLUDE">不包含</option><option value="START_WITH">开始于</option><option value="END_WITH">结束于</option></select>
<select id="ip_relation"><option value="INCLUDE">包含</option><option value="NOT_INCLUDE">不包含</option></select>
</div>
<div style="heidht:50px;overflow:auto;">
<table class="black-grid black-grid-blackb table-width100">
<thead>
	<tr>
		<th width="4%" style="text-align : center"><input type="checkbox" id="checkall"></th>
		<th width="18%" style="text-align : center">内容</th>
		<th style="text-align : center">条件</th>
		<th width="6%" style="text-align : center">关系</th>
	</tr>
</thead>
<tbody id="custom_lines" >
<tr id="ndel">
	<td><input type="checkbox" disabled></td>
	<td>告警对象类型<input type="hidden" name="" value="${obj_type.value}" id="obj_type_ids"/></td>
	<td><select disabled><option value="EQUAL">等于</option></select><input size=50 class="input-single" onFocus="javascript:this.blur()" id="obj_type_name" value="${obj_type_names}"/>
	<SPAN id="chooseObjType" class="black-btn-l" ><SPAN class=btn-r><SPAN class=btn-m><A onFocus="undefined">选择</A></SPAN></SPAN></SPAN>
	<input type="hidden" name="" value="${obj_type.condition}"/>
	<input type="hidden" name="" value="${obj_type.value}" />
	</td>
	<td>并</td>
</tr>
<%--
<tr class=black-grid-graybg>
	<td><input type="checkbox" onclick="unChecked(this)"></td>
	<td>事件内容</td><td>事件内容</td><td>并</td>
</tr>
--%>
<s:iterator value="customObjects" id="c_obj" status="s">
<tr <s:if test="#s.even">class=black-grid-graybg</s:if> lineNum="${s.index}">
	<td><input type="checkbox" onclick="unChecked(this)"></td>
	<td><s:select list="@com.mocha.bsm.notification.util.enums.CustomContentTypeEnum2@values()" listKey="key" listValue="value" value="#c_obj.content" name="chooseViewObjType"></s:select></td>
	<td><s:if test="#c_obj.content=='INSTANCEID'">
	<s:select list="@com.mocha.bsm.notification.util.enums.CustomObjTypeRelationEnum@values()" listKey="key" listValue="value" value="#c_obj.condition"></s:select>
	</s:if><s:else>
	<s:select list="@com.mocha.bsm.notification.util.enums.CustomIPRelationEnum@values()" listKey="key" listValue="value" value="#c_obj.condition"></s:select>
	</s:else><input value="${c_obj.value}" class="input-single" size="50"/></td>
	<td>并</td>
</tr>
</s:iterator>
</tbody>
</table>
</div>
</DIV>
</div>
</div>
<script type="text/javascript" src="${ctxJs}/notification/editview/custom.js"></script>
<script type="text/javascript">
//var pageObj = document.getElementById("contentDIV3");
//var pHeight = pageObj.offsetHeight;
//parent.setBodyHeight(pHeight);
</script>