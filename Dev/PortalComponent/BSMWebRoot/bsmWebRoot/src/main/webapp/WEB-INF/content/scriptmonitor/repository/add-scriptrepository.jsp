<%--  
 *************************************************************************
 * @source  : add-scriptrepository.jsp
 * @desc    : Mocha BSM 8.0
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.1.10	 huaf     	 添加脚本库
 * ----------- ----------  -----------------------------------------------
 * Copyright(c) 2011 mochasoft,  All rights reserved.
 *************************************************************************
--%>
<!-- WEB-INF\content\scriptmonitor\repository\add-scriptrepository.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<s:set name="operate" value="#request.operate"/>
<s:set name="success" value="#request.success"/>
<s:if test="\"add\".equals(#operate)">
	<s:set name="action" value="\"/scriptmonitor/repository/scriptRepository!addScriptRepostiory.action\"" scope="request"/>
	<s:set name="titleName" value="\"添加脚本库\""  scope="request"/>
	<s:set name="passwordMask" value=""/>
</s:if>
<s:else>
	<s:set name="action" value="\"/scriptmonitor/repository/scriptRepository!updateScriptRepostiory.action\"" scope="request"/>
	<s:set name="titleName" value="\"编辑脚本库\""  scope="request"/>
	<s:set name="passwordMask" value="\"#########\""/>
</s:else>
<title>${titleName}</title>

<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/location/dialogResize.js"></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js" ></script>
<script src="${ctxJs}/scriptmonitor/scriptRepositorys.js"></script>
<script type="text/javascript">

	function noLocalIpAddress(callerObj){
		return callerObj.value == '127.0.0.1';
	}
		
	//表单验证
	$(document).ready(function() {
		if("${success}" == "true"){
			//刷新父页面
			window.returnValue="freshTree";
			self.close();
			return;
		}
		<s:if test="edit">	
		$("#addForm").validationEngine({
			promptPosition:"centerRight", 
			validationEventTriggers:"blur",
			inlineValidation: true,
			scroll:false,
			success:false
		});
		</s:if>
		$("#closeId").click(function (){
			window.close();
		});
		
		//测试
		$("#test").click(function(){
			if(!$.validate($('#addForm'))){
				return false;
			}
			$.blockUI({message:$('#loading')});
			$.ajax({
				url:		"${ctx}/scriptmonitor/repository/repositoryConnection.action",
				data:		$("#addForm").serialize(),
				dataType:	"json",
				cache:		false,
				success:	function(data, textStatus){
					if(data.code == 1){
						var _information = new information({text:"连接成功"});
						_information.show();
					}else{
						var msg = "连接失败:"+data.msg;
						var _information = new information({text:msg});
						_information.show();
					}
					$.unblockUI();
				}
			});
		});
		<s:if test="edit">
		$("#submit").click(function (){
			$("#addForm").attr("action","${ctx}${action}");
			$("#addForm").submit();
		});
		$("#serverProcotol").change(function(){
			setDefaultPortAndDescriptionValue($(this).val());
		});
		</s:if>
		$("#cancel").click(function(){
			window.close();
		});
		
		
		$.validationEngineLanguage.allRules.<%=com.mocha.bsm.script.monitor.bean.ScriptBean.VALIDATE_ERROR_REPOSITORY%>={
      		"file":"${ctx}/scriptmonitor/repository/nameValidate.action?currentId=${scriptRepository.id}",
         	"alertTextLoad":"<font color='red'>*</font> 正在验证，请等待",
         	"alertText":"<font color='red'>*</font> 脚本库名称已经存在"
     	}

		<s:if test="scriptRepository != null && scriptRepository.serverProcotol !=null">
			setDefaultPortAndDescriptionValue('${scriptRepository.serverProcotol}',${scriptRepository.serverPort});
		</s:if>
		<s:else>
			initDefaultPortAndDescriptionValue();
		</s:else>
		
		$("#serverPassword").change(function(){
			$("#changePassword").val("true");
		});
		
     	<s:if test="edit == false">
			$.each($(":input"),function(i,n){
				n.disabled=true;
			});
		</s:if>		
	});
	
	function initDefaultPortAndDescriptionValue(){
		var protocol = $("#serverProcotol").val(protocol);
		setDefaultPortAndDescriptionValue(protocol);
	}
	
	function setDefaultPortAndDescriptionValue(protocol,port){
	 		var defaultPort;
			if('tel' == protocol){
				defaultPort = 23;
				$("#protocolDescription").html("");
			}else if('wmi' == protocol){
				defaultPort = 135;
				$("#protocolDescription").html("&nbsp;(执行前提条件：开启远程管理共享Admin$。)");
			}else if('ssh' == protocol){
				defaultPort = 22;
				$("#protocolDescription").html("");
			}
			if(port){
				defaultPort = port;
			}
			$("#serverPort").val(defaultPort);
	}
	
	function validatePort(dataValue){
		var intValue = parseInt(dataValue.value);
		return intValue <0 || intValue>65535;
	}
</script>
</head>
<body>
<div class="loading" id="loading" style="display:none;">
	 <div class="loading-l">
	  <div class="loading-r">
	    <div class="loading-m">
	       <span class="loading-img">正在执行，请稍候...</span> 
	    </div>
	  </div>
	  </div>
</div>
<page:applyDecorator name="popwindow"  title="${titleName}">
	<page:param name="width">600px</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">test</page:param>
	<page:param name="bottomBtn_text_1">测试连接</page:param>
		
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">submit</page:param>
	<page:param name="bottomBtn_text_2">确定</page:param>
	
	<page:param name="bottomBtn_index_3">3</page:param>
	<page:param name="bottomBtn_id_3">cancel</page:param>
	<page:param name="bottomBtn_text_3">取消</page:param>
	
	<page:param name="content">
	<div style="margin-top:10px;">
		<span class="vertical-middle"><img src="${ctxImages}/scriptmonitor/ico-info.gif" border="0"  width="16" height="16" hspace="6" align="absmiddle"/></span>
		<span class="vertical-middle">输入脚本库所在服务器的信息，${titleName}。</span>
	</div>
	<fieldset class="blue-border-nblock">
    <legend>脚本库信息</legend>
	<s:form id="addForm">
		<s:hidden name="scriptRepository.id" value="%{scriptRepository.id}"></s:hidden>
		<ul class="fieldlist-n">
			<li>
				<span class="field-middle" style="width:125px;">脚本库名称</span><span>：</span>
				<s:textfield name="scriptRepository.name" cssClass="validate[required,noSpecialStr,length[0,50,脚本库名称],ajax[duplicateRepositoryName]]" value="%{scriptRepository.name}"></s:textfield><span class="red">*</span>
			</li>
			<li>
				<span class="field-middle" style="width:125px;">脚本库所在服务器IP</span><span>：</span>
				<s:textfield id="serverIp" name="scriptRepository.serverIp" cssClass="validate[required,ipAddress]" value="%{scriptRepository.serverIp}"></s:textfield><span class="red">*</span>
				<!--br>
				<span class="field" style="color:red;width:100%;">*&nbsp;脚本服务器和BSM服务器是否部署在同一机器上，IP地址都必须输入，并且不允许输入127.0.0.1</span-->
			</li>
			<li>
				<span class="field-middle" style="width:125px;">系统帐户</span><span>：</span>
				<s:textfield name="scriptRepository.serverAccount" cssClass="validate[required,length[0,50,系统帐户]]" value="%{scriptRepository.serverAccount}"></s:textfield><span class="red">*</span>
			</li>	
			<li>
				<span class="field-middle" style="width:125px;">密码</span><span>：</span>
				<s:password id="serverPassword" name="scriptRepository.serverPassword" cssClass="validate[required,length[0,50,密码]]" value="%{passwordMask}" showPassword="true"></s:password><span class="red">*</span>
				<s:hidden name="changePassword" value="false" id="changePassword"/>
			</li>
			<li>
				<span class="field-middle" style="width:125px;">连接方式</span><span>：</span>
				<s:select id="serverProcotol" list="#{'ssh':'SSH(Unix)','tel':'Telnet(Unix)','wmi':'WMI(Windows)'}" name="scriptRepository.serverProcotol" cssClass="validate[required]"></s:select>
				<span class="red">*</span><span id="protocolDescription"></span>
			</li>
			<li><span class="field-middle" style="width:125px;">端口</span><span>：</span>
				<s:textfield id="serverPort"  name="scriptRepository.serverPort" cssClass="validate[required,funcCall[validatePort]]" value="%{scriptRepository.serverPort}"></s:textfield>
				<span class="red">*</span>
			</li>
			<li><span class="field-middle" style="width:125px;">备注</span><span>：</span>
				<s:textarea style="width:230px;height:80px;scrolling:auto;" name="scriptRepository.description" value="%{scriptRepository.description}" cssClass="validate[length[0,200,备注]]"></s:textarea>
			</li>
		</ul>
	</s:form>
	</fieldset>
	</page:param>
</page:applyDecorator>
</body>
</html>