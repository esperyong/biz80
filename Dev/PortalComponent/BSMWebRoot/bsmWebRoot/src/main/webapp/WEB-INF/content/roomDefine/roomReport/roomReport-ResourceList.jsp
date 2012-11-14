<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
	<table id="tableReport" name="tableReport"  class="tongji-grid table-width100 whitebg grayborder" style="border: 1px solic #ccc; overflow: scroll;">
	<tr>
		<th style="width:25%"><input type="checkbox" id="MachineRoom_Checkbox" onclick="fullChoice(this)" />标题</th>
		<th style="width:25%">指标<span class="red">*</span></th>
		<th style="width:25%">设置</th>
		<th style="width:25%">预览</th> 
	</tr>
	<tr><td colspan="4" style="padding: 0 0 0 0;width:100%">
		 <div style="width: 100%;height: 226px;overflow-y:auto; overflow-x:hidden; padding: 0 0 0 0; margin:0;">
		 	<table id="MachineRoomTable" border="0" style="width:100%" >
		 	<s:iterator  var="info" value="reportInfo"  status="stat">
				<s:if test="#stat.count>0">
					<tr id="MachineRoom_tr_<s:property value='#stat.index' />" name="MachineRoom_tr_<s:property value='#stat.index' />" style="width:100%">
					<td style="width:25%">
					    <input type="checkbox" name="reportInfoName" id="<s:property value="#stat.index" />" />
						<span id="MachineRoom_reportInfoName_<s:property value="#stat.index" />" value="<s:property value="#info.name" />" disabled=true><s:property value="#info.name" /></span>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].id" id="MachineRoom_idValue_<s:property value="#stat.index" />" value="<s:property value="#info.id" />" />
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].name" id="MachineRoom_nameValue_<s:property value="#stat.index" />"  value="<s:property value="#info.name" />"/>
						<!-- <input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].resources" id="Performance_resouresValue_<s:property value="#stat.index" />" value="<s:property value="#info.resources" />"/> -->
					</td>
					<td style="width:25%">
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].metrics" id="MachineRoom_metricValue_<s:property value="#stat.index" />"  value="<s:property value="#info.metrics" />"  />
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].order" id="MachineRoom_orderValue_<s:property value="#stat.index" />" value="<s:property value="#info.order" />"  />
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].resources" id="MachineRoom_resouresValue_<s:property value="#stat.index" />" value="<s:property value="#info.resources" />"  />
						<s:if test="#info.metricNum">			
							<span id="MachineRoom_metricNum_<s:property value="#stat.index" />" ><s:property value="#info.metricNum" />个</span>
						</s:if>
						<s:else>
							<span id="MachineRoom_metricNum_<s:property value="#stat.index" />" >-</span>												
						</s:else>						
					</td>
					<td style="width:25%">						
						<span class="black-btn-l"><span class="btn-r"><span class="btn-m"><a id="MachineRoom_a3_<s:property value="#stat.index" />" onclick="reSet(this)">设置</a></span></span></span><input type="hidden" id="MachineRoom_isLoad_<s:property value="#stat.index" />" value="false" /> 
					</td>
					<td style="width:25%">
						<span class="ico ico-select" id="MachineRoom_preview_<s:property value="#stat.index" />" onclick="preview(this)" title="预览"></span>
					</td>					
				 </tr>
				</s:if>																		
			</s:iterator>
		 	</table>
		 	<input type="hidden" id="MachineRoomTableNum" value="<s:property value="sign" />"/>
		 	<s:if test="reportInfo==null">
		 		<div class="textalign" id="MachineRoom_showAddButton" style="margin-top:80px;">
		 		<table style="width:130px;left:0px;position:relative">
		 			<tr>
		 				<td style="width:38px">
		 					<span>请点击</span>
		 				</td>
		 				<td style="width:20px">
		 					<div style="width:15px;height:15px;top:2px"><span position:relative" class="r-ico r-ico-add" title="添加" id="Performance_add" ></span></div>
		 				</td>
		 				<td style="wdith:50px">
		 					<span>按钮</span>	
		 				</td>
		 			</tr>
		 		</table>
		 		</div>
		 	</s:if>										 					 	
		 </div>
		</td>
	</tr>							
	</table>
	
	<div id="MachineRoom_reportInfo">
			<s:iterator  var="info" value="reportInfo"  status="stat">
				<s:if test="#stat.count>0">
					<div id="MachineRoom_div0_<s:property value="#stat.index" />" style="position:absolute;left:10%;top:1%;width:90%;height:90%;z-index:1000;visibility:hidden"></div>
				</s:if>
			</s:iterator>		
	</div>		
</body>
</html>

<script type="text/javascript">
		$(document).ready(function(){
			if ("<s:property value='reportInfo'/>" == '' || "<s:property value='reportInfo'/>" == null ){
				$("#MachineRoom_showAddButton").attr("style","display:display;width:100%");
			}else{
				$("#MachineRoom_showAddButton").attr("style","display:none;width:100%");
			}
			//$("#MachineRoom_tr_0").children("td:first").width(400);
			//alert($("#MachineRoom_tr_0").children("td:first").width()+"  "+$("#MachineRoom_tr_0").width());
		});
</script>