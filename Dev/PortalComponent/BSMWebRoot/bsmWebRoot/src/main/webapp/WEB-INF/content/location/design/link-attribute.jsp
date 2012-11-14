<!-- WEB-INF\content\location\design\link-attribute.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>链路属性</title>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/component/cfncc.js"></script>
<script src="${ctxJs}/component/tabPanel/tab.js"></script>
<script src="${ctxJs}/component/panel/panel.js" type="text/javascript"></script>
<script src="${ctxJs}/component/accordionPanel/accordionPanel.js" type="text/javascript"></script>
<script src="${ctxJs}/component/accordionPanel/accordionAddSubPanel.js" type="text/javascript"></script>
<script src="${ctxJs}/component/toast/Toast.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	var panel = null;
	var tp = new TabPanel({id:"mytab"});
	var toast = new Toast({position:"CT"});
	
	$("#nodes").validationEngine({
			promptPosition:"topRight", 
			validationEventTriggers:"keyup blur change",
			inlineValidation: false,
			scroll:false,
			success:false
		});
	
	$("#submit").click(function(){
		settings = {
	   promptPosition:"topRight", 
	   validationEventTriggers:"keyup blur change",
	   inlineValidation: true,
	   scroll:false,
	   success:false
	 }

	  if(!$.validate($('#nodes'),settings)) {
		 return;
		}else{
			opener.saveProperty({
		    type:$("#component_type").val(),
		    locationId:$("#component_locationId").val(),
		    componentId:$("#component_componentId").val(),
		    isRelationRes:$("input[name='component.isRelationRes']:checked").length>0?
	    			 $("input[name='component.isRelationRes']:checked").val():"false",
		    relationResId:$("#component_relationResId").val(),
			fromResId:$("#component_fromResId").val(),
		    fromInterfaceId:$("#component_fromInterfaceId").val(),
		    toResId:$("#component_toResId").val(),
		    toInterfaceId:$("#component_toInterfaceId").val(),
		    linkType:$("input[name='component.linkType']:checked").length>0?
	    			 $("input[name='component.linkType']:checked").val():"",
	    	linkRemark:$("input[name='component.linkRemark']:checked").length>0?
	    			 $("input[name='component.linkRemark']:checked").val():"",
	    	linkUpflow:$("input[name='component.linkUpflow']:checked").length>0?
	    			 $("input[name='component.linkUpflow']:checked").val():"",
	    	linkDownflow:$("input[name='component.linkDownflow']:checked").length>0?
	    			 $("input[name='component.linkDownflow']:checked").val():""
	    	//,
	    	//linkDirection:$("input[name='component.linkDirection']:checked").val()
		});
		window.close();
			}
		
	});
	
	
	
	$("#cancel").click(function(){
		window.close();
	});

	$("#closeId").click(function(){
		window.close();
	});
	
	$("#apply").click(function(){
		$("#submit").click();
	});
	
	// 选择资源事件
	/*
	$("span[name=seleceEquipment]").click(function(){
		var equipment = window.showModalDialog("${ctx}/location/relation/device!showSelectEquipment.action?location.locationId=${component.locationId}","help=no;status=no;scroll=yes;center=yes");
		if(equipment){
			alert(this.res);
			$("#"+this.res+"Id").val(equipment.id);
			$("#"+this.res+"Name").val(equipment.equipName);
		}
	});
	*/
	// 选择资源接口事件
	$("span[name=interfaces]").click(function(){
		var resId = $("#" + this.res + "ResId").val();
		if(resId!=""){
			var resource = window.showModalDialog("${ctx}/location/relation/resource!selectInterfaces.action?resId="+resId,"help=no;status=no;scroll=yes;center=yes");
			if(resource){
				$("#component_relationResId").val(resource.id);
				$("#component_relationResName").val(resource.name);
				$("#component_fromResId").val(resource.leftIp);
				$("#component_fromInterfaceId").val(resource.leftName);
				$("#component_toResId").val(resource.rightIp);
				$("#component_toInterfaceId").val(resource.rightName);
			}
			return;
		} else {
			// 资源Id为空
			if(this.res=="component_from"){
				toast.addMessage("请选择源设备");
			} else {
				toast.addMessage("请选择目的设备");
			} 
		}

	});
	
	if($("input[name='component.isRelationRes']:checked").val() == "true"){
		  $("#component_relationResName").attr("class","validate[required]");
		  $("#link_red").show();
		}else{
			$("#link_red").hide();
			}
	
	$("input[name='component.isRelationRes']").click(function(){
		if(this.checked){
			if(this.value == 'true'){
				$("#component_relationResName").attr("class","validate[required]");
				$("#link_red").show();
				}else{
					$("#component_relationResName").attr("class","");
					$("#link_red").hide();
					}
			}else{
					$("#component_relationResName").attr("class","");
					$("#link_red").hide();
					}
		});
	
});
</script>
</head>
<body >

<page:applyDecorator name="popwindow"  title="链路属性">
	
	<page:param name="width">400px</page:param>
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
<s:form id="nodes" action="/location/design/designImage!delete.action" method="post">
	
<ul class="fieldlist-n">
		<s:hidden name="component.type" id="component_type"/>
		<s:hidden name="component.locationId" id="component_locationId"/>
		<s:hidden name="component.componentId" id="component_componentId"/>
	<li>
		<s:checkboxlist name="component.isRelationRes" id="component_isRelationRes" list="#{'true':'关联链路' }" />
	</li>
	<li><span>链路：</span>
		<s:hidden name="component.relationResId" id="component_relationResId"/>
		<span style="margin-left:21px"><s:textfield name="component.relationResName" id="component_relationResName" readonly="true" ></s:textfield></span>
		<span class="black-btn-l" name="interfaces" res="component_fromRes"><span class="btn-r"><span class="btn-m"><a>浏览</a></span></span></span>
		<span class="red" id="link_red">*</span>
	</li>
	<li><span>源IP：</span>
		<span style="margin-left:25px">
			<input type="text" name="component.fromResId" id="component_fromResId" disabled="true" value="${(component.fromResId eq 'null')?"":component.fromResId}"/>

			</span>
	</li>
	<li><span>源接口：</span>
		<span style="margin-left:12px">
			<input type="text" name="component.fromInterfaceId" id="component_fromInterfaceId" disabled="true" value="${(component.fromInterfaceId eq 'null')?"":component.fromInterfaceId}"/>
			
			</span>
	</li>
	<li><span>目的IP：</span>
		<span style="margin-left:13px">
			<input type="text" name="component.toResId" id="component_toResId" disabled="true" value="${(component.toResId eq 'null')?"":component.toResId}"/>
			</span>
	</li>
	<li><span>目的接口：</span>
		<input type="text" name="component.toInterfaceId" id="component_toInterfaceId" disabled="true" value="${(component.toInterfaceId eq 'null')?"":component.toInterfaceId}"/>
		
	</li>
<%--	
	<li><span>源设备：</span>
		<s:hidden name="component.fromResId" id="Id"/>
		<s:textfield name="component.fromResName" id="component_fromResName"></s:textfield>
		<span class="black-btn-l" name="seleceEquipment" res="component_fromRes"><span class="btn-r"><span class="btn-m"><a>浏览</a></span></span></span>
	</li>
	<li><span>源接口：</span>
		<s:hidden name="component.fromInterfaceId" id="component_fromInterfaceId"/>
		<s:textfield name="component.fromInterfaceName" id="component_fromInterfaceName"></s:textfield>
		<span class="black-btn-l" name="interfaces" res="component_from"><span class="btn-r"><span class="btn-m"><a>浏览</a></span></span></span><br>
	</li>
	<li><span>目的设备：</span>
		<s:hidden name="component.toResId" id="component_toResId"/>
		<s:textfield name="component.toResName" id="component_toResName"></s:textfield>
		<span class="black-btn-l" name="seleceEquipment" res="component_toRes"><span class="btn-r"><span class="btn-m"><a>浏览</a></span></span></span>
	</li>
	<li><span>目的接口：</span>
		<s:hidden name="component.toInterfaceId" id="component_toInterfaceId"/>
		<s:textfield name="component.toInterfaceName" id="component_toInterfaceName"></s:textfield>
		<span class="black-btn-l" name="interfaces" res="component_to"><span class="btn-r"><span class="btn-m"><a>浏览</a></span></span></span><br>
	</li>
 --%>
	<li><span>链路标注：</span>
		<s:checkboxlist name="component.linkType" list="#{'true':'类型'}"/>
		<s:checkboxlist name="component.linkRemark" list="#{'true':'备注'}"/>
		<s:checkboxlist name="component.linkUpflow" list="#{'true':'上行流量'}"/>
		<s:checkboxlist name="component.linkDownflow" list="#{'true':'下行流量' }"/>
	</li>
	<!-- 
	<li><span>链路方向：</span>
		<s:radio name="component.linkDirection" list="#{'true':'显示', 'hide':'不显示'}"/>
	</li>
	 -->
</ul>

</s:form>

	</page:param>
</page:applyDecorator>

</body>
</html>