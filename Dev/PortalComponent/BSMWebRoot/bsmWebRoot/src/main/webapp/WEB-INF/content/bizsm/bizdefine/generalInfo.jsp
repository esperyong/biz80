<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
	author:liuyong,liuhw
	description:常规信息
	uri:{domainContextPath}/bizsm/bizservice/ui/bizservicemanager
 -->
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Untitled Document</title>
<link href="<%=request.getContextPath()%>/css/master.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/portal.css" rel="stylesheet" type="text/css" />

<link href="<%=request.getContextPath()%>/css/jquery-ui/jquery.ui.slider.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
<script src="<%=request.getContextPath()%>/js/component/cfncc.js" type="text/javascript"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/component/plugins/jquery.ui.slider.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/component/slider/j-dynamic-slider.js"></script>


<script type="text/javascript" src="<%=request.getContextPath()%>/js/bizservice/ajaxcommon.js"></script>

<script>


	$(function() {
		var jDynamicSlide = new JDynamicSlider({id:"slider-range-case1",defaultValue:"<s:property value="model.reflectFactor"/>",min:0,max:100});
		
		jDynamicSlide.change(function(value){
			$("#model\\.reflectFactor").val(value);
		});

		jDynamicSlide.appendToContainer($("#slider-range-min"));
		
		//alert($("#jd-slider-root").html());
		
		$("#model\\.reflectFactor").val(jDynamicSlide.getValue());

		$("#model\\.reflectFactor").change(function(){
			var num = $('#model\\.reflectFactor').val();
			jDynamicSlide.setValue(num);
		});
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
	
	function OK(){
		//var name = $("#model\\.name").attr("value");
		var name = document.getElementById("model.name").value;
		if(name.trim() == ""){
			alert("服务名称不允许为空。");
			document.getElementById("model.name").focus();
			return;
		}
		if(name.length > 50){
			alert("服务名称的输入长度不能超过50个字符。");
			document.getElementById("model.name").focus();
			return;
		}

		var reflect = document.getElementById("model.reflectFactor").value;
		if(reflect.trim() == ""){
			alert("影响因子不允许为空。");
			document.getElementById("model.reflectFactor").focus();
			return;
		}

		var customFlag = customPropIsNull();
		if(customFlag){
			alert('自定义属性不允许为空。');
			return;
		}

		//暂时去掉
		var person = document.getElementById("model.responsiblePerson.name").value;
		//if(person.trim() == ""){
		//	alert("服务责任人不允许为空。");
		//	document.getElementById("model.responsiblePerson.name").focus();
		//	return;
		//}
		
		var remark = document.getElementById("model.remark").value;
		if(remark.trim() != "" && remark.length > 200){
			alert("备注的输入长度不能超过200个字符。");
			document.getElementById("model.remark").focus();
			return;
		}
		
		var formparamsdata = get_form_params('newForm'); 
		var domain = document.getElementById("model.belongDomainIds");
		$.each( domain, function(i, n){
			formparamsdata+="&"+domain.id+"="+n.value;
		});
		
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
						alert(errorInfo);
						field.focus();
					});
			  },
			  success: function(msg){
				  parent.f_updateLeftPanel();
				     //alert('保存成功!');
			  }			  		  
		});	

		
	}

	function customPropIsNull(){
		var flag = false;
		$('#customTable').find('tr').each(function(i){
			if(i > 0){
				var key = $(this).find('input[id="model.customPropertiesKey"]').val();
				var value = $(this).find('input[id="model.customPropertiesValue"]').val();
				if($.trim(key) == ''
					|| $.trim(value) == ''){
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

		var row= document.getElementById("customTable").insertRow(rowIndex);
		var col = row.insertCell(0);
		
		if(all.checked){
		    col.innerHTML = "<input type=checkbox id=propId name=propId checked/>";
		}else{
		    col.innerHTML = "<input type=checkbox id=propId name=propId/>";
		}
		row.appendChild(col);
		
		col = row.insertCell(1);
		col.innerHTML = "<input type=text id=model.customPropertiesKey name=model.customPropertiesKey maxLength=25 size=20/>";
		row.appendChild(col);
		
		col = row.insertCell(2);
		col.align="center";
		col.innerHTML = "&nbsp;&nbsp;&nbsp;：";
		row.appendChild(col);
		
		col = row.insertCell(3);
		col.innerHTML = "<input type=text id=model.customPropertiesValue name=model.customPropertiesValue maxlength=25 size=20 />"; 
		row.appendChild(col);
		
		row.setAttribute("id", "row" + rowIndex); 
		document.getElementById("customBody").appendChild(row); 
	}
	   
	function deleteRow(){
	    $('input[id="propId"]:checked').each(function(){
	 	    $(this).parent().parent().remove();
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
					<span class="field-min">名称：</span>
					<input id="model.name" type="text" name="model.name" value="<s:property value="model.name"/>"/>
					<span class="red">*</span>
				</li>
				<li>
					<span class="field-min">创建人：</span>
					<label >admin</label>
				</li>	
				<li>
					<span class="field-min">所属域:</span>
					
					<select id="model.belongDomainIds" name="model.belongDomainIds" multiple="multiple" size="4">
						<s:iterator value="model.belongDomainIds" status="stuts">
							<s:iterator value="model.belongDomainIds[#stuts.index]" >   
       							<option value="<s:property/>"><s:property/></option>
      						</s:iterator> 
						</s:iterator>
						<!-- option value="bb">bb1</option> -->
					</select>
					<span class="ico ico-find"></span>
				</li>
				<li>
					<span class="field-middle">影响因子：</span>
					<span id="slider-range-min" style="width:180px;display:-moz-inline-box;display:inline-block"></span>
					<input type="text" id="model.reflectFactor" name="model.reflectFactor" value="<s:property value="model.reflectFactor"/>" size=2/>
					<span class="red">*</span>
				</li>
				<li>
					<span class="field-min">备注：</span>
					<textarea id="model.remark" name="model.remark" cols="30" rows="4"><s:property value="model.remark"/></textarea>
				</li>										
			</ul>
		</div>
	</div>
	<div class="sub-panel-open">
		<div class="sub-panel-top">
			<span id="del" class="r-ico r-ico-close"></span>
			<span id="add" class="r-ico r-ico-add"></span>
			<span class="sub-panel-title">自定义属性</span>
		</div>
		<div class="sub-panel-content">
          <table id="customTable" class="grid-gray-fontwhite">
			<thead>
				<tr>
					<th width="10%"><input id="checkboxAll" type="checkbox"/></th>
					<th width="40%">属性名称</th>
					<th width="10%"></th>
					<th width="40%">属性值</th>
				</tr>
			</thead>
			<tbody id="customBody">
			<s:iterator value="model.customPropertiesKey" status="stuts">
      			<tr>
      				<s:iterator value="model.customPropertiesKey[#stuts.index]" >    
      					<td><input type=checkbox id=propId name=propId/></td>  				
       					<td height="30px">
       						<input type=text id=model.customPropertiesKey name=model.customPropertiesKey value="<s:property/>" maxLength=25 size=20/>
       					</td>
       					<td>&nbsp;&nbsp;&nbsp;：</td>
      				</s:iterator>
      				<s:iterator value="model.customPropertiesValue[#stuts.index]" >      				
       					<td height="30px">
       						<input type=text id=model.customPropertiesValue name=model.customPropertiesValue value="<s:property/>" maxLength=25 size=20/>
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
			<span class="sub-panel-title">负责人信息：</span>
		</div>
		<div class="sub-panel-content">
			<ul class="fieldlist-n">
				<li>
					<span class="field-middle">服务责任人：</span>
					<input type="text"id="model.responsiblePerson.name" name="model.responsiblePerson.name" value="<s:property value="model.responsiblePerson.name"/>"/>
					<span class="ico ico-select"></span>
					<span class="red">*</span>
				</li>
				<li>
					<span class="field-middle">联系电话：</span>
					<input id="model.responsiblePerson.telephoneNumber" type="text" name="model.responsiblePerson.telephoneNumber" value="<s:property value="model.responsiblePerson.telephoneNumber"/>"/>
				</li>
				<li>
					<span class="field-middle">电子邮件：</span>
					<input id="model.responsiblePerson.emailAddress" type="text" name="model.responsiblePerson.emailAddress" value="<s:property value="model.responsiblePerson.emailAddress"/>"/>
				</li>
			</ul>
			<div class="t-right"><span class="win-button"><span id="apply" class="win-button-border"><a>应用</a></span></span></div>
		</div>
	</div>
</div>
</form>
</body>
</html>