<!-- WEB-INF\content\location\relation\batchAdd.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>模型扩展</title>
<script type="text/javascript">
	//表单验证
	$(document).ready(function() {
		var tp = new TabPanel({id:"mytab",isclear:true,
			listeners:{
		        change:function(tab){
		        	
			        /*resType = tab.id=="netFixing"?networkType
			        		 :tab.id=="server"?serverType
			        		 :tab.id=="pc"?pcType:pcType;
		        	tp.loadContent(tab.index,{url:"${ctx}/location/relation/device!batchAddDevices.action?location.locationId=${location.locationId}&resType=" + resType});
		        	*/
		        }
        	}	
		}); 

	});

</script>
</head>

<body bgcolor="black">
	<s:form id="addForm" action="/scriptmonitor/repository/modelExtend!showModelsByType.action">
		<s:hidden name="location.locationId"/>	
		<s:hidden name="resType" id="resType"/>	
	</s:form>
		<page:applyDecorator name="tabPanel">  
			<page:param name="id">extendTab</page:param>
			<page:param name="width">100%</page:param>
			<page:param name="tabBarWidth">100%</page:param>
			<page:param name="cls">tab-grounp</page:param>
			<page:param name="current">1</page:param>
			<page:param name="tabHander">[{text:"系统默认",id:"tab1"},{text:"自定义模型",id:"tab2"}]</page:param>
			<page:param name="content_1">
				<div id="sysDefaultDiv">
					<s:action name="modelExtend!searchModels" namespace="/scriptmonitor/repository"
						executeResult="true" flush="false">
						<s:param name="resourceCategoryId" value="<s:property value='resourceCategoryId' />"/>
						<s:param name="isExtension" value="false"/>
					</s:action>
				</div>
			</page:param>
		</page:applyDecorator>
</body>

<script>
	$(function(){
		var tp = new TabPanel({
			id:"extendTab",
			listeners:{
				change:function(tab){
					var isExtension = tab.id == "tab2";
					var resourceCategoryId = "<s:property value='resourceCategoryId' />";
					$.blockUI({message:$('#loading')});
					$.ajax({
							url:"${ctx}/scriptmonitor/repository/modelExtend!searchModels.action",
							data:"resourceCategoryId="+resourceCategoryId+"&isExtension="+isExtension,
							dataType:"html",
							type:"POST",
							success:function(data,state){						
								$("#sysDefaultDiv").find("*").unbind();
								$("#sysDefaultDiv").html("");
								$("#sysDefaultDiv").append(data);
								$.unblockUI();
							}
					});
				}
			}
		});
	});
</script>

</html>