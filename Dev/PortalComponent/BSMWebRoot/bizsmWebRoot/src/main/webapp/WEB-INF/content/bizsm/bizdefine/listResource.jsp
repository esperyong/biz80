<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<s:if test="model.resultMap.keySet().size != 0">
	<table width="100%" align="center" cellpadding="0" cellspacing="0" id="dataTbl_<s:property value="{model.resultMap.values().toArray()[0].parentId.toString()}"/>">
		<s:iterator value="model.resultMap" status="status">
			<tr resURI="<s:property value="value.uri"/>" resID="<s:property value="value.resourceInstanceId"/>" onclick="f_selectResDataRow('<s:property value="value.uri"/>')">
				<td width="23px">
					<s:if test="value.monitered==true">
						<span class="state state-use" style="display:inline-block" title="已监控"/>&nbsp;
					</s:if>
					<s:else>
						<span class="state state-unuse"  style="display:inline-block" title="未监控"/>&nbsp;
					</s:else>
			   </td>
			   <td>
				  <nobr>
					 <div style="display:inline-block" class="nobrResName" title="<s:property value="value.resourceName"/><s:if test="value.discoveryIp!=null"><s:if test="value.discoveryIp!=''">(<s:property value="value.discoveryIp"/>)</s:if></s:if>">
						<s:property value="value.resourceName"/><s:if test="value.discoveryIp!=null"><s:if test="value.discoveryIp!=''">(<s:property value="value.discoveryIp"/>)</s:if></s:if>
					 </div>
				  </nobr>
			   </td>
			</tr>
		</s:iterator>
	</table>
	<br>
	<div style="width:100%;text-align:center">
		<span style="width:100px;background-color:gray;font-color:white;font-weight:900;border:1px solid gray;cursor:hand" onclick='f_pageForward("<s:property value="{model.resultMap.values().toArray()[0].parentId}"/>", "<s:property value="model.pageNo"/>", "<s:property value="model.pageSize"/>", "first")'>&lt;&lt;</span>
		&nbsp;&nbsp;
		<span style="width:100px;background-color:gray;font-color:white;font-weight:900;border:1px solid gray;cursor:hand" onclick='f_pageForward("<s:property value="{model.resultMap.values().toArray()[0].parentId}"/>", "<s:property value="model.pageNo"/>", "<s:property value="model.pageSize"/>", "pre")'>&lt;</span>
		&nbsp;<span style="width:100px;font-color:white;font-weight:900;cursor:default;"><s:property value="model.pageNo"/>/<s:property value="model.pageSize"/></span>&nbsp;
		<span style="width:100px;background-color:gray;font-color:white;font-weight:900;border:1px solid gray;cursor:hand" onclick='f_pageForward("<s:property value="{model.resultMap.values().toArray()[0].parentId}"/>", "<s:property value="model.pageNo"/>", "<s:property value="model.pageSize"/>", "next")'>&gt;</span>
		&nbsp;&nbsp;
		<span style="width:100px;background-color:gray;font-color:white;font-weight:900;border:1px solid gray;cursor:hand" onclick='f_pageForward("<s:property value="{model.resultMap.values().toArray()[0].parentId}"/>", "<s:property value="model.pageNo"/>", "<s:property value="model.pageSize"/>", "last")'>&gt;&gt;</span>
	</div>
 </s:if>