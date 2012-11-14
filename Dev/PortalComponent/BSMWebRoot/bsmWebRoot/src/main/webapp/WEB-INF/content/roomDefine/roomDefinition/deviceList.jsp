<!-- 机房-设备管理  deviceList.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.*"%>
<%@ page import="com.opensymphony.xwork2.util.*"%> 
<title>设备管理</title>
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
	
   <form id="deviceListID" action="DeviceListVisit" name="deviceListForm" method="post" namespace="/roomDefine" style="height:100%">
   		<%
   		if(!"1".equals(typeFlag)){
   		%>
   		<input type="hidden" name="typeFlag" id="typeFlag" value="0" />
   		<div style="height:25px"><span style="position:relative;top:5px" class="ico ico-note"></span ><span style="color: white;position:relative;top:5px">说明：请批量导入或手工添加机房内设备。</span></div>
   		<%}else{
   		%>
   		<input type="hidden" name="typeFlag" id="typeFlag" value="1"/>
   		<%}%>
   		<div style="overflow:hidden;width:100%;height:25px" >
   		<%
   		if(!"1".equals(typeFlag)){
   		%>
   		<span class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a id="exportId">导出</a></span></span></span>
   		<span class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a id="importId">导入</a></span></span></span>
   		<%} %>
   		<span class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a id="insertId">添加</a></span></span></span>
   		<span class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a id="batchId">批量添加</a></span></span></span>
   		<span class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a id="batchEditId">批量编辑</a></span></span></span>
   		<span class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a id="deleteId">删除</a></span></span></span>
   		
   		<s:select id="chooseDev" name="chooseDev" class="validate[required]" list="resGroups" listKey="key" listValue="value" style="width:182px;left:-4px;position:relative">
		</s:select>
   		<select id="chooseSearchType" name="chooseSearchType" class="">
   			<option value="ipAddress" >IP地址</option>
			<option value="devName" >设备名称</option>
			<!-- huaf:机柜右键属性的设备列表里因为都在同一个机柜里故不需要机柜号的条件搜索。 -->
			<%
	   		if(!"1".equals(typeFlag)){
	   		%>
			<option value="room_jigui" >机柜号</option>
			<%}%>
			<option value="room_deviceNo" >设备号</option>
		</select>
   		<input type="text" id="inputName" style="height:19px" name="inputName" />
   		<span class="ico" title="搜索" ></span>
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
	     <page:param name="width"></page:param>
	     <page:param name="height">650</page:param>
	     <page:param name="lineHeight">28</page:param>
	     <page:param name="linenum">20</page:param>
	     <page:param name="tableCls">grid-gray</page:param>
	     <page:param name="gridhead">[{colId:"allchk",text:"<input type='checkbox' name='checkAll' id='checkAllId' style='cursor:pointer' />"},{colId:"ipAddress",text:"IP地址"},{colId:"macAddress",text:"MAC地址"},{colId:"devName",text:"设备名称"},{colId:"devType",text:"设备类型"},{colId:"jiguiNo",text:"机柜号"},{colId:"jikuangNo",text:"机框号"},{colId:"deviceNo",text:"设备号"},{colId:"notes",text:"备注"},{colId:"operator",text:"操作"}]</page:param>
	     <page:param name="gridcontent"><%=jsonStr%></page:param>
	   </page:applyDecorator>
	   
	   <div id="pageDevice" style="overflow:hidden;width:100%;" >
       </div>
   </form>	
  </body> 


</html>
<script type="text/javascript">
$.unblockUI();

$(document).ready(function(){

})

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
                url: "${ctx}/roomDefine/DeviceListVisit!searchDeviceMethod.action?resourceId="+resourceId+"&capacityId="+capacityId+"&roomId="+ roomId+"&typeFlag="+$("#typeFlag").val() +"&curPageCount=" + page + "&chooseDev=" + $("#chooseDev option:selected").val() + "&chooseSearchType="+ $("#chooseSearchType option:selected").val() + "&inputName=" + $("#inputName").val() + "&colId=" + sort + "&sortType=" + sortCol,
                success: function(data, textStatus) {

                	var deviceData = data.deviceData;
        			gp.loadGridData(deviceData);
        			
                }
            });
        }
    }
});
page.pageing(pageSize,1);

$(".ico").click(function (){
	var result = $("#deviceListID").serialize();
	var url="${ctx}/roomDefine/DeviceListVisit!searchDeviceMethod.action";
	ajaxSearchDeviceListFun(result,url);
});
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
			page.pageing(data.pageCount,1);
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
$('#importId').click(function() {
	  var roomId = $('#roomIdHidden').val();
	  window.open("${ctx}/roomDefine/UploadExcelVisit.action?roomId="+roomId,"_blank","width=600,height=650");
});
$('#exportId').click(function() {
	var roomId = $('#roomIdHidden').val();
	  window.open("${ctx}/roomDefine/ImportantExcel!exportExcel.action?roomId="+roomId,"_blank","width=400,height=250");
});
$('#insertId').click(function() {
	  var roomId = $('#roomIdHidden').val();
	  var jiguiNo = $('#jiguiNoHidden').val();
	  jiguiNo = setEncodeURI(jiguiNo);
	  window.open("${ctx}/roomDefine/AddDeviceInfoVisit.action?roomId="+roomId+"&jiguiNo="+jiguiNo,"_blank","width=500,height=325");
});
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
$('#batchId').click(function() {
	  var roomId = $('#roomIdHidden').val();
	  var jiguiNo = $('#jiguiNoHidden').val();
	  jiguiNo = setEncodeURI(jiguiNo);
	  //window.open("${ctx}/roomDefine/BatchAddDeviceInfoVisit.action?roomId="+roomId);
	  window.open("${ctx}/roomDefine/BatchAddDeviceNewInfoVisit.action?roomId="+roomId+"&jiguiNo="+jiguiNo,"_blank","width=650,height=510");
});
$('#batchEditId').click(function() {
	  var roomId = $('#roomIdHidden').val();
	  var jiguiNo = $('#jiguiNoHidden').val();
	  jiguiNo = setEncodeURI(jiguiNo);
	  //alert(jiguiNo);
	  var str = "";
	  $("#tableId input[name=checkOne]:checked").each(function(){
		  str+=$(this).val()+",";
	  });
	  if(str == ""){
		  parent.window.toast.addMessage("请至少选择一项");
		return;
	  }
	  window.open("${ctx}/roomDefine/BatchUpdateDeviceInfoVisit.action?roomId="+roomId+"&resourceIds="+str+"&jiguiNo="+jiguiNo,"_blank","width=600,height=185");
});
$('#deleteId').click(function() {
	var che = $("input[name='checkOne']:checkbox:checked");  
	var delId = "";
	 if(che != null && (che.length>0)) {
		 for(i=0;i<che.length;i++) {
			 delId += $(che[i]).val() +",";
		 }
		 delId = delId.substring(0,(delId.length-1));
		 //alert(delId);
		 //$("#deleteDevIds").val(delId);
		 var roomId = $('#roomIdHidden').val();


		 var _confirm = new confirm_box({text:"是否执行此操作？"});
			_confirm.show();
			_confirm.setConfirm_listener(function(){
				
				ajaxDelDeviceInfoFun(roomId,delId,"${ctx}/roomDefine/DeleteDeviceInfo.action");
				_confirm.hide();
			});

	 }else{
		parent.window.toast.addMessage("请至少选择一项");
	 }
});

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

	  $("#checkAllId").click(function() {
			if($(this).attr("checked")) {
				$("[name='checkOne']").attr("checked",'true');//全选
			}else {
				$("[name='checkOne']").removeAttr("checked");//取消全选
			}
	  });
	 
	// alert($("#tableId").children("div").length);//表头最外层
	// alert($("#tableId").children("div:eq(0)").children("table").children("thead").children("tr:first"));//表头最外层
	 //alert($("#tableId").children("div:eq(0)").children("table").children("thead").children("tr:first"));//表头最外层
    gp = new GridPanel({id:"tableId",
        					unit:"%",
        					columnWidth:{allchk:5,ipAddress:15,macAddress:10,devName:15,devType:10,jiguiNo:10,jikuangNo:10,deviceNo:10,notes:10,operator:5},
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
                            },{
                            	index: "macAddress"
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
    gp.rend([{index:"allchk",fn:function(td){
    	
        if(td.html!="" && td.html!=" ") {
        	$checkbox = $('<input type="checkbox" style="cursor:pointer" name="checkOne" value="'+td.html+'"/>');
	        $checkbox.bind("click",function(){
		        	 //alert($(this).attr("checked"));
	         		 //alert($(this).val());
	        });
	    	return $checkbox;
        }else{
			return null;
        }
					    	
    					}
   		},{index:"ipAddress",fn:function(td){
   				if(td.html!="" && td.html!=" ") {
   	   				var ipStr = td.html+"";
   	   				//ipStr = ipStr.substring(2,ipStr.length-2);

   	   				var ipArr = ipStr.split(",");

					var selectID = "";
   	   				
   	   				if (ipArr.length > 1){

   	   					for (var thisNum=0;thisNum<ipArr[0].split(".").length;thisNum++){
   	   						selectID += ipArr[0].split(".")[thisNum];
   	   	   				}
   	   	   				
   	   					$select = $('<select id="'+selectID+'" name="'+selectID+'" iconIndex="0" iconClass="ico ico-right" iconTitle="" ></select>');
	   	   				for (var i=0;i<ipArr.length;i++){
	   	   					$("<option value='"+i+"'>"+ipArr[i]+"</option>").appendTo($select)//添加下拉框的option	
	   	   	   			}
	   	   	   			return $select;
   	   	   			}else{
   	   	   				$span = $('<span>'+ipArr[0]+'</span>');
  						return $span; 
   	   	   	   		}
   	   			}else{
   	   				return null;
   	   	   		}
   				
   	   			
   	   		}
   	   	},{index:"notes",fn:function(td){
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
   		        	var widthVal=event.pageX; 
   		        	var heightVal=event.pageY; 
   		        	var deviceId;
   		        	if(event.pageX+280 > document.documentElement.clientWidth){
   		        		widthVal = document.documentElement.clientWidth-280;
   		        	}
   		        	if(event.pageY+400 > screen.height){
   		        		heightVal = screen.height-400;
   		        	}

					if(arr[0] == "null"){
						arr[0] = ""
					}
					   		        	
   		        	if(arr[0]);
   		        	deviceId = arr[1];
   		    		 panel = new winPanel({
				        url:encodeURI("${ctx}/roomDefine/EditNote.action?deviceId=" + arr[1] +"&note=" + arr[0]),
				        //html:"alskdflaksdflkasdklj",
				        width:280,
				        x:widthVal,
				        y:heightVal,
				        isDrag:false,
				        isautoclose: true, 
				        closeAction: "close",
				        listeners:{
				          closeAfter:function(){
					          panel = null;
					      },
					      loadAfter:function(){
					    		function cc(){
					    			if(window.panel){
						    			panel.close("close");
						    			panel = null;
					    			}
					    		}
					    		$("#closepanelId").click(cc);

								function noteSubmit(){
									$.ajax({
									   type: "POST",
									   dataType:"text",
									   url: "${ctx}/roomDefine/updateDeviceInfoVisit.action",
									   data: "deviceId="+deviceId+"&note="+$("#e_desc").val(),
									   success: function(msg){
										   deviceManagerFunClk();
										   cc();
									   },
									   error:function (XMLHttpRequest, textStatus, errorThrown) {
										   alert("Error");
									   }
									});
								}
								$("#submitId").click(noteSubmit);
					    		
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
   	   	},{index:"operator",fn:function(td){
   			if(td.html!="" && td.html!=" ") {
   	        	$span = $('<span class="ico ico-edit" val="'+td.html+'"></span>');
   		        $span.bind("click",function(){
   		        	//alert(td.rowIndex);
   		        	//var rowIndex = gp.getRowByIndex(td.rowIndex);
   		        	//alert(rowIndex[1].html);
   		        	var roomId = $('#roomIdHidden').val();
   		        	var jiguiNo = $('#jiguiNoHidden').val();
   		        	jiguiNo = setEncodeURI(jiguiNo);
   		        	window.open("${ctx}/roomDefine/UpdateDeviceVisit.action?resourceId="+td.html+"&rowIndex="+td.rowIndex+"&roomId="+roomId+"&jiguiNo="+jiguiNo,"_blank","width=500,height=295");
   		        });
   		    	return $span;
   	        }else{
   				return null;
   	        }
   	   	  }
   	   	}]);
    
	//$("#tableId").children("div:eq(1)").children("table").children("tbody").children("tr:odd").css("background","gray");
	//$("#tableId").children("div:eq(1)").children("table").children("tbody").children("tr:even").css("background","#fff");
	
    SimpleBox.renderAll();
  });
  defaultSoft();
	function defaultSoft(){
	  	var sort="ipAddress";
 	    var sortCol="up";
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
          	data:"resourceId="+resourceId+"&capacityId="+capacityId+"&roomId="+ roomId+"&typeFlag="+$("#typeFlag").val() +"&curPageCount=" + page + "&chooseDev=" + $("#chooseDev option:selected").val() + "&chooseSearchType="+ $("#chooseSearchType option:selected").val() + "&inputName=" + $("#inputName").val() + "&colId=" + sort + "&sortType=" + sortCol,
             url: "${ctx}/roomDefine/DeviceListVisit!searchDeviceMethod.action",
             success: function(data, textStatus) {
	               
             	var deviceData = data.deviceData;
             	//alert("deviceData="+deviceData);
     			gp.loadGridData(deviceData);
     			SimpleBox.renderAll();
             }
         });
	}
</script> 