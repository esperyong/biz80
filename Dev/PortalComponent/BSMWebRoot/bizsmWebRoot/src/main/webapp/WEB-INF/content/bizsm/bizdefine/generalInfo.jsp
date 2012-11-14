<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
	author:liuyong,liuhw
	description:常规信息
	uri:{domainContextPath}/bizsm/bizservice/ui/bizservicemanager

 -->
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="com.mocha.bsm.bizsm.web.util.SpringBeanUtil"%>
<%@ page import="com.mocha.bsm.bizsm.adapter.bsmres.IBSMClientAdapter"%>

<%@taglib prefix="s" uri="/struts-tags"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%
	IBSMClientAdapter clientAdapter = (IBSMClientAdapter)SpringBeanUtil.getSpringBean(request.getSession().getServletContext(),"bizsm.bsmclientadapter");
    String domainPageName = clientAdapter.getDomainPageName();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>业务服务属性信息</title>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<!--link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" /-->

<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" />

<link href="${ctx}/css/jquery-ui/jquery.ui.slider.css" rel="stylesheet" type="text/css" />
<link type="text/css" href="/pureportal/css/validationEngine.jquery.css" rel="stylesheet" media="screen" title="no title" charset="utf-8" />


<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.slider.js"></script>

<script type="text/javascript" src="${ctx}/js/component/slider/j-dynamic-slider.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/ajaxcommon.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>

<script type="text/javascript" src="/pureportal/js/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="/pureportal/js/jquery.validationEngine.js"></script>

<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js "></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine-cn.js"></script>

<script src="${ctx}/js/component/toast/Toast.js" type="text/javascript"></script>

<script>
var confirmConfig = {width: 300,height: 80};
	var toast  = null;
	var domainId = '<s:property value="model.belongDomains[0].domainId"/>';
	$(function(){
		toast = new Toast({position:"CT"});
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
				if(domainIDStr == domainId){
					$belongDomainId_sel.append('<option selected value="'+domainIDStr+'" uri="'+domainURIStr+'" title="'+domainNameStr+'">'+domainNameStr+'</option>');
				}else{
					$belongDomainId_sel.append('<option value="'+domainIDStr+'" uri="'+domainURIStr+'" title="'+domainNameStr+'">'+domainNameStr+'</option>');
				}

			});

		});
	});

	/*
	* 读取责任人列表数据
	*
	*/
	function f_loadBSMPrincipal(){
		//显示加载状态条
		$.blockUI({message:$('#loading')});

		$.get('${ctx}/bsmprincipal/.xml', {}, function(data){
			var dataStr = ''
				+'<UserInfos>'
					+'<UserInfo>'
					  +'<userName>tangyj</userName>'
					  +'<userId>user-M5VE3Y2KLC0D0J0</userId>'
					  +'<orgName>集团</orgName>'
					  +'<email>1@1.com</email>'
					  +'<telPhone />'
					  +'<mobile>13901234567</mobile>'
					+'</UserInfo>'
					+'<UserInfo>'
					  +'<userName>admin</userName>'
					  +'<userId>user-000000000000001</userId>'
					  +'<orgName>集团</orgName>'
					  +'<email>admin@xxx.com.cn</email>'
					  +'<telPhone>-</telPhone>'
					  +'<mobile>13901234567</mobile>'
					+'</UserInfo>'
				+'</UserInfos>';

			var $principalUL = $('#principal_ul');
			$principalUL.empty();
			//var dataDom = func_asXMLDom(dataStr);

			var responsibleDisNameTemp = "", mobileTemp = "", emailTemp = "";
			var responsiblePersonId = $('input[name="model.responsiblePerson.id"]').val();

			var $userInfo = $(data).find('UserInfos>UserInfo');
			$userInfo.each(function(cnt){
				var $this = $(this);

				var userId = $this.find('>userId').text();
				var userName  = $this.find('>userName').text();
				var loginName = $this.find('>loginName').text();
				var email = $this.find('>email').text();
				var telPhone = $this.find('>telPhone').text();
				var mobile = $this.find('>mobile').text();

				if(userId == responsiblePersonId){
					responsibleDisNameTemp = userName;
					mobileTemp = mobile;
					emailTemp = email;
				}

				var $li = $('<li class="list"></li>');
				$li.attr("userID", userId);
				$li.attr("mail", email);
				$li.attr("phone", telPhone);
				$li.attr("mobile", mobile);

				var $radio = $('<input name="userDataID" type="radio" value="'+userId+'" />');

				//$li.append($radio);

				var $nobr = $('<nobr></nobr>');
				$nobr.append($radio);
				$nobr.append('<span elID="nameEl">'+userName+'</span>');
				$nobr.append('<span>('+loginName+')</span>');

				$li.append($nobr);

				$principalUL.append($li);
			});

			$('input[name="responsibleDisName"]').val(responsibleDisNameTemp);
			$('input[name="model.responsiblePerson.telephoneNumber"]').val(mobileTemp);
			$('input[name="model.responsiblePerson.emailAddress"]').val(emailTemp);

			$.unblockUI();// 屏蔽loading
	});
}

	$(function(){
		//负责人列表框对象
		$('#userListPoP').hide();

		//选择负责人按钮
		$('#search_btn').click(function(){
		    $('#principal_ul>li[userID="'+$('input[name="model.responsiblePerson.id"]').val()+'"]>nobr>input[name="userDataID"]').attr("checked", true);
			$('#userListPoP').css("left", $('#search_btn').offset().left+30);
			$('#userListPoP').css("bottom", "70px");
			$('#userListPoP').slideDown(300);
		});

		//负责人列表框取消按钮
		$('#userListBtn-cancel').click(function(){
			$('#userListPoP').slideUp(300);
		});
		//负责人列表框确定按钮
		$('#userListBtn-exec').click(function(){
			var $chkedLi = $('#userListPoP input[name="userDataID"]:checked').parent().parent();

			$('input[name="responsibleDisName"]').val($chkedLi.find('span[elID="nameEl"]').text());
			$('input[name="model.responsiblePerson.id"]').val($chkedLi.attr("userID"));
			$('input[name="model.responsiblePerson.emailAddress"]').val($chkedLi.attr("mail"));
			$('input[name="model.responsiblePerson.telephoneNumber"]').val($chkedLi.attr("mobile"));

			$('#userListPoP').slideUp(300);
		});

		//读取责任人列表数据
		f_loadBSMPrincipal();

	});

	$(
		function(){
			$("#apply").click(
				function(){
					OK();
				}
			);
		}
	);
	$(
			function(){
				$("#add").click(
					function(){
						addRow();
					}
				);
			}
	);
	$(
			function(){
				$("#del").click(
					function(){
						deleteRow();
					}
				);
			}
	);
	$(
			function(){
				$("#checkboxAll").click(
					function(){
						selAll();
					}
				);
			}
	);
	String.prototype.trim=function(){
   		return this.replace(/(^\s*)|(\s*$)/g, "");
	}

	/*
	function checkCustomLength(customObj){
		if($(customObj).val().length > 50){
			alert("自定义属性名称的输入长度不能超过50个字符。");
			$(customObj).select();
			$(customObj).focus();
			return;
		}
	}*/


function get_form_params(p_formId){
	var selectSelector = "form#" + p_formId + " select";
	var inputSelector = "form#" + p_formId + " input";
	var textareaSelector = "form#" + p_formId + " textarea";
	//var textareaSelector = "form#" + p_formId + ":textarea";
	var params = '';

	$(selectSelector).each(
			function (index, domEle) {
				  var selectid = domEle.id;
				  var options = domEle.getElementsByTagName('option');
				  for(var i = 0,il = options.length;i < il;i++){
					if(options[i].selected){
						params += ((params.length > 0)?'&':'') + selectid + '='+encodeURIComponent(options[i].value);
					}
				  }
			}
	);

	$(inputSelector).each(
			function (index, domEle) {
				  var type = domEle.getAttribute('type');
				  if(type=='text'||type=='password'||type=='hidden'||(type=='checkbox'&&domEle.checked)){
					  params += ((params.length > 0)?'&':'')+domEle.name+'='+encodeURIComponent(domEle.value);
				  }
				  if(type=='radio'&&domEle.checked){
					  params += ((params.length > 0)?'&':'')+domEle.name+'='+encodeURIComponent(domEle.value);
				  }
			}
	);

	$(textareaSelector).each(
			function (index, domEle) {
				  params += ((params.length > 0)?'&':'')+domEle.name+'='+encodeURIComponent($(domEle).val());
			}
	);

	return params;
}




	function OK(){
	if(!$.validate($("#newForm"))){
		   return false;
		  }
		var _model_name=document.getElementById("model_name").value;
		document.getElementById("model.name").value=_model_name;

		var $modelName = $('input[name="model.name"]');
		var name = $.trim($modelName.val())

		  /*
		if(name == ""){
			alert("服务名称不允许为空。");
			$modelName.select();
			$modelName.focus();
			return;
		}
		if(common_specialChar(name, /[\"\'%\\:?<>|;&@#*]/)){
			alert("服务名称不能包含特殊字符(\"'%\\:?<>|;&@#*)。");
			$modelName.select();
			$modelName.focus();
			return;
		}
		*/
		/*
		if(common_strInvalid(name)){
			alert("服务名称不能包含特殊字符(\"\'<>``!@#$%^&*+-\/\/\/\\//?,.)");
			$modelName.select();
			$modelName.focus();
			return;
		}
		*/
		/*
		if(name.length > 50){
			alert("服务名称的输入长度不能超过50个字符。");
			$modelName.select();
			$modelName.focus();
			return;
		}
*/
		/*var reflect = document.getElementById("model.reflectFactor").value;
		if(reflect.trim() == ""){
			alert("影响因子不允许为空。");
			document.getElementById("model.reflectFactor").focus();
			return;
		}*/
/*
		var customFlag = customPropIsNull();
		if(customFlag){
			alert('自定义属性不允许为空。');
			return;
		}

		var customCheckValue = customCheckInput();
		if(customCheckValue){
			alert("自定义属性不能包含特殊字符(\"'%\\:?<>|;&@#*)。");
			return;
		}

		var customLength = checkCustomLength();
		if(customLength){
			alert("自定义属性名称的输入长度不能超过50个字符。");
			return;
		}
*/
		//暂时去掉
		//var _mode_customPropertiesKey=document.getElementById("mode_customPropertiesKey").value;
		//document.getElementById("mode.customPropertiesKey").value=_mode_customPropertiesKey;

		var person = document.getElementById("model.responsiblePerson.id").value;
		/*
		if(person.trim() == ""){
			alert("服务责任人不允许为空。");
			//document.getElementById("model.responsiblePerson.name").focus();
			return;
		}

		var remark = document.getElementById("model.remark").value;
		if(remark.trim() != "" && remark.length > 200){
			alert("备注的输入长度不能超过200个字符。");
			document.getElementById("model.remark").focus();
			return;
		}
*/
		var formparamsdata = get_form_params('newForm');

//		var domain = document.getElementById("model.belongDomainIds");0
//		$.each( domain, function(i, n){
//			formparamsdata+="&"+domain.id+"="+n.value;
//		});

		$.ajax({
			  type: 'POST',
			  url: "<%=request.getContextPath()%>/bizservice/<s:property value="model.bizId"/>?__http_method=PUT",
			  contentType: "application/x-www-form-urlencoded",
			  data: formparamsdata,
			  processData: false,
			  cache:false,
			  error: function (request) {
				    var errorMessage = request.responseXML;
					var $errorObj = $(errorMessage).find('FieldErrors>FieldError');
					$errorObj.each(function(i){
						var fieldId = $(this).find('FieldId').text();
						var field = document.getElementById(fieldId);
						var errorInfo = $(this).find('ErrorInfo').text();
						//alert(errorInfo);
						var _information  = top.information();
						_information.setContentText(errorInfo);
						_information.show();
						//field.focus();
					});
			  },
			  success: function(msg){
				 // top.leftFrame.f_updateLeftPanel();
				 toast.addMessage("保存成功!");
				 parent.parent.parent.leftFrame.f_updateLeftPanel();
				     //alert('保存成功!');
			  }
		});


	}

	function checkCustomLength(){
		var flag = false;
		$('#customTable').find('tr').each(function(i){
			if(i > 0){
				var $keyObj = $(this).find('input[id="model.customPropertiesKey"]');
				var $valueObj = $(this).find('input[id="model.customPropertiesValue"]');
				//alert("$keyObj.val()="+$keyObj.val());
				var key = $.trim($keyObj.val());
				//alert("key="+key);
				var value = $.trim($valueObj.val());

				if(key.length > 50){
					$keyObj.select();
					$keyObj.focus();
					flag = true;
					return false;
				}
			}
		});

		return flag;
	}

	function customPropIsNull(){
		var flag = false;
		$('#customTable').find('tr').each(function(i){
			if(i > 0){
				var $keyObj = $(this).find('input[id="model.customPropertiesKey"]');
				var $valueObj = $(this).find('input[id="model.customPropertiesValue"]');
				//alert("$keyObj.val()="+$keyObj.val());
				var key = $.trim($keyObj.val());
				//alert("key="+key);
				var value = $.trim($valueObj.val());
				if(key == ''){
					$keyObj.select();
					$keyObj.focus();
					flag = true;
					return false;
				}
				if(value == ''){
					$valueObj.select();
					$valueObj.focus();
					flag = true;
					return false;
				}
			}
		});

		return flag;
	}

	function customCheckInput(){
		var flag = false;
		$('#customTable').find('tr').each(function(i){
			if(i > 0){
				var $keyObj = $(this).find('input[id="model_customPropertiesKey"]');
				var $valueObj = $(this).find('input[id="model_customPropertiesValue"]');

				var key = $.trim($keyObj.val());
				var value = $.trim($valueObj.val());
				//if(common_strInvalid(key)){
				if(common_specialChar(key, /[\"\'%\\:?<>|;&@#*]/)){
					$keyObj.select();
					$keyObj.focus();
					flag = true;
					return false;
				}
				//if(common_strInvalid(value)){
				if(common_specialChar(value, /[\"\'%\\:?<>|;&@#*]/)){
					$valueObj.select();
					$valueObj.focus();
					flag = true;
					return false;
				}
			}
		});

		return flag;
	}

	function addRow() {

		var all = document.getElementById("checkboxAll");
		var rowIndex = document.getElementById("customTable").rows.length;

		if(rowIndex > 5){
			//alert('最多增加5个自定义属性');
			var _information  = top.information();
			_information.setContentText("最多增加5个自定义属性.");
			_information.show();
			return;
		}

		var row= document.getElementById("customTable").insertRow(rowIndex);
		var col = row.insertCell(0);

		if(all.checked){
		    col.innerHTML = "<input type=checkbox id=propId name=propId checked/>";
		}else{
		    col.innerHTML = "<input type=checkbox id=propId name=propId/>";
		}
		row.appendChild(col);

		col = row.insertCell(1);
		col.innerHTML = "<input type=text id=model_customPropertiesKey_"+rowIndex+" name=model.customPropertiesKey class=\"validate[required[属性名称],length[0,50,属性名称],noSpecialStr[属性名称]]\"  size=30 /><span class=\"red\">*</span>";
		row.appendChild(col);

		col = row.insertCell(2);
		col.align="center";
		col.innerHTML = "&nbsp;&nbsp;&nbsp;：";
		row.appendChild(col);

		col = row.insertCell(3);
		col.innerHTML = "<input type=text id=model_customPropertiesValue_"+rowIndex+" name=model.customPropertiesValue class=\"validate[required[属性值]]\"  size=30  /><span class=\"red\">*</span>";
		row.appendChild(col);

		row.setAttribute("id", "row" + rowIndex);
		document.getElementById("customBody").appendChild(row);
	}

	function deleteRow(){
		var dataNum = $('input[id="propId"]').size();
		if(dataNum == 0){
			//alert('请至少选择一项。');
			var _information  = top.information();
			_information.setContentText("没有要删除的记录。");
			_information.show();
			return;
		}
		var $selObj = $('input[id="propId"]:checked');
		if(!$selObj || $selObj.length <= 0){
			//alert('请至少选择一项。');
			var _information  = top.information();
			_information.setContentText("请至少选择一项。");
			_information.show();
			return;
		}

		var _confirm = top.confirm_box(confirmConfig);
		_confirm.setContentText("此操作不可恢复，是否确认执行？"); //提示框
		_confirm.show();
		_confirm.setConfirm_listener(function() {
			_confirm.hide();
			$selObj.each(function(){
				$(this).parent().parent().remove();
			});
		});
		_confirm.setCancle_listener(function(){
			_confirm.hide();
		});

	}

	function selAll(){
		var flag = $('#checkboxAll').attr('checked');
		$('input[id="propId"]').each(function(){
			$(this).attr('checked', flag);
		});
	}
</script>
</head>

<body>
<form id="newForm" name="newForm">
<div class="set-panel-content-white">
	<div class="sub-panel-open">
		<div class="sub-panel-top">
			<span class="sub-panel-title">属性</span>
		</div>
		<div class="sub-panel-content">
			<ul class="fieldlist-n">
				<li>
					<span class="field-min" style="width:120px">创建人</span><span>：</span>
					<span style="width:275px"><label ><s:property value="model.createUserInfo.userName"/></label></span>
					<span class="field-min" style="width:120px">所属<%= domainPageName%></span><span>：</span>
					<select id="model.belongDomainIds" name="model.belongDomainIds" style="width:150px"></select>
					<span class="red">*</span>
				</li>
				<!-- li>
					<span class="field-middle" style="width:150px">影响因子</span><span>：</span>

					<span id="slider-range-min" style="width:180px;display:-moz-inline-box;display:inline-block"></span>
					&nbsp;&nbsp;&nbsp;
					<input type="text" id="model.reflectFactor" name="model.reflectFactor" maxLength="3" value="<s:property value="model.reflectFactor"/>" size=2/>
				</li -->
				<li>
					<span class="field-min" style="width:120px">名称</span><span>：</span><input id="model_name" type="text" class="validate[required[服务名称],length[0,50,服务名称],noSpecialStr[服务名称]]"  size=50 name="model_name" value="<s:property value="model.name"/>"/>
					<span class="red">*</span>
					<input id="model.name" type="hidden" name="model.name" value="<s:property value="model.name"/>"/>
				</li>
				<li>
					<table>
						<tr>
							<td style="vertical-align:top" width="130px"><nobr><span class="field-min" style="width:120px">备注</span><span>：</span></nobr></td>
							<td>
								<textarea id="model_remark" name="model.remark" cols="52" class="validate[length[0,200,备注]]" rows="4"><s:property value="model.remark"/></textarea>
							</td>
						</tr>
					</table>
				</li>
			</ul>
		</div>
	</div>
	<div class="sub-panel-open">
		<div class="sub-panel-top">
			<span id="del" title="删除" class="r-ico r-ico-close" style="position:absolute;left:420px;"></span>
			<span id="add" title="增加" class="r-ico r-ico-add" style="position:absolute;left:400px;"></span>
			<span class="sub-panel-title">自定义属性</span>
		</div>
		<div class="sub-panel-content">
          <table id="customTable" class="grid-gray-fontwhite">
			<thead>
			<tr>
			 <th width="3%"><input id="checkboxAll" type="checkbox"/></th>
			 <th width="40%">属性名称</th>
			 <th width="2%" style="text-align:center;"></th>
			 <th width="56%">属性值</th>
			</tr>
		   </thead>
			<tbody id="customBody">
			<s:iterator value="model.customPropertiesKey" status="stuts">
      			<tr>
      				<s:iterator value="model.customPropertiesKey[#stuts.index]" >
						<td><input type=checkbox id=propId name=propId/></td>
       					<td height="30px">
       						<input type="text" id="model_customPropertiesKey_<s:property value="#stuts.index"/>"  name=model.customPropertiesKey  value="<s:property/>" class="validate[required[属性名称],length[0,50,属性名称],noSpecialStr[属性名称]]"  size=30/><span class="red">*</span>
       					</td>
       					<td>&nbsp;&nbsp;&nbsp;：</td>
      				</s:iterator>
      				<s:iterator value="model.customPropertiesValue[#stuts.index]" >
       					<td height="30px">
       						<input type="text" id="model_customPropertiesValue+<s:property value="#stuts.index"/>" name=model.customPropertiesValue    value="<s:property/>"  class="validate[required[属性值],length[0,50,属性值],noSpecialStr[属性值]]" size=30/><span class="red">*</span>
       					</td>
      				</s:iterator>
      			</tr>
     		</s:iterator>
			</tbody>
		  </table>
		</div>
	</div>

	<div class="sub-panel-open">
		<div class="sub-panel-top">
			<span class="sub-panel-title">责任人信息</span>
		</div>
		<div class="sub-panel-content">
			<ul class="fieldlist-n">
				<li>
					<span class="field-middle" style="width:120px">服务责任人</span><span>：</span>
					<input type="text" readonly name="responsibleDisName" id="responsibleDisName" class="validate[required[服务责任人]]"/>

					<input type="hidden" id="model.responsiblePerson.id" name="model.responsiblePerson.id" value="<s:property value="model.responsiblePerson.id"/>"/>

					<span class="ico" title="选择" id="search_btn" style="vertical-align:top"></span><span class="red" style="vertical-align:middle">*</span>
					<span style="width:105px">&nbsp;</span>
					<span class="field-middle" style="width:120px">手机号</span><span>：</span>
					<input id="model.responsiblePerson.telephoneNumber" readonly type="text" size="14" name="model.responsiblePerson.telephoneNumber" />
				</li>
				<li>
					<span class="field-middle" style="width:120px">电子邮箱</span><span>：</span>
					<input id="model.responsiblePerson.emailAddress" readonly type="text" name="model.responsiblePerson.emailAddress"/>
				</li>
			</ul>
			<div class="t-right"><span class="win-button"><span id="apply" class="win-button-border"><a>应用</a></span></span></div>
		</div>
	</div>
</div>
</form>

<div id="userListPoP" class="pop-black" style="position:absolute;z-index:101;width:220px;">
	<div class="pop-top-l">
		<div class="pop-top-r">
			<div class="pop-top-m">页面上部修饰</div>
		</div>
	</div>
	<div class="pop-middle-l">
		<div class="pop-middle-r">
			<div class="pop-middle-m">
				<div class="pop-content">
				  <div class="cue">
					<div class="ruler"></div>
					<div class="cue-content">
						<ul>
							<li class="title">请选择用户名：</li>
						</ul>
						<ul id="principal_ul" class="bg-boder" style="height:100px;widht:100%;overflow-y:auto;overflow-x:auto;"></ul>

					</div>
					<div>
						<ul>
							<li>
								<span>
									<span id="userListBtn-cancel" class="gray-btn-l  f-right">
										<span class="btn-r">
											<span class="btn-m"><a>取消</a></span>
										</span>
									</span>
									<span id="userListBtn-exec" class="gray-btn-l  f-right">
										<span class="btn-r">
											<span class="btn-m"><a>确定</a></span>
										</span>
									</span>
								</span>
							</li>
						</ul>
					</div>
				  </div>
			    </div>
			</div>
		</div>
	</div>
	<div class="pop-bottom-l">
		<div class="pop-bottom-r">
			<div class="pop-bottom-m">页面下部修饰</div>
		</div>
	</div>
</div>

<div class="loading" id="loading" style="display:none;">
 <div class="loading-l">
  <div class="loading-r">
    <div class="loading-m">
       <span class="loading-img">载入中，请稍候...</span>
    </div>
  </div>
  </div>
</div>

<script type="text/javascript">
 $(function(){
$("#newForm").validationEngine();
})
</script>
</body>
</html>