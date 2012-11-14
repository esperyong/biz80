<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="com.mocha.bsm.bizsm.web.util.SpringBeanUtil"%>
<%@ page import="com.mocha.bsm.bizsm.adapter.bsmres.IBSMClientAdapter"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
	author:liuyong,liuhw
	description:添加业务服务
	uri:{domainContextPath}/bizsm/bizservice/ui/addnewbizservice
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%
	IBSMClientAdapter clientAdapter = (IBSMClientAdapter)SpringBeanUtil.getSpringBean(request.getSession().getServletContext(),"bizsm.bsmclientadapter");
    String domainPageName = clientAdapter.getDomainPageName();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>新建服务</title>
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.pop-win{ overflow:hidden; margin:0 auto; z-index:999;}
.pop-win-tl{ background:url(../../../images/uicomponent/window/pop-window.gif) left 0 no-repeat; padding-left:10px;}
.pop-win-tr{ background:url(../../../images/uicomponent/window/pop-window.gif) right -29px no-repeat; padding-right:10px;}
.pop-win-tc{ background:url(../../../images/uicomponent/window/pop-window.gif) right -58px repeat-x; overflow:auto;zoom:1;padding:7px 4px 6px;}
.pop-title-m{ background:url(../../../images/uicomponent/window/pop-title-ico.gif) 0% 50% no-repeat; text-indent:0px; color:#fff; font-weight:700; display:inline-block;*display:inline;zoom:1;padding-left:15px; padding-right:0px;}
.pop-title-m span{ font-weight:700; margin-top:1px;}
.pop-title{background:none; padding-right:3px; float:left;zoom:1; display:block; text-indent:0; padding-left:0;}
.pop-win-m{ background:#060606; border:#6d6d6d 1px solid; border-bottom:none; border-top:none; padding:0 5px;}
.pop-win-content{ overflow-x:hidden;overflow-y:auto;background:#fff; border:#6B6B6B 1px solid}
.pop-win-bl{ background:url(../../../images/uicomponent/window/pop-window-bottom.gif) no-repeat left 0;padding-left:10px;}
.pop-win-br{ background:url(../../../images/uicomponent/window/pop-window-bottom.gif) no-repeat right -25px ; padding-right:10px;}
.pop-win-bc{ background:url(../../../images/uicomponent/window/pop-window-bottom.gif) repeat-x left -50px;height:25px; vertical-align:middle; padding:0;}
</style>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/ajaxcommon.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine-cn.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>
<script src="${ctx}/js/component/popwin.js" type="text/javascript"></script>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<script>
var confirmConfig = {width: 200,height: 80};
	$(function(){
		$("#newForm").bind("submit", function(event){
			event.preventDefault();
		});
	});

	$(function(){
		//读取域列表
		$.get('${ctx}/bsmdomain/.xml',{},function(data){
			var $domainData = $(data).find('BSMDomains:first>BSMDomain');
			var $belongDomainId_sel = $('select[id="model.belongDomainIds"]');
			$belongDomainId_sel.empty();
			$domainData.each(function(cnt){
				var $thisDomain = $(this);
				var domainIDStr = $thisDomain.find('domainId').text();
				var domainNameStr = $thisDomain.find('domainName').text();
				var domainURIStr = $thisDomain.find('uri').text();

				$belongDomainId_sel.append('<option value="'+domainIDStr+'" uri="'+domainURIStr+'" title="'+domainNameStr+'">'+domainNameStr+'</option>');
			});

		});
		$('#model_remark').val("最多可输入200个字符。");
		$('#model_remark').click(function(){
			var $this = $(this);
			if($this.val() == "最多可输入200个字符。"){
				$this.val("");
			}
		});
		$('#model_remark').blur(function(){
			var $this = $(this);
			if($this.val() == ""){
				$this.val("最多可输入200个字符。");
			}
		});
	});

	$(
			function(){
				$("#confirm").click(
					function(){
						OK();
					}
				);
			}
	);

	$(
			function(){
				$("#concel").click(
					function(){
						Cancel();
					}
				);
			}
	);

	$(
			function(){
				$("#close").click(
					function(){
						Cancel();
					}
				);
			}
	);

	String.prototype.trim=function(){
   		return this.replace(/(^\s*)|(\s*$)/g, "");
	}

	function OK(){
		var _model_name=document.getElementById("model_name").value;
		document.getElementById("model.name").value=_model_name;

		var _model_remark=document.getElementById("model_remark").value;
		if(_model_remark == "最多可输入200个字符。"){
				document.getElementById("model.remark").value="";
		}else{
			document.getElementById("model.remark").value=_model_remark;
		}

		 if(!$.validate($("#newForm"))){
		   return false;
		  }
		var $modelName = $('input[name="model.name"]');
		var name = $.trim($modelName.val())

		var formparamsdata = get_form_params('newForm');

		var $domain = $("model.belongDomainIds>option:selected");
		$domain.each(function(i){
			var $this = $(this);
			formparamsdata+="&"+domain.id+"="+$this.attr("value");
		});

		//$modelName.val(name);

		var httpClient;
		$.ajax({
			  type: 'POST',
			  url: "<%=request.getContextPath()%>/bizservice/.xml",
			  contentType: "application/x-www-form-urlencoded",
			  data: 'xhr=1&' + formparamsdata,
			  processData: false,
			  beforeSend: function(request){
				  httpClient = request;
			  },
			  cache:false,
			  error: function (request) {
				    var errorMessage = request.responseXML;
					var $errorObj = $(errorMessage).find('FieldErrors>FieldError');
					$errorObj.each(function(i){
						var fieldId = $(this).find('FieldId').text();
						var field = document.getElementById(fieldId);
						var errorInfo = $(this).find('ErrorInfo').text();
						var _information  = information();
						_information.setContentText(errorInfo);
						_information.show();
						return;
						//field.focus();
					});
			  },
			  success: function(msg){
				  var uri = httpClient.getResponseHeader("Location");
				  window.returnValue = uri;
				  window.close();
			  }
		});


	}

	function Cancel(){
		window.close();
	}



</script>
</head>
<body>
	<form id="newForm" name="newForm"  action="self" style="height:110px">
	<div class="roundedform">
	<div class="roundedform-top">
		<div class="top-right">
		  <div class="top-min">
				<table class="hundred"><thead><tr><th>
				<div class="theadbar">
				            <a id="close" title="关闭" class="win-ico win-close"></a>
							<div class="theadbar-name">新建服务</div>
						</div></th></tr></thead></table>
			</div>
		</div>
	</div>
<div style="height:30px">&nbsp;</div>
	<div class="roundedform-content02">
	    <div>
			<ul class="fieldlist">
				<li>
					<span class="field" style="width:120px">服务名称</span><span>：</span>
					<input id="model_name" name="model_name" type="text" value="" size="30" class="validate[required[服务名称],length[0,50,服务名称],noSpecialStr[服务名称]]"/>
					<input id="model.name" name="model.name" type="hidden" value="" size="30" />
					<span class="red">*</span>
				</li>
				<li>
					<span class="field" style="width:120px">所属<%= domainPageName%></span><span>：</span>
					<select id="model.belongDomainIds" name="model.belongDomainIds" style="width:158px"></select>&nbsp;<div style="display:inline;margin-left:25px;"><span class="red">*</span></div>
				</li>
				<li>
					<span class="field" style="width:120px; vertical-align:top;">备注</span><span style="vertical-align:top;">：</span>
					<textarea cols="30" rows="4" id="model_remark" name="model_remark" class="validate[length[0,200,备注]]" style="width:175px"></textarea>&nbsp;<div style="display:inline;margin-left:25px;"></div>
					<input id="model.remark" name="model.remark" type="hidden" value=""/>
				</li>
				<li class="last">
				   <span class="black-btn02-l black-btn02-l-blank"><span class="btn-r"><span id="concel" class="btn-m"><a >取消</a></span></span></span>
				   <span class="black-btn02-l  black-btn02-l-blank"><span class="btn-r"><span id="confirm" class="btn-m"><a >确定</a></span></span></span>					</li>
				</li>
			</ul>
		</div>
	</div>
	<div class="roundedform-bottom">
		<div class="bottom-right">
			<div class="bottom-min"></div>
		</div>
	</div>
</div>
	</form>
</body>
<script type="text/javascript">
 $(function(){
$("#newForm").validationEngine();
})
</script>
</html>
