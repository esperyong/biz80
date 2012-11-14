<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ include file="/WEB-INF/common/userinfo.jsp"%>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<title>告警评注</title>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctx}/js/notification/comm.js"></script>
</head>
<body onload="setBodyHeight();">
<page:applyDecorator name="popwindow"  title="告警评注">
 <page:param name="width">600px;</page:param>
 <page:param name="topBtn_index_1">1</page:param>
 <page:param name="topBtn_id_1">win-close</page:param>
 <page:param name="topBtn_css_1">win-ico win-close</page:param>
 <page:param name="topBtn_title_1">关闭</page:param>

 

 <page:param name="content">
 <form name="commentForm" id="commentForm" method="post">
 <input type="hidden" name="ids" id="ids" value="${ids}"/>
 <input type="hidden" name="createUser" id="createUser"/>
 <input type="hidden" name="createTime" id="createTime"/>
 <input type="hidden" name="isActivity" id="isActivity" value="${isActivity}"/>

 <div class="whitebg" style="width:585px;" id="contentDiv">
  <fieldset class="blue-border-nblock">
    <legend>查看评注</legend>
    <ul class="fieldlist-n">
		 <s:iterator value="ntfcommentList" status="stuts" id="list">
		 	<li id='<s:property value="#list.remarkId"/>'>
		 		<s:property value="#list.remark"/><br/>
		 		<table width="100%" border="0">
					<tbody><tr>
						<td width="50%">&nbsp;</td>
						<td align="left" width="20%">
							<s:property value="#list.createUser"/>
						</td>
						<td align="right" width="25%">
							<s:property value="#list.createTime"/>
						</td>
						<td align="right" width="5%">
							<s:if test="#list.createUser==createUser && isActivity=='true'">
							<span class="ico ico-delete" title="删除" onclick="delComment('<s:property value="#list.remarkId"/>')" value='<s:property value="#list.remarkId"/>'/>
							</span>
							</s:if>
							&nbsp;
						</td>
					</tr>
					</tbody>
				</table>
				<hr />
		 	</li>
		 </s:iterator>
     </ul>
  </fieldset>
  <s:if test="isActivity=='true'">
  <fieldset class="blue-border-nblock">
    <legend>添加评注</legend>
    <ul class="fieldlist-n">
		<textarea id="content" name="content" cols="90" rows="4"></textarea>
		<span id="addBtn" class="gray-btn-l">
			<span class="btn-r">
				<span class="btn-m"><a>添加</a></span>
			</span>
		</span>
     </ul>
  </fieldset>
  </s:if>
</div>
</form>
 </page:param>
</page:applyDecorator>
<script>
	path = '${ctx}';
	$(function(){
		$("#addBtn").click(function(){
			$("#createUser").val(getUserId());
			$("#createTime").val(getDate());
			var data = function(){};
			data.createUser = getUserId();
			data.createTime = getDate();
			data.ids = $("#ids").val();
			data.isActivity = $("#isActivity").val();
			data.content = $("#content").val();
			$.ajax({
				type:"POST",
				url:path + "/notification/addNotificationComment.action",
				data:data,
				success:function(){
					doSubmit($("#commentForm"), path+"/notification/seeNotificationComment.action");
				}
			});
		});
		$('#close_button').click(function(){
			window.close();
		})
	});
	function delComment(comentid){
		var data = function(){};
			data.ids = $("#ids").val();
			data.isActivity = $("#isActivity").val();
			data.remarkId = comentid;
			$.ajax({
				type:"POST",
				url:path + "/notification/deleteNotificationComment.action",
				data:data,
				success:function(){
					$('#'+comentid).remove();
				},
	              error:function(e){
	              	alert(e.responseText);
	              }
			});
	}
	function getUserId(){
		return userId;
	}
	function getDate(){
		var now = new Date();
		var year = now.getFullYear();
		var month=now.getMonth()+1;
		var day=now.getDate();
    	var hour=now.getHours();
   		var minute=now.getMinutes();
    	var second=now.getSeconds();
    	var nowdate=year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
    	return nowdate;
	}
	function doSubmit(formObj, actionUrl) {
		formObj.attr("action", actionUrl);
		formObj.submit();
	}
    function setBodyHeight(){
        var pageObj = document.getElementById("contentDiv");
        var pHeight = pageObj.offsetHeight + 97;
        if(pHeight > 535){
            pHeight = 535;
        }
        window.resizeTo(633, pHeight);
        window.moveTo((screen.width - 800)/2, (screen.height - pHeight)/2); 
    }
</script>
</body>
</html>