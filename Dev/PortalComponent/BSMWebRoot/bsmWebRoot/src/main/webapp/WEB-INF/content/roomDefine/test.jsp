<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/room.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/room/UnityObject.js"></script>
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript"	src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript"	src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript"	src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript"	src="${ctx}/js/component/plugins/jquery.ui.draggable.js"></script>
<script type="text/javascript"	src="${ctx}/js/component/plugins/jquery.ui.slider.js"></script>
<div>
<ul style="float:left">
<li class="" style="cursor:pointer" id="baseInfoId">基本信息</li>
<li class="normal" id="environmentInfoId">环境信息</li>
<li class="normal" id="realTimeAlarmId">实时告警</li>
<li class="normal" id="messageBoardId">留言板</li>
</ul>
</div>
<iframe name="iframeMyselfName" src="${ctx}/roomDefine/MonitorVisit!showRoom.action?roomId=room_5ABBB430-C388-5527-2F3F-F49EAD40F496" id="myselfId" frameborder="1" height="100%" width="100%"></iframe>
<script language="javascript">
var panel;
$(document).ready(function() {
	$("#baseInfoId").click(baseInfoFun);
	$("#environmentInfoId").click(environmentInfoFun);
	$("#realTimeAlarmId").click(realTimeAlarmFun);
	$("#messageBoardId").click(messageBoardFun);
});
/**
 * 基本信息.
 */
function baseInfoFun() {
	if(panel){panel.close("close");}
	panel = new winPanel({
		    title:"基本信息",
	        url:"${ctx}/roomDefine/BaseInfoVisit.action",
	        //html:"",
	        width:280,
	        height:100,
		    x:200,
		    y:10,
		    isautoclose:false,
		    isDrag:true,
	        tools:[],
	        listeners:{
	          closeAfter:function(){
		          panel = null;
		      },
		      loadAfter:function(){
		      }
	        }
	});
}
/**
 * 环境信息.
 */
function environmentInfoFun() {
	
}
/**
 * 实时告警.
 */
function realTimeAlarmFun() {
	
}
/**
 * 留言板.
 */
function messageBoardFun() {
	
}
</script>
