<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${ctxJs}/monitor/componentlist.js"></script>
<script type="text/javascript">var path = "${ctx}";
function coder(str) {
	var s = "";
	if (str.length == 0)
		return s;
	for (var i = 0; i < str.length; i++) {
		switch (str.substr(i, 1)) {
			case '"' :
				s += "&#34;";
				break; // 双引号 &quot;
			case '$' :
				s += "&#36;";
				break;
			case '%' :
				s += "&#37;";
				break;
			case '&' :
				s += "&#38;";
				break; // &符号 &amp;
			case '\'' :
				s += "&#39;";
				break; // 单引号
			case ',' :
				s += "&#44;";
				break;
			case ':' :
				s += "&#58;";
				break;
			case ';' :
				s += "&#59;";
				break;
			case '<' :
				s += "&#60;";
				break; // 小于 &lt;
			case '=' :
				s += "&#61;";
				break;
			case '>' :
				s += "&#62;";
				break; // 大于 &gt;
			case '@' :
				s += "&#64;";
				break; // @
			case ' ' :
				s += "&#160;";
				break; // 空格 &nbsp;
			case '?' :
				s += "&#169;";
				break; // 版权 &copy;
			case '?' :
				s += "&#174;";
				break; // 注册商标 &reg;
			default :
				s += str.substr(i, 1);
		}
	}
	return s;
};
</script> 
</head>
<body>
<s:if test="problemCompList == null || problemCompList.size() == 0">
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
<s:iterator value="problemCompList" var="compMap" status="status">
	<page:applyDecorator name="accordionAddSubPanel">
		<page:param name="id">panel_c_id_<s:property value="#status.index" /></page:param>
		<page:param name="title"><s:property value="#compMap.resourceName" />(<s:property value="#compMap.totalCount" />)</page:param>
		<page:param name="width">600px</page:param>
		<page:param name="display"><s:if test="#status.first"></s:if><s:else>collect</s:else></page:param>
		<page:param name="cls">fold-blue</page:param>
		<page:param name="content">
		<!-- content start -->
		  <div style="color:black;">
		    <page:applyDecorator name="indexgrid">
		       <page:param name="id">grid_c_id_<s:property value="#status.index" /></page:param>
		       <page:param name="width">600</page:param>
		       <page:param name="linenum">0</page:param>
		       <page:param name="tableCls">grid-blue</page:param>
		       <page:param name="gridhead">[{colId:'state', text:' '},{colId:'instanceName', text:'<s:property value="#compMap.resourceName" />名称'},{colId:'availabilityCount',text:'问题可用性指标'},{colId:'performanceCount',text:'问题性能指标'},{colId:'configurationCount',text:'问题配置指标'},{colId:'instanceId',text:'',hidden:true},{colId:'availabilityJson',text:'',hidden:true},{colId:'performanceJson',text:'',hidden:true},{colId:'configurationJson',text:'',hidden:true}]</page:param>
		       <page:param name="gridcontent"><s:property value="#compMap.gridJson" escape="false" /></page:param>
		     </page:applyDecorator>
		     <div id="pageid_<s:property value="#status.index" />"></div>
		  </div>
		<!-- content end -->
		</page:param>
	</page:applyDecorator>
	<script type="text/javascript">
	var top  = (document.documentElement.clientHeight) / 2 ; 
    var left = (document.documentElement.clientWidth) / 2 ;
	var config = {
		    width: 580,
		    columnWidth: {state:80,instanceName:140,availabilityCount:110,performanceCount:110,configurationCount:110},
		    render: [{
		        index: "instanceName",
		        fn: function(td) {
		            if (td.html != "") {
		                $name = $('<span class="span_dot" name="' + coder(td.html) + '" rowIndex="' + td.rowIndex+ '" title="' + coder(td.html) + '">'+td.html+"</span>");
		                return $name;
		            } else {
		                return null;
		            }
		        }
		    },{
		        index: "state",
		        fn: function(td) {
		            if (td.html != "") {
		                $state = $('<span style="cursor:default" class=" ' + td.html + '"name="' + td.html + '"rowIndex="' + td.rowIndex + '"></span>"');
		                return $state;
		            } else {
		                return null;
		            }
		        }
		    },
		    {
		        index: "availabilityCount",
		        fn: function(td) {
		            if (td.html == null || td.html == '-') {
		                return null;
		            }
		            //alert(td.html);
		            if (td.html == '0') {
		            	$span = $('<span style="cursor:default">' + td.html + '</span>');
		                return $span;
		            }
		            $span = $('<span style="cursor:pointer">' + td.html + '</span>');
		            var availabilityPanel = null;
		            $span.bind("click",function(event) {
		                availabilityPanel = new winPanel({
		                    type: "POST",
		                    whatTable: "问题可用性指标详细信息",
		                    tableJson : td.value.availabilityJson,
		                    widthJson : "{metricName:140,state:130,collectTime:130}",
		                    titleJson : "[{colId:'metricName', text:'指标名称'},{colId:'state', text:'确认状态'},{colId:'collectTime', text:'最近采集时间'}]",
		                    width: 500,
		                    x: left-250,
		                    y: top,
		                    isautoclose: true,
		                    closeAction: "close"
		                },
		                {
		                    winpanel_DomStruFn: "blackLayer_winpanel_DomStruFn_table"
		                });
		            });
		            return $span;
		        }
		    },
		    {
		        index: "performanceCount",
		        fn: function(td) {
		            if (td.html == null || td.html == '-') {
		                return null;
		            }
		            if (td.html == '0') {
		            	$span = $('<span style="cursor:default">' + td.html + '</span>');
		                return $span;
		            }
		            $span = $('<span style="cursor:pointer">' + td.html + '</span>');
		            var performancePanel = null;
		            $span.bind("click",function(event) {
		                performancePanel = new winPanel({
		                    type: "POST",
		                    whatTable: "问题性能指标详细信息",
		                    tableJson: td.value.performanceJson,
		                    widthJson : "{metricName:100,currentValue:100,state:100,collectTime:100}",
		                    titleJson : "[{colId:'metricName', text:'指标名称'},{colId:'currentValue', text:'当前值'},{colId:'state', text:'确认状态'},{colId:'collectTime', text:'最近采集时间'}]",
		                    width: 500,
		                    x: left-250,
		                    y: top,
		                    isautoclose: true,
		                    closeAction: "close"

		                },
		                {
		                    winpanel_DomStruFn: "blackLayer_winpanel_DomStruFn_table"
		                });
		            });
		          //  $span.bind("mouseout",function() {
		          //      if (performancePanel != null) {
		          //          performancePanel.close("close");
		          //          performancePanel = null;
		          //      }
		         //   });

		            return $span;

		        }
		    },
		    {
		        index: "configurationCount",
		        fn: function(td) {
		            if (td.html == null || td.html == '-') {
		                return null;
		            }
		            if (td.html == '0') {
		            	$span = $('<span style="cursor:default">' + td.html + '</span>');
		                return $span;
		            }
		            $span = $('<span style="cursor:pointer">' + td.html + '</span>');
		            var configurationPanel = null;
		            $span.bind("click",function(event) {
		                configurationPanel = new winPanel({
		                    type: "POST",
		                    whatTable: "问题配置指标详细信息",
		                    tableJson : td.value.configurationJson,
		                    widthJson : "{metricName:100,currentValue:100,state:100,collectTime:100}",
		                    titleJson : "[{colId:'metricName', text:'指标名称'},{colId:'currentValue', text:'当前值'},{colId:'state', text:'确认状态'},{colId:'collectTime', text:'最近采集时间'}]",
		                    width: 500,
		                    x: left-250,
		                    y: top,
		                    isautoclose: true,
		                    closeAction: "close"
		                },
		                {
		                    winpanel_DomStruFn: "blackLayer_winpanel_DomStruFn_table"
		                });
		            });
		          //  $span.bind("mouseout",function() {
		          //      if (configurationPanel != null) {
		          //          configurationPanel.close("close");
		          //          configurationPanel = null;
		          //      }
		         //   });
		            return $span;
		        }
		    }]
		};
	
	 // alert(config);
      var gp_<s:property value="#status.index" /> = createGridPanel("grid_c_id_<s:property value="#status.index" />",config);
    //  var page_<s:property value="#status.index" /> = createPagination("pageid_<s:property value="#status.index" />",url,"<s:property value="#compMap.pageCount" />",gp_<s:property value="#status.index" />);
      var panel_<s:property value="#status.index" /> = createAccordionPanel("panel_c_id_<s:property value="#status.index" />");
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