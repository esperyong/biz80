<!-- 机房-机房定义-机房设施管理-单个添加指标   addMetricInfo.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<s:if test="isUpdate=='true'">
	<title>修改指标</title>
</s:if>
<s:else>
	<title>添加指标</title>
</s:else>

<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" 
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/button-module.css" rel="stylesheet" type="text/css">
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>

<style type="text/css">
	li.myHeight{
		height:25px;
	}
</style>

<%
	ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
	String saveFlag = "";
	String roomId = "";
	String catalogId = "";
	String resourceId = "";
	String errorMsg = "";
	long exeTime =0l;
	String finalVal = "";
	String oriVal = "";
	int status = 0;
	if(null != vs && !"".equals(vs)){
		if(vs.findValue("saveFlag") != null && !"".equals(vs.findValue("saveFlag"))){
			saveFlag = (String)vs.findValue("saveFlag");
			roomId = (String)vs.findValue("roomId");
			catalogId = (String)vs.findValue("catalogId");
			resourceId = (String)vs.findValue("resourceId");
			
			//System.out.println("aaaa:"+roomId);
			//System.out.println("aaaa:"+resourceId);
		}
		if(vs.findValue("errorMsg") != null && !"".equals(vs.findValue("errorMsg"))){
			errorMsg = (String)vs.findValue("errorMsg");
		}
		if(vs.findValue("exeTime") != null && !"".equals(vs.findValue("exeTime"))){
			//System.out.println(vs.findValue("exeTime"));
			exeTime = Long.parseLong(vs.findValue("exeTime").toString());
			//String a = (String)vs.findValue("exeTime");
			//exeTime = Long.parseLong(a);
			//System.out.println("exeTime:"+a);
			//System.out.println("exeTime:"+exeTime);
			//exeTime = (long)vs.findValue("exeTime");
		}
		if(vs.findValue("finalVal") != null && !"".equals(vs.findValue("finalVal"))){
			finalVal = (String)vs.findValue("finalVal");
		}
		if(vs.findValue("oriVal") != null && !"".equals(vs.findValue("oriVal"))){
			oriVal = (String)vs.findValue("oriVal");
		}
		if(vs.findValue("status") != null && !"".equals(vs.findValue("status"))){
		 	//System.out.println(vs.findValue("status"));
			status = Integer.parseInt(vs.findValue("status").toString());
			//String a = (String)vs.findValue("status");
			//status = Integer.getInteger(a);
			//System.out.println("status:"+a);
			//status = (int)vs.findValue("status");
		}
	}
%>
<script>
var panel;
/**
 * 取值显示层.
 */
function displayPanel(displayStr) {
	if(panel){panel.close("close");}
		panel = new winPanel({
	    html:displayStr,
	    width:280,
	    x:400,
	    y:150,
	    isautoclose:true,
	    isDrag:true,
	    listeners:{
	      closeAfter:function(){
	          panel = null;
	      },
	      loadAfter:function(){
	    		
	      }
	    }
		},{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"});
}
var toast = new Toast({position:"CT"});
try{
	if("<%=saveFlag%>" == "true") {
		var loadStr = parent.window.opener.location.href;
		if(loadStr.indexOf("DevTypeManagerVisit")>=0 || loadStr.indexOf("DeleteMetric")>=0 ||loadStr.indexOf("DeleteUserDefineType")>=0){
			parent.window.opener.focusMetric("<%=resourceId%>_next","<%=catalogId%>","<%=resourceId%>");
		}else if(loadStr.indexOf("ResourcePropertyVisit")>=0 || loadStr.indexOf("ResourceProperty")>=0){
			parent.window.opener.loadDataTable("<%=roomId%>");
		}else if(loadStr.indexOf("IndexVisit")>=0){
			var isJigui = parent.window.opener.$("#isJigui").val();
			var capacityId = parent.window.opener.$("#capacityId").val();
			parent.window.opener.ajaxJiGUIFun("<%=roomId%>","<%=resourceId%>","dynamicJsptreeChange1Id","${ctx}/roomDefine/ResMetricVisit.action?treeTarget=true&capacityId="+capacityId+"&isJigui="+isJigui);
			//window.opener.location.href="${ctx}/roomDefine/IndexVisit.action?roomId=<%=roomId%>&saveFlag=deviceManager";
		}
		else{
			//parent.window.opener.location.href="${ctx}/roomDefine/ResourcePropertyVisit.action?roomId=<%=roomId%>&capacityId=<%=catalogId%>&componentId=<%=resourceId%>";
		}
		parent.window.close();
	}else if("<%=saveFlag%>" == "testVal"){
		var displaystr = new Array();
		if('<%=errorMsg%>' == "" || '<%=errorMsg%>' == "null"){
			displaystr.push("取值正确：结果如下<br/>");
			displaystr.push("执行时间：<%=exeTime%><br/>");
			displaystr.push("原始值：<%=oriVal%><br/>");
			displaystr.push("执行后取值：<%=finalVal%><br/>");
			var stateStr="";
			//0无状态, 1正常, -1异常
			if("<%=status%>" == "0"){
				stateStr="无状态";
			}else if("<%=status%>" == "1"){
				stateStr="正常";
			}else{
				stateStr="异常";
			}
			displaystr.push("取值状态："+stateStr);
		}else{
			displaystr.push('取值错误：<%=errorMsg%>');
		}
		displaystr = displaystr.join('');
		parent.window.displayPanel(displaystr);
		//parent.window.toast.addMessage("测试取值状态");
	}else{
		
	}
}catch(e){
	
}
</script>
</head>

<body>
	<page:applyDecorator name="popwindow"   >
	<page:param name="width">430px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="title"><s:if test="isUpdate=='true'">修改指标</s:if><s:else>添加指标</s:else></page:param>

	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">testbtn</page:param>
	<page:param name="bottomBtn_text_1">测试取值</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">submit</page:param>
	<page:param name="bottomBtn_text_2">确定</page:param>
	
	<page:param name="bottomBtn_index_3">3</page:param>
	<page:param name="bottomBtn_id_3">cancel</page:param>
	<page:param name="bottomBtn_text_3">取消</page:param>
	
	<page:param name="content">
		<form id="addMetricForm" action="${ctx}/roomDefine/AddMetric.action" name="AddMetricForm" method="post" >
	   		<ul class="fieldlist-n">
	   			<li>
	   				<div class="h2">基本信息</div>
	   			</li>
		   		<li>
		   			<span  class="field">指标名称</span>
		   			<span>：<input type="text" class="validate[required,noSpecialStr,ajax[duplicateMetricName]]" name="metricName" id="metricName" size="40" value="<s:property value='metric.name'/>" /></span>
		   			<span class="red">*</span>
		   		</li>
		   		<li>
		   			<span  class="field">指标类型</span>
		   			<!-- 获取指标的类型 -->
		   			<s:iterator value="metric.basic" id="map">
		   				<s:if test="#map.key=='type'">
		   					<s:set value="#map.value" name="selMetricType" />
		   				</s:if>
		   			</s:iterator>
		   			<span>：</span><span><select name="metricType" id="metricType" style="width: 110px" >
		   				<option value="analog" <s:if test="#selMetricType.indexOf('analog')>=0">selected</s:if> >模拟量</option>
		   				<option value="digital" <s:if test="#selMetricType.indexOf('digital')>=0">selected</s:if> >开关量</option>
		   				<option value="info" <s:if test="#selMetricType=='info'">selected</s:if> >信息指标</option>
		   				<option value="other" <s:if test="#selMetricType=='other'">selected</s:if> >其他类型</option>
		   			</select>
		   			</span>
		   			<span class="red">*</span>
		   			<span class="ico ico-what" id="whatType"></span>
		   		</li>
		   	</ul>
		   	<ul class="fieldlist-n" id="moniFirstId" ></ul>
		   	<ul class="fieldlist-n" id="openCloseId" ></ul>
		   	<ul class="fieldlist-n" >
		   		<li>
	   				<div class="h2">取值方式</div>
	   			</li>
		   		<li>
		   			<span  class="field">取值方式</span>
		   			<!-- 获取取值方式 -->
		   			<s:iterator value="metric.fetch" id="map">
		   				<s:if test="#map.key=='protocol'">
		   					<s:set value="#map.value" name="getMetricValType" />
		   				</s:if>
		   			</s:iterator>
		   			<span>：</span><span><select name="changeValMethod" id="changeValMethod" class="validate[required]">
		   				<option value="">请选择</option>
		   			<s:iterator value="allFetches" id="map">
		   				<option value="<s:property value="#map.key" />" <s:if test="#getMetricValType==#map.key">selected</s:if> ><s:property value="#map.value" /></option>
			   		</s:iterator>
		   			</select>
		   			</span>
		   			<span class="red">*</span>
		   			<span class="ico ico-what" id="whatFetch"></span>
		   		</li>
		   	</ul>
			<div id="selValDisplayId" style="left: -9px;position: relative;"></div> 
			<!-- 获取数据处理方式 参数 --> 
			 <s:iterator value="metric.process" var="listmap" >
			 	<s:iterator value="#listmap.map" id="valMap" >
<!--			 		<s:property value="#valMap.key" /> -->
<!--			 		<s:property value="#valMap.value" /> -->
			 		<s:if test="#valMap.key=='key'">
			 			<s:set value="#valMap.value" name="hidName"></s:set>
			 		</s:if>
			 		<s:if test="#valMap.key=='param' || #valMap.key=='value'">
			 		<input type="hidden" name="<s:property value='#hidName' />" tmd="tmd" id="<s:property value='#hidName' />" value="<s:property value="value" />" />
			 		</s:if>
			 			
			 	</s:iterator>
   			 </s:iterator>
   			<div id="moniId1" ></div>	
		<input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId' />" />
		<input type="hidden" name="metricId" id="metricId" value="<s:property value='metric.id' />" />
		<input type="hidden" name="resourceId" id="resourceId" value="<s:property value='resourceId' />" />
		<input type="hidden" name="resourceName" id="resourceName" value="<s:property value='resourceName' />" />
		<input type="hidden" name="catalogId" id="catalogId" value="<s:property value='catalogId' />" />
		<input type="hidden" name="isUpdate" id="isUpdate" value="<s:property value='isUpdate' />" />
		<input type="hidden" name="modifytype" id="modifytype"
	value="<s:property value='modifytype' />" />
   		</form>
   		
	</page:param>
</page:applyDecorator>
<s:iterator value="metric.basic" id="map">
	<s:if test="#map.key=='type' && #map.value.indexOf('analog')>=0">
		<s:iterator value="metric.basic" id="childmap">
			<s:if test="'unit'==#childmap.key">
			<s:set name="unit" value="#childmap.value" />
			</s:if>
			<s:if test="'maxvalue'==#childmap.key">
			<s:set name="maxvalue" value="#childmap.value" />
			</s:if>
			<s:if test="'minvalue'==#childmap.key">
			<s:set name="minvalue" value="#childmap.value" />
			</s:if>
		</s:iterator>
	</s:if>
	<s:if test="#map.key=='type' && #map.value.indexOf('digital')>=0">
		<s:iterator value="metric.basic" id="childmap">
			<s:if test="'maxvalue'==#childmap.key">
			<s:set name="maxvalue" value="#childmap.value" />
			</s:if>
			<s:if test="'minvalue'==#childmap.key">
			<s:set name="minvalue" value="#childmap.value" />
			</s:if>
			<s:if test="'minvaluestate'==#childmap.key">
			<s:set name="minvaluestate" value="#childmap.value" />
			</s:if>
			<s:if test="'maxvaluestate'==#childmap.key">
			<s:set name="maxvaluestate" value="#childmap.value" />
			</s:if>
		</s:iterator>
	</s:if>
	<s:if test="#map.key=='type' && #map.value.indexOf('other')>=0">
		<s:iterator value="metric.basic" id="childmap">
			<s:if test="'international_key'==#childmap.key">
			<s:set name="otherInternationalValue" value="#childmap.value" />
			</s:if>
			<s:if test="'international_value'==#childmap.key">
			<s:set name="otherInternationalKey" value="#childmap.value" />
			</s:if>
			<s:if test="'normalrange'==#childmap.key">
			<s:set name="otherMetricValue" value="#childmap.value" />
			</s:if>
		</s:iterator>
	</s:if>
</s:iterator>
	<div id="moniFirstTempId" style="display:none">
	   		<li>
	   			<span  class="field">正常区间</span>
	   			<span>：<input type="text" class="validate[required,length[0,30],onlyNumber]" name="startVal" id="startVal" size="15" value="<s:property value='#minvalue'/>" />
	   		   -<input type="text" class="validate[required,length[0,30],onlyNumber]" name="endVal" id="endVal" size="15" value="<s:property value='#maxvalue'/>" />
	   		   	</span>
	   			<span class="red">*</span>
	   		</li>
	   		<li>
	   			<span  class="field">单位</span>
	   			<span>：<input type="text" class="" name="unit" id="unit" size="40" value="<s:property value='#unit'/>" /></span>
	   		</li>
	   		
	   		
	</div>
	
	<div id="moniTempId" style="display:none">
		<table class="grid-gray-fontwhite" style="width:400px;" id="tb">
		   	<div ><span style="position: relative;top: 15px">数据处理</span><span class="ico ico-what" style="position: relative;top: 15px" id="whatParam"></span><span class="r-ico r-ico-close" id="delDetailRow" alt="删除"></span><span class="r-ico r-ico-add" id="addNewRow" alt="添加" ></span></div>
			<thead>
				<tr>
					<th><input type="checkbox" name="allCheck" id="allCheck" /><span>处理顺序</span></th>
					<th><font color="white">数据处理方式</font></th>
					<th><font color="white">参数</font></th>
				</tr>
			</thead>
			<tr>
				<td>
					<input id="CK" type="checkbox" name="CK"/>
				</td>
				<td>
					<select name="selectName" id="selectName">
					<s:iterator value="allProcessors" id="map">
						<option value="<s:property value="#map.key" />"><s:property value="#map.value" /></option>
					</s:iterator>
					</select>
					<span class="red">*</span>
				</td>
				<td>
					<input type="text" id="textName" name="textName" class="validate[required]" size="15" value="1"/>
				</td>
			</tr>
		</table>
	</div>
	<div id="otherTempId" style="display:none">
	   		<li>
	   			<span  class="field">指标值</span>
	   			<span>：<input type="text" class="" name="otherInternationalValue" id="otherInternationalValue" size="40" value="<s:property value='#otherInternationalValue'/>" /></span>
	   			<span class="red">*</span>多个值用','分割。
	   		</li>
	   		<li>
	   			<span  class="field">值对应名称</span>
	   			<span>：<input type="text" class="" name="otherInternationalKey" id="otherInternationalKey" size="40" value="<s:property value='#otherInternationalKey'/>" /></span>
	   			<span class="red">*</span>多个值用','分割。
	   		</li>
	   		<li>
	   			<span  class="field">正常状态对应值</span>
	   			<span>：<input type="text" class="" name="otherMetricValue" id="otherMetricValue" size="40" value="<s:property value='#otherMetricValue'/>" /></span>
	   			<span class="red">*</span>多个值用','分割。
	   		</li>
	</div>
	<div id="openCloseTempId" style="display:none">
   			<li>
	   			<span  class="field">开启状态名称</span>
	   			<span>：<input type="text" class="validate[required]" name="oc1Name" id="oc1Name" size="40" value="<s:property value='#minvalue'/>" /></span>
	   			<span class="red">*</span>
   			</li>
<!--   			<li>-->
<!--	   			<span  class="field">对应值:</span>-->
<!--	   			<input type="text" class="" name="oc1Val" id="oc1Val" size="40" value="" />-->
<!--   			</li>-->
   			<li>
	   			<span  class="field">对应状态</span>
	   			<span>：<select name="oc1Sel" id="oc1Sel">
	   				<option value="0" <s:if test="#minvaluestate==0">selected</s:if> >正常</option>
	   				<option value="1" <s:if test="#minvaluestate==1">selected</s:if>  >异常</option>
   				</select>
   				</span>
   			</li>
   			<li>
	   			<span  class="field">关闭状态名称</span>
	   			<span>：<input type="text" class="validate[required]" name="oc2Name" id="oc2Name" size="40" value="<s:property value='#maxvalue'/>" /></span>
	   			<span class="red">*</span>
   			</li>
<!--   			<li>-->
<!--	   			<span  class="field">对应值:</span>-->
<!--	   			<input type="text" class="" name="oc2Val" id="oc2Val" size="40" value="" />-->
<!--   			</li>-->
   			<li>
	   			<span  class="field">对应状态</span>
	   			<span>：<select name="oc2Sel" id="oc2Sel">
	   				<option value="0" <s:if test="#maxvaluestate==0">selected</s:if> >正常</option>
	   				<option value="1" <s:if test="#maxvaluestate==1">selected</s:if>  >异常</option>
   			    </select>
   			    </span>
   			</li>
	</div>
	<s:iterator value="metric.fetch" id="map">
<!--		<s:property value='#map.key'/>-->
<!--		<s:property value='#map.value'/>-->
		<s:if test="#map.key=='protocol' && #map.value=='snmp'">
			<s:iterator value="metric.fetch" id="childmap">
			<s:if test="'oid'==#childmap.key">
			<s:set name="snmpOId" value="#childmap.value" />
			</s:if>
			<s:if test="'community'==#childmap.key">
			<s:set name="community" value="#childmap.value" />
			</s:if>
			<s:if test="'ip'==#childmap.key">
			<s:set name="ipId" value="#childmap.value" />
			</s:if>
			<s:if test="'port'==#childmap.key">
			<s:set name="portId" value="#childmap.value" />
			</s:if>
			</s:iterator>
		</s:if>
		<s:if test="#map.key=='protocol' && #map.value=='serial'">
			<s:iterator value="metric.fetch" id="childmap">
			<s:if test="'transport'==#childmap.key">
			<s:set name="transport" value="#childmap.value" />
			</s:if>
			<s:if test="'address'==#childmap.key">
			<s:set name="address" value="#childmap.value" />
			</s:if>
			<s:if test="'fc'==#childmap.key">
			<s:set name="fc" value="#childmap.value" />
			</s:if>
			<s:if test="'reference'==#childmap.key">
			<s:set name="reference" value="#childmap.value" />
			</s:if>
			<s:if test="'count'==#childmap.key">
			<s:set name="count" value="#childmap.value" />
			</s:if>
			<s:if test="'connectType'==#childmap.key">
			<s:set name="connectType" value="#childmap.value" />
			</s:if>
			<s:if test="'ip'==#childmap.key">
			<s:set name="ipAddress" value="#childmap.value" />
			</s:if>
			<s:if test="'port'==#childmap.key">
			<s:set name="port" value="#childmap.value" />
			</s:if>
			</s:iterator>
		</s:if>
		<s:if test="#map.key=='protocol' && #map.value=='tcpPool'">
			<s:iterator value="metric.fetch" id="childmap">
			<s:if test="'header'==#childmap.key">
			<s:set name="header" value="#childmap.value" />
			</s:if>
			<s:if test="'type'==#childmap.key">
			<s:set name="type" value="#childmap.value" />
			</s:if>
			<s:if test="'client'==#childmap.key">
			<s:set name="client" value="#childmap.value" />
			</s:if>
			<s:if test="'channel'==#childmap.key">
			<s:set name="channel" value="#childmap.value" />
			</s:if>
			<s:if test="'length'==#childmap.key">
			<s:set name="length" value="#childmap.value" />
			</s:if>
			<s:if test="'content'==#childmap.key">
			<s:set name="content" value="#childmap.value" />
			</s:if>
			<s:if test="'ip'==#childmap.key">
			<s:set name="ipAddress" value="#childmap.value" />
			</s:if>
			<s:if test="'port'==#childmap.key">
			<s:set name="port" value="#childmap.value" />
			</s:if>
			<s:if test="'codeType'==#childmap.key">
			<s:set name="codeType" value="#childmap.value" />
			</s:if>
			
			</s:iterator>
		</s:if>
		<s:if test="#map.key=='protocol' && #map.value=='mram'">
			<s:iterator value="metric.fetch" id="childmap">
			<s:if test="'ip'==#childmap.key">
			<s:set name="ipAddress" value="#childmap.value" />
			</s:if>
			<s:if test="'port'==#childmap.key">
			<s:set name="port" value="#childmap.value" />
			</s:if>
			<s:if test="'cmd'==#childmap.key">
			<s:set name="cmd" value="#childmap.value" />
			</s:if>
			</s:iterator>
		</s:if>
		<s:if test="#map.key=='protocol' && #map.value=='modbustcp'">
			<s:iterator value="metric.fetch" id="childmap">
			<s:if test="'ip'==#childmap.key">
			<s:set name="ipAddress" value="#childmap.value" />
			</s:if>
			<s:if test="'port'==#childmap.key">
			<s:set name="port" value="#childmap.value" />
			</s:if>
			<s:if test="'cmd'==#childmap.key">
			<s:set name="cmd" value="#childmap.value" />
			</s:if>
			</s:iterator>
		</s:if>
		<s:if test="#map.key=='protocol' && #map.value=='file'">
			<s:iterator value="metric.fetch" id="childmap">
			<s:if test="'file'==#childmap.key">
			<s:set name="file" value="#childmap.value" />
			</s:if>
			<s:if test="'encoding'==#childmap.key">
			<s:set name="encoding" value="#childmap.value" />
			</s:if>
			<s:if test="'limit'==#childmap.key">
			<s:set name="limit" value="#childmap.value" />
			</s:if>
			</s:iterator>
		</s:if>
		<s:if test="#map.key=='protocol' && #map.value=='jdbc'">
			<s:iterator value="metric.fetch" id="childmap">
			<s:if test="'driver'==#childmap.key">
			<s:set name="driver" value="#childmap.value" />
			</s:if>
			<s:if test="'url'==#childmap.key">
			<s:set name="url" value="#childmap.value" />
			</s:if>
			<s:if test="'user'==#childmap.key">
			<s:set name="user" value="#childmap.value" />
			</s:if>
			<s:if test="'password'==#childmap.key">
			<s:set name="password" value="#childmap.value" />
			</s:if>
			<s:if test="'sql'==#childmap.key">
			<s:set name="sql" value="#childmap.value" />
			</s:if>
			</s:iterator>
		</s:if>
		<s:if test="#map.key=='protocol' && #map.value=='jdbc4sqlserver'">
			<s:iterator value="metric.fetch" id="childmap">
			<s:if test="'driver'==#childmap.key">
			<s:set name="driver" value="#childmap.value" />
			</s:if>
			<s:if test="'url'==#childmap.key">
			<s:set name="url" value="#childmap.value" />
			</s:if>
			<s:if test="'user'==#childmap.key">
			<s:set name="user" value="#childmap.value" />
			</s:if>
			<s:if test="'password'==#childmap.key">
			<s:set name="password" value="#childmap.value" />
			</s:if>
			<s:if test="'sql'==#childmap.key">
			<s:set name="sql" value="#childmap.value" />
			</s:if>
			</s:iterator>
		</s:if>
		<s:if test="#map.key=='protocol' && #map.value=='mramcon'">
			<s:iterator value="metric.fetch" id="childmap">
			<s:if test="'ip'==#childmap.key">
			<s:set name="ipAddress" value="#childmap.value" />
			</s:if>
			<s:if test="'port'==#childmap.key">
			<s:set name="port" value="#childmap.value" />
			</s:if>
			<s:if test="'cmd'==#childmap.key">
			<s:set name="cmd" value="#childmap.value" />
			</s:if>
			</s:iterator>
		</s:if>
		<s:if test="#map.key=='protocol' && #map.value=='demo'">
			<s:iterator value="metric.fetch" id="childmap">
			<s:if test="'data'==#childmap.key">
			<s:set name="data" value="#childmap.value" />
			</s:if>
			</s:iterator>
		</s:if>
	</s:iterator>
	<div id="snmpId" style="display:none">
		<li class="myHeight">
   			<span  class="field">IP地址</span>
   			<span>：<input type="text" class="validate[required,ipAddress]" name="ipAddress" id="ipAddress" size="40" value="<s:property value='#ipId'/>" /></span>
   			<span class="red">*</span>
   		</li>
   		<li class="myHeight">
   			<span  class="field">端口</span>
   			<s:if test="#portId!='' && #portId!=null">
   			<span>：<input type="text" class="validate[required,onlyNumber]" name="port" id="port" size="40" value="<s:property value='#portId'/>" /></span>
   			</s:if>
   			<s:else>
   			<span>：<input type="text" class="validate[required,onlyNumber]" name="port" id="port" size="40" value="161" /></span>
   			</s:else>
   			<span class="red">*</span>
   		</li>
   		<li class="myHeight">
   			<span  class="field">OID</span>
   			<span>&nbsp;：<input type="text" class="validate[required]" name="oid" id="oid" size="40" value="<s:property value='#snmpOId'/>" /></span>
   			<span class="red">*</span>
   		</li>
   		<li class="myHeight">
   			<span  class="field">团体名</span>
   			<s:if test="#community!='' && #community!=null">
   			<span>：<input type="text" class="validate[required]" name="community" id="community" size="40" value="<s:property value='#community'/>" /></span>
   			</s:if>
   			<s:else>
   			<span>：<input type="text" class="validate[required]" name="community" id="community" size="40" value="public" /></span>
   			</s:else>
   			<span class="red">*</span>
   		</li>
	</div>
	<div id="serialId" style="display:none">
		<li class="myHeight">
   			<span  class="field">传输方式</span>
   			<span>：<input type="text" class="validate[required]" name="transport" id="transport" size="40" value="<s:property value='#transport'/>" /></span>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">传输地址</span>
   			<s:if test="#address != '' && #address!=null">
   			<span>：<input type="text" class="validate[required]" name="address" id="address" size="40" value="<s:property value='#address'/>" /></span>
   			</s:if>
   			<s:else>
   			<span>：<input type="text" class="validate[required]" name="address" id="address" size="40" value="rtu" /></span>
   			</s:else>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">FC</span>
   			<span>&nbsp;：<input type="text" class="validate[required]" name="fc" id="fc" size="40" value="<s:property value='#fc'/>" /></span>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">开始位</span>
   			<span>：<input type="text" class="validate[required]" name="reference" id="reference" size="40" value="<s:property value='#reference'/>" /></span>
   			<span class="red">*</span>
   		</li class="myHeight">
		<li class="myHeight">
   			<span  class="field">移多少位</span>
   			<span>：<input type="text" class="validate[required]" name="count" id="count" size="40" value="<s:property value='#count'/>" /></span>
   			<span class="red">*</span>
   		</li>
	</div>
	<div id="tcpPoolId" style="display:none">
		<li class="myHeight">
   			<span  class="field">帧头部</span>
   			<s:if test="#header=='' || #header==null">
   			<span>：<input type="text" class="validate[required]" name="header" id="header" style="background:#fff;border:1px solid #7f9db9;height:21px;width:233px" size="40" value="DW" /></span>
   			</s:if>
   			<s:else>
   			<span>：<input type="text" class="validate[required]" name="header" id="header" style="background:#fff;border:1px solid #7f9db9;height:21px;width:233px" size="40" value="<s:property value='#header'/>" /></span>
   			</s:else>
   			
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">帧类型</span>
   			<s:if test="#type=='' || #type==null">
   			<span>：<input type="text" class="validate[required]" name="type" id="type" size="40" value="81" /></span>
   			</s:if>
   			<s:else>
   			<span>：<input type="text" class="validate[required]" name="type" id="type" size="40" value="<s:property value='#type'/>" /></span>
   			</s:else>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">终端编号</span>
   			<span>：<input type="text" class="validate[required]" name="client" id="client" size="40" value="<s:property value='#client'/>" /></span>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">终端通道号</span>
   			<span>：<input type="text" class="validate[required]" name="channel" id="channel" size="40" value="<s:property value='#channel'/>" /></span>
   			<span class="red">*</span>
   		</li>
   		<li class="myHeight">
   			<span  class="field">编码类型</span>
   			<s:if test="#codeType=='' || codeType==null">
   			<span>：<input type="text" class="validate[required]" name="codeType" id="codeType" size="40" value="H" /></span>
   			</s:if>
   			<s:else>
   			<span>：<input type="text" class="validate[required]" name="codeType" id="codeType" size="40" value="<s:property value='#codeType'/>" /></span>
   			</s:else>
   			
   			<span class="red">*</span>
   		</li>
   		
		<li class="myHeight">
   			<span  class="field">数据长度</span>
   			<s:if test="#length!='' && #length!=null">
   			<span>：<input type="text" class="validate[required]" name="length" id="length" size="40" value="<s:property value='#length'/>" /></span>
   			</s:if>
   			<s:else>
   			<span>：<input type="text" class="validate[required]" name="length" id="length" size="40" value="8" /></span>
   			</s:else>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">数据内容</span>
   			<span>：<input type="text" class="validate[required]" name="content" id="content" size="40" value="<s:property value='#content'/>" /></span>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">终端IP</span>
   			<span>&nbsp;：<input type="text" class="validate[required]" name="ipAddress" id="ipAddress" size="40" value="<s:property value='#ipAddress'/>" /></span>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">终端PORT</span>
   			<span>&nbsp;：<input type="text" class="validate[required]" name="port" id="port" size="40" value="<s:property value='#port'/>" /></span>
   			<span class="red">*</span>
   		</li>
	</div>
	<div id="mramId" style="display:none">
		<li class="myHeight">
   			<span  class="field">IP地址</span>
   			<span>：<input type="text" class="validate[required]" name="ipAddress" id="ipAddress" size="40" value="<s:property value='#ipAddress'/>" /></span>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">端口</span>
   			<s:if test="#port!='' && #port!=null">
   			<span>：<input type="text" class="validate[required]" name="port" id="port" size="40" value="<s:property value='#port'/>" /></span>
   			</s:if>
   			<s:else>
   			<span>：<input type="text" class="validate[required]" name="port" id="port" size="40" value="7777" /></span>
   			</s:else>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">命令字</span>
   			<span>：<input type="text" class="validate[required]" name="cmd" id="cmd" size="40" value="<s:property value='#cmd'/>" /></span>
   			<span class="red">*</span>
   		</li>
	</div>
	<div id="modbustcpId" style="display:none">
		<li class="myHeight">
   			<span  class="field">IP地址</span>
   			<span>：<input type="text" class="validate[required]" name="ipAddress" id="ipAddress" size="40" value="<s:property value='#ipAddress'/>" /></span>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">端口</span>
   			<span>：<input type="text" class="validate[required]" name="port" id="port" size="40" value="<s:property value='#port'/>" /></span>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">命令字</span>
   			<span>：<input type="text" class="validate[required]" name="cmd" id="cmd" size="40" value="<s:property value='#cmd'/>" /></span>
   			<span class="red">*</span>
   		</li>
	</div>
	<div id="fileId" style="display:none">
		<li class="myHeight">
   			<span  class="field">文件</span>
   			<span>：<input type="text" class="validate[required]" name="file" id="file" size="40" value="<s:property value='#file'/>" /></span>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">编码</span>
   			<s:if test="#encoding!='' && #encoding!=null">
   			<span>：<input type="text" class="validate[required]" name="encoding" id="encoding" size="40" value="<s:property value='#encoding'/>" /></span>
   			</s:if>
   			<s:else>
   			<span>：<input type="text" class="validate[required]" name="encoding" id="encoding" size="40" value="UTF-8" /></span>
   			</s:else>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">读取文件行数</span>
   			<s:if test="#limit!='' && #limit!=null">
   			<span>：<input type="text" class="validate[required]" name="limit" id="limit" size="40" value="<s:property value='#limit'/>" /></span>
   			</s:if>
   			<s:else>
   			<span>：<input type="text" class="validate[required]" name="limit" id="limit" size="40" value="100" /></span>
   			</s:else>
   			<span class="red">*</span>
   		</li>
	</div>
	<div id="jdbcId" style="display:none">
		<li class="myHeight">
   			<span  class="field">驱动</span>
   			
   			<s:if test="#driver!='' && #driver!=null">
   			<span>：<input type="text" class="validate[required]" name="driver" id="driver" size="40" value="<s:property value='#driver'/>" /></span>
   			</s:if>
   			<s:else>
   			<span>：<input type="text" class="validate[required]" name="driver" id="driver" size="40" value="orcal.odbc.driver.OracleDriver" /></span>
   			</s:else>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">URL</span>
   			<s:if test="#url!='' && #url!=null">
   			<span>&nbsp;：<input type="text" class="validate[required]" name="url" id="url" size="40" value="<s:property value='#url'/>" /></span>
   			</s:if>
   			<s:else>
   			<span>&nbsp;：<input type="text" class="validate[required]" name="url" id="url" size="40" value="jdbc:oracle:thin:@ip:port:sid" /></span>
   			</s:else>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">用户名</span>
   			<span>：<input type="text" class="validate[required]" name="user" id="user" size="40" value="<s:property value='#user'/>" /></span>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">密码</span>
   			<span>：<input type="text" class="validate[required]" name="password" id="password" size="40" value="<s:property value='#password'/>" /></span>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">SQL语句</span>
   			<span>：<input type="text" class="validate[required]" name="sql" id="sql" size="40" value="<s:property value='#sql'/>" /></span>
   			<span class="red">*</span>
   		</li>
	</div>
	<div id="jdbc4sqlserverId" style="display:none">
		<li class="myHeight">
   			<span  class="field">驱动</span>
   			<span>：<input type="text" class="validate[required]" name="driver" id="driver" size="40" value="<s:property value='#driver'/>" /></span>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">URL</span>
   			<span>：<input type="text" class="validate[required]" name="url" id="url" size="40" value="<s:property value='#url'/>" /></span>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">用户名</span>
   			<span>：<input type="text" class="validate[required]" name="user" id="user" size="40" value="<s:property value='#user'/>" /></span>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">密码</span>
   			<span>：<input type="text" class="validate[required]" name="password" id="password" size="40" value="<s:property value='#password'/>" /></span>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">SQL语句</span>
   			<span>：<input type="text" class="validate[required]" name="sql" id="sql" size="40" value="<s:property value='#sql'/>" /></span>
   			<span class="red">*</span>
   		</li>
	</div>
	<div id="mramconId" style="display:none">
		<li class="myHeight">
   			<span  class="field">IP地址</span>
   			<span>：<input type="text" class="validate[required]" name="ipAddress" id="ipAddress" size="40" value="<s:property value='#ipAddress'/>" /></span>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">端口</span>
   			<s:if test="#port!='' && #port!=null">
   			<span>：<input type="text" class="validate[required]" name="port" id="port" size="40" value="<s:property value='#port'/>" /></span>
   			</s:if>
   			<s:else>
   			<span>：<input type="text" class="validate[required]" name="port" id="port" size="40" value="7777" /></span>
   			</s:else>
   			<span class="red">*</span>
   		</li>
		<li class="myHeight">
   			<span  class="field">命令字</span>
   			<span>：<input type="text" class="validate[required]" name="cmd" id="cmd" size="40" value="<s:property value='#cmd'/>" /></span>
   			<span class="red">*</span>
   		</li>
	</div>
	<div id="demoId" style="display:none">
		<li class="myHeight">
   			<span  class="field">模拟数据</span>
   			<span>：<input type="text" class="validate[required]" name="data" id="data" size="40" value="<s:property value='#data'/>" /></span>
   			<span class="red">*</span>
   		</li>
	</div>
<iframe name="submitIframe" id="submitIframeId" frameborder="0" scrolling="no" height="0" width="0" src=""></iframe>	
</body>
</html>
<script type="text/javascript">
var panel;
var toast;
var i=0;
var isLoad=0;
var current=$("#metricType").val();
$(document).ready(function() {
	var roomId = "<s:property value='roomId' />";
	var catalogIdVal = "<s:property value='catalogId' />";
	var resourceIdVal = "<s:property value='resourceId' />";
	var modifytype = "<s:property value='modifytype' />";
	var isUpdate = "<s:property value='isUpdate' />";
	toast = new Toast({position:"RT"});
	$("#addMetricForm").validationEngine({
		promptPosition:"centerRight", 
		validationEventTriggers:"blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	})
	$.validationEngineLanguage.allRules.duplicateMetricName={
		"file":"${ctx}/roomDefine/AddMetric!isExistMetricName.action?catalogId="+catalogIdVal+"&resourceId="+resourceIdVal+"&roomId="+roomId+"&modifytype="+modifytype+"&isUpdate="+isUpdate,
	    "alertTextLoad":"* 正在验证，请等待",
	    "alertText":"* 指标名称已经存在"
	}	
	
	$("#moniFirstId").append($("#moniFirstTempId").html());
	$("#moniId1").append($("#moniTempId").html());
	$("#moniFirstId").show("slow");
	bindId();
	
	var isUpdate = $("#isUpdate").val();
	if(isUpdate){
		changeMetricState();
		changeValMethodFun();
		//更新时获取数据处理方式的默认值
		var hid = $("input:hidden[tmd='tmd']");
		for(var i=0; i<hid.length; i++){
			var selname = hid[i].name;
			var value = hid[i].value;
			copyTR();
			setval(selname,value);
			
		}
		/**
		* 更新时给数据处理方式赋默认值
		*/
		function setval(selname,value) {
			var selObj = $("#moniId1 select[name='selectName']");
			//alert(selObj.length);
			var aa= $(selObj[i+1]).children("option");
			for (var k=0;k<aa.length;k++){
				if(aa[k].value == selname){
					$(selObj[i+1]).val(selname);
					break;
				}
			}
			var txtObj = $("#moniId1 input[name='textName']");
			$(txtObj[i+1]).val(value);
				
		}
		
	}
	
	/**
	 *  指标类型下拉列表变化动作
	 */
	$("#metricType").change(changeMetricState);

	/**
	*取值方式切换div
	*/
	$("#changeValMethod").change(changeValMethodFun);
	
	 //隐藏模板tr
    $("#tb tr").eq(1).hide();
    //var i = 0;
    
    //动态添加
    $("#addNewRow").click(copyTR);

    //动态删除
    $("#delDetailRow").click(function() {
        $("#tb tr:gt(1)").each(function() {
            if ($(this).find("#CK").get(0).checked == true) {
                $(this).remove();
            }else{
            	$(this).find("td").get(0).innerHTML =$("#tb tr").eq(1).find("td").get(0).innerHTML +$(this).index();
            }
        });
       // i = 0;
       // $("#tb tr:gt(1)").each(function() {
       //     $(this).find("td").get(0).innerHTML = ++i;
       // });
        $("#allCheck").attr("checked", false);
    });

    //全选
    $("#allCheck").click(function() {
        $("#tb tr:gt(1)").each(function() {
            $(this).find("#CK").get(0).checked = $("#allCheck").get(0).checked;
        });
    });
    isLoad = 1;

    //SimpleBox.renderAll();
});

function copyTR() {
	//复制一行
    var tr = $("#tb tr").eq(1).clone();
    tr.find("td").get(0).innerHTML = tr.find("td").get(0).innerHTML+($("#tb tr").length-1);
    tr.show();
    tr.appendTo("#tb");
    bind();
}
/**
 *  指标类型下拉列表变化动作
 */
function changeMetricState() {
	var chstr = $("#metricType").val();
	
	if(chstr.indexOf('analog')>=0){
		$("#moniFirstId").html("");
		$("#moniFirstId").append($("#moniFirstTempId").html());
		//$("#moniId1").append($("#moniTempId").html());
		$("#moniFirstId").show("slow");
		//$("#moniId1").show("slow");
		$("#openCloseId").hide("slow");
		$("#openCloseId").html("");
		if (isLoad!=0 && current.indexOf('analog')<0){
			$("#startVal").val("");
			$("#endVal").val("");
		}
	}else if(chstr.indexOf('digital')>=0){
		$("#moniFirstId").hide("slow");
		$("#moniFirstId").html("");
		//$("#moniId1").hide("slow");
		//$("#moniId1").html("");
		$("#openCloseId").html("");
		$("#openCloseId").append($("#openCloseTempId").html());
		$("#openCloseId").show("slow");
		if(isLoad!=0 && current.indexOf('digital')<0){
			$("#oc1Name").val("")
			$("#oc2Name").val("")
		}
	}else if(chstr.indexOf('info')>=0){
		$("#moniFirstId").hide("slow");
		$("#moniFirstId").html("");
		//$("#moniId1").hide("slow");
		//$("#moniId1").html("");
		$("#openCloseId").hide("slow");
		$("#openCloseId").html("");
	}else if(chstr.indexOf('other')>=0){
		$("#moniFirstId").hide("slow");
		$("#moniFirstId").html("");
		//$("#moniId1").hide("slow");
		//$("#moniId1").html("");
		$("#openCloseId").html("");
		$("#openCloseId").append($("#otherTempId").html());
		$("#openCloseId").show("slow");
	}
}

/**
 *  取值方式切换div
 */
function changeValMethodFun() {
	var checkStr = $("#changeValMethod").val();
	//alert(checkStr);
	if(checkStr == "snmp") {
		$("#selValDisplayId").html("");
		$("#selValDisplayId").append($("#snmpId").html());
		$("#selValDisplayId").show("slow");
	}else if(checkStr == "serial") {
		$("#selValDisplayId").html("");
		$("#selValDisplayId").append($("#serialId").html());
		$("#selValDisplayId").show("slow");
	}else if(checkStr == "tcpPool") {
		$("#selValDisplayId").html("");
		$("#selValDisplayId").append($("#tcpPoolId").html());
		$("#selValDisplayId").show("slow");
	}else if(checkStr == "mram") {
		$("#selValDisplayId").html("");
		$("#selValDisplayId").append($("#mramId").html());
		$("#selValDisplayId").show("slow");
	}else if(checkStr == "modbustcp") {
		$("#selValDisplayId").html("");
		$("#selValDisplayId").append($("#modbustcpId").html());
		$("#selValDisplayId").show("slow");
	}else if(checkStr == "file") {
		$("#selValDisplayId").html("");
		$("#selValDisplayId").append($("#fileId").html());
		$("#selValDisplayId").show("slow");
	}else if(checkStr == "jdbc") {
		$("#selValDisplayId").html("");
		$("#selValDisplayId").append($("#jdbcId").html());
		$("#selValDisplayId").show("slow");
	}else if(checkStr == "jdbc4sqlserver") {
		$("#selValDisplayId").html("");
		$("#selValDisplayId").append($("#jdbc4sqlserverId").html());
		$("#selValDisplayId").show("slow");
	}else if(checkStr == "mramcon") {
		$("#selValDisplayId").html("");
		$("#selValDisplayId").append($("#mramconId").html());
		$("#selValDisplayId").show("slow");
	}else if(checkStr == "demo") {
		$("#selValDisplayId").html("");
		$("#selValDisplayId").append($("#demoId").html());
		$("#selValDisplayId").show("slow");
	}else{
		$("#selValDisplayId").html("");
	}
}

function bind() {
	var selObj = $("#moniId1 select[name='selectName']");
	selObj.unbind();
	//选择数据处理方式联动
    selObj.change(function() {
        
        var $sel = $(this);
		var val  = $sel.val();
		if(val == "int" || val == "sum" || val == "intbin" || val == "trim" || val == "inverse"){//取整处理器不需要参数,不是必填项
			$sel.parent().next().html("");
			$sel.parent().next().html("<input type='text' id='textName' name='textName' size='15' value=''/>");
		}else{
			$sel.parent().next().html("");
			$sel.parent().next().html("<input type='text' class='validate[required]' id='textName' name='textName' size='15' value=''/><span class='red'>*</span>");
		}
    });
}

function getTimeRndString() {
   var tm=new Date();
   var str=tm.getMilliseconds()+tm.getSeconds()*60+tm.getMinutes()*3600+tm.getHours()*60*3600+tm.getDay()*3600*24+tm.getMonth()*3600*24*31+tm.getYear()*3600*24*31*12;
   return str;
};

$("#closeId").click(function (){
	window.close();
})

$("#submit").click(function (){
	var isUpdate = $("#isUpdate").val();
	if(isUpdate || isUpdate==null){
		$("#addMetricForm").attr("action","${ctx}/roomDefine/AddMetric!updateMetric.action");
		$("#addMetricForm").attr("target","submitIframe");
		$("#addMetricForm").submit();
	}else{
		$("#addMetricForm").attr("action","${ctx}/roomDefine/AddMetric.action");
		$("#addMetricForm").attr("target","submitIframe");
		$("#addMetricForm").submit();
	}
})
$("#testbtn").click(function (){
		$("#addMetricForm").attr("action","${ctx}/roomDefine/AddMetric!testGetVal.action");
		$("#addMetricForm").attr("target","submitIframe");
		$("#addMetricForm").submit();
})
$("#cancel").click(function(){
	window.close();
})

function bindId(){
	//指标类型帮助信息
	$("#whatType").click(function(event) {
		panel = new winPanel({
	        url:"${ctx}/roomDefine/EditNote!lookTypeHelp.action",
	        //html:"alskdflaksdflkasdklj",
	        width:420,
	        x:event.pageX-100,
	        y:event.pageY,
	        isDrag:false,
	        isautoclose: true, 
	        closeAction: "close",
	        listeners:{
	          closeAfter:function(){
		          //alert("afterClose");
		          panel = null;
		      },
		      loadAfter:function(){
		          //alert("loadAfter");
		      }
	        }
			},{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"});
	});
	//取值方式帮助信息
	$("#whatFetch").click(function(event) {
		panel = new winPanel({
	        url:"${ctx}/roomDefine/EditNote!lookFetchHelp.action",
	        //html:"alskdflaksdflkasdklj",
	        width:420,
	        x:event.pageX-100,
	        y:event.pageY,
	        isDrag:false,
	        isautoclose: true, 
	        closeAction: "close",
	        listeners:{
	          closeAfter:function(){
		          //alert("afterClose");
		          panel = null;
		      },
		      loadAfter:function(){
		          //alert("loadAfter");
		      }
	        }
			},{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"});
	});
	//数据处理方式帮助信息
	$("#whatParam").click(function(event) {
		panel = new winPanel({
	        url:"${ctx}/roomDefine/EditNote!lookParamHelp.action",
	        //html:"alskdflaksdflkasdklj",
	        width:420,
	        x:event.pageX-200,
	        y:event.pageY-200,
	        isDrag:false,
	        isautoclose: true, 
	        closeAction: "close",
	        listeners:{
	          closeAfter:function(){
		          //alert("afterClose");
		          panel = null;
		      },
		      loadAfter:function(){
		          //alert("loadAfter");
		      }
	        }
			},{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"});
	});
}
</script>