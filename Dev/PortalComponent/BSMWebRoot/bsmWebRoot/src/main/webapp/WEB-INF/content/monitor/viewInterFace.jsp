<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" />
<title>指标查看接口</title>
</head>
<body>
   <div class="bold underline-gray lineheight26"><span><s:property value="instanceName"/>(<s:property value="ipAddress"/>)－指标查看接口</span></div>
       <input type="hidden" id="insId" value='<s:property value="instanceId"/>' />
	  <input type="hidden" id="currentMetric" value='<s:property value="whichMetric"/>'/>
   <div class="margin5">
        <ul>
	        <li class="left vertical-middle">
	            <input class="vertical-middle" name="whichMetric" type="radio" value='<s:property value="nicType"/>' checked="true"/><span>接口状态</span>
		        <input class="" name="whichMetric" type="radio" value='<s:property value="nicBandwidthUtil"/>' /><span>带宽利用率</span>
	            <input class="vertical-middle" name="whichMetric" type="radio" value='<s:property value="nicBroadcastRate"/>' /><span>广播包率</span>
	            <input class="" name="whichMetric" type="radio" value='<s:property value="nicDropRate"/>' /><span>丢包率</span>
	          
	       </li>
	       <li class="right padding2"><span class="vertical-middle">数量：<span id="nicCount"><s:property value="nicCount"/></span></span></li>
       </ul>
  </div>
  <div id="nicStatusDiv">
      <s:action name="resourceStateDetail!nicStatus"  namespace="/monitor"  executeResult="true" ignoreContextParams="false" flush="false"> 
			<s:param name="instanceId" value="instanceId" />
			<s:param name="whichMetric" value="whichMetric" />
	  </s:action> 
  </div>
</body>
   <script type="text/javascript">
        var nicCount = '<s:property value="nicCount"/>';
        var path = "<%=request.getContextPath()%>";
        $(function(){
        	 // var $metricArray = $("input[name='whichMetric']");//[0].attr("checked", true);
        	   //   $metricArray[0].attr("checked", true);
        	      $("input[name='whichMetric']").bind("click", function(event) {
        	      	     $("#currentMetric").val($(this).val());
    		             $.ajax({
                                  type: "POST",
                                  dataType: 'html',
                                  url: path + "/monitor/resourceStateDetail!nicStatus.action?instanceId=" + $("#insId").val()+"&whichMetric="+$(this).val(),
                                  success: function(data, textStatus) { 
                                          $("#nicStatusDiv").find("*").unbind();
                                          $("#nicStatusDiv").html("");
                                          $("#nicStatusDiv").append(data);
                                  }
                          });
    		      });
        });
   </script>
</html>