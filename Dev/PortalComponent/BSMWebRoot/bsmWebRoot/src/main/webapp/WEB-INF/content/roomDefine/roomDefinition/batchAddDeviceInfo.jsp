<!-- 机房-机房定义-批量添加设备  batchAddDeviceInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%> 
<title>批量添加设备</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" 
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>

<script type="text/javascript">
var gp="";
var gp1="";
  $(function() {
    gp = new GridPanel({id:"tableId1",
		width:335,
		columnWidth:{0:35,1:100,2:100,3:100},
		plugins:[SortPlugin],
		sortColumns:[{index:1,sortord:"0",defSorttype:"up"},{index:3,sortord:"1"}],
	       			sortLisntenr:function($sort){
	            $.post("gridStore.html",function(data){
	                  gp.loadGridData(data);
	            });
	       }});
    gp.rend([{index:0,fn:function(td){
        $checkbox = $('<input type="checkbox" style="cursor:pointer" name="checkOne" value="'+td.html+'"/>');
        $checkbox.bind("click",function(){
	        
         		 //alert($(this).val());
        });
       	return $checkbox;
				}
	}]);
    gp1 = new GridPanel({id:"tableId2",
		width:335,
		columnWidth:{0:35,1:100,2:100,3:100},
		plugins:[SortPlugin],
		sortColumns:[{index:1,sortord:"0",defSorttype:"up"},{index:3,sortord:"1"}],
	       			sortLisntenr:function($sort){
	            $.post("gridStore.html",function(data){
	                  gp1.loadGridData(data);
	            });
	       }});
    gp1.rend([{index:0,fn:function(td){
        $checkbox = $('<input type="checkbox" style="cursor:pointer" name="checkOne1" value="'+td.html+'"/>');
        $checkbox.bind("click",function(){
	        
         		 //alert($(this).val());
        });
       	return $checkbox;
				}
	}]);
    
  //gp.loadGridData("[[{text:'c0'},{text:'content1'},{text:'content2'},{text:'content3'}]]");
    
    
  });
</script>  

</head>

<body>
<%
	ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
	String waitChooseStr = "";
	String hasChooseStr = "";
	if(null != vs && !"".equals(vs)){
		if(vs.findValue("waitChooseStr") != null && !"".equals(vs.findValue("waitChooseStr"))){
			waitChooseStr = (String)vs.findValue("waitChooseStr");
			hasChooseStr = (String)vs.findValue("hasChooseStr");
		}
	}
%>  
<page:applyDecorator name="popwindow"  title="添加">
	
	<page:param name="width">940px;</page:param>
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
		<s:form id="formID" action="BatchAddDeviceInfo" name="BatchAddDeviceInfoForm" method="post" namespace="/roomDefine" theme="simple">
		 	<div class="select-lr">			
				<div class="left-n">
				  <div class="h1">待选资源</div>
				  <div class="h1">
				  	<select name="searchTypeWait" id="selectId">
				  		<option value="ipAddress">IP地址</option>
				  		<option value="devName">设备名称</option>
				  		<option value="devType">设备类型</option>
				  	</select><span>：</span>
				  	<span>
				  		<input type="text" name="inputVal" id="inputVal" />
				  		<select id="devTypeVal" name="devTypeVal" style="display:none">
				  		 	<s:iterator value="capacityMap" id="map">
		   						<option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
		   					</s:iterator>
				  		</select>
				  	</span>
				  	<span class="ico ico-select" id="searchWaitId"></span>
				  </div>
				  <div class="gray-border">
				  	<page:applyDecorator name="grid">  
				     <page:param name="id">tableId1</page:param>
				     <page:param name="width">335px</page:param>
				     <page:param name="height">300px</page:param>
				     <page:param name="tableCls">grid-gray</page:param>
				     <page:param name="gridhead">[{text:"<input type='checkbox' name='checkAll' id='checkAllId' style='cursor:pointer' />"},{text:"设备名称"},{text:"IP地址"},{text:"设备类型"}]</page:param>
				     <page:param name="gridcontent"><%=waitChooseStr%></page:param>
				    </page:applyDecorator>
				  </div>
				</div>
				<div class="middle">
					<span class="turn-right"></span>
					<span class="turn-left"></span>
				</div>
				<div class="right-n">
					<div class="h1">已选资源</div>
					   <div class="h1">
					  	<select name="searchTypeHas" id="selectIds">
					  		<option value="ipAddress">IP地址</option>
					  		<option value="devName">设备名称</option>
					  		<option value="devType">设备类型</option>
					  	</select><span>：</span>
					  	<span>
					  		<input type="text" name="inputVals" id="inputVals" />
					  		<select id="devTypeVals" name="devTypeVals" style="display:none">
					  		 	<s:iterator value="capacityMap" id="map">
			   						<option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
			   					</s:iterator>
					  		</select>
					  	</span>
					  	<span class="ico ico-select" id="searchHasId"></span>
					  </div>
					<div class="gray-border">
				  	   <page:applyDecorator name="grid">  
					     <page:param name="id">tableId2</page:param>
					     <page:param name="width">335px</page:param>
					     <page:param name="height">300px</page:param>
					     <page:param name="tableCls">grid-gray</page:param>
					     <page:param name="gridhead">[{text:"<input type='checkbox' name='checkAll' id='checkAllId1' style='cursor:pointer' />"},{text:"设备名称"},{text:"IP地址"},{text:"设备类型"}]</page:param>
					     <page:param name="gridcontent"><%=hasChooseStr%></page:param>
					   </page:applyDecorator>
				  </div>
				</div>
			</div>
		 	<input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId' />" />
		 	<input type="hidden" name="searchType" id="searchType" value="<s:property value='searchType' />" />
		 	<input type="hidden" name="searchVal" id="searchVal" value="<s:property value='searchVal' />" />
		 	<input type="hidden" name="isSelect" id="isSelect" value="<s:property value='isSelect' />" />
			
   		</s:form>
	</page:param>
</page:applyDecorator>
	
</body>


</html>
<script type="text/javascript">

	var $leftBody = $("tbody", $("#tableId1"));
	var $rightBody = $("tbody", $("#tableId2"));
$(document).ready(function() {
	
	$("#formID").validationEngine({
		promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	})
	
	$("#checkAllId").click(function() {
		if($(this).attr("checked")) {
			$("[name='checkOne']").attr("checked",'true');//全选
		}else {
			$("[name='checkOne']").removeAttr("checked");//取消全选
		}
	});
	  
	$("#checkAllId1").click(function() {
		if($(this).attr("checked")) {
			$("[name='checkOne1']").attr("checked",'true');//全选
		}else {
			$("[name='checkOne1']").removeAttr("checked");//取消全选
		}
	});
	  
	$('#selectId').change(function (){
		var sel = $('#selectId').val();
		if(sel == "devType") {
			$('#devTypeVal').attr("style","");
			$('#inputVal').attr("style","display:none");
		}else{
			$('#inputVal').attr("style","");
			$('#devTypeVal').attr("style","display:none");
		}
	});
	
	$('#selectIds').change(function (){
		var sel = $('#selectIds').val();
		if(sel == "devType") {
			$('#devTypeVals').attr("style","");
			$('#inputVals').attr("style","display:none");
		}else{
			$('#inputVals').attr("style","");
			$('#devTypeVals').attr("style","display:none");
		}
	});
	SimpleBox.renderAll();
});

function moveSelectTR(baseTable, targetTable) {
	// 得到选中的行
	//$rightBody,$leftBody
	//if()
		//alert(baseTable);
	var $selectTR =$("input[name=checkOne][checked]", baseTable).parents("tr");
	if($selectTR.size()>0){
/*			var parent = $selectTR[0].parentNode;
		for(var r=$selectTR.size()-1; r>=0; r--){
			// 添加行到目标表格
			var newTr = targetTable[0].insertRow();
			// 设置目录行内外单元格
			for(var i=0; i<$selectTR[r].cells.length; i++){
				var cell = newTr.insertCell();
				cell.style.width = $selectTR[r].cells[i].style.width;
				cell.innerHTML = $selectTR[r].cells[i].innerHTML;
			}
			// 删除原表格行
			parent.deleteRow($selectTR[r].rowIndex);
		}
*/		
		targetTable.append($selectTR);
	} else {
		//toast.addMessage("请选择移动的行");
	} 
}
$("#closeId").click(function (){
	window.close();
})

$("#submit").click(function (){
	$("#formID").submit();
})
$("#cancel").click(function(){
	window.close();
})
$(".turn-right").click(function(){
	moveSelectTR($leftBody,$rightBody);
	$("#checkAllId").attr("checked",false);
});
$(".turn-left").click(function(){
	moveSelectTR($rightBody,$leftBody);
	$("#checkAllId1").attr("checked",false);
});

$("#searchWaitId").click(function(){
	$("#searchType").val($("#selectId").val());
	var searchType = $("#searchType").val();
	if(searchType == "devType") {
		var devTypeVal = $("#devTypeVal").val();
		$("#searchVal").val(devTypeVal);
	}else {
		var inputVal = $("#inputVal").val();
		$("#searchVal").val(inputVal);
	}

	$.ajax({
		type: "post",
		dataType:'json', //接受数据格式 
		data:"searchType="+searchType+"&searchVal="+$("#searchVal").val()+"&roomId="+$("#roomId").val()+"&isSelect=false", 
		url: "${ctx}/roomDefine/SearchDeviceInfo!getDeviceList.action",
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			//alert(data.chooseJsonStr);
			var jsonStr = data.chooseJsonStr;
			gp.loadGridData(jsonStr);
			
		},
		complete: function(XMLHttpRequest, textStatus){
		//HideLoading();
		},
		error: function(){
		//请求出错处理
			alert("error");
		}
		});
	
})
$("#searchHasId").click(function(){
	$("#searchType").val($("#selectIds").val());
	var searchType = $("#searchType").val();
	if($("#searchType").val() == "devType") {
		var devTypeVal = $("#devTypeVals").val();
		$("#searchVal").val(devTypeVal);
	}else {
		var inputVal = $("#inputVals").val();
		$("#searchVal").val(inputVal);
	}

	$.ajax({
		type: "post",
		dataType:'json', //接受数据格式 
		data:"searchType="+searchType+"&searchVal="+$("#searchVal").val()+"&roomId="+$("#roomId").val()+"&isSelect=true", 
		url: "${ctx}/roomDefine/SearchDeviceInfo!getDeviceList.action",
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			//alert(data.chooseJsonStr);
			var jsonStr = data.chooseJsonStr;
			gp1.loadGridData(jsonStr);
			
		},
		complete: function(XMLHttpRequest, textStatus){
		//HideLoading();
		},
		error: function(){
		//请求出错处理
			alert("error");
		}
		});
})

</script>