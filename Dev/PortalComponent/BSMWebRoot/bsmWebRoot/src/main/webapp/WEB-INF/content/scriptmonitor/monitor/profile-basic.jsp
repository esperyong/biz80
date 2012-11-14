<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script type="text/javascript">
<!--
var popwind;
$(document).ready(function(){
	$selectScript = $("#selectScript");
	isVisible($selectScript);
	$('#monitorTime').timeEntry();
	$.timeEntry.setDefaults({show24Hours: true,showSeconds:true,spinnerImage: '${ctxImages}/uicomponent/time/time-select.gif',spinnerSize: [15, 16, 0],spinnerIncDecOnly: true,useMouseWheel: false,defaultTime: '09:00:00',timeSteps: [1, 1, 1]});
	$selectScript.click(function (){
		var scriptId = $("#scriptId").val();
		scriptId = window.showModalDialog("${ctx}/scriptmonitor/repository/scriptMonitor!queryScriptRepository.action?scriptId="+scriptId,"help=no;status=no;scroll=yes;center=yes");
		if(scriptId){
			$.ajax({
				url:		"${ctx}/scriptmonitor/repository/scriptTemplate!selectScriptById.action",
				data:		"scriptTemplate.id="+scriptId,
				dataType:	"json",
				cache:		false,
				success: function(data, textStatus){
					if(data.scriptTemplate){
						$("input[name=scriptProfile.scriptId]").val(data.scriptTemplate.id);
						$("input[name=scriptTemplate.name]").val(data.scriptTemplate.name);
						$("input[name=scriptTemplate.filePath]").val(data.scriptTemplate.filePath);
						$params = $("#params");
						$paramValues = $("#paramValues");
						$params.empty();
						$paramValues.empty();
						// 设置脚本参数
						if(data.scriptTemplate.scriptParameters){
							var scriptParams = data.scriptTemplate.scriptParameters;
							$params.addOptions(scriptParams,"key","name");
							$.ajax({
								url:		"${ctx}/scriptmonitor/repository/scriptPropfile!createIds.action",
								data:		"idsCount="+scriptParams.length,
								dataType:	"json",
								cache:		false,
								success: function(data, textStatus){
									var paramValues="";
									paramValues+="<div class=\"greytable-titlebg\"><span class=\"greytable-titlebg-ico\"></span><b>参数设置</b></div>";
									paramValues+="<span class=\"field-middle\"></span>";
									for(var i=0; i<scriptParams.length; i++){
										paramValues+="<li style=\"padding-left:1px; margin-top:1px;\"><span class=\"field\" >" + scriptParams[i].name + "</span>"+
														"<input name=\"scriptProfile.sptParameterList["+i+"].profileId\" value=\""+profileId+"\" type=\"hidden\"/>"+
														"<input name=\"scriptProfile.sptParameterList["+i+"].parameterId\" value=\""+scriptParams[i].id+"\" type=\"hidden\"/>"+
														"<input name=\"scriptProfile.sptParameterList["+i+"].parameterValue\" value=\""+scriptParams[i].parameter.defaultValue+"\"/></li>";
									}
									$paramValues.append(paramValues);
									dialogResize();
								}
							});
						}
						dialogResize();
					}
				}
			});
		}
	});
	$("#frequencyId").change(function(){
		var type = $(this).val();
		var $week = $("#frequencyWeek");
		var $month = $("#frequencyMonth");
		var $time = $("#monitorTime");
		var $monitorTimeSpan = $("#monitorTimeSpan");
		if(type=="EVERY_DAY"){
			$week.hide().attr("disabled","true");
			$month.hide().attr("disabled","true");
			$time.show().removeAttr("disabled");
			$monitorTimeSpan.show();
		}else if(type=="EVERY_WEEK"){
			$week.show().removeAttr("disabled");
			$month.hide().attr("disabled","true");
			$time.show().removeAttr("disabled");
			$monitorTimeSpan.show();
		}else if(type=="EVERY_MONTH"){
			$week.hide().attr("disabled","true");
			$month.show().removeAttr("disabled");
			$time.show().removeAttr("disabled");
			$monitorTimeSpan.show();
		}else{
			$week.hide().attr("disabled","true");
			$month.hide().attr("disabled","true");
			$time.attr("disabled","true");
			$monitorTimeSpan.hide();
		}
	});
	
	$("#execute").click(function(){
		if(!$.validate($('#addForm'))){
		    return false;
		}
		$.blockUI({message:$('#loading')});
		var scriptId = $("#scriptId").val();
		if(!canEdit){
			$.each($("#paramValues input"),function(i,n){
				n.disabled=false;
			});
		}
		$.ajax({
			url: "${ctx}/scriptmonitor/repository/scriptPropfile!runScript.action",
			dataType: "json",
			data: "scriptProfile.scriptId="+scriptId+"&"+$("#paramValues input").serialize(),
			cache: false,
			success: function(data, textStatus){
				
				var resultContent;
				if(data.runResult.code=="<%=com.mocha.bsm.script.monitor.obj.ScriptRunResult.SUCCESS%>"){
					resultContent = "<span class=\"ico ico-right\"/>";
					resultContent += "<br>脚本返回值：<br>";
					resultContent += "<textarea name=\"t1\" cols=\"80\" rows=\"8\">";
					for(var i=0; i<data.runResult.content.length; i++){
						resultContent+=data.runResult.content[i]+"\n";
					}
					resultContent+="</textarea>";
				} else{
					resultContent = "<span style=\"width:400px;color:red;word-wrap:break-word;\">"+data.runResult.errorMessage+"</span>";
					resultContent += "<br>脚本返回值：<br>";
					resultContent += "<textarea name=\"t1\" cols=\"80\" rows=\"8\">";
					for(var i=0; i<data.runResult.content.length; i++){
						resultContent+=data.runResult.content[i]+"\n";
					}
					resultContent+="</textarea>";
				}
				resultContent="<div style=\"margin:5px 0px 5px 5px;height:190px;width:430px;overflow:auto;\">脚本执行结果：" + resultContent + "</div>";
				$.unblockUI();
				if(popwind){
					popwind.setContentHtml(resultContent);
					popwind.show();
				}else{
					popwind = new PopWindow({
						width  : 460,
						height : 200,
						title  : '提示',
						html   : resultContent,
						botButs:[{_id:'confirm_button',_listener:function(){
							popwind.hide();
						},_text:'确认'}]
						
					});
					popwind.show();
				}
				
			}
		});
		if(!canEdit){
			$.each($("#paramValues input"),function(i,n){
				n.disabled=true;
			});
		}
	});
});
//-->
</script>
<div class="blackbg01"><span class="ico ico-tips"></span>说明：脚本监控的前提是监控服务器能与被监控设备网络连接，否则无法进行脚本监控。</div>
<div class="greytable-titlebg"><span class="greytable-titlebg-ico"></span><b>选择脚本</b></div>
<s:hidden name="scriptProfile.profileId" />
<s:hidden name="scriptProfile.splitFlg" />
<div>
<ul class="fieldlist-n">
	<li><span class="field-middle" style="width:110px;">${domainName}</span><span>：</span>
	<s:select name="scriptProfile.domainId" id="domainId" list="domains" listKey="ID" listValue="name" headerKey="-1" headerValue="请选择" value="%{scriptProfile.domainId}" style="width:100px;"></s:select><span class="red">*</span>
	</li>
	<li><span class="field-middle" style="width:110px;">脚本名称</span><span>：</span> 
	<s:hidden name="scriptProfile.scriptId" id="scriptId" value="%{scriptProfile.scriptId}"/> 
	<s:textfield name="scriptTemplate.name" cssClass="validate[required]" disabled="true" value="%{scriptProfile.scriptTemplate.name}" title="%{scriptProfile.scriptTemplate.name}"></s:textfield><span class="red">*</span><span id="selectScript" class="ico"></span>
	</li>
	<li><span class="field-middle" style="width:110px;">脚本库路径及文件名</span><span>：</span> 
	<s:textfield style="width:250px;" name="scriptTemplate.filePath" disabled="true" value="%{scriptProfile.scriptTemplate.filePath}"  title="%{scriptProfile.scriptTemplate.filePath}"></s:textfield>
	</li>
	<li><span class="field-middle" style="width:110px; float: left;">脚本参数选择</span><span style="float: left;">：</span> 
	<s:select style="width:150px; height:100px; y-overflow:scroll; margin-left:10px; float:left;" id="params" name="params" size="6" multiple="true" list="parameters" listKey="parametekey" listValue="parameteName"></s:select>
	</li>
	<li><span class="field-middle" style="width:110px;">执行频度</span><span>：</span> 
	<s:select name="scriptProfile.frequencyId" id="frequencyId" list="frequencys" listKey="key" listValue="value" value="%{scriptProfile.frequencyId}"></s:select> 
	<s:if test="scriptProfile.frequencyId=='EVERY_WEEK'">
		<s:select name="scriptProfile.frequencyDay" id="frequencyWeek" list="{1,2,3,4,5,6,7}" value="%{scriptProfile.frequencyDay}"></s:select>
	</s:if> 
	<s:else>
		<s:select disabled="true" name="scriptProfile.frequencyDay" id="frequencyWeek" list="{1,2,3,4,5,6,7}" style="display:none"></s:select>
	</s:else> 
	<s:if test="scriptProfile.frequencyId=='EVERY_MONTH'">
		<s:select name="scriptProfile.frequencyDay" id="frequencyMonth" list="{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31}" value="%{scriptProfile.frequencyDay}"></s:select>
	</s:if> 
	<s:else>
		<s:select disabled="true" name="scriptProfile.frequencyDay" id="frequencyMonth" list="{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31}" style="display:none"></s:select>
	</s:else> 
	<s:if test="scriptProfile.frequencyId=='EVERY_DAY'||scriptProfile.frequencyId=='EVERY_WEEK'||scriptProfile.frequencyId=='EVERY_MONTH'">
		<span id="monitorTimeSpan">
		<s:textfield name="scriptProfile.monitorTime" id="monitorTime" value="%{scriptProfile.monitorTime}" size='5'></s:textfield>
		</span>
	</s:if> 
	<s:else>
		<span id="monitorTimeSpan" style="display:none">
		<s:textfield disabled="true" name="scriptProfile.monitorTime" id="monitorTime" size='5' value="%{scriptProfile.monitorTime}" style="display:none"></s:textfield>
		</span>
	</s:else>
	</li>
	<li><span class="field-middle" style="width:110px;">备注</span><span>：</span> 
	<s:textarea name="scriptProfile.remark" rows="4" cols='40' value="%{scriptProfile.remark}"></s:textarea>
	</li>
	<li><span class="field-middle"></span></li>
	<li><span class="black-btn-l f-right"><span class="btn-r"><span class="btn-m" id="execute"><a>脚本测试</a></span></span></span></li>
</ul>

<div id="paramValues">
<s:iterator value="parameters" id="list" status="f">
 		<s:if test="%{#f.last}">
 			<s:set name="dataSize" value="%{#f.count}"></s:set>
 		</s:if>
</s:iterator>
<s:if test="#dataSize > 0">
<div class="greytable-titlebg"><span class="greytable-titlebg-ico"></span><b>参数设置</b></div>
<span class="field-middle"></span>
<s:iterator value="parameters" status="status">
	<li style="padding-left:1px; margin-top:1px;"><span class="field" ><s:property value='parameteName' />&nbsp;</span>
	<input name="scriptProfile.sptParameterList[<s:property value="#status.index"/>].profileId" value="<s:property value='profileId'/>" type="hidden" /> 
	<input name="scriptProfile.sptParameterList[<s:property value="#status.index"/>].parameterId" value="<s:property value='proParameterId'/>" type="hidden" /> 
	<input name="scriptProfile.sptParameterList[<s:property value="#status.index"/>].parameterValue" value="<s:property value='proParameterValue'/>" /></li>
</s:iterator>
</s:if>
</div>