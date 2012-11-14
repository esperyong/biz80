<!-- 机房-机房定义-设备管理-添加设备-选择设备 chooseDeviceDiv.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="java.util.List"%><html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%> 
<base target="_self">
<title>设备列表</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/button-module.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
</head>
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/page.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
 <script src="${ctx}/js/component/toast/Toast.js"></script>

<%
 	ValueStack vs = (ValueStack) request.getAttribute("struts.valueStack");
 	String jsonStr = "";
 	String typeFlag = "";
 	String saveFlag = "";
 	if (null != vs && !"".equals(vs)) {
 		if (vs.findValue("waitChooseStr") != null && !"".equals(vs.findValue("waitChooseStr"))) {
 			jsonStr = (String) vs.findValue("waitChooseStr");
 		}
 		if (vs.findValue("saveFlag") != null && !"".equals(vs.findValue("saveFlag"))) {
 			saveFlag = (String) vs.findValue("saveFlag");
 		}
 	}
 %> 
 
<body >
 	<page:applyDecorator name="popwindow"  title="设备列表">
	<page:param name="width">505px;</page:param>
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
	<form id="deviceListID" name="deviceListID">
	<div style="height:22px">
	<s:select id="category" name="category" class="validate[required]" list="resGroups" listKey="key" listValue="value">
				<!-- 
				<s:iterator value="capacityMap" id="map">
				<s:if test="category==#map.key">
					<option value="<s:property value="#map.key" />" selected="selected"><s:property value="#map.value" /></option>
				</s:if>
				<s:else>
					<option value="<s:property value="#map.key" />"><s:property value="#map.value" /></option>
				</s:else>
				</s:iterator>
				 -->
			</s:select>
			<select id="chooseSearchType" name="chooseSearchType" class="">
   			<option value="ipAddress" >IP地址</option>
			<option value="devName" >设备名称</option>
			<!-- huaf:机柜右键属性的设备列表里因为都在同一个机柜里故不需要机柜号的条件搜索。 -->
			<%
	   		if(!"1".equals(typeFlag)){
	   		%>
			<!-- <option value="room_jigui" >机柜号</option> -->
			<%}%>
			<!-- <option value="room_deviceNo" >设备号</option> -->
		</select>
   		<input type="text" id="inputName" style="position:relative;top:3px" name="inputName" />
   		<span class="ico" title="搜索" ></span>
	</div>
	<!-- <div id="divId" style="width:390px;height:360px;overflow-y:auto"> -->
		<input type="hidden" name="resoureIdVal" id="resoureIdVal" value="<s:property value='resoureIdVal' />" />
		<page:applyDecorator name="indexgrid">  
		     <page:param name="id">tableId</page:param>
		     <page:param name="width">393px</page:param>
		     <page:param name="height">363px</page:param>
		     <page:param name="linenum">15</page:param>
		     <page:param name="tableCls">grid-gray</page:param>
		     <page:param name="gridhead">[{colId:"resoureIdVal",text:""},{colId:"ipAddress",text:"IP地址"},{colId:"devName",text:"设备名称"},{colId:"deviceType",text:"设备类型"}]</page:param>
		     <!--<page:param name="gridcontent"><s:property value="deviceInfo" escape="false" /></page:param>-->
		     <page:param name="gridcontent"><%=jsonStr%></page:param>
		     
		</page:applyDecorator>
	</form>
	<!-- </div> -->
	<div id="pageDevice" >
    </div>
    <input type="hidden" id="roomIdHidden" name="roomId" value="<s:property value='roomId'/>" />
	<input type="hidden" id="jiguiNo" name="jiguiNo" value="<s:property value='jiguiNo'/>" />
	<input type="hidden" id="sortIdHidden" name="sortIdHidden" value="" />
	<input type="hidden" id="sortColIdHidden" name="sortColIdHidden" value="" />
</page:param>
</page:applyDecorator>  

</body>
</html>

<script type="text/javascript">

var currentPage = '1';
var pageSize = '<s:property value="pageCount" />';
var page = new Pagination({
    applyId: "pageDevice",
    listeners: {
        pageClick: function(page) {
			var sort=$("#sortIdHidden").val();
		    var sortCol=$("#sortColIdHidden").val();
		    var chooseDev = $("#category option:selected").val();
			var roomId = $("#roomIdHidden").val();
            $.ajax({
                dataType: 'json',
                //data:"category="+$("#category").val(), 
                //url:"${ctx}/roomDefine/AddDeviceInfoVisit!getFilterDeviceList.action",
                url:"${ctx}/roomDefine/BatchAddDeviceNewInfoVisit!searchDeviceList.action",
                //data:"roomId="+roomId+"&chooseDev="+chooseDev,  
                data:"roomId="+roomId+"&chooseDev="+chooseDev+"&curPageCount=" + page + "&colId=" + sort + "&sortType=" + sortCol,
                success: function(data, textStatus) {
        			var waitChooseStr = data.waitChooseStr;
        			devGp.loadGridData(waitChooseStr);
        			SimpleBox.renderAll();
                }
            });
        }
    }
});

page.pageing(pageSize,1);

var devGp = new GridPanel({id:"tableId",
    columnWidth:{resoureIdVal:50,ipAddress:100,devName:100,devType:100},
    plugins:[SortPluginIndex,TitleContextMenu],
    sortColumns:[{index:"devName",defSorttype:"up"}],
    sortLisntenr:function($sort){
   },
	contextMenu:function(td){}
   },{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
devGp.rend([{index:"resoureIdVal",fn:function(td){
	if(td.html!=""){
		$radioObj = $("<input type='radio' style='cursor:pointer' name='radioName' value='"+td.html+"'/>");
		return $radioObj;
	}else{
		return null;
	}
}
},{index:"ipAddress",fn:function(td){
	if(td.html!="" && td.html!=" ") {
			var ipStr = td.html+"";
  				//ipStr = ipStr.substring(2,ipStr.length-2);

  				var ipArr = ipStr.split(",");
  				
  				if (ipArr.length > 1){
					var strId = "";
					for (var thisNum = 0;thisNum<ipArr[0].split(".").length;thisNum++){
						strId += ipArr[0].split(".")[thisNum];
					}
  	  				
  					$select = $('<select id="'+strId+'" iconIndex="0" iconClass="ico ico-right" iconTitle=""></select>');
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
  	}]);
	/*
$("#category").change(function(){

	var sort=$("#sortIdHidden").val();
    var sortCol=$("#sortColIdHidden").val();
    var chooseDev = $("#category option:selected").val();
	var roomId = $("#roomIdHidden").val();
	
	$.ajax({
		//url:"${ctx}/roomDefine/AddDeviceInfoVisit!getFilterDeviceList.action",
		//data:"category="+$(this).val(),
		dataType:"json",
		data:"roomId="+roomId+"&chooseDev="+chooseDev+"&searchType='devName'", 
        url:"${ctx}/roomDefine/BatchAddDeviceNewInfoVisit!searchDeviceList.action",
		success:function(data,type){
			devGp.loadGridData(data.waitChooseStr);
			page.pageing(data.pageCount,1);
		},
		error:function (XMLHttpRequest, textStatus, errorThrown) {
			alert(textStatus);
		}
	});
});
*/
$("#submit").click(function (){
	if(typeof($("input[name=radioName]:checked").val())=="undefined"){
		alert("请选择设备");
	}else{
		window.opener.setDevInfo($("input[name=radioName]:checked").val());
		window.close();
	}
	//alert($("input[name=radioName]:checked").val());
	
});
$("#cancel").click(function (){
	window.close();
});
$("#closeId").click(function (){
	window.close();
});

$(".ico").click(function (){
	var result = $("#deviceListID").serialize();
	var url="${ctx}/roomDefine/DeviceListVisit!searchDeviceMethod.action";
	ajaxSearchDeviceListFun(result,url);
});

function ajaxSearchDeviceListFun(result,url) {
	var sort=$("#sortIdHidden").val();
    var sortCol=$("#sortColIdHidden").val();
    var chooseDev = $("#category option:selected").val();
	var roomId = $("#roomIdHidden").val();
	var searchType = $("#chooseSearchType").val();
	var searchValue = $("#inputName").val();
	$.ajax({
		//url:"${ctx}/roomDefine/AddDeviceInfoVisit!getFilterDeviceList.action",
		//data:"category="+$(this).val(),
		dataType:"json",
		data:"roomId="+roomId+"&chooseDev="+chooseDev+"&searchType="+searchType+"&searchVal="+searchValue, 
        url:"${ctx}/roomDefine/BatchAddDeviceNewInfoVisit!searchDeviceList.action",
		success:function(data,type){
			devGp.loadGridData(data.waitChooseStr);
			page.pageing(data.pageCount,1);
		},
		error:function (XMLHttpRequest, textStatus, errorThrown) {
			alert(textStatus);
		}
	});
}
SimpleBox.renderAll();
</script>
