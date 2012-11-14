<!-- 机房-监控设置-设施管理-设备列表 chooseJiguiDevList.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.*"%>
<%@ page import="com.opensymphony.xwork2.util.*"%> 
<title>设备列表</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/button-module.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/page.js"></script>
 
<%
	ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
	String jsonStr = "";
	String typeFlag = "";
	if(null != vs && !"".equals(vs)){
		if(vs.findValue("deviceData") != null && !"".equals(vs.findValue("deviceData"))){
			jsonStr = (String)vs.findValue("deviceData");
		}
		if(vs.findValue("typeFlag") != null && !"".equals(vs.findValue("typeFlag"))){
			typeFlag = (String)vs.findValue("typeFlag");
		}
	}
%>    
</head>
  <body>
	
   <form id="deviceListID" action="DeviceListVisit" name="deviceListForm" method="post" namespace="/roomDefine">
   		
   		
   		<div style="overflow:hidden;width:585px" >
   		
   		</div>
   		<input type="hidden" id="roomIdHidden" name="roomId" value="<s:property value='roomId'/>" />
   		<input type="hidden" id="jiguiNoHidden" name="jiguiNo" value="<s:property value='jiguiNo'/>" />
   		<input type="hidden" id="capacityId" name="capacityId" value="<s:property value='capacityId'/>" />
   		<input type="hidden" id="resourceId" name="resourceId" value="<s:property value='resourceId'/>" />
   		<input type="hidden" id="deleteDevIds" name="deleteDevIds" value="" />

   		<input type="hidden" id="sortIdHidden" name="sortIdHidden" value="" />
   		<input type="hidden" id="sortColIdHidden" name="sortColIdHidden" value="" />
   		<input type="hidden" id="pageIdHidden" name="pageIdHidden" value="" />
   		
	   <page:applyDecorator name="indexgrid">  
	     <page:param name="id">tableId</page:param>
	     <page:param name="width">585px</page:param>
	     <page:param name="height">360px</page:param>
	     <page:param name="linenum">15</page:param>
	     <page:param name="tableCls">grid-gray</page:param>
	     <page:param name="gridhead">[{colId:"ipAddress",text:"IP地址"},{colId:"devName",text:"设备名称"},{colId:"devType",text:"设备类型"},{colId:"jiguiNo",text:"机柜号"},{colId:"jikuangNo",text:"机框号"},{colId:"deviceNo",text:"设备号"},{colId:"notes",text:"备注"}]</page:param>
	     <page:param name="gridcontent"><%=jsonStr%></page:param>
	   </page:applyDecorator>
	   <div id="pageDevice" style="overflow:hidden;width:585px" >
       </div>
   </form>	
  </body> 


</html>
<script type="text/javascript">
var currentPage = '1';
var pageSize = '<s:property value="pageCount" />';
var page = new Pagination({
    applyId: "pageDevice",
    listeners: {
        pageClick: function(page) {
	$("#pageIdHidden").val(page);
    var sort=$("#sortIdHidden").val();
    var sortCol=$("#sortColIdHidden").val();
    var resourceId = $("#resourceId").val();
    var capacityId = $("#capacityId").val();
    var roomId = $("#roomIdHidden").val();
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: "${ctx}/roomDefine/ChooseJiguiDevList!searchDeviceMethod.action?resourceId="+resourceId+"&capacityId="+capacityId+"&roomId="+ roomId +"&curPageCount=" + page + "&chooseDev=" + $("#chooseDev option:selected").val() + "&chooseSearchType="+ $("#chooseSearchType option:selected").val() + "&inputName=" + $("#inputName").val() + "&colId=" + sort + "&sortType=" + sortCol,
                success: function(data, textStatus) {
                	var deviceData = data.deviceData;
        			gp.loadGridData(deviceData);
                }
            });
        }
    }
});
page.pageing(pageSize,1);


function ajaxSearchDeviceListFun(result,url) {
	$.ajax({
		type: "post",
		dataType:'json', //接受数据格式 
		cache:false,
		data:result, 
		url: url,
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			var deviceData = data.deviceData;
			gp.loadGridData(deviceData);
		},
		complete: function(XMLHttpRequest, textStatus){
		//HideLoading();
		},
		error: function(){
		//请求出错处理
			alert("error");
		}
		});
}

/**
 * 对传递值进行编码
 */
function setEncodeURI(str){
  var result = encodeURI(str); 
  result =  encodeURI(result); 
  return result;
}

/**
 * 对传递值进行解码
 */
function setdecodeURI(str){
  var result = decodeURI(str); 
  result =  decodeURI(result); 
  return result;
}


function ajaxDelDeviceInfoFun(roomId,deleteDevIds,url) {
	
	$.ajax({
		type: "post",
		dataType:'json', //接受数据格式 
		cache:false,
		data:"deleteDevIds="+deleteDevIds+"&roomId="+roomId, 
		url: url,
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			var saveVal = data.saveFlag;
			if(null != saveVal && "true" == saveVal){
				window.deviceManagerFunClk();
			}
		},
		complete: function(XMLHttpRequest, textStatus){
		//HideLoading();
		},
		error: function(){
		//请求出错处理
			alert("error");
		}
		});
}

var gp;
var panel;
  $(function(){

	 
	 
	// alert($("#tableId").children("div").length);//表头最外层
	// alert($("#tableId").children("div:eq(0)").children("table").children("thead").children("tr:first"));//表头最外层
	 //alert($("#tableId").children("div:eq(0)").children("table").children("thead").children("tr:first"));//表头最外层
    gp = new GridPanel({id:"tableId",
        					width:585,
        					columnWidth:{ipAddress:100,devName:100,devType:100,jiguiNo:70,jikuangNo:70,deviceNo:70,notes:55},
        					plugins:[SortPluginIndex],
                   			sortColumns: [{
                    	        index: "ipAddress",
                    	        defSorttype: "up"
                    	    },{
                    	        index: "devName"
                    	    },{
                    	    	index: "jiguiNo"
                            },{
                    	    	index: "deviceNo"
                            }],
        					sortLisntenr:function($sort) {
                                //alert($sort.colId);
                                //alert($sort.sorttype);
                                //var colId = $sort.colId;
                                //var sortType = $sort.sorttype;
                           		//$.post("instance-list-sort!sortInstance.action?hashId=${hashId}&colId=" + colId + "&sortType=" + sortType, function(data){
                           		//	var deviceData = data.deviceData;
			              		//	gp.loadGridData(deviceData);
                             	//});

                           		var sort=$sort.colId;
                           	    var sortCol=$sort.sorttype;
                        		$("#sortIdHidden").val(sort);
                        		$("#sortColIdHidden").val(sortCol);
                           	    var resourceId = $("#resourceId").val();
                           	    var capacityId = $("#capacityId").val();
                           	 	var page = $("#pageIdHidden").val();
                           	 	if(null == page || "" == page){
	                           	    page = '<s:property value="curPageCount" />';
                               	}
                           	    var roomId = $("#roomIdHidden").val();
                   	            $.ajax({
                   	                type: "POST",
                   	                dataType: 'json',
                   	             	data:"resourceId="+resourceId+"&capacityId="+capacityId+"&roomId="+ roomId +"&curPageCount=" + page + "&chooseDev=" + $("#chooseDev option:selected").val() + "&chooseSearchType="+ $("#chooseSearchType option:selected").val() + "&inputName=" + $("#inputName").val() + "&colId=" + sort + "&sortType=" + sortCol,
                   	                url: "${ctx}/roomDefine/DeviceListVisit!searchDeviceMethod.action",
                   	                success: function(data, textStatus) {
                   	                	var deviceData = data.deviceData;
                   	                	//alert("deviceData="+deviceData);
                   	        			gp.loadGridData(deviceData);
                   	                }
                   	            });
                            }
        	                },{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"}
    );
    gp.rend([{index:"notes",fn:function(td){
   			if(td.html!="" && td.html!=" ") {
   	        	$span = $('<span class="ico ico-file" val="'+td.html+'"></span>');
   		        $span.bind("click",function(event){
   	   		        var arr = td.html.split(":");
   		        	//alert(arr);
   		        	//var rowIndex = gp.getRowByIndex(td.rowIndex);
   		        	//alert(rowIndex[1].html);
   		        	var roomId = $('#roomIdHidden').val();
   		        	//window.open("${ctx}/roomDefine/UpdateDeviceVisit.action?resourceId="+td.html+"&rowIndex="+td.rowIndex+"&roomId="+roomId);
   		        	if(panel){panel.close("close");}
   		        	arr[0] = encodeURI(arr[0]);
   		        	arr[0] = encodeURI(arr[0]);
   		    		 panel = new winPanel({
				        url:"${ctx}/roomDefine/EditNote.action?deviceId=" + arr[1] +"&note=" + arr[0],
				        //html:"alskdflaksdflkasdklj",
				        width:280,
				        x:event.pageX-100,
				        y:event.pageY,
				        isDrag:false,
				        isautoclose: true, 
				        closeAction: "close",
				        listeners:{
				          closeAfter:function(){
					          panel = null;
					      },
					      loadAfter:function(){
					    		function cc(){
					    			if(window.panel){panel.close("close");}
					    		}
					    		$("#closepanelId").click(cc);
					    		$("#e_desc").focus().click(function(event){
					    			event.stopPropagation();
					    		});
					      }
				        }
	   				},{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"});
	   				
   		        });
   		    	return $span;
   	        }else{
   				return null;
   	        }
   	   	  }
   	   	}]);
    
  });
</script> 