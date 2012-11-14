<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<s:if test="nicList == null || nicList.size() == 0">
	<div class="grid-black" style="height:250px;">
	  <div class="formcontent" style="height:250px;">
	    <table style="height:250px;width:100%;">
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
<div class="bluekuang">
        <ul id="jikoustate" class="jikoustate">
            <s:iterator value="nicList" var="ifMap" status="status">
                  <s:if test="#status.first">
                            <li id='<s:property value="#ifMap.instanceId" />' name='<s:property value="#ifMap.name" />' class="on">
                                 <span class='<s:property value="#ifMap.state"/>' title='<s:property value="#ifMap.name"/>' isMonitor='<s:property value="#ifMap.isMonitor"/>'></span>
                            </li>
                  </s:if>
                  <s:else>
                            <li id='<s:property value="#ifMap.instanceId" />' name='<s:property value="#ifMap.name" />'>
                                 <span class='<s:property value="#ifMap.state"/>' title='<s:property value="#ifMap.name"/>' isMonitor='<s:property value="#ifMap.isMonitor"/>'></span>
                            </li>
                  </s:else>
                
            </s:iterator>
       </ul>
</div>
<div>
        <ul class="fieldlist-n">
             <li>
				<span class="field-middle bold">接口名称：</span>
				<span id="name" style="" class=""><s:property value="instanceName"/></span>
			 </li>
			 <li>
				<span class="field-middle bold">接口类型：</span>
				<span id="type" style="" class=""><s:property value="instanceType"/></span>
			 </li>
			    <s:if test="whichMetric != 'NICType'">
			       <li>
				      <span class="field-middle bold">当前值：</span>
				      <span id="currentValue" style="" class=""></span>
			       </li>
			    </s:if>
			 <li>
				<span class="field-middle bold">采集时间：</span>
				<span id="collectTime" style="" class=""><s:property value="collectTime"/></span>
			 </li>
        </ul>
 </div>
 </s:else>
   <script type="text/javascript">
        var nicCount = '<s:property value="nicCount"/>';
        var currentValue = '<s:property value="currentValue"/>';
        if( !currentValue || currentValue == null || currentValue == 'null' || currentValue == '0' ){
        	currentValue = 0;
        }
        var unit = '<s:property value="unit"/>';
        var redValue = '<s:property value="redValue"/>';
        var yellowValue = '<s:property value="yellowValue"/>';
        var isMonitor = '<s:property value="isMonitor"/>';
        var path = "<%=request.getContextPath()%>";
        $(function(){
            var $nicCount = $("#nicCount");
            var threshold = '（黄色阈值 '+yellowValue+unit+'；红色阈值 '+redValue+unit+'）';
            if( $nicCount[0] ){
               $nicCount.html(nicCount);
            } else {
               $nicCount.html(0);
            }
            if( isMonitor && isMonitor == "unmonitor"){
            	$("#currentValue").html("<span>"+"-"+"</span>");
            }else{
            	if( currentValue > redValue ){
                	$("#currentValue").html("<span style=\"color:red\">"+currentValue+unit+"</span>"+threshold);
                }else{
                    if( currentValue > yellowValue ){
                    	$("#currentValue").html("<span style=\"color:#FFD700\">"+currentValue+unit+"</span>"+threshold);
                    }else{
                        $("#currentValue").html("<span style=\"color:#1dc817\">"+currentValue+unit+"</span>"+threshold);
                    }
                }
            }
            $("#jikoustate li").bind("click", function(event) {
                 if($("on")){
	    	        $(".on").removeClass("on");
	    	     }
	    	     $(this).addClass("on");
	    	     $("#name").html($(this).attr("name"));
	    	   //  var $whichMetric = null;
	    	    // $("input[name='whichMetric']").each(function() {
    		    //         if ($(this).attr("checked") == true) {
    		   //                $whichMetric = $(this).attr("value");
    		   //          }
    		   //  });
    		   
    		   	      $.ajax({
                              type: "POST",
                               dataType:'json',
                              url: path +"/monitor/resourceStateDetail!nicInfo.action?nicId="+$(this).attr("id")+"&whichMetric="+$("#currentMetric").val(),
                              success: function(data, textStatus) {
                                  var currentValue = data.currentValue;
                                  if( !currentValue || currentValue == null || currentValue == 'null' || currentValue == '0' ){
                                	  currentValue = 0;
                                  }
                                  if(data.isMonitor && data.isMonitor == "unmonitor"){
                                	  $("#currentValue").html("<span>"+"-"+"</span>");
                                  }else{
                                	  var threshold = '（黄色阈值 '+data.yellowValue+data.unit+'；红色阈值 '+data.redValue+data.unit+'）';
                                      if( currentValue > data.redValue ){
                	                      $("#currentValue").html("<span style=\"color:red\">"+currentValue+data.unit+"</span>"+threshold);
                                      }else{
                                          if( currentValue > data.yellowValue ){
                    	                      $("#currentValue").html("<span style=\"color:#FFD700\">"+currentValue+data.unit+"</span>"+threshold);
                                          }else{
                                              $("#currentValue").html("<span style=\"color:#1dc817\">"+currentValue+data.unit+"</span>"+threshold);
                                          }
                                      }
                                  }
                                  $("#type").html(data.instanceType);
                                  $("#collectTime").html(data.collectTime);
                              }
                      });
    		   
            });
        });
   </script>