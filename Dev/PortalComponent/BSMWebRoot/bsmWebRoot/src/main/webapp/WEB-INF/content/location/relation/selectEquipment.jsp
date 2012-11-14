<!-- WEB-INF\content\location\relation\selectEquipment.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mocha.bsm.location.enums.EquipmentTypeEnum" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<title>选择资源</title>
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
<script src="${ctxJs}/jquery.blockUI.js" type="text/javascript"></script>
<script type="text/javascript">

	var networkType = "<%=EquipmentTypeEnum.networkdevice %>";
	var serverType = "<%=EquipmentTypeEnum.host_server %>";
	var pcType = "<%=EquipmentTypeEnum.host_pc %>";
	var resType = networkType;
	
	var returnObject = {};

	function resize(){
		window.dialogHeight=(document.body.scrollHeight)+"px";
		window.dialogWidth=(document.body.scrollWidth)+"px";
	}
	//表单验证
	$(document).ready(function() {
		var toast = new Toast({position:"CT"});
		
		var tp = new TabPanel({id:"mytab",isclear:true,
			listeners:{
		        change:function(tab){
			$.blockUI({message:$('#loading')});
			        resType = tab.id=="networkdevice"?networkType
			        		 :tab.id=="server"?serverType
			        		 :tab.id=="pc"?pcType:pcType;
		        	tp.loadContent(tab.index,{callback:resize,url:"${ctx}/location/relation/device!selectEquipment.action?location.locationId=${location.locationId}&unRelation=${parameters.unRelation[0]}&resType=" + resType,callback:$.unblockUI});
		        }
        	}	
		}); 
		
		$("#closeId").click(function (){
			window.close();
		});
		
		$("#submit").click(function (){
			if($("input[name=equipmentIds]:checked").length<=0){
				toast.addMessage("请已选资源");
				return;				
			}
			window.returnValue=returnObject;
			window.close();
		});
		
		$("#cancel").click(function(){
			window.close();
		});
		
		resize();
	});
</script>
</head>

<body bgcolor="black">
<input type="hidden" value="${parameters.unRelation[0]}" id="unRelation"/>
<page:applyDecorator name="popwindow"  title="选择资源">
	
	<page:param name="width">510px</page:param>
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
			<page:param name="width">498</page:param>
			<page:param name="tabBarWidth">498</page:param>
			<page:param name="cls">tab-grounp</page:param>
			<page:param name="current">1</page:param>
			<page:param name="tabHander">[{text:"网络设备",id:"networkdevice"},{text:"服务器",id:"server"},{text:"PC",id:"pc"}]</page:param>
			<page:param name="content_1">
				<s:action name="device!selectEquipment" namespace="/location/relation"
					executeResult="true" ignoreContextParams="false">
				</s:action>
			</page:param>
			<page:param name="content_2">
			</page:param>
			<page:param name="content_3">
			</page:param>
		</page:applyDecorator>
	</page:param>
</page:applyDecorator>
</body>
</html>