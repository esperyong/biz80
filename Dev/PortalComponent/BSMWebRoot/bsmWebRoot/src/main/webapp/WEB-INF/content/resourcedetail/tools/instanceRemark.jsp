<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.mocha.sys.util.time.DateFormatUtils"%>
<%@page import="java.util.Date"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String now = DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss");
%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ include file="/WEB-INF/common/userinfo.jsp"%>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css">
<link type="text/css" href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" media="screen" title="no title" charset="utf-8" />
<title><s:text name="detail.messageboard" /></title>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctx}/js/notification/comm.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.draggable.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#commentForm").validationEngine({
		promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	    //,failure : function() { callFailFunction()  } 
	});
});
</script>
</head>
<body>
<page:applyDecorator name="popwindow">
  <page:param name="title"><s:text name="detail.messageboard" /></page:param>
 <page:param name="width">800px;</page:param>
 <page:param name="height">500px;</page:param>
 <page:param name="topBtn_index_1">1</page:param>
 <page:param name="topBtn_id_1">win-close</page:param>
 <page:param name="topBtn_css_1">win-ico win-close</page:param>

 <page:param name="bottomBtn_index_1">1</page:param>
 <page:param name="bottomBtn_id_1">close_button</page:param>
 <page:param name="bottomBtn_text_1"><s:text name="i18n.close" /></page:param>

 <page:param name="content">
 <form name="commentForm" id="commentForm" method="post">
 
 <input type="hidden" name="instanceId" id="instanceId" value="${instanceId}"/>
 <input type="hidden" name="createTime" id="createTime" value="<%=now%>"/>
 <input type="hidden" name="userId" id="userId" value="${userId}"/>
 <div class="whitebg" style="width:785px; height: 500px; overflow-y: auto; overflow-x: hidden;" >
  <fieldset class="blue-border-nblock">
    <legend><s:text name="detail.lookupmessgae" /></legend>
    <ul id="data-ul" class="fieldlist-n">
    	<s:if test="remarkList==null || remarkList.isEmpty()">
	    	<ul id="nodata-ul" class="fieldlist-n" align="center">
	    	<li>
	    		<div class="formcontent" style="height:160px;">
				     <table style="height:160px;width:100%;">
				       <tbody>
				         <tr>
				          <td class="nodata vertical-middle" style="text-align:center;">
				            <span class="nodata-l">
				               <span class="nodata-r">
				                 <span class="nodata-m"> <span class="icon"><s:text name="i18n.nodata" /></span> </span>
				               </span>
				             </span>
				            </td>
				          </tr>
				       </tbody>
				     </table>
				   </div>
	    	</li>
	    </ul>
   		</s:if>
   		<s:else>
	    	<li>
		    	<table width="100%" border="1" class="black-grid">
					<tbody>
						<tr>
							<th width="25%"><s:text name="detail.createtime" /></th>
							<th width="35%"><s:text name="detail.subject" /></th>
							<th width="10%"><s:text name="detail.author" /></th>
							<th width="25%"><s:text name="detail.expiredate" /></th>
							<th width="5%">&nbsp;</th>
						</tr>
					</tbody>
				</table>
			</li>
			<s:iterator value="remarkList" status="stuts" id="list">
				<li id='<s:property value="#list.remarkId"/>'>
			 		<table width="100%" border="1" class="black-grid">
						<tbody>
							<tr>
								<td width="25%"><s:date name="#list.createDate" format="yyyy-MM-dd HH:mm:ss"/></td>
								<td align="left" width="35%">
									<a href="#" onclick="showComment('<s:property value="#list.createUser.name"/>', '<s:date name="#list.expiringDate" format="yyyy-MM-dd HH:mm:ss"/>', '<s:property value="#list.title"/>', '<s:property value="#list.content"/>', '<s:date name="#list.createDate" format="yyyy-MM-dd HH:mm:ss"/>', '<s:property value="#list.remarkId"/>')"><s:property value="#list.title"/></a>
								</td>
								<td align="right" width="10%">
									<s:property value="#list.createUser.name"/>
								</td>
								<td align="right" width="25%">
									<s:date name="#list.expiringDate" format="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td align="right" width="5%">
									<s:if test="#list.createUser.ID==userId">
										<span class="ico ico-delete" onclick="delComment('<s:property value="#list.remarkId"/>')" value='<s:property value="#list.remarkId"/>'/>
										</span>
									</s:if>
								</td>
							</tr>
						</tbody>
					</table>
					<hr />
			 	</li>
			</s:iterator>
		</s:else>
		<li>
			<span id="addBtn" class="gray-btn-l" style="float:right">
				<span class="btn-r">
					<span class="btn-m"><a><s:text name="i18n.add" /></a></span>
				</span>
			</span>
		</li>
     </ul>
  </fieldset>
  <fieldset id="addFields" style="display:none;" class="blue-border-nblock">
    <legend><s:text name="detail.createmessageboard" /></legend>
    <ul class="fieldlist-n">
    	<li style="display:none;">
			<span class="vertical-middle" id="remarkIdSpan">
    			<input type="text" id="remarkIdField" size="80"/>
    		</span>
    	</li>
		<li>
			<span class="field-min"><s:text name="detail.createtime" /></span><span><s:text name="i18n.colon" /></span>
				<span class="vertical-middle" id="createTimeDiv">
    			<%=now %>
    		</span>
    	</li>
    	<li>
    		<span class="field-min"><s:text name="detail.author" /></span><span><s:text name="i18n.colon" /></span>
    		<span class="vertical-middle" id="authorDiv">
    			<s:property value="userName"/>
    		</span>
    	</li>
    	<li id="addDiv">
				<span class="field-min"><s:text name="detail.subject" /></span><span><s:text name="i18n.colon" /></span>
				<span class="vertical-middle" id="createTimeDiv">
    			<input type="text" id="newTitle" size="80" class="validate[required,length[0,30]]"/>
    			<span class="red">*</span>
    		</span>
    	</li>
    	<li>
    		<span class="field-min"><s:text name="detail.keep" /></span><span><s:text name="i18n.colon" /></span>
    		<span class="vertical-middle" id="authorDiv">
    			<select id="expirePeriod">
							<option value="0"><s:text name="detail.nondelete" /></option>
							<option value="1"><s:text name="detail.oneday" /></option>
							<option value="5"><s:text name="detail.fivedays" /></option>
							<option value="10"><s:text name="detail.tendays" /></option>
							<option value="15"><s:text name="detail.fifteendays" /></option>
						</select>
    		</span>
    	</li>
    	<li id="viewDiv">
				<span class="field-min"><s:text name="detail.subject" /></span><span><s:text name="i18n.colon" /></span>
				<span class="vertical-middle" id="titleDiv"></span>
    	</li>
    	<li id="viewDiv2">
    		<span class="field-min"><s:text name="detail.expiredate" /></span><span><s:text name="i18n.colon" /></span>
    		<span class="vertical-middle" id="expireDiv"></span>
    	</li>
    	<li>
				<span class="field-min multi-line"><s:text name="detail.content" /></span><span class="multi-line">：</span>
				<span class="vertical-middle">
					<textarea id="content" cols="100" rows="4"></textarea>	
				</span>
    	</li>
    	<li class="line"></li>
    	<li>
				<span id="saveBtn" class="gray-btn-l" style="float:right;">
					<span class="btn-r">
						<span class="btn-m"><a><s:text name="i18n.save" /></a></span>
					</span>
				</span>
			</li>
     </ul>
  </fieldset>
  
</div>
</form>
 </page:param>
</page:applyDecorator>
<script>
	path = '${ctx}';
	$(function(){
		$("#addBtn").click(function(){
			$("#newTitle").val("");
			$("#content").val("");
			$("#remarkIdField").val("");
			$("#addFields").show();
			$("#addDiv").show();
			$("#viewDiv").hide();
			$("#viewDiv2").hide();
		});
		$("#saveBtn").click(function(){
			//alert($("#remarkIdField"));
			if(!$.validate( $("#commentForm") )) return;
			var data = function(){};
			data.instanceId = $("#instanceId").val();
			data.userId = getUserId();
			data.createTime = getDate();
			data.expirePeriod = $("#expirePeriod").val();
			data.title = $("#newTitle").val();
			data.content = $("#content").val();
			data.remarkId = $("#remarkIdField").val();
			
			$.ajax({
				type:"POST",
				url:path + "/detail/addinstanceremark.action",
				data:data,
				success:function(){
					window.location.reload();
				}
			});
		});
		$('#close_button').click(function(){
			window.close();
		});
	});
	function delComment(comentid){
		var data = function(){};
		data.remarkId = comentid;
		$.ajax({
			type:"POST",
			url:path + "/detail/delinstanceremark.action",
			data:data,
			success:function(){
				//$('#'+comentid).remove();
				window.location.reload();
			},
              error:function(e){
              	alert(e.responseText);
              }
		});
	}
	function showComment(author, expire, title, content, createtime, remarkId){
		$("#addFields").show();
		$("#titleDiv").html(title);
		$("#expireDiv").html(expire);
		$("#createTimeDiv").html(createtime);
		$("#remarkIdField").val(remarkId);
		$("#authorDiv").html(author);
		$("#content").val(content);
		$("#addDiv").hide();
		$("#viewDiv").show();
		$("#viewDiv2").show();
	}
	function getUserId(){
		return "<%=userId%>";
	}
	function getDate(){
		return "<%=now %>";
	}
</script>
</body>
</html>