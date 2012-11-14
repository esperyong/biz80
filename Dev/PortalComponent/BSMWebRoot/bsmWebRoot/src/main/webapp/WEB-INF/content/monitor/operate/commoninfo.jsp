<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<style type="text/css">
.span_dot{width:460px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;}
</style>
</head>
<body>
<form id="form1">
    <input type="hidden" name="instanceId" id="instanceId" value="<s:property value="instanceId "/>"/>
    <input type="hidden" name="userId" id="userId" value="<s:property value="userId"/>"/>
    <input type="hidden" name="rowIndex" id="rowIndex" value="<s:property value="rowIndex "/>"/>
    <input type="hidden" name="pointId" id="pointId" value="<s:property value="pointId"/>"/>
    <input type="hidden" name="isMonitor" id="isMonitor" value="<s:property value="isMonitor"/>"/>
    <input type="hidden" name="submitJson" id="submitJson" />
	<ul class="fieldlist-n">
	  <li><span class="field-middle">资源名称</span><span>：</span><span><s:if test="resourceName=='' || resourceName==null"><s:property value="discoveryIp" /></s:if><s:else><s:property value="resourceName" /></s:else></span></li>
	  <li><span class="field-middle">显示名称</span><span>：</span><span><input name="instanceName" id="instanceName" type="text" class="validate[required[显示名称],length[0,30,显示名称],noSpecialStr[显示名称],ajax[instanceName]]" value="<s:property value="instanceName" />" size="30" /><span class="red">*</span>请勿输入：' " % \ : ? &lt; &gt; | ; &amp; @ # *</span></li>
	  <li><span class="field-middle">设备说明</span><span>：</span><span class="span_dot" title="<s:property value="deviceInfomation" />"><s:property value="deviceInfomation" /></span></li>
	  <li><span class="field-middle multi-line">用途</span><span>：</span><textarea name="purpose" rows="4" cols="40" id="purpose"><s:property value="purpose" /></textarea></li>
	  <li class="last"><span class="field-middle multi-line">备注</span><span>：</span><textarea name="description" rows="4" cols="40" id="description"><s:property value="description" /></textarea></li>
	  <li class="line"></li>
	</ul>
	<ul class="fieldlist-n">
	  <li>
	    <span class="field-middle">维护人</span><span>：</span><span><input name="userName" id="userName" disabled="disabled" class="validate[required[维护人]]" type="text" value="<s:property value="userName" />" size="30" /></span>
	    <span class="ico ico-find" id="selectUser" title="选择"></span>
	    <span class="red">*</span>
	  </li>
	  <li>
	    <span class="field-middle">部门</span><span>：</span><span id="departmentspan"><s:property value="department" /></span>
	  </li>
	  <li>
	    <span class="field-middle">电话</span><span>：</span><span id="telphonespan"><s:property value="telphone" /></span>
	  </li>
	   <li>
	    <span class="field-middle">手机</span><span>：</span><span id="mobilespan"><s:property value="mobilephone" /></span>
	  </li>
	  <li class="last">
	    <span class="field-middle">e-mail</span><span>：</span><span id="emailspan"><s:property value="email" /></span>
	  </li>
	  <li class="line"></li>
	</ul>
	
	<ul class="fieldlist-n">
	  <li class="last"><span class="field-middle">影响因子</span><span>：</span><span id="numberSliderSpan" style="height:20px;width:310px"></span><input name="impactFactor" id="impactFactor" class="validate[funcCall[impactFactor]]" type="text" size="3" value="<s:property value="impactFactor" />" /></li>
	</ul>
</form>
<script type="text/javascript">
	$(function(){
		  var numberSlider = new NumberSlider({wrapId:'numberSliderSpan', sliderId:'numberSlider', minValue:0, maxValue:100, bindId:'impactFactor', defaultValue:"<s:property value="impactFactor" />", sliderWidth:290});
		  $("#selectUser").bind("click",function(){
			  var url = path + "/monitor/maintainSetting!getUsers.action";
			  var offset = $(this).offset();
			  selectUserPanel = new winPanel({
			         id:"selectUserPanelId",
			         isautoclose:false,
			         isDrag:false,
			         width:260,
			         x:offset.left,
			         y:offset.top,
			         url:url
			     },{
			    winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"
			  });
			});
	});
</script>
</body>
</html>