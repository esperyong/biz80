<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <%@ include file="/WEB-INF/common/meta.jsp" %>
	<title>设置维护信息</title>
	<link type="text/css" href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" media="screen" title="no title" charset="utf-8" />
	<link rel="stylesheet" type="text/css" href="${ctxCss}/public.css" />
	<link rel="stylesheet" type="text/css" href="${ctxCss}/UIComponent.css" />
	<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js"></script>
	<script src="${ctx}/js/jquery.validationEngine-cn.js"></script>
    <script src="${ctx}/js/jquery.validationEngine.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.core.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.widget.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.mouse.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.draggable.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/accordionPanel/accordionLeft.js"></script>
    <script type="text/javascript" src="${ctxJs}/component/accordionPanel/accordionPanel.js"></script>
    <script type="text/javascript" src="${ctxJs}/component/accordionPanel/accordionAddSubPanel.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/tabPanel/tab.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/gridPanel/grid.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/gridPanel/page.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/menu/menu.js"></script> 
	<script type="text/javascript" src="${ctxJs}/monitor/maintainsetting.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/slider/numberSlider.js"></script> 
	<script type="text/javascript" src="${ctxJs}/monitor/Util.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
	<script type="text/javascript">
       var path = "${ctx}";
       var childMap = new Map();
    </script> 
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
<page:applyDecorator name="popwindow"  title="设置维护信息">
  <page:param name="width">630px</page:param>
  <page:param name="bottomBtn_index_1">1</page:param>
  <page:param name="bottomBtn_id_1">confirm_button</page:param>
  <page:param name="bottomBtn_text_1">确定</page:param>
  <page:param name="bottomBtn_index_2">2</page:param>
  <page:param name="bottomBtn_id_2">cancel_button</page:param>
  <page:param name="bottomBtn_text_2">取消</page:param>
  <page:param name="bottomBtn_index_3">3</page:param>
  <page:param name="bottomBtn_id_3">apply_button</page:param>
  <page:param name="bottomBtn_text_3">应用</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">close_button</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="topBtn_title_1">关闭</page:param>
  <page:param name="content">
  <!-- content start -->
  <div style="padding:30px 10px 10px 10px;">
	<page:applyDecorator name="tabPanel">  
		<page:param name="id">maintaintab</page:param>
		<page:param name="cls">tab-grounp</page:param>
		<page:param name="background">#FFF</page:param>
		<page:param name="current">1</page:param> 
		<page:param name="tabHander">[{text:"常规信息",id:"tab1"},{text:"组件列表",id:"tab2"}]</page:param>
		<page:param name="content_1">
		   <div style="width:590px">
		     <s:action name="maintainSetting!commoninfo"  namespace="/monitor"  executeResult="true" ignoreContextParams="false" flush="false"> 
			     <s:param name="instanceId" value="instanceId" />
			     <s:param name="rowIndex" value="rowIndex" />
			     <s:param name="pointId" value="pointId" />
			     <s:param name="isMonitor" value="isMonitor" />
			 </s:action> 
			</div>
		</page:param>
		<page:param name="content_2">
		  <div style="width:590px;overflow:auto">
            <s:action name="maintainSetting!componentlist"  namespace="/monitor"  executeResult="true" ignoreContextParams="false" flush="false"> 
                 <s:param name="instanceId" value="instanceId" />
                 <s:param name="rowIndex" value="rowIndex" />
                 <s:param name="pointId" value="pointId" />
                 <s:param name="isMonitor" value="isMonitor" />
            </s:action>
           </div>
		</page:param>
	</page:applyDecorator>
	</div>
  <!-- content end -->
  </page:param>
</page:applyDecorator>
<script type="text/javascript">
function impactFactorCheck(tag){
    var re=/^(?:0|[1-9][0-9]?|100)$/;
    return !re.test($("#impactFactor").val());
 }
jQuery.extend(
 {
  /**
   * @see  将json字符串转换为对象
   * @param   json字符串
   * @return 返回object,array,string等对象
   */
  evalJSON : function (strJson)
  {
   return eval( "(" + strJson + ")");
  }
 });
 jQuery.extend(
 {
  /**
   * @see  将javascript数据类型转换为json字符串
   * @param 待转换对象,支持object,array,string,function,number,boolean,regexp
   * @return 返回json字符串
   */
  toJSON : function (object)
  {
   var type = typeof object;
   if ('object' == type)
   {
    if (Array == object.constructor)
     type = 'array';
    else if (RegExp == object.constructor)
     type = 'regexp';
    else
     type = 'object';
   }
      switch(type)
   {
         case 'undefined':
       case 'unknown': 
     return;
     break;
    case 'function':
       case 'boolean':
    case 'regexp':
     return object.toString();
     break;
    case 'number':
     return isFinite(object) ? object.toString() : 'null';
       break;
    case 'string':
     return '"' + object.replace(/(\\|\")/g,"\\$1").replace(/\n|\r|\t/g,
       function(){   
                 var a = arguments[0];                   
        return  (a == '\n') ? '\\n':   
                       (a == '\r') ? '\\r':   
                       (a == '\t') ? '\\t': ""  
             }) + '"';
     break;
    case 'object':
     if (object === null) return 'null';
        var results = [];
        for (var property in object) {
          var value = jQuery.toJSON(object[property]);
          if (value !== undefined)
            results.push(jQuery.toJSON(property) + ':' + value);
        }
        return '{' + results.join(',') + '}';
     break;
    case 'array':
     var results = [];
        for(var i = 0; i < object.length; i++)
     {
      var value = jQuery.toJSON(object[i]);
           if (value !== undefined) results.push(value);
     }
        return '[' + results.join(',') + ']';
     break;
      }
  }
 });
$(function() {
	$.validationEngineLanguage.allRules.instanceName = {
			  "file":"${ctx}/monitor/maintainSetting!validateInstanceName.action?instanceId="+$("#instanceId").val()+"&instanceName="+$("#instanceName").val(),
			  "alertTextLoad":"正在验证，请稍后",
			  "alertText":"<font color='red'>*</font> @@已存在。"
	}
	$("#form1").validationEngine({promptPosition:"topRight"});
	settings = {
		promptPosition:"topRight",
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false,
		failure : function() {}
	}
	$.validate = function(form){
 	$.validationEngine.onSubmitValid = true;
   	if($.validationEngine.submitValidation(form,settings) == false){
        if($.validationEngine.submitForm(form,settings) == true){
        	return false;
        }else{
        	return true;
        }
   }else{
       settings.failure && settings.failure();
       return false;
   }
	};
	$.validationEngineLanguage.allRules.impactFactor = {
       "nname":"impactFactorCheck",
       "alertText":"<font color='red'>*</font>请输出0-100之间的整数"
    }
	 $("#confirm_button").click(function() {
		 if(!$.validate($("#form1"))) {return;}
		 var allElem = childMap.arr;
		 var json = $.toJSON(allElem);
		 $("#submitJson").val(json);
		 var ajaxParam = $("#form1").serialize();
		 $.blockUI({message:$('#loading')});
		 $.ajax({type: "POST",
		       	 dataType:'json',
		       	 url:path+"/monitor/maintainSetting!save.action",
		       	 data: ajaxParam,
		       	 success: function(data, textStatus){
		       	 	          $.unblockUI();
                              var pointId = $("#pointId").val(); 
                              var isMonitor = $("#isMonitor").val(); 
		       	 	          if(pointId && pointId=="pc"){
		       	 	        	 window.opener.Monitor.Resource.right.pcList.modiColName($("#rowIndex").val(),$("#instanceName").val());
			       	 	      }else{
				       	 	     if(isMonitor != "monitor"){
				       	 	        window.opener.Monitor.Resource.right.noMonitorList.modiColName($("#rowIndex").val(),$("#instanceName").val());
					       	 	 }else{
					       	 		window.opener.Monitor.Resource.right.monitorList.modiColName($("#rowIndex").val(),$("#instanceName").val());
							     }
					       	  }
		       			      logout();
		       			  }
		       	 });
     });
       $("#apply_button").click(function(){
    	 if(!$.validate($("#form1"))) {return;}
         var allElem = childMap.arr;
		 var json = $.toJSON(allElem);
		 $("#submitJson").val(json);
		 var ajaxParam = $("#form1").serialize();
		 $.blockUI({message:$('#loading')});
		 $.ajax({type: "POST",
		       	 dataType:'json',
		       	 url:path+"/monitor/maintainSetting!save.action",
		       	 data: ajaxParam,
		       	 success: function(data, textStatus){
		       	 	         $.unblockUI();
		       	 	     var pointId = $("#pointId").val(); 
                         var isMonitor = $("#isMonitor").val(); 
	       	 	          if(pointId && pointId=="pc"){
	       	 	        	 window.opener.Monitor.Resource.right.pcList.modiColName($("#rowIndex").val(),$("#instanceName").val());
		       	 	      }else{
			       	 	     if(isMonitor != "monitor"){
			       	 	        window.opener.Monitor.Resource.right.noMonitorList.modiColName($("#rowIndex").val(),$("#instanceName").val());
				       	 	 }else{
				       	 		window.opener.Monitor.Resource.right.monitorList.modiColName($("#rowIndex").val(),$("#instanceName").val());
						     }
				       	  }
		       	      }
		       	 });
       });
});
</script>	
</body>
</html>