<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${ctxJs}/monitor/componentlist.js"></script>
<script type="text/javascript">var path = "${ctx}";</script> 
</head>
<body>
<s:if test="problemMetricList == null || problemMetricList.size() == 0">
	<div class="grid-black" style="height:350px;">
	  <div class="formcontent" style="height:350px;">
	    <table style="height:350px;width:100%;">
	      <tbody>
	        <tr>
	         <td class="nodata vertical-middle" style="text-align:center;">
	           <span class="nodata-l">
	              <span class="nodata-r">
	                <span class="nodata-m"> <span class="icon">当前无数据</span> </span>
	              </span>
	            </span>
            </td>
          </tr>
	      </tbody>
	    </table>
	  </div>
	</div>
</s:if>
<s:else>  
<s:iterator value="problemMetricList" var="metricMap" status="status">
	<page:applyDecorator name="accordionAddSubPanel">
		<page:param name="id">panelid_<s:property value="#status.index" /></page:param>
		<page:param name="title"><s:property value="#metricMap.title" />(<s:property value="#metricMap.totalCount" />)</page:param>
		<page:param name="width">600px</page:param>
		<page:param name="display"><s:if test="#status.first"></s:if><s:else>collect</s:else></page:param>
		<page:param name="cls">fold-blue</page:param>
		<page:param name="content">
		<!-- content start -->
		  <div style="color:black;">
		    <page:applyDecorator name="indexgrid">
		       <page:param name="id">gridid_<s:property value="#status.index" /></page:param>
		       <page:param name="width">600</page:param>
		       <page:param name="linenum">0</page:param>
		       <page:param name="tableCls">grid-blue</page:param>
		       <page:param name="gridhead"><s:property value="#metricMap.titleJson" escape="false" /></page:param>
		       <page:param name="gridcontent"><s:property value="#metricMap.gridJson" escape="false" /></page:param>
		     </page:applyDecorator>
		     <div id="pageid_<s:property value="#status.index" />"></div>
		  </div>
		<!-- content end -->
		</page:param>
	</page:applyDecorator>
	<script type="text/javascript">
	  var config = {
			  width:580,
			  columnWidth:<s:property value="#metricMap.widthJson" escape="false" />,
	          render:[
	    	{
	     	    index: "currentValue",
	     	    fn: function(td) {
	     	    	var currentValue = td.html;
	     	    	var unit = td.value.unit;
	     	    	var redValue = td.value.redValue;
	     	    	var yellowValue = td.value.yellowValue;
	     	    	var state = td.value.hidState;
	     	    	//var gRed = "（>红色阈值";
		     	  //  var lRed = "（<红色阈值";
		     	   // var gYel = "（>黄色阈值";
		     	  //  var lYel = "（<黄色阈值";
	     	        if(currentValue == ""){
	     	           return "-";
			     	}
	     	        if(currentValue == "-"){
	     	           return "-";
			     	}
	     	        if(!unit || unit =="" || unit =="-"){
	     	           $state = $('<span title="'+currentValue+'">' + currentValue + '</span>');
	     	           return $state;
			     	}
	     	        if(redValue == "-" || redValue == ""){
	     	           redValue = "";
			     	}
	     	        if(yellowValue == "-" || yellowValue =="" ){
	     	           yellowValue = "";
			     	}
	     	        
			       var tmp= false;
	     	       if( yellowValue != "" && redValue != "" ){
		     	       if(Number(yellowValue) > Number(redValue)){
		     	    	  tmp = true;
				       }
		     	   }
	     	        if(!tmp && redValue!="" && "lamp lamp-lingred" == state){
                       $state = $('<span class="span_dot_long" title="'+currentValue+unit+'（>红色阈值'+redValue+unit+'）'+ '">'+currentValue+unit+'（>红色阈值'+redValue+unit+'）'+'</span>');
		     	       return $state;
			     	}
	     	        if(tmp && redValue!="" && "lamp lamp-lingred" == state){
	     	        	   $state = $('<span class="span_dot_long" title="'+currentValue+unit+'（<红色阈值'+redValue+unit+'）'+ '">'+currentValue+unit+'（<红色阈值'+redValue+unit+'）'+'</span>');
			     	       return $state;
				     	}
		     	    if(!tmp && yellowValue !="" && "lamp lamp-lingyellow" == state){
		     	       $state = $('<span class="span_dot_long" title="'+currentValue+unit+'（>黄色阈值'+redValue+unit+'）'+ '">'+currentValue+unit+'（>黄色阈值'+redValue+unit+'）'+'</span>');
		     	       return $state;
			     	}
		     	   if(tmp && yellowValue !="" && "lamp lamp-lingyellow" == state){
		     		   $state = $('<span class="span_dot_long" title="'+currentValue+unit+'（<黄色阈值'+redValue+unit+'）'+ '">'+currentValue+unit+'（<黄色阈值'+redValue+unit+'）'+'</span>');
		     	       return $state;
			     	}
			     	$state = $('<span class="span_dot_long">'+currentValue+unit+'</span>');
		     	    return $state;
	     	    }
	     	},
	    	{
	     	    index: "state",
	     	    fn: function(td) {
	     	        if (td.html != "") {
	     	        	 $state = $('<span style="cursor:default" class=" ' + td.html+ '"name="' + td.html + '"rowIndex="' + td.rowIndex + '"></span>"');
	     	        	return $state;
	     	        } else {
	     	            return null;
	     	        }
	     	    }
	     	},
	     	{
	     	    index: "operate",
	     	    fn: function(td) { 
	     	        if(td.value.whichMetric == 'PerformanceMetric' || td.value.whichMetric == 'ConfigurationMetric'){
	     	        	 if(td.value.hidState){
	 	     	        	if("lamp lamp-linggrey" != td.value.hidState){
	                             return "-";
	 			     	    }
	 		     	    }
			     	}
	     	       if(td.value.whichMetric == 'AvailabilityMetric'){
	     	        	 if(td.value.hidState){
	 	     	        	if("lamp lamp-linggrey" != td.value.hidState && "lamp lamp-lingred" != td.value.hidState){
	                             return "-";
	 			     	    }
	 		     	    }
			     	}
	     	        if (td.html != "") {
	     	        	$font = $('<span><span class="gray-btn-l"><span class="btn-r"><span class="btn-m"><a>诊断</a></span></span></span>');
	     	        	$font.bind('click',function(e) {
	     	        		  var url = path + "/discovery/resource-instance-diagnose!diagnose.action?instanceId=" + td.value.instanceId; 
	     	                  winOpen({url:url,width:710,height:510,scrollable:true,name:'detailDiagnose'});
		     	        });
	     	            return $font;
	     	        }
	     	    }
	     	}
	    ]
			  };
	  
	 // alert(config);
      var gp_<s:property value="#status.index" /> = createGridPanel("gridid_<s:property value="#status.index" />",config);
    //  var page_<s:property value="#status.index" /> = createPagination("pageid_<s:property value="#status.index" />",url,"<s:property value="#compMap.pageCount" />",gp_<s:property value="#status.index" />);
      var panel_<s:property value="#status.index" /> = createAccordionPanel("panelid_<s:property value="#status.index" />");
    //  items["<s:property value="#compMap.index" />"] = {
    //	    gridPanel : gp_<s:property value="#status.index" />,
      //    pagination : page_<s:property value="#status.index" />,
     //     accordionPanel : panel_<s:property value="#status.index" />
   //   };
    </script>
    </s:iterator>
    </s:else>
</body>
</html>