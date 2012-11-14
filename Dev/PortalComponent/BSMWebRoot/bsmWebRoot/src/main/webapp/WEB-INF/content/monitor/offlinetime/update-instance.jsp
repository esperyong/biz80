<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<title>待选资源</title>
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/jquery-ui/treeview.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctx}/js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.blockUI.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.draggable.js"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionLeft.js"></script>
<script type="text/javascript" src="${ctx}/js/component/tabPanel/tab.js"></script>
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/treeView/tree.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/page.js"></script>
<script type="text/javascript" src="${ctx}/js/component/menu/menu.js"></script>
<script type="text/javascript" src="${ctx}/js/monitor/Util.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>  
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<style type="text/css">
	.span.elli{width:95%;text-overflow:ellipsis;white-space:nowrap;overflow:hidden;word-spacing:normal; word-break:normal;display:block;}
    .inputoff{color:#CCCCCC}
</style>
<script type="text/javascript">
var paramMap = new Map();
var path = "${ctx}";
$(function(){
	var toast = new Toast({position:"CT"});	
	$.blockUI({message:$('#loading')});
	$.unblockUI();	  	  
 $("#submitForm").click(function (){
	 //alert($("input[name='instanceRela']").val());
 	 //var gridJson = '<s:property value="gridJson"/>'
	  //alert("gridJson ::"+gridJson)
	  // alert("a");
	 var tmp = [];
	 var allElem = paramMap.arr;
      if(allElem && allElem.length>0){
   	   		for(var i=0;i<allElem.length;i++){
	   			var key = allElem[i].key;
	   			var value = allElem[i].value;
				tmp.push(allElem[i].key);
   			}
   	   		var instanceRela = $("input[name='instanceRela']").val();
   	   		var instancIds = instanceRela.split(',');
   	   		for(var i = 0; i<tmp.length;i++) {
   	   	   		//如果资源已经添加就不再添加。
   	   	   		var isadd = true;
   	   	   		for(var j = 0; j < instancIds.length; j++){
					if(tmp[i]==instancIds[j]){
						isadd = false;
						break;
					}
   	   	   		}
   	   	   		if(isadd){
   	   				if(null != instanceRela && instanceRela != ""){
   	   	   					instanceRela = instanceRela+ ",";
   	   	   			}else{
   	   	   				instanceRela = "";
   	   	   			}
   	   				instanceRela = instanceRela + tmp[i];
   	   	   		}
   	   		}
   	   		//alert(instanceRela);
   	   		var count = instanceRela.split(',').length;
   	   		//alert(count);
   	   		$.ajax( {
				type : "post",
				url : "offlinetime-instance!updateInstance.action",
				data : "offlineTimeId=${offlineTimeId}&instanceRela=" + instanceRela,
				success : function(data, textStatus) {
					//alert("data=" + data);
					 var url = "offlinetime-instance.action?offlineTimeId=${offlineTimeId}";
				     opener.openViewPage(url,null);
				     var id = "${offlineTimeId}";
				     //alert(id);				     
				     opener.modifiableCount(id,count);
					logout();
				}
			});
   	   		
   	   // window.opener.addRows(paramMap);
	    // logout();
      }else{
    	  toast.addMessage("请至少选择一条记录。");
      }
   })
   $("#app").bind("click",function(){
		 var tmp = [];
		 var allElem = paramMap.arr;
	      if(allElem && allElem.length>0){
	   	   		for(var i=0;i<allElem.length;i++){
		   			var key = allElem[i].key;
		   			var value = allElem[i].value;
					tmp.push(allElem[i].key);
	   			}
	   	   		var instanceRela = $("input[name='instanceRela']").val();
	   	   	var instancIds = instanceRela.split(',');
	   	   		for(var i = 0; i<tmp.length;i++) {
	   	   	//如果资源已经添加就不再添加。
	   	   	   		var isadd = true;
	   	   	   		for(var j = 0; j < instancIds.length; j++){
						if(tmp[i]==instancIds[j]){
							isadd = false;
							break;
						}
	   	   	   		}
	   	   	   		if(isadd){
	   	   				if(null != instanceRela && instanceRela != ""){
	   	   	   					instanceRela = instanceRela+ ",";
	   	   	   			}else{
	   	   	   				instanceRela = "";
	   	   	   			}
	   	   				instanceRela = instanceRela + tmp[i];
	   	   	   		}
	   	   		}
	   	   		var count = instanceRela.split(',').length;
	   	   		$.ajax( {
					type : "post",
					url : "offlinetime-instance!updateInstance.action",
					data : "offlineTimeId=${offlineTimeId}&instanceRela=" + instanceRela,
					success : function(data, textStatus) {
						//alert("data=" + data);
						//alert(instanceRela);
						 var url = "offlinetime-instance.action?offlineTimeId=${offlineTimeId}";
					     opener.openViewPage(url,null);
					     var id = "${offlineTimeId}";			     
					     opener.modifiableCount(id,count);
					}
				});
	      }else{
	    	  toast.addMessage("请至少选择一条记录。");
	      }
   });   
   $("#closeWindow").bind("click", function() {
	   logout();
	});
   $("#logouts").bind("click",function(){
	   logout();
   });
});
function logout() {
  window.opener = null;
  window.open("", "_self");
  window.close();
}
</script>
</head>
<body>
 <div id="loading" class="loading" style="display:none;"
               ><div class="loading-l"
                ><div class="loading-r"
                    ><div class="loading-m"
                         ><span class="loading-img">载入中，请稍候...</span 
                    ></div
                ></div
                ></div
           ></div>
<input type="hidden" name="instanceRela" id="instanceRela" value="${instanceRela}"/>
<page:applyDecorator name="popwindow"  title="待选资源">
    <page:param name="width">830px;</page:param>
   	<page:param name="height">620px;</page:param>
   	<page:param name="style">overflow:hidden;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeWindow</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="topBtn_title_1">关闭</page:param>
    <page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submitForm</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">logouts</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	<page:param name="bottomBtn_index_3">3</page:param>
	<page:param name="bottomBtn_id_3">app</page:param>
	<page:param name="bottomBtn_text_3">应用</page:param>
    <page:param name="content">
		<div class="main">
			<div class="main-left" style="overflow:auto;width:200px;height:615px;">
			       <s:action name="offlinetime-instance!updateInstanceTree"  namespace="/monitor"  executeResult="true" ignoreContextParams="true" flush="false">
			       <s:param name="currentUserId" value="%{<%=userId %>}" />
			       <s:param name="isAdmin" value="%{<%=isAdmin %>}" />
			       </s:action>
			</div>
			 <div class="main-right" id="main-right" style="width:600px;height:630px;">
			       <s:action name="offlinetime-instance!updateInstanceList"  namespace="/monitor"  executeResult="true" ignoreContextParams="true" flush="false">
			           <s:param name="pointId" value="pointId"/>
			            <s:param name="currentUserId" value="%{<%=userId %>}" />
			            <s:param name="isAdmin" value="%{<%=isAdmin %>}" />
			       </s:action>
			 </div>
		</div>
		</page:param>
</page:applyDecorator>
</body>
</html>