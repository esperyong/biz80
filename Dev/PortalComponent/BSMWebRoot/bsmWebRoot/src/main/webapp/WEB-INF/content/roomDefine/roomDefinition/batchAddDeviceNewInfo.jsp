<!-- 机房-设备管理-批量添加  batchAddDeviceNewInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%> 
<title>批量添加</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/button-module.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/page.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
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
</head>
<script>

if("<%=saveFlag%>" != "" && "<%=saveFlag%>" == "true") {
	try{
		var json = '<%=jsonStr%>';
		//toast.addMessage("应用成功");
		window.opener.deviceManagerFunClk();
		gp.loadGridData(json);
	}catch(e){
	}
}
if("<%=saveFlag%>" != "" && "<%=saveFlag%>" == "saveOK") {
	try{
		//toast.addMessage("保存成功");
		window.opener.deviceManagerFunClk();
		window.close();
	}catch(e){
	}
}
function cleanFont() {
	if($("#searchNameId").val() == "输入名称或IP地址") {
		$("#searchNameId").val("");
	}
}
</script>
  <body>
   <form id="formID" action="" name="deviceListForm" method="post" namespace="/roomDefine">
   	<page:applyDecorator name="popwindow"  title="批量添加">
	<page:param name="width">650px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submit</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
	<page:param name="bottomBtn_index_3">3</page:param>
	<page:param name="bottomBtn_id_3">use</page:param>
	<page:param name="bottomBtn_text_3">应用</page:param>
	<page:param name="content">
   		<div style="overflow:hidden;width:635px" >
   		<div style="position:relative;top:2px;left:3px;z-index:111;width:100%">
   		<s:select id="chooseDev" name="chooseDev" class="validate[required]" list="resGroups" listKey="key" listValue="value" style="width:182px;left:-4px;position:relative">
   			<!-- 
			<option value="all" >请选择设备类型</option>
			<s:iterator value="capacityMap" id="map">
			<s:if test="chooseDev==#map.key">
				<option value="<s:property value="#map.key" />" selected="selected"><s:property value="#map.value" /></option>
			</s:if>
			<s:else>
				<option value="<s:property value="#map.key" />"><s:property value="#map.value" /></option>
			</s:else>
			</s:iterator>
			 -->
		</s:select>
   		<select id="SearchType" name="SearchType" class="">
	   		<option value="ipAddress" <s:if test="SearchType=='ipAddress'">selected="selected"</s:if> >IP地址</option>
			<option value="devName" <s:if test="SearchType=='devName'">selected="selected"</s:if> >名称</option>
		</select>
   		<input type="text" style="top:2px;position:relative" id="searchNameId" name="searchVal" value="<s:property value='searchVal' />" onfocus="cleanFont();" />
		<span   class="ico" style="top:2px;position:relative" title="搜索" ></span>
   		</div>
   		
   		<div style="position:relative;top:5px">
   		
   		 <page:applyDecorator name="indexgrid">  
	     <page:param name="id">tableId</page:param>
	     <page:param name="width">650px</page:param>
	     <page:param name="height">378px</page:param>
	     <page:param name="linenum">15</page:param>
	     <page:param name="tableCls">grid-gray</page:param>
	     <page:param name="gridhead">[{colId:"resourceId",text:"<input type='checkbox' name='checkAll' id='checkAllId' style='cursor:pointer' />"},{colId:"devName",text:"设备名称"},{colId:"ipAddress",text:"IP地址"},{colId:"deviceType",text:"设备类型"}]</page:param>
	     <page:param name="gridcontent"><%=jsonStr%></page:param>
	   	</page:applyDecorator>
	   	<div id="pageDevice" >
       	</div>
   		</div>
   		<input type="hidden" id="roomIdHidden" name="roomId" value="<s:property value='roomId'/>" />
   		<input type="hidden" id="jiguiNo" name="jiguiNo" value="<s:property value='jiguiNo'/>" />
   		<input type="hidden" id="sortIdHidden" name="sortIdHidden" value="" />
   		<input type="hidden" id="sortColIdHidden" name="sortColIdHidden" value="" />
	</page:param>
	</page:applyDecorator>  
	</div> 
   </form>
   <iframe frameborder="0" id="addResourceIframe" name="addResourceIframe" src="" scrolling="no" width="0" height="0" marginheight="0" marginwidth="0"></iframe>
   
  </body> 

<script type="text/javascript">
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
    var url = "${ctx}/roomDefine/BatchAddDeviceNewInfoVisit!searchDeviceList.action";
            $.ajax({
                type: "POST",
                dataType: 'json',
                data:"roomId="+roomId+"&chooseDev="+chooseDev+"&searchType="+SearchType+"&searchVal="+inputVal+"&curPageCount=" + page + "&colId=" + sort + "&sortType=" + sortCol, 
                url:url,
                success: function(data, textStatus) {
        			var waitChooseStr = data.waitChooseStr;
        			gp.loadGridData(waitChooseStr);
                }
            });
        }
    }
});
page.pageing(pageSize,1);

var toast = new Toast({position:"RT"}); 
$("#closeId").click(function (){
	window.close();
});

$("#submit").click(function (){
	if(!validateChoose()){
		return;
	}
	$("#formID").attr("action","${ctx}/roomDefine/BatchAddDeviceNewInfoVisit!batchAddResource.action?saveFlag=save");
	//$("#formID").attr("target","addResourceIframe");
	$("#formID").submit();
});

$("#cancel").click(function(){
	window.close();
});

$("#use").click(function(){
	if(!validateChoose()){
		return;
	}
	$("#formID").attr("action","${ctx}/roomDefine/BatchAddDeviceNewInfoVisit!batchAddResource.action");
	//$("#formID").attr("target","addResourceIframe");
	$("#formID").submit();
});
/**
 * 验证选中否
 */
function validateChoose() {
	var str = "";
	  $("#tableId input[name=checkOne]:checked").each(function(){
		  str+=$(this).val()+",";
	  });
	  if(str == ""){
		alert("请选择设备");
		return false;
	  }
	  return true;
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
$(".ico").click(function (){
	var chooseDev = $("#chooseDev option:selected").val();
	var SearchType = $("#SearchType option:selected").val();
	var roomId = $("#roomIdHidden").val();
	var inputVal = encodeURI(trim($("#searchNameId").val()));
	inputVal = encodeURI(inputVal);
	var url = "${ctx}/roomDefine/BatchAddDeviceNewInfoVisit!searchDeviceList.action";
	ajaxSearchDeviceInfoFun(roomId,chooseDev,SearchType,inputVal,url);
});

function trim(str)   
{   
    if(str==null)   
        return "";   
    //如果str前存在空格   
    while(str.charAt(0)==' '){   
        str = str.substring(1,str.length);   
    }   
    //如果str末尾存在空格   
    while(str.charAt(str.length-1)==' '){   
        str = str.substring(0,str.length-1);   
    }   
    return str ;   
} 

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
			gp.loadGridData(waitChooseStr);
			page.pageing(data.pageCount,1);
			SimpleBox.renderAll();
				//window.deviceManagerFunClk();
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



var gp = new GridPanel({id:"tableId",
    width:650,
    columnWidth:{resourceId:50,devName:200,ipAddress:200,deviceType:200},
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
 		var url = "${ctx}/roomDefine/BatchAddDeviceNewInfoVisit!searchDeviceList.action";
        $.ajax({
            type: "POST",
            dataType: 'json',
            data:"roomId="+roomId+"&chooseDev="+chooseDev+"&searchType="+SearchType+"&searchVal="+inputVal+"&curPageCount=" + page + "&colId=" + sort + "&sortType=" + sortCol, 
            url:url,
            success: function(data, textStatus) {
        	
        		var waitChooseStr = data.waitChooseStr;
				gp.loadGridData(waitChooseStr);
			
				
            }
        });  
    },
	contextMenu:function(td){
	//alert("=="+td.colId);
    }
    },{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"}
    );
gp.rend([{index:"resourceId",fn:function(td){
		if(td.html!="") {
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
 			var ipArr = ipStr.split(",");

 			if (ipArr.length > 1){

				var strID = "";
				for (var thisNum=0;thisNum<ipArr[0].split(".").length;thisNum++){
					strID += ipArr[0].split(".")[thisNum];
				}

				$select = $("<select id='"+strID+"'></select>");
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
$(function(){

	  $("#checkAllId").click(function() {
			if($(this).attr("checked")) {
				$("[name='checkOne']").attr("checked",'true');//全选
			}else {
				$("[name='checkOne']").removeAttr("checked");//取消全选
			}
	  });
});
SimpleBox.renderAll();

</script> 