<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>待选资源</title>
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
 <link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" />
 <link rel="stylesheet" href="${ctx}/css/jquery-ui/treeview.css" type="text/css" />
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
<style type="text/css">.span.elli{width:95%;text-overflow:ellipsis;white-space:nowrap;overflow:hidden;word-spacing:normal; word-break:normal;display:block;}
.inputoff{color:#CCCCCC}
</style>
</head>
<body>
<!-- 移入资源组待选资源 standbyResource.jsp -->
 <div id="loading" class="loading" style="display:none;"
               ><div class="loading-l"
                ><div class="loading-r"
                    ><div class="loading-m"
                         ><span class="loading-img">载入中，请稍候...</span 
                    ></div
                ></div
                ></div
           ></div>
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
	<page:param name="bottomBtn_id_2">logout</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
    <page:param name="content">
        <form id="form1">
		    <input type="hidden" id="resourceGroupId" name="resourceGroupId" value='<s:property value="resourceGroupId"/>'/>
		    <input type="hidden" id="monitor" name="monitor" value='<s:property value="monitor"/>'/>
		</form>
		<div class="main">
			<div class="main-left" style="overflow:auto;width:200px;height:620px;">
			      　　<s:action name="resourceGroup!resourceTree"  namespace="/monitor"  executeResult="true" ignoreContextParams="true" flush="false">
			           <s:param name="currentUserId" value="%{<%=userId %>}" />
			           <s:param name="isAdmin" value="%{<%=isAdmin %>}" />
			      </s:action>
			</div>
			 <div class="main-right" id="main-right" style="width:600px;height:620px;">
			       <s:action name="resourceGroup!resourceList"  namespace="/monitor"  executeResult="true" ignoreContextParams="true" flush="false">
			            <s:param name="pointId" value="pointId"/>
			            <s:param name="pointLevel" value="pointLevel"/>
			            <s:param name="currentUserId" value="%{<%=userId %>}" />
			            <s:param name="isAdmin" value="%{<%=isAdmin %>}" />
			       </s:action>
			 </div>
		</div>
		</page:param>
</page:applyDecorator>
</body>
		<script type="text/javascript">
		var path = "${ctx}";
		var paramMap = new Map();
		$(function() {
		    $("#submitForm").click(function() {
		        var instanceIdArr = [];
		        var tmp = [];
		        var allElem = paramMap.arr;
		        if (allElem) {
		             if(allElem.length > 0){
		            	 for(var i=0;i<allElem.length;i++){
			         		 instanceIdArr.push(allElem[i].key);
			         	 }
			             for(var i=0;i<instanceIdArr.length;i++){
			            	 tmp.push( "<input type='hidden' name='resourceInsId'" +" value='"+instanceIdArr[i]+"'/>"); 
			             }
			             $("#form1").append(tmp.join(""));
			         }
		       		  var ajaxParam = $("#form1").serialize();
		       		  $.ajax({
		       			   type: "POST",
		       			   dataType:'json',
		       			   url:path+"/monitor/monitorAjaxList!shiftinGroup.action",
		       			   data: ajaxParam,
		       			   success: function(data, textStatus){
		       			       window.opener.Monitor.refresh("/monitor/monitorList.action");
		       	    	   	  //alert(data.gridJson);
		       	    	   	  //if("monitor" == $("#monitor").val() && data.gridJson != null && data.gridJson != ""){
		       	    	   	  //   window.opener.Monitor.Resource.right.monitorList.render(data.gridJson);
		       	    	   	 //    window.opener.Monitor.Resource.right.monitorList.ListMenu.init("resourceGroupTree");
			       	    	 // }
		       	    	     // if("noMonitor" == $("#monitor").val() && data.gridJson != null && data.gridJson != ""){
		       	    	   	//     window.opener.Monitor.Resource.right.noMonitorList.render(data.gridJson);
		       	    	   	    // window.opener.Monitor.Resource.right.monitorList.ListMenu.init("resourceGroupTree");
			       	    	//  }
		       	    	      logout();
		       			   }
		       			});
		       	   
		            //	for(var i=0;i<allElem.length;i++){
		            ////		var key = allElem[i].key;
		            //		var value = allElem[i].value;
		            //			tmp.push(allElem[i].value);
		            //alert(value);
		            //   		}
		            //window.opener.addRows(paramMap);
		            //logout();
		        }
		    });
		    $("#closeWindow,#logout").click(function() {
		    	 logout();
		    });
		});
		function logout() {
		    window.opener = null;
		    window.open("", "_self");
		    window.close();
		}
   	   </script>
</html>