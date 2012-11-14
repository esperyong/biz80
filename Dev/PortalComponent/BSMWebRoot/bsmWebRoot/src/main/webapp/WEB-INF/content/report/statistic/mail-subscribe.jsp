<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css" />
<link href="${ctxCss}/tongjifenxi.css" rel="stylesheet" type="text/css" />
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript" src="${ctxJs}/component/tabPanel/tab.js"></script>
<script type="text/javascript" src="${ctxJs}/component/menu/menu.js"></script> 
<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctxJs}/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctxJs}/report/statistic/statisticMetric.js"></script>
<page:applyDecorator name="popwindow" title="邮件订阅">
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">mailSubsribe</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submitMailSubsribe</page:param>
	<page:param name="bottomBtn_text_1" >确定</page:param>

	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancelMailSubsribe</page:param>
	<page:param name="bottomBtn_text_2" >取消</page:param>

	<page:param name="content">
	<s:form id="mailSubscribeForm">
		<div class="fold-blue">
			<ul class="fieldlist-n" >
			<input type="hidden" id="userId" name="userId" value="<s:property value="userId" />">
			<input type="hidden" id="customReportId" name="subscribereportvo.customReportId" value="<s:property value="reportID" />">
			<li><span class="field-middle">报告名称：</span> <span id="reportName"><s:property value="reportName" /></span></li>
			<li><span class="field-middle">邮件订阅：</span> 
			<s:if test="#subscribereportvo.subscription!='true'">
				<input type="radio" name="subscribereportvo.subscription" value="true" /><span>是</span> 
				<input type="radio" name="subscribereportvo.subscription" value="false" checked="checked" /> <span>否</span>				
			</s:if>
			<s:else>
				<input type="radio" name="subscribereportvo.subscription" value="true" checked="checked" /><span>是</span> 
				<input type="radio" name="subscribereportvo.subscription" value="false" /> <span>否</span> 
			</s:else>
			</li>
			<li><span class="field-middle">接收邮箱：</span>
			<span style="width:223px;display:inline-block;zoom:1" id="receiveMail"><s:property value="mail"/></span>
			<span class="black-btn-l"><span class="btn-r"><span class="btn-m"><a id="userEditor" onclick="editorUser()">编辑</a></span></span></span><span class="ico ico-what" title="邮箱可在用户基本信息中编辑。"></span> 
			<input type="hidden"  name="mail" value="<s:property value="mail" />"/>
			</li>
			<li><span class="field-middle multi-line">其他接收人：</span> 
			<textarea cols="40" rows="5" id="otherUserName" readonly=“true" ><s:property value="recipientNames" escape="false" /></textarea>
			<span>　</span><span class="black-btn-l" style="margin-bottom:54px"><span class="btn-r"><span class="btn-m"><a id="personalChoice" onclick="choicePersonal()">选择</a></span></span></span>
			<input type="hidden" id="otherUserId"  name="recipients" value="<s:property value="recipients" />"/>
			</li>
			<li class="last"><span class="field-middle multi-line">其他接收人邮箱：</span> 
			<s:if test="#receiveMails!=null">
				<s:textarea cols="52" rows="5" id="otherMail" name="receiveMails" onblur="checkMail()" value="%{receiveMails }"></s:textarea>	
			</s:if>
			<s:else>
				<s:textarea cols="52" rows="4" id="otherMail" name="receiveMails" onblur="checkMail()" value="多个邮件地址之间请用英文分号分隔"></s:textarea>	
			</s:else>					
			</li>
			<li><span class="field-middle">报告文件格式：</span><select id="reportFormat" >			
			<s:iterator var="type" value="filetype" status="stat">
				<option value="<s:property value=" #type.name() " />"><s:property value=" #type.name() " /></option>		
			</s:iterator>
			</select>
			<input type="hidden" id="reportFileType"  name="reportFileType" value="<s:property value="reportFileType" />"/>
			</li>
			</ul>
		</div>
		</s:form>
	</page:param>
</page:applyDecorator>
<script type="text/javascript">
var popInfo = new information();
popInfo.offset({top:'100px',left:'100px'});
$(function(){	
	var reportFileType=$("#reportFileType").val();
	if(reportFileType){
		$("#reportFormat").val(reportFileType);
	}
	var flag=$("input[type$='radio']:checked").val();
	setEidtor(flag);
});
//页面加载完成后，给页面的报告名称，邮箱地址赋值
$("input[type$='radio']").click(function(){
	var flag=$(this).val();
	setEidtor(flag);
});
function setEidtor(flag){
	if(flag=="false"){		
		$("#otherUser").attr("disabled",true);
		$("#otherMail").attr("disabled",true);	
		$("#userEditor").attr("disabled",true);
		$("#personalChoice").attr("disabled",true);
		$("#reportFormat").attr("disabled",true);
	}
	else{
		$("#otherUser").attr("disabled",false);
		$("#otherMail").attr("disabled",false);	
		$("#userEditor").attr("disabled",false);
		$("#personalChoice").attr("disabled",false);
		$("#reportFormat").attr("disabled",false);
	}
}
//编辑用户信息
function editorUser(){	
	popWindow("/mochaadmin/organization/user/user-content.action?report=report",660,330);
}
function setMail(mail){
	if(objValue.isNotEmpty(mail)){
		$("#receiveMail").html(mail);
		$("input[name$='mail']").val(mail);
	}	
}
//选择人员
function choicePersonal(){	
	var userId=$("#userId").val();
	popWindow("${ctx}/report/statistic/statisticManage!loadChoicePersonnel.action?userId="+userId,380,425);
}
function setPersonal(userIds,userNames){
	if(objValue.isNotEmpty(userIds)){
		$("#otherUserName").html(userNames);
		$("#otherUserId").val(userIds);
	}	
}
$("#otherMail").click(function(){
	var mailValues=$("#otherMail").val();
	if(mailValues=="多个邮件地址之间请用英文分号分隔"){
		$("#otherMail").val("");
	}
});
//确定提交
$("#submitMailSubsribe").click(function(){
	var flag=$("input[type$='radio']:checked").val();
	$("#reportFileType").val($("#reportFormat").val());
	var otherUserId=$("#otherUserId").val();
	var otherMail=$("#otherMail").val();
	if(otherMail=="多个邮件地址之间请用英文分号分隔"){
		$("#otherMail").val("");
	}
	var url="${ctx}/report/statistic/statisticManage!subscribeReport.action";
	var ajaxParam=$("#mailSubscribeForm").serialize();
	var result=submitFrom(url,ajaxParam);	
	if(result){
		dialogArguments.setIco(flag);
		closeWindow();
	}	
});
//校验mail
function checkMail(){
	var regEmail = /^([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	var mails=$("#otherMail").val();
	if(objValue.isNotEmpty(mails)){
		var mail=mails.split(";");
		var errorMails=[];
		var googMails=[];
		var flag=false;
		for(var i=0;i<mail.length;i++){
			var strMail=mail[i];
			var matchArray = strMail.match(regEmail);
	        if(matchArray == null){
	        	errorMails.push(strMail);
	        	flag=true;
	        }else{
	        	googMails.push(strMail);
	        }
		}
		if(flag){
			popInfo.setContentText(errorMails.join(";")+" 邮箱地址输入有误。");
			popInfo.show();
			$("#otherMail").val(googMails.join(";"));
			return false;			
		}
	}else{
		$("#otherMail").val("多个邮件地址之间请用英文分号分隔");
	}	
}
//取消提交
$("#cancelMailSubsribe").click(function(){
	closeWindow();
});
$("#mailSubsribe").click(function(){
	closeWindow();
});
</script>