<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title><s:property value="whatOperate"/></title>
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
</head>
<body>
 <div id="loading" class="loading" style="display:none;"
               ><div class="loading-l"
                ><div class="loading-r"
                    ><div class="loading-m"
                         ><span class="loading-img">载入中，请稍候...</span 
                    ></div
                ></div
                ></div
           ></div>
<page:applyDecorator name="popwindow" >
 <page:param name="title"><s:property value="whatOperate"/></page:param>
    <page:param name="width">490px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeWindow</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="topBtn_title_1">关闭</page:param>
    <page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submitForm</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">logout</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
    <page:param name="content">
          <form id="form1" action="" method="post">
            <input type="hidden" id="resourceGroupId" name="resourceGroupId" value="<s:property value="resourceGroupId" />"/>
            <input type="hidden" id="currentUserId" name="currentUserId" value="<s:property value="currentUserId" />"/>
            <input type="hidden" id="groupName" name="groupName" value="<s:property value="resourceGroupName" />"/>
            <input type="hidden" id="currentDomainId" name="currentDomainId" value="<s:property value="currentDomainId" />"/>
            <input type="hidden" id="updateOrInsert" name="updateOrInsert" value="<s:property value="updateOrInsert" />"/>
       <ul class="fieldlist">
        <li><span class="ico ico-note-blue"></span><s:property value="whatOperate"/>，然后在资源组的设备列表中移入或移出资源组的资源。</li>
        <li><span class="field">资源组名称</span><span>：</span><input type="text" id="resourceGroupName" name="resourceGroupName" class="validate[required[资源组名称],length[0,50,资源组名称],noSpecialStr[资源组名称],ajax[resourceGroupName]]" size="30" value="<s:property value="resourceGroupName" />"/><span class="red">*</span></li>
        <li><span class="field">备注</span><span>：</span><textarea id="remark" name="remark" rows="5" cols="40" class="validate[length[0,200,备注]]"  /><s:property value="remark"/></textarea></li>
       </ul>
</form>
	</page:param>
</page:applyDecorator>
</body>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/monitor/Util.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>  
<script type="text/javascript">
var paramMapCreate = new Map();
var path = "<%=request.getContextPath()%>";
$(function() {
	$.validationEngineLanguage.allRules.resourceGroupName = {
			  "file":"${ctx}/monitor/resourceGroup!validateGroupName.action?resourceGroupName="+$("#groupName").val()+"&whatOperate="+$("#updateOrInsert").val(),
			  "alertTextLoad":"正在验证，请稍后",
			  "alertText":"* @@已存在。"
	}
	$("#form1").validationEngine({promptPosition:"centerRight"});
	settings = {
		promptPosition:"centerRight",
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false,
		failure : function() {}
	}
	$.validate = function(form) {
	    $.validationEngine.onSubmitValid = true;
	    if ($.validationEngine.submitValidation(form, settings) == false) {
	        if ($.validationEngine.submitForm(form, settings) == true) {
	            return false;
	        } else {
	            return true;
	        }
	    } else {
	        settings.failure && settings.failure();
	        return false;
	    }
	};
	$("#resourceGroupName").keydown(function(event){
	      if(event.keyCode == 13){
	        $("#remark").focus();
	      }
	}); 
    $("#submitForm").click(function(e) {
    	if(!$.validate($("#form1"))) {return;}
        var url = "";
        var whatOperate = $("#updateOrInsert").val();
        if (whatOperate == 'insert') {
            url = path + "/monitor/resourceGroup!creatResourceGroup.action";
        }
        if (whatOperate == 'update') {
            url = path + "/monitor/resourceGroup!updateResourceGroup.action";
       }
        var ajaxParam = $("#form1").serialize();
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: url,
            data: ajaxParam,
            success: function(data, textStatus) {
                parent.opener.location.href = path+"/monitor/monitorList.action?monitor=monitor&whichTree=resourceGroupTree&whichGrid=resourceGroup&currentTree=0&currentResourceTree=0&pointId=" + data.resourceGroupId;
                if (whatOperate == 'insert') {
                    parent.opener.Monitor.Resource.toast.addMessage("新增成功。");
                }
                if (whatOperate == 'update') {
                    parent.opener.Monitor.Resource.toast.addMessage("保存成功。");
                }
                logout();
            }
        });
    });
    $("#closeWindow,#logout").click(function() {
   	 logout();
   });
});
function logout() {
    window.opener = null;
    window.open("", "_self");
    window.close();
}
</script>
</html>