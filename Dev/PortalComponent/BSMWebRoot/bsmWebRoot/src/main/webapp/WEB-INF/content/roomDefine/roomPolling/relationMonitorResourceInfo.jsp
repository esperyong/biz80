<!-- 机房-机房巡检-编辑巡检模板-关联监控资源relationMonitorResourceInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.*"%>
<%@ page import="com.opensymphony.xwork2.util.*"%> 
<title>关联监控资源</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" 
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/tongjifenxi.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>	
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/page.js"></script>
</head>
<%
	ValueStack vs = (ValueStack) request
			.getAttribute("struts.valueStack");
	String saveFlag = "";
	if (null != vs && !"".equals(vs)) {

		if (vs.findValue("saveFlag") != null
				&& !"".equals(vs.findValue("saveFlag"))) {
			saveFlag = (String) vs.findValue("saveFlag");
			System.out.println(saveFlag);
		}
	}
%> 
<script>
try{
if("<%=saveFlag%>" != null && "<%=saveFlag%>" == "true") {
	parent.window.toast.addMessage("操作成功");
	setTimeout(function(){
		//parent.window.returnValue='true';
		parent.opener.refreshWin();
		parent.window.close();
		},1000);
}else if("<%=saveFlag%>" == "false") {
	parent.window.toast.addMessage("操作失败");
	parent.window.close();
}
}catch(e){
	alert(e);
}
</script>
<body>

<page:applyDecorator name="popwindow" >
<page:param name="title">关联资源</page:param>	
<page:param name="width">570px;</page:param>
<page:param name="topBtn_index_1">1</page:param>
<page:param name="topBtn_id_1">closeId</page:param>
<page:param name="topBtn_css_1">win-ico win-close</page:param>

<page:param name="bottomBtn_index_1">2</page:param>
<page:param name="bottomBtn_id_1">submit</page:param>
<page:param name="bottomBtn_text_1">确定</page:param>

<page:param name="bottomBtn_index_2">3</page:param>
<page:param name="bottomBtn_id_2">cancel</page:param>
<page:param name="bottomBtn_text_2">取消</page:param>

<page:param name="content">
<form id="relationMonitorResourceFormID" action="" name="relationMonitorResourceForm" method="post" >
<div id="relationMonitorResourceAllId">
<ul id="radioUi" class="fieldlist">
	<li>
	<span class="field" style="padding-left:0px;width:0px"></span>
	<input type="radio" name="relationRadio" value="true" id="relationRadio1Id" checked="checked" />关联机房内设备
	<input type="radio" name="relationRadio" value="false" id="relationRadio2Id" />关联机房设施
	</li>
</ul>
	<div id="roomsDeviceDivId" style="display:none">
<ul class="fieldlist">
		<li>
			<span  class="field" style="padding-left:0px;width:0px"></span>
			<s:select id="chooseDev" name="chooseDev" class="validate[required]" list="resGroups" listKey="key" listValue="value">
			</s:select>
			<s:iterator value="capacityMap" id="map">
			<s:if test="chooseDev==#map.key">
				<option value="<s:property value="#map.value" />" selected="selected"><s:property value="#map.value" /></option>
			</s:if>
			<s:else>
				<option value="<s:property value="#map.value" />"><s:property value="#map.value" /></option>
			</s:else>
			</s:iterator>
			</select>
			<select id="SearchType" name="SearchType" class="">
			<option value="ipAddress" <s:if test="SearchType=='ipAddress'">selected="selected"</s:if> >IP地址</option>
			<option value="devName" <s:if test="SearchType=='devName'">selected="selected"</s:if> >设备名称</option>
			</select>：
			<input type="text" id="searchNameId" name="searchVal" value="<s:property value='searchVal' />" onfocus="cleanFont();" />
			<span class="ico" title="搜索" ></span>
		</li>
		
		<li class="last" id="tableDivId">
		<page:applyDecorator name="indexgrid">  
	     <page:param name="id">devTableId</page:param>
	     <page:param name="width">500px</page:param>
	     <page:param name="height">385px</page:param>
	     <page:param name="linenum">15</page:param>
	     <page:param name="tableCls">grid-gray</page:param>
	     <page:param name="gridhead">[{colId:"resourceId",text:""},{colId:"devName",text:"设备名称"},{colId:"ipAddress",text:"IP地址"},{colId:"deviceType",text:"设备类型"}]</page:param>
	     <page:param name="gridcontent"><s:property value="waitChooseStr" escape="false" />
	     	
	     </page:param>
	   	</page:applyDecorator>
	   
		</li>
	</ul>
	</div>
	<div id="roomsFacilityDivId" style="display:none">
<ul class="fieldlist">
		<li>
			<span  class="field" style="padding-left:0px;width:0px"></span>
			<select id="chooseFacilityType" name="chooseFacilityType" class="validate[required]">
				<option value="all">请选择设施类型</option>
			<s:iterator value="roomResTypeMap" id="map">
				<option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
			</s:iterator>
				
			</select>设施名称：
			<input type="text" id="facilityName" name="facilityName" value="<s:property value='facilityName' />" onfocus="" />
			<span class="ico" title="搜索" id="searchFacilityListId"></span>
		</li>
		<li class="last" id="tableDiv2Id">
		<page:applyDecorator name="indexgrid">  
	     <page:param name="id">facilityTableId</page:param>
	     <page:param name="width">500px</page:param>
	     <page:param name="height">385px</page:param>
	     <page:param name="linenum">15</page:param>
	     <page:param name="tableCls">grid-gray</page:param>
	     <page:param name="gridhead">[{colId:"facilityId",text:""},{colId:"facilityName",text:"设施名称"},{colId:"facilityType",text:"设施类型"}]</page:param>
	     <page:param name="gridcontent"><s:property value="facilityStr" escape="false" /></page:param>
	   	</page:applyDecorator>
	  
	   	<div id="pageFacility" >
       	</div>
		</li>
 	</ul>
	</div>
</div>
<input type="hidden" id="roomIdHidden" name="roomId" value="<s:property value='roomId'/>" />
<input type="hidden" id="resourceId" name="resourceId" value="<s:property value='resourceId' />" />
<input type="hidden" id="facilityId" name="facilityId" value="<s:property value='facilityId' />" />
<input type="hidden" name="pollingId" id="pollingId" value="<s:property value='pollingId' />" />
<input type="hidden" id="sortIdHidden" name="sortIdHidden" value="" />
<input type="hidden" id="sortColIdHidden" name="sortColIdHidden" value="" />
<input type="hidden" id="sortIdFacHidden" name="sortIdFacHidden" value="" />
<input type="hidden" id="sortColIdFacHidden" name="sortColIdFacHidden" value="" />
<input type="hidden" name="pollingIndexId" id="pollingIndexId" value="<s:property value='pollingIndexId' />" />
<input type="hidden" name="checkId" id="checkId" value="<s:property value='checkId' />" />
</form>
<iframe name="submitIframe" id="submitIframeId" frameborder="0" scrolling="no" height="0" width="0" src=""></iframe>
<div id="pageDevice" >
</div>
</page:param>
</page:applyDecorator>
</body>
</html>
<script>
var currentPage = '1';
var pageSize = '<s:property value="pageCount" />';
var page = new Pagination({
    applyId: "pageDevice",
    listeners: {
        pageClick: function(page) {
	var sort=$("#sortIdHidden").val();
    var sortCol=$("#sortColIdHidden").val();
    var chooseDev = $("#chooseDev option:selected").val();
    
	var SearchType = $("#SearchType option:selected").val();
	var roomId = $("#roomIdHidden").val();
	var inputVal = $("#searchNameId").val();
    var url = "${ctx}/roomDefine/RelationMonitorResourceVisit!searchDeviceList.action";
            $.ajax({
                type: "POST",
                dataType: 'json',
                data:"roomId="+roomId+"&chooseDev="+chooseDev+"&searchType="+SearchType+"&searchVal="+inputVal+"&curPageCount=" + page + "&colId=" + sort + "&sortType=" + sortCol, 
                url:url,
                success: function(data, textStatus) {
        			var waitChooseStr = data.waitChooseStr;
        			devGp.loadGridData(waitChooseStr);
        			page.pageing(data.pageCount,1);
                }
            });
        }
    }
});

if (pageSize==0){
	pageSize = 1;
}
page.pageing(pageSize,1);

var toast = new Toast({position:"RT"}); 
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

var devGp = new GridPanel({id:"devTableId",
    width:500,
    columnWidth:{resourceId:50,devName:150,ipAddress:150,deviceType:100},
    plugins:[SortPluginIndex,TitleContextMenu],
    sortColumns:[{index:"devName",defSorttype:"up"},{index:"ipAddress"}],
    sortLisntenr:function($sort){
   	var sort=$sort.colId;
  	    var sortCol=$sort.sorttype;
	$("#sortIdHidden").val(sort);
	$("#sortColIdHidden").val(sortCol);
  	 	var page = $("#pageIdHidden").val();
  	 	if(null == page || "" == page){
      	    page = '<s:property value="curPageCount" />';
      	}
  	 	var chooseDev = $("#chooseDev option:selected").val();
		var SearchType = $("#SearchType option:selected").val();
		var roomId = $("#roomIdHidden").val();
		var inputVal = $("#searchNameId").val();
		var url = "${ctx}/roomDefine/RelationMonitorResourceVisit!searchDeviceList.action";
       $.ajax({
           type: "POST",
           dataType: 'json',
           data:"roomId="+roomId+"&chooseDev="+chooseDev+"&searchType="+SearchType+"&searchVal="+inputVal+"&curPageCount=" + page + "&colId=" + sort + "&sortType=" + sortCol, 
           url:url,
           success: function(data, textStatus) {
       		var waitChooseStr = data.waitChooseStr;
			devGp.loadGridData(waitChooseStr);
			page.pageing(data.pageCount,1);
           }
       });  
   },
contextMenu:function(td){
//alert("=="+td.colId);
   }
   },{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"}
   );
devGp.rend([{index:"resourceId",fn:function(td){
		if(td.html!="") {
			if("${resourceId}" === td.html){
	    		$radioObj = $('<input type="radio" style="cursor:pointer" name="radioOne" checked value="'+td.html+'"/>');
			}else{
				$radioObj = $('<input type="radio" style="cursor:pointer" name="radioOne" value="'+td.html+'"/>');
			}
	    	$radioObj.bind("click",function(){
	    		$("#resourceId").val($(this).val());	    	
	        });
	    	return $radioObj;
	    }else{
			return null;
	    }
      }
   },{index:"ipAddress",fn:function(td){
		
		if(td.html!="" && td.html!=" ") {
			var ipStr = td.html+"";
			var ipArr = ipStr.split(",");

			if (ipArr.length > 1){
				$select = $("<select/>");
				for (var i=0;i<ipArr.length;i++){
 					$("<option value='"+i+"'>"+ipArr[i]+"</option>").appendTo($select)//添加下拉框的option	
 	   			}
 	   			return $select;
	  		}else{
	  			$span = $('<span>'+ipArr[0]+'</span>');
				return $span;
		  	}
		}
		else{
			return null;
		}
	}
}]);

var facilityGp = new GridPanel({id:"facilityTableId",
    width:500,
    columnWidth:{facilityId:50,facilityName:200,facilityType:200},
    plugins:[SortPluginIndex,TitleContextMenu],
    sortColumns:[{index:"facilityName",defSorttype:"up"},{index:"facilityType"}],
    sortLisntenr:function($sort){
   	var sort=$sort.colId;
  	    var sortCol=$sort.sorttype;
	$("#sortIdFacHidden").val(sort);
	$("#sortColIdFacHidden").val(sortCol);
  	 	var page = $("#pageIdHidden").val();
  	 	if(null == page || "" == page){
      	    page = '<s:property value="curPageCount" />';
      	}
  	 	var chooseFacilityType = $("#chooseFacilityType option:selected").val();
		var roomId = $("#roomIdHidden").val();
		var inputVal = $("#facilityName").val();
		var url = "${ctx}/roomDefine/RelationMonitorResourceVisit!searchFacilityList.action";
       $.ajax({
           type: "POST",
           dataType: 'json',
           data:"roomId="+roomId+"&chooseFacilityType="+chooseFacilityType+"&facilityName="+inputVal+"&curPageCount=" + page + "&colId=" + sort + "&sortType=" + sortCol, 
           url:url,
           success: function(data, textStatus) {
       		var facilityStr = data.facilityStr;
       		//alert(facilityStr);
       		facilityGp.loadGridData(facilityStr);
           }
       });  
   },
contextMenu:function(td){
//alert("=="+td.colId);
   }
   },{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"}
   );
facilityGp.rend([{index:"facilityId",fn:function(td){
		if(td.html!="") {
			if("${resourceId}" === td.html){
	    		$radioObj = $('<input type="radio" style="cursor:pointer" name="radioFacOne" checked value="'+td.html+'"/>');
			}else{
				$radioObj = $('<input type="radio" style="cursor:pointer" name="radioFacOne" value="'+td.html+'"/>');
			}
	    	$radioObj.bind("click",function(){
	    		$("#facilityId").val($(this).val());
	        });
	    	return $radioObj;
	    }else{
			return null;
	    }
      }
   }]);
$(".ico").click(function (){
	var chooseDev = $("#chooseDev option:selected").val();
	var SearchType = $("#SearchType option:selected").val();
	var roomId = $("#roomIdHidden").val();
	var url = "${ctx}/roomDefine/RelationMonitorResourceVisit!searchDeviceList.action";
	var inputVal = encodeURI($("#searchNameId").val());
	inputVal = encodeURI(inputVal);
	ajaxSearchDeviceInfoFun(roomId,chooseDev,SearchType,inputVal,url);
});

function ajaxSearchDeviceInfoFun(roomId,chooseDev,SearchType,inputVal,url) {
	
	$.ajax({
		type: "post",
		dataType:'json', //接受数据格式 
		cache:false,
		data:"roomId="+roomId+"&chooseDev="+chooseDev+"&searchType="+SearchType+"&searchVal="+inputVal, 
		url: url,
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			var waitChooseStr = data.waitChooseStr;
			//alert(waitChooseStr);
			devGp.loadGridData(waitChooseStr);
			page.pageing(data.pageCount,1);
			
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
$("#searchFacilityListId").click(function (){
	var chooseFacilityType = $("#chooseFacilityType option:selected").val();
	var roomId = $("#roomIdHidden").val();
	var inputVal = $("#facilityName").val();
	inputVal = setEncodeURI(inputVal);
	var url = "${ctx}/roomDefine/RelationMonitorResourceVisit!searchFacilityList.action";
	ajaxSearchFacilityInfoFun(roomId,chooseFacilityType,inputVal,url);
});
function ajaxSearchFacilityInfoFun(roomId,chooseFacilityType,inputVal,url) {
	
	$.ajax({
		type: "post",
		dataType:'json', //接受数据格式 
		cache:false,
		data:"roomId="+roomId+"&chooseFacilityType="+chooseFacilityType+"&facilityName="+inputVal, 
		url: url,
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			var facilityStr = data.facilityStr;
       		facilityGp.loadGridData(facilityStr);
       		page.pageing(data.pageCount,1);
       		
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

function cleanFont() {
	if($("#searchNameId").val() == "输入名称或IP地址") {
		$("#searchNameId").val("");
	}
}
$("#closeId").click(winClose);
$("#submit").click(function (){
	var radioVal = $("input[name=relationRadio]:checked").val();
	var $facilityId="";
	var $resourceId="";
	if(radioVal=="true") {
		$resourceId = $("#resourceId").val();
		$("#facilityId").val("");
	}else if(radioVal=="false") {
		$facilityId = $("#facilityId").val();
		$("#resourceId").val("");
	}
	if($facilityId == "" && $resourceId == ""){
		window.toast.addMessage("请选择一个资源或者设施！");
		return;
	}
	var url = "${ctx}/roomDefine/RelationMonitorResourceVisit!saveRelationResource.action";
	/*
	$.ajax({
		url:url,
		data:$("#relationMonitorResourceFormID").serialize(),
		dataType:"html",
		type:"POST",
		success:function(data,state){
			
			window.returnValue="true";
			self.window.close();
		},
		error:function (XMLHttpRequest, textStatus, errorThrown){
			alert(XMLHttpRequest+" "+textStatus+"  "+errorThrown);
		}
	});
	*/
	$("#relationMonitorResourceFormID").attr("action",url);
	$("#relationMonitorResourceFormID").attr("target","submitIframe");
	$("#relationMonitorResourceFormID").submit();
});
if("${isBindRoom}" == "Bind"){
	$("#radioUi").show();
}else{
	$("#radioUi").hide();
}
$("#cancel").click(winClose);
function winClose() {
	window.close();
}
$(document).ready(function() {
	var $AllDivId = $("#relationMonitorResourceAllId");
	var $btns = $AllDivId.find("input[name='relationRadio']");
	$btns.bind("click",radioSelValFun);
	var type= "<s:property value='facilityId' />";
	if(type!=''){
		$('[name="relationRadio"]:radio').each(function() {
		       if (this.value == 'false')
		       {
		         this.checked = true;
		       } 
		    });
	}
	radioSelValFun();
});
function radioSelValFun() {
	var radioVal = $("input[name=relationRadio]:checked").val();
	if(radioVal!=null && radioVal=="false"){
		if($("#roomsFacilityDivId").is(":hidden")){
			$("#roomsDeviceDivId").hide();
			$("#roomsFacilityDivId").show();
		}
	}else if(radioVal=="true"){
		if($("#roomsDeviceDivId").is(":hidden")){
			$("#roomsDeviceDivId").show();
			$("#roomsFacilityDivId").hide();
		}
	}
	//alert(radioVal);
}
</script>