<!-- 设备树 equipmentTree.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<div style="height:570px;width:96%;border-style : solid;border-color : #EBEBEB;">
<s:property value="instanceTree" escape="false" />
</div>
<script type="text/javascript">
	this.tree = new  Tree({id:"instanceTree",listeners:{
           nodeClick:function(node){
		  $.blockUI({message:$('#loading')});
          var tmpArr = []; 
          var pointId = node.getValue("pointId");
          tmpArr.push("&pointId=");
          tmpArr.push(pointId);
          tmpArr.push("&currentUserId=");
          tmpArr.push(userId);
          tmpArr.push("&isAdmin=");
          tmpArr.push(isAdmin);
         //alert("pointId :"+pointId+"monitor :"+monitor+"tree:"+tree+"grid:"+grid);
        var param = tmpArr.join("");
        //alert(param);
        // alert(path+"/monitor/offlinetime-instance!updateInstanceList.action?"+param);
	 $.ajax({
			   type: "POST",
			   dataType:'html',
			   url: path+"/monitor/offlinetime-instance!updateInstanceList.action?"+param,
			   success: function(data, textStatus){
			  //alert("success!!!");
			    $("#main-right").find("*").unbind();
			    $("#main-right").html("");
			    $("#main-right").append(data);
			    $.unblockUI();
		   }
			});
             //alert(node.getValue("pointId")+"&&&&&"+node.getValue("treetype"));
           }
		}
	});
	var currNodeObj = this.tree.getNodeById("server");
	var currNodePath = currNodeObj.getPathId();
	this.tree.setCurrentNode("server"); 
	this.tree.locationNode(currNodePath); 
	</script>