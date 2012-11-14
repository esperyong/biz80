<%--  
 *************************************************************************
 * @source  : edit-model.jsp
 * @desc    : Mocha BSM 8.0
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.5.16	 huaf     	 编辑模型
 * ----------- ----------  -----------------------------------------------
 * Copyright(c) 2011 mochasoft,  All rights reserved.
 *************************************************************************
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<title>编辑模型</title>
<script>
	var ctx= "${ctx}";
	var alertVal;
	var toast;
</script>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/component/cfncc.js"></script>
<script src="${ctxJs}/component/tabPanel/tab.js"></script>
<script src="${ctxJs}/component/gridPanel/grid.js"></script>
<script src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
<script src="${ctxJs}/component/toast/Toast.js"></script>
<script src="${ctxJs}/location/dialogResize.js"></script>
<script src="${ctxJs}/component/menu/menu.js"></script>
<script src="${ctx}/js/scriptmonitor/modelWindow.js"></script>
<script src="${ctx}/js/scriptmonitor/modolExtension.js"></script>
<script src="${ctx}/js/component/popwindow/popwin.js" ></script>
<script src="${ctxJs}/location/dialogResize.js"></script>
</head>

  <body>
  <s:set name="extensionVal" value="module.extension" />
  <page:applyDecorator name="popwindow"  title="编辑模型">
	<page:param name="width">600px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submit</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	<page:param name="content">
  	
	<page:applyDecorator name="tabPanel">  
       <page:param name="id">mytab</page:param>
       <page:param name="width">580</page:param>
       <page:param name="height">400</page:param>
       <page:param name="background">#fff</page:param>
       <page:param name="tabBarWidth"></page:param>
       <page:param name="cls">tab-grounp</page:param>
       <page:param name="current">1</page:param>
       <page:param name="tabHander">[{text:"常规信息",id:"tab1"},{text:"指标定义",id:"tab2"},{text:"组件定义",id:"tab3"}]</page:param>
       <page:param name="content_1">
        <s:form id="formID">
   		<div >
   			<div id="infoDiv"/>
	   			<fieldset class="blue-border-nblock">
			    <legend>基本信息</legend>
		   			<ul class="fieldlist-n">
						<li>
							<span class="field-middle" style="width:125px;">设备类型</span><span>：</span>
							<s:property value="%{resourceCategoryName}" />
						</li>
						<li>
							<span class="field-middle" style="width:125px;">模型显示名称</span><span>：</span>
							<s:textfield name="module.resourceName" value="%{module.resourceName}" input="true" cssClass="validate[required,noSpecialStr,length[0,30,模型名称]]"></s:textfield><span class="red">*</span>
							<br>
							<span class="field" style="color:red;width:100%;">*&nbsp;(模型显示名称，在需要显示监控模型的地方显示。如：华为交换机、Cisco路由器。)</span>
						</li>
						<li><span class="field-middle" style="width:125px;">备注</span><span>：</span>
							<s:textarea style="width:230px;height:80px;scrolling:auto;" name="module.resourceDescription" input="true" value="%{module.resourceDescription}" cssClass="validate[length[0,200,备注]]"></s:textarea>
						</li>
					</ul>
				</fieldset>
			</div>
			<div id="setValueDiv"/>
				<fieldset class="blue-border-nblock">
			    <legend>取值信息</legend>
					<ul class="fieldlist-n">
						<li>
							<span class="sub-panel-tips" style="line-height:20px;"></span>定义脚本返回值格式，资源名称必须是返回值的第一行第一列。
						</li>
						<li>
							<span class="field-middle" style="width:125px;">对应脚本</span><span>：</span>
							<s:textfield name="scriptTemplateIdForModule" readonly="true" cssClass="validate[required]"></s:textfield><span class="red">*</span><span id="selectScript" style="cursor:hand" class="tree-panel-ico tree-panel-ico-search"></span>
							<s:hidden name="module.scriptTemplateId" value="%{module.scriptTemplateId}"/>
						</li>
						<li>
							<span class="field-middle" style="width:125px;">脚本列分隔符</span><span>：</span>
							<s:textfield name="module.dataSeperator" value="%{module.dataSeperator}" size="5" cssClass="validate[required,myNoSpecialStr]"></s:textfield><span class="red">*</span>
						</li>
						<li>
							<span class="field-middle" style="width:125px;">资源实例名称返回值</span><span>：</span>
							<s:textfield name="module.dataRow" size="3" readOnly="true" cssClass="validate[required,length[0,2],onlyNumber]" value="%{module.dataRow}"></s:textfield>行
							<s:textfield name="module.dataColumn" readOnly="true" value="%{module.dataColumn}" size="3" cssClass="validate[required,length[0,2],onlyNumber]"></s:textfield>列<span class="red">(资源名称必须是返回值的第一行第一列。)</span>
						</li>
					</ul>
				</fieldset>
			</div>
		<br><br>
   		</div>
   		<s:hidden name="module.resourceId" value="%{module.resourceId}"/>
   		<s:hidden name="module.resourceCategroupId" value="%{module.resourceCategroupId}"/>
   		<s:hidden name="module.published" value="%{module.published}"/>
   		<s:hidden name="module.extension" value="%{module.extension}"/>
   		</s:form>
       </page:param>
       <page:param name="content_2">
       	<div class="clear" id="dynamicJsp2Id" style=" height:380px;width:100%;scrolling:auto;"></div>
       </page:param>
       <page:param name="content_3">
	   	<div class="clear" id="dynamicJsp3Id" style=" height:380px;width:100%;scrolling:auto;"></div>
	   </page:param>
     </page:applyDecorator>
   	</page:param>
   </page:applyDecorator>
  </body> 
</html>
<script type="text/javascript">
$(document).ready(function(){
	toast = new Toast({position:"CT"}); 
	$("#formID").validationEngine({
		promptPosition:"centerRight", 
		validationEventTriggers:"blur",
		inlineValidation: true,
		scroll:false,
		success:false
	});
	$.validationEngineLanguage.allRules.myNoSpecialStr={
			"regex":"/^$|^[^:;'&#<>()%*?！|\"^*]+$/",
			"alertText":"<font color='red'>*</font> ^^^不能输入非法字符 : ; ' & # < > ( ) % * ? ！ | &quot; ^"
	}
});	
var tableType = "tab1";
var myTab = new TabPanel({id:"mytab",
	listeners:{
        change:function(tab){
        	if(tab.id=="tab1"){
				return;
           	 }
       		targetType = tab.id=="tab2"?"tab2":"tab3";
	        tableType = tab.id;
	        loadTablePanelFun(tableType,true);
        }
	}}
	);
	function loadTablePanelFun(tableType,changePage){
		var url = "${ctx}/scriptmonitor/repository/editModel!changePage.action";
		var resourceId = "<s:property value='%{module.resourceId}'/>";
		$.ajax({
			url:url,
			data:"tableType="+tableType+"&resourceId="+resourceId,
			dataType:"html",
			type:"POST",
			success:function(data,state){
				if(!changePage){
					alertVal=true;
				}
				if(tableType == "tab2"){
					$("#dynamicJsp2Id").find("*").unbind();
					$("#dynamicJsp2Id").html("");
					$("#dynamicJsp2Id").append(data);
				}else if(tableType == "tab3"){
					$("#dynamicJsp3Id").find("*").unbind();
					$("#dynamicJsp3Id").html("");
					$("#dynamicJsp3Id").append(data);
				}
			}
		});
	}
	$("#cancel").bind("click",function(){
		if(alertVal){
			parent.window.returnValue="success";
		}
		window.close();
	});
	$("#submit").bind("click",function(){
		var url = "${ctx}/scriptmonitor/repository/editModel!editModel.action";
		$.ajax({
			url:		url,
			data:		$("#formID").serialize(),
			dataType:	"html",
			cache:		false,
			success: function(data, textStatus){
				parent.window.returnValue="success";
				window.close();
			}
		});
	});
	$(".win-close").bind("click",function(){
		if(alertVal){
			parent.window.returnValue="success";
		}
		window.close();
	});
	var scritpId = $("input[name=module.scriptTemplateId]").val();
	$("#selectScript").click(function (){
		
		var url;
		if(scritpId){
			url = "${ctx}/scriptmonitor/repository/scriptMonitor!queryScriptRepository.action?scriptTemplateId="+scritpId;
		}else{
			url = "${ctx}/scriptmonitor/repository/scriptMonitor!queryScriptRepository.action";
		}
		scritpId = window.showModalDialog(url,"help=no;status=no;scroll=yes;center=yes");
		if(scritpId){
			getScriptTemplateFun(scritpId);
		}	
	});
	function getScriptTemplateFun(scritpId){
		$.ajax({
			url:		"${ctx}/scriptmonitor/repository/scriptTemplate!selectScriptById.action",
			data:		"scriptTemplate.id="+scritpId,
			dataType:	"json",
			cache:		false,
			success: function(data, textStatus){
				if(data.scriptTemplate){
					$("input[name=scriptTemplateIdForModule]").val(data.scriptTemplate.name);
					$("input[name=module.scriptTemplateId]").val(data.scriptTemplate.id);
				}
			}
		});
	}
	var scriptTemplateId = $("input[name=module.scriptTemplateId]").val();
	getScriptTemplateFun(scriptTemplateId);
	if("<s:property value='module.extension' />" == "false"){
		$("#infoDiv").find("*").each(function(i){
			if($(this).attr("input")=="true"){
				$(this).attr("readonly",true);
			}
		});
		$("#setValueDiv").hide();
		$("#submit").hide();
		$("#cancel").hide();
	}
</script>
