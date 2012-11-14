<!-- 机房-机房定义-属性-状态设置页面 resStatusSet.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<%@ page import="com.opensymphony.xwork2.*"%>
<%@ page import="com.mocha.bsm.room.entity.Resource"%>
<title></title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/master.css" type="text/css" />

<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
</head>
<%
	ValueStack vs = (ValueStack) request
			.getAttribute("struts.valueStack");
	String cond = "";
	String jsonStr1 = "";
	String jsonStr2 = "";
	if (null != vs && !"".equals(vs)) {
		if (vs.findValue("condition") != null
				&& !"".equals(vs.findValue("condition"))) {
			cond = (String) vs.findValue("condition");
		}
		if (vs.findValue("relaDevData") != null
				&& !"".equals(vs.findValue("relaDevData"))) {
			jsonStr1 = (String) vs.findValue("relaDevData");
		}
		if (vs.findValue("statusRelaDevData") != null
				&& !"".equals(vs.findValue("statusRelaDevData"))) {
			jsonStr2 = (String) vs.findValue("statusRelaDevData");
		}
	}
%>
<script type="text/javascript">
$.unblockUI();

$(function(){
	if("condition1"=="<%=cond%>"){
		$("#statusRes").hide("slow");
		$("#noRes").show("slow");
		$("input[name='statusSet'][value='condition1']").attr("checked",true);
	} else if("condition2"=="<%=cond%>"){
		$("#statusRes").hide("slow");
		$("#noRes").show("slow");
		$("input[name='statusSet'][value='condition2']").attr("checked",true);
	} else if("condition3"=="<%=cond%>"){
		$("#statusRes").show("slow");
		$("#noRes").hide("slow");
		$("input[name='statusSet'][value='condition3']").attr("checked",true);
	}
});
var toast = new Toast({position:"CT"});
var gp1;
var gp2;
$(function(){

	  	$("#checkAllId1").click(function() {
			if($(this).attr("checked")) {
				$("[name='checkOne']").attr("checked",'true');//全选
			}else {
				$("[name='checkOne']").removeAttr("checked");//取消全选
			}
	  	});
  		gp1 = new GridPanel({id:"tableId1",
      					width:300,
      					columnWidth:{0:10,1:20,2:25,3:45},
      					unit:'%',
      					plugins:[SortPlugin],
                 			sortColumns:[{index:1,sortord:"0",defSorttype:"up"},{index:2,sortord:"1"}],
                 			sortLisntenr:function($sort){
					                      $.post("gridStore.html",function(data){
					                            gp.loadGridData(data);
					                      });
                 }});
  		gp1.rend([{index:0,fn:function(td){
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
 		},{index:1,fn:function(td){
	   		if(td.html!="" && td.html!=" ") {

   				var thval = td.html;
   				var arr = thval.split(",");

				if (arr.length<=1){
					
					$span = $('<span name="ip" title="'+thval+'">'+thval+'</span>');
		            $span.bind("click",function(e){
		            	
			   			}
			   		);
		            return $span;
				}else{
					var strId = "";
					for (var thisNum = 0;thisNum<arr[0].split(".").length;thisNum++){
						strId += arr[0].split(".")[thisNum];
					}
					
					$select = $('<select name="'+strId+'" id="'+strId+'" style="width:50px"></select>');

					for (var i=0;i<arr.length;i++){
						$("<option value='"+i+"'>"+arr[i]+"</option>").appendTo($select);
					}

					return $select
				}
             }else{
				return null;
             }
   	   		}
		  },{index:2,fn:function(td){
		   		if(td.html!="" && td.html!=" ") {

	   				var thval = td.html;
		            $span = $('<span name="ip" style="display: block; width: 50px; overflow: hidden; white-space: nowrap;text-overflow: ellipsis;" title="'+thval+'">'+thval+'</span>');
		            $span.bind("click",function(e){
		            	
			   			}
			   		);
		            return $span;
	             }else{
					return null;
	             }
	   	   		}
			  }
		 
 		]);
  
  		 SimpleBox.renderAll();
  		$("#checkAllId2").click(function() {
			if($(this).attr("checked")) {
				$("[name='checkOne']").attr("checked",'true');//全选
			}else {
				$("[name='checkOne']").removeAttr("checked");//取消全选
			}
		});

  		gp2 = new GridPanel({id:"tableId2",
			width:300,
			columnWidth:{0:10,1:25,2:20,3:45},
			unit:'%',
			plugins:[SortPlugin],
 			sortColumns:[{index:1,sortord:"0",defSorttype:"up"},{index:2,sortord:"1"}],
 			sortLisntenr:function($sort){
	                      $.post("gridStore.html",function(data){
	                            gp.loadGridData(data);
	                      });
 		}});
		gp2.rend([{index:0,fn:function(td){
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
	},{index:1,fn:function(td){
   		if(td.html!="" && td.html!=" ") {

				var thval = td.html;
				var arr = thval.split(",");

				if (arr.length<=1){
					
					$span = $('<span name="ip" title="'+thval+'">'+thval+'</span>');
		            $span.bind("click",function(e){
		            	
			   			}
			   		);
		            return $span;
				}else{
					var strId = "";
					for (var thisNum = 0;thisNum<arr[0].split(".").length;thisNum++){
						strId += arr[0].split(".")[thisNum];
					}
					
					$select = $('<select name="'+strId+'" id="'+strId+'" style="width:50px"></select>');

					for (var i=0;i<arr.length;i++){
						$("<option value='"+i+"'>"+arr[i]+"</option>").appendTo($select);
					}

					return $select
				}
           

            return $span;
         }else{
			return null;
         }
	   		}
	  },{index:2,fn:function(td){
	   		if(td.html!="" && td.html!=" ") {

   				var thval = td.html;
	            $span = $('<span name="ip" title="'+thval+'">'+thval+'</span>');
	            $span.bind("click",function(e){
	            	
		   			}
		   		);
	           

	            return $span;
             }else{
				return null;
             }
   	   		}
		  }
	 
		]);
		 SimpleBox.renderAll();
	});

$("input[name='statusSet']").change(function() {
	var sel = $("input[name='statusSet']:checked").val();
	if(sel=="condition1" || sel=="condition2"){
		$("#statusRes").hide("slow");
		$("#noRes").show("slow");
	}else if(sel=="condition3"){
		$("#statusRes").show("slow");
		$("#noRes").hide("slow");
	}
});


var $leftBody = $("tbody", $("#tableId1"));
var $rigthBody = $("tbody", $("#tableId2"));

$(".turn-right").click(function(){
	moveSelectTR($leftBody,$rigthBody);
	$("#checkAll1").attr("checked",false);
});
$(".turn-left").click(function(){
	moveSelectTR($rigthBody,$leftBody);
	$("#checkAll2").attr("checked",false);
});



function moveSelectTR(baseTable, targetTable){
// 得到选中的行
var $selectTR =$("input[name=checkOne][checked]", baseTable).parents("tr");

if($selectTR.size()>0){
	var parent = $selectTR[0].parentNode;
	
	for(var r=$selectTR.size()-1; r>=0; r--){
		// 添加行到目标表格
		var newTr = targetTable[1].insertRow();
		// 设置目录行内外单元格
		for(var i=0; i<$selectTR[r].cells.length; i++){
			var cell = newTr.insertCell();
			cell.style.width = $selectTR[r].cells[i].style.width;
			//alert($($selectTR[r].cells[i]).html());
			$(cell).append($($selectTR[r].cells[i]).html());
			//cell.innerHTML = $($selectTR[r].cells[i]).children("span").html();
		}
		
		// 删除原表格行
		//parent.deleteRow($selectTR[r].rowIndex);
		
		$selectTR[0].parentNode.parentNode.deleteRow($selectTR[r].rowIndex);
		
		
	}
	$("input[name=checkOne]", $rigthBody).each(function(i){
		
		$("#resourceIds").val(this.value + "," + $("#resourceIds").val());
	});
} else {
	toast.addMessage("请选择设备");
} 
}
</script>
<body>
<form id="statusForm" action="" name="ResourceStatusForm" method="post">
<div class="clear" >
<ul>
	<li><span id="lamp-redICO" class="lamp lamp-red"></span>异常：
	<input type="radio" name="statusSet" value="condition1"
		checked="checked" />机柜指标异常</li>
	<li>
	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	<input type="radio" name="statusSet" value="condition2" />机柜指标异常或机柜内任一设备不可用
	</li>
	<li>
	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	<input type="radio" name="statusSet" value="condition3" />机柜指标异常或机柜内指定设备不可用
	</li>
</ul>


<br />
<div class="ui-layout-center">
<div id="noRes"></div>
<div id="statusRes" class="clear" style="display: none">
<div class="select-lr" style="height:265px">
<div class="left-n">
<div class="h1">待选设备</div>
<div class="gray-border">
<page:applyDecorator name="grid">
	<page:param name="id">tableId1</page:param>
	<page:param name="height">200px</page:param>
	<page:param name="tableCls">grid-gray</page:param>
	<page:param name="gridhead">[{text:"<input type='checkbox' name='checkAll1' id='checkAllId1' style='cursor: pointer' />"},{text:"IP地址"},{text:"设备名称"},{text:"设备类型"}]</page:param>
	<page:param name="gridcontent"><%=jsonStr1%></page:param>
</page:applyDecorator></div>
</div>
<div class="middle"><span class="turn-right"></span> <span
	class="turn-left"></span></div>
<div class="right-n">
<div class="h1">已选设备<div style="display:none1"><s:hidden name="resourceIds" id="resourceIds" cssClass="validate[required]"></s:hidden></div></div>
<div class="gray-border"><page:applyDecorator name="grid">
	<page:param name="id">tableId2</page:param>
	<page:param name="height">200px</page:param>
	<page:param name="tableCls">grid-gray</page:param>
	<page:param name="gridhead">[{text:"<input type='checkbox' name='checkAll2' id='checkAllId2' style='cursor: pointer' />"},{text:"IP地址"},{text:"设备名称"},{text:"设备类型"}]</page:param>
	<page:param name="gridcontent"><%=jsonStr2%></page:param>
</page:applyDecorator></div>
<div class="gray-border" style="display:none"></div>
</div>
</div>
</div>
</div>
<ul>
	<li><span id="lamp-greenICO" class="lamp lamp-green"></span>正常：不符合异常则状态为正常</li>
</ul>
<input type="hidden" name="roomId" id="roomId"
	value="<s:property value='roomId' />" />
<input type="hidden" name="resourceId" id="resourceId"
	value="<s:property value='resourceId' />" />
<s:if test="treeTarget==true">	
	<ul class="panel-button" style="width:70%">
		<li><span></span><a  onclick="submitStatusSetFun();">应用</a></li>
    </ul>
<input type="hidden" name="capacityId" id="capacityhidId"
	value="" />    
<input type="hidden" name="componentId" id="componenthidId"
	value="" />   
<input type="hidden" name="isMonitorSet" id="isMonitorSet"
	value="<s:property value='isMonitorSet' />" />  
</s:if>
</div>
</form>
</body>
</html>
<script type="text/javascript">
function submitStatusSetFun() {
	var capacityId = $("#capacityId").val();
	var resourceId = $("#resourceId").val();
	var componentId = $("#componentId").val();
	//alert(capacityId+":"+resourceId+":"+componentId);
	//alert($("#capacityId").val());
	//alert($("#componentId").val());
	//alert($("#isJigui").val());
	try{
		$("#capacityhidId").val(capacityId);		
		$("#componenthidId").val(componentId);		
	}catch(e){
	}
	
	//$("#statusForm").attr("action","${ctx}/roomDefine/ResourceProperty.action?commitType=statusSet");
	//$("#statusForm").submit();

	$("#statusForm").attr("action","${ctx}/roomDefine/ResourceProperty.action?commitType=statusSet");
	$("#statusForm").attr("target","submitIframe");
	$("#statusForm").submit();
}
</script>
