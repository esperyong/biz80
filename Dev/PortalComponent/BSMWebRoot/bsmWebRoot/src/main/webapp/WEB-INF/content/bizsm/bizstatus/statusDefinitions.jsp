<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
	author:liuhw
	description:自定义规则
	uri:{domainContextPath}/bizsm/bizservice/ui/bizservicemanager
 -->
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>规则设定</title>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/ajaxcommon.js"></script>
<script>
$(function(){
	$("#display").click(
			function(){
				window.open("${ctx}/bizsm/bizservice/ui/bizstatusmanager!getDefaultRule","系统默认规则","height=300, width=420");
			}
	);
	$("#edit").click(
			function(){
				var srvId = "<s:property value="model.bizId"/>";
				window.open("${ctx}/bizsm/bizservice/ui/bizstatusmanager!getCustomRule?serviceId="+srvId,"自定义规则","height=550, width=500");
			}
	);
	
	$("#apply").click(
		function(){
			var value = $('input[name="rule"]:checked').val();
			//默认选择默认规则
			var rule = "false";
			if(value == "1"){
				rule = "true";
			}
			var data = "<BizService><confStateCal>"+rule+"</confStateCal></BizService>";
			//alert(data);
			var srvId = "<s:property value="model.bizId"/>";
			
			$.ajax({
				  type: 'PUT',
				  url: "${ctx}/bizservice/" + srvId,
				  contentType: "application/xml",
				  data: data,
				  processData: false,
				  cache:false,
				  error: function (request) {
					    var errorMessage = request.responseXML;
						var $errorObj = $(errorMessage).find('FieldErrors>FieldError');
						$errorObj.each(function(i){
							var fieldId = $(this).find('FieldId').text();
							var field = document.getElementById(fieldId);
							var errorInfo = $(this).find('ErrorInfo').text();
							alert(errorInfo);
							field.focus();
						});
				  },
				  success: function(msg){
				      alert('保存成功!');
				  }			  		  
			});
			
		}		
	);
	
});
</script>
</head>
<body>
<div class="set-panel-content-white">
  <div style="height:240px;" >
    <ul class="fieldlist-m">
      <li class="title"> <span class="gray-btn-l  f-right"> <span class="btn-r"> <span class="btn-m"><a id="display">查看</a></span> </span> </span> <span>
        <input name="rule" type="radio" value="0" <s:if test="model.confStateCal != true">checked</s:if>/>
        </span> <span class="fold-top-title">系统默认规则</span> </li>
      <li class="txt"> <span >通过服务包含的资源、子服务状态自动计算状态，不可编辑。</span> </li>
      <li class="title"> <span class="gray-btn-l  f-right"> <span class="btn-r"> <span class="btn-m"><a id="edit">编辑 </a></span> </span> </span> <span>
        <input name="rule" type="radio" value="1" <s:if test="model.confStateCal">checked</s:if>/>
        </span> <span class="fold-top-title">自定义规则</span> </li>
      <li class="txt"> <span >手工定义服务的状态规则。</span> </li>
    </ul>
  </div>
  <div class="buttonline"><span class="win-button02"><span class="win-button02-border"><a id="apply">应用</a></span></span></div>
</div>
</body>
</html>