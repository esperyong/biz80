<!-- WEB-INF\content\location\relation\batchAdd.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mocha.bsm.location.enums.EquipmentTypeEnum" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<title>批量添加</title>
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
<script src="${ctxJs}/jquery.blockUI.js" type="text/javascript"></script>
<script type="text/javascript">
<s:if test="#session.succeed == true">
<%
com.opensymphony.xwork2.ActionContext.getContext().getSession().remove("succeed");
%>
//新建区域完成，刷新父页面
if(opener){
	opener.loalDevices("${resType}",true);
} else {
	window.returnVale="刷新父页面";
}
window.close();
</s:if>
	var networkType = "<%=EquipmentTypeEnum.networkdevice %>";
	var serverType = "<%=EquipmentTypeEnum.host_server %>";
	var pcType = "<%=EquipmentTypeEnum.host_pc %>";
	var resType = networkType;

	//表单验证
	$(document).ready(function() {
		var tp = new TabPanel({id:"mytab",isclear:true,
			listeners:{
		        change:function(tab){
		        	$.blockUI({message:$('#loading')});
			        resType = tab.id=="networkdevice"?networkType
			        		 :tab.id=="server"?serverType
			        		 :tab.id=="pc"?pcType:pcType;
		        	tp.loadContent(tab.index,{url:"${ctx}/location/relation/device!batchAddDevices.action?location.locationId=${location.locationId}&resType=" + resType,callback:$.unblockUI});
		        }
        	}	
		}); 

		$("#addForm").validationEngine({
			promptPosition:"centerRight", 
			validationEventTriggers:"keyup blur change",
			inlineValidation: true,
			scroll:false,
			success:false/*,
			failure: function() { 
				alert("没有添加已选设备");
			}*/
		});

		
		$("#closeId").click(function (){
			window.close();
		});
		
		$("#submit").click(function (){
			if($("input[name=equipmentIds]:checked").length<=0){
				showMess("请至少选择一项");
				return;				
			}
			$("#resType").val(resType);
			$("#addForm").submit();
		});
		
		$("#cancel").click(function(){
			window.close();
		});

	});

	function showMess(str){
		var toast = new Toast({position:"CT"});
		toast.addMessage(str);
	}
</script>
</head>

<body bgcolor="black">

<page:applyDecorator name="popwindow"  title="批量添加">
	
	<page:param name="width">550px</page:param>
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
	
	<s:form id="addForm" action="/location/relation/device!batchAdd.action">
		<s:hidden name="location.locationId"/>	
		<s:hidden name="resType" id="resType"/>	
	
		<page:applyDecorator name="tabPanel">  
			<page:param name="id">mytab</page:param>
			<page:param name="width">538</page:param>
			<page:param name="tabBarWidth">538</page:param>
			<page:param name="cls">tab-grounp</page:param>
			<page:param name="current">1</page:param>
			<page:param name="tabHander">[{text:"网络设备",id:"networkdevice"},{text:"服务器",id:"server"},{text:"PC",id:"pc"}]</page:param>
			<page:param name="content_1">
				<s:action name="device!batchAddDevices" namespace="/location/relation"
					executeResult="true" ignoreContextParams="true" />
			</page:param>
			<page:param name="content_2">
			</page:param>
			<page:param name="content_3">
			</page:param>
		</page:applyDecorator>
	</s:form>

	</page:param>
</page:applyDecorator>
</body>
</html>