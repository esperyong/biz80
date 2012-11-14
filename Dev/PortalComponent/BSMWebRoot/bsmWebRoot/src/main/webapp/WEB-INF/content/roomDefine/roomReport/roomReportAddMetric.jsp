<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.opensymphony.xwork2.util.*"%> 
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>机房监控</title>
</head>
<body>



 	<page:applyDecorator name="popwindow"  title="设备列表">
	<page:param name="width">505px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId_${sign}</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submit_${sign}</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel_${sign}</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
	<page:param name="bottomBtn_index_3">3</page:param>
	<page:param name="bottomBtn_id_3">app_${sign}</page:param>
	<page:param name="bottomBtn_text_3">应用</page:param>

	<page:param name="content">
		<ul>
		<li>
		<span>选择机房：</span>
		<select id="chooseRoom_${sign}">
			<s:iterator value="allRoom" id="map">
				<option value='<s:property value="#map.key" />'><s:property value="#map.value.name" /></option>
			</s:iterator>
		</select>
		</li>
		<li>
		<table>
		<tr>
			<td style="top:0px;position:relative"><span style="top:0px;position:relative">选择指标：</span></td>
			<td style="width:85%"><div id="thisTree_${sign}" style="width: 90%;height: 300px;overflow-y:auto;positioin:relative;border-style:solid;border-width:1px; border-color:#000000"/></td>
		</tr>
		</table>
		
		
		</li>
		</ul>
		
</page:param>
</page:applyDecorator>  
<input type="hidden" id="userIds_${sign}" name="userIds_${sign}" value=""/>
<input type="hidden" id="userNames_${sign}" name="userNames_${sign}" value=""/>	


<input type="hidden" id="MachineRoom_infoName_${sign}" name="MachineRoom_infoName_${sign}" value=""/>
<input type="hidden" id="instances_${sign}" name="instances_${sign}" value=""/>
<input type="hidden" id="MachineRoom_metric_${sign}" name="MachineRoom_metric_${sign}" value=""/>

</body>
</html>

<script type="text/javascript">

var tree;

var roomid = '<s:property value="resources"/>';

$(document).ready(function() {
	
	$("#chooseRoom_${sign}").change(function(){
		ajaxChoose();
	});

	if (roomid!="" && roomid!=null){
		$("#chooseRoom_${sign}").val(roomid);
	}
	
	ajaxChoose();

	$("#submit_${sign}").click(function(){
		addData(true);
		//window.parent.closeTree();
	});

	$("#app_${sign}").click(function(){
		addData(false);
	});

	$("#cancel_${sign}").click(function(){
		closeDiv();
	});
	$("#closeId_${sign}").click(function(){
		closeDiv();
	});

	function addData(isClose){
		// 机房名称
		var idx = document.getElementById("chooseRoom_${sign}").selectedIndex;
		var option;
		var value = ""; 
		if (idx > -1) { 
			option = document.getElementById("chooseRoom_${sign}").options[idx]; 
			value = option.text; 
		}

		$("#MachineRoom_infoName_${sign}").val(value);
		$("#instances_${sign}").val($("#chooseRoom_${sign}").val());
		
		$("#MachineRoom_metric_${sign}").val($("#userIds_${sign}").val());

		/*
		var userId;
		var userName;
		
		
		var nodes=tree.getCheckedNodes(false);
		
		for(var i=0;i<nodes.length;i++){
			if(objValue.isNotEmpty(userId)){
				userId+=";"+nodes[i].getId();
				userName+=";"+nodes[i].getText();
			}else{
				userId=nodes[i].getId();
				userName=nodes[i].getText();
			}
		}
		*/
		
		
		var isflag = saveCustomResoureVo();
		if (isflag){
			$("#"+cacheObj.getReportType()+"_tr_"+cacheObj.getRowID()) .css("display","block"); 
			$("#isShowTr").val("true"); 
			$("#isNew_"+cacheObj.getRowID()).val("false");
			if (isClose){
				closeDiv();
			}else{
				toast.addMessage("保存成功");
			}
			
		}
		
		//window.parent.addRow($("#userIds").val(),$("#userNames").val(),$("#chooseRoom").val(),value);
	}
	
});
var treeRoot;
function ajaxChoose(){
	var resources = $("#chooseRoom_${sign}").val();
	var metrics = '<s:property value="metrics"/>';
	$.ajax({
		   type: "POST",
		   url: "${ctx}/roomDefine/RoomReportTreeVisit.action",
		   data: "roomId="+$("#chooseRoom_${sign}").val()+"&metrics="+metrics+"&sign="+${sign},
		   success: function(msg){
			    $("#thisTree_${sign}").find("*").unbind();
				$("#thisTree_${sign}").html("");
				
				$("#thisTree_${sign}").append(msg.treeStr);

				tree_${sign} = new Tree({id:"treeId_${sign}",listeners:{
					checkboxClick:function(node) {
					var userId="";//$("#userIds_${sign}").val();
	  	  			var userName="";//$("#userNames_${sign}").val();
	  	  			var thisID = tree_${sign}.getRoot().getId();
	  	  			var nodes=node.getCheckedNodes(true);

					for(var i=0;i<nodes.length;i++){
						if (i==0){
							userId=nodes[i].getId();
	  	  					userName=nodes[i].getText();
						}else{
							if(nodes[i].getId() != ""){
		  	  					userId+=";"+nodes[i].getId();
		  	  					userName+=";"+nodes[i].getText();
		  	  				}
						}
					}	
	  	  				
	  	  				/*
						if(node.isChecked()){			
							if(node.getId() != ""){//("".isNotEmpty(userId)){
		  	  					userId+=";"+node.getId();
		  	  					userName+=";"+node.getText();
		  	  				}else{
		  	  					userId=node.getId();
		  	  					userName=node.getText();
		  	  				} 				
		  	  			}else{
		  	  				var array=userId.split(";");
		  	  				deleteArrayValue(array,node.getId());
		  	  				userId=getArrayValue(array,";");
		  	  				
		  	  				array=userName.split(";");
		  	  				deleteArrayValue(array,node.getText());
		  	  				userName=getArrayValue(array,";");  				  				
		  	  			}
		  	  			*/
						$("#userIds_${sign}").val(userId);
		  	  			$("#userNames_${sign}").val(userName);	
					}
				}
				});

		   }
	});
}
</script>