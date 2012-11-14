<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ include file="/WEB-INF/common/userinfo.jsp"%>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<title>告警查询</title>
<script type="text/javascript">
$(function() {
    //$.blockUI({message:$('#loading')});
    
    var path = "${ctx}";
    /*var data = function(){};
    $.ajax({
        type:"POST",
        url:path + "/notification/historyNotificationSearch.action",
        data:data,
        success:function(data){
        }
    });*/
    
    //document.location.href=path+'/notification/historyNotificationSearch.action';
                    
    //$.unblockUI();
})
</script>
</head>
<body>
<div id="search">
<s:action name="historyNotificationSearch" namespace="/notification" executeResult="true" ignoreContextParams="true" flush="false">
</s:action>
</div>
</body>
</html>