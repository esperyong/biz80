<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ include file="/WEB-INF/common/userinfo.jsp"%>
<%@ include file="/WEB-INF/common/loading.jsp" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<head>			
		<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css" />		
		<link href="${ctxCss}/portal.css" rel="stylesheet" type="text/css" />
		<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">	
		<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">	
		<link href="${ctxCss}/validationEngine.jquery.css" type="text/css"  rel="stylesheet" media="screen" title="no title" charset="utf-8" />
		<link href="${ctxCss}/tongjifenxi.css" rel="stylesheet" type="text/css" />
		<link href="${ctxCss}/jquery-ui/treeview.css" rel="stylesheet"type="text/css">
		
		<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.core.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.widget.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.mouse.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.draggable.js"></script>
		<script type="text/javascript" src="${ctxJs}/jquery.layout-1.2.0.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/tabPanel/tab.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/menu/menu.js"></script> 
		<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/treeView/tree.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/accordionPanel/accordionLeft.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/toast/Toast.js"></script>
		<script type="text/javascript" src="${ctxJs}/jquery.blockUI.js"></script>
		<script type="text/javascript" src="${ctxJs}/jquery.validationEngine.js"></script>
		<script type="text/javascript" src="${ctxJs}/jquery.validationEngine-cn.js"></script>	
		<script type="text/javascript" src="${ctxJs}/component/gridPanel/grid.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/gridPanel/indexgrid.js"></script>		
        <script type="text/javascript" src="${ctxJs}/component/gridPanel/page.js"></script>
		<script type="text/javascript" src="${ctxJs}/component/popwindow/popwin.js"></script>
		<script type="text/javascript" src="${ctxJs}/report/statistic/statisticMetric.js"></script>
		<script type="text/javascript" src="${ctxJs}/report/statistic/statisticUtil.js"></script>		
	</head>
	<body>
		<page:applyDecorator name="popwindow" title="定制报告">
		<page:param name="width">980</page:param>
		<page:param name="topBtn_index_1">1</page:param>
		<page:param name="topBtn_id_1">customizationReportID</page:param>
		<page:param name="topBtn_css_1">win-ico win-close</page:param>
		<page:param name="topBtn_title_1">关闭</page:param>
		
		<page:param name="bottomBtn_index_1">1</page:param>
		<page:param name="bottomBtn_id_1">createCustomizationReport</page:param>
		<page:param name="bottomBtn_text_1" >确定</page:param>
	
		<page:param name="bottomBtn_index_2">2</page:param>
		<page:param name="bottomBtn_id_2">cancelCustomizationReport</page:param>
		<page:param name="bottomBtn_text_2" >取消</page:param>
	
		<page:param name="bottomBtn_index_3">3</page:param>
		<page:param name="bottomBtn_id_3">applyCustomizationReport</page:param>
		<page:param name="bottomBtn_text_3" >应用</page:param>
		<page:param name="content">	
		<form id="reportInfo" onSubmit="return false;">
		  <div style="overflow:auto;height:525px;" class=f-relative>
		   <div class="fold-blue">
			<div class="fold-top"><span class="fold-top-title">1.基本信息</span></div>			
				<input type="hidden"   id="statisticUserId" name="userId" value=""/>
				<input type="hidden"   id="statisticReportId" name="reportbasevo.id" value="<s:property value="reportbasevo.id" />"/>	
				<ul class="fieldlist-n" >
				<li><span class="field-middle">报告名称：</span> <s:textfield  name="reportbasevo.name" cssClass="validate[required[报告名称],length[0,50,报告名称],noSpecialStr[报告名称],ajax[duplicateReportName]]" value="%{reportbasevo.name}" size="50" id="showReportName" /><span class="red">*</span></li>
				<li id="statisticDatas"><span class="field-middle">报告周期：</span>
				<s:iterator var="reportPeriod" value="reportperiodArray" status="stat">
				  <s:if test="reportbasevo.reportPeriod!=null">	  
				  	<s:if test="#reportPeriod.name()==reportbasevo.reportPeriod">
						 <input type="radio" name="reportbasevo.reportPeriod"  id="<s:property value=" #reportPeriod.name() " />" value="<s:property value=" #reportPeriod.name() " />"  checked="checked"/>				    
					</s:if>
					<s:else>
						<input type="radio" name="reportbasevo.reportPeriod"  id="<s:property value=" #reportPeriod.name() " />" value="<s:property value=" #reportPeriod.name() " />"  /> 		
					</s:else>			  	
				  </s:if>
				  <s:else>
				  	<s:if test="#stat.first">
				  		<input type="radio" name="reportbasevo.reportPeriod"  id="<s:property value=" #reportPeriod.name() " />" value="<s:property value=" #reportPeriod.name() " />"  checked="checked"/>
				  	</s:if>
				  	<s:else>
						<input type="radio" name="reportbasevo.reportPeriod"  id="<s:property value=" #reportPeriod.name() " />" value="<s:property value=" #reportPeriod.name() " />" />			  	
				  	</s:else>
				  </s:else>				
				  <span><s:property value="#reportPeriod.getDesc()" /></span>			   
				</s:iterator>
				</li>
				<li id="DailyTime0" style="display:block"><span class=field-middle><span>时间范围：</span></span>
				<span>从前一天</span><select >
				<s:iterator  var="hour" value="hourofday"  status="stat">
					<s:if test="#hour.key==reportbasevo.timeRangle.split(';')[0]">
						<option selected="selected"  value="<s:property value="#hour.key" />"><s:property value="#hour.value" /></option>
					</s:if>
					<s:else>
						<option  value="<s:property value="#hour.key" />"><s:property value="#hour.value" /></option>
					</s:else>										        	    	 			
				</s:iterator>		
				</select>				
				<span>至当天</span><select id="DailyCreateSelect">
					<s:iterator  var="hour" value="hourofday"  status="stat">
						<s:if test="#hour.key==reportbasevo.timeRangle.split(';')[1]">
							<option selected="selected"  value="<s:property value="#hour.key" />"><s:property value="#hour.value" /></option>
						</s:if>
						<s:else>
							<option  value="<s:property value="#hour.key" />"><s:property value="#hour.value" /></option>
						</s:else>										        	    	 			
				    </s:iterator>				
				</select>
				</li>			
				<li id="DailyTime1" style="display:block"><span class=field-middle><span>生成时间：</span></span>
				<span>每天</span><span>生成日报</span></li>						
				
				<li id="WeeklyTime0" style="display:none"><span class=field-middle><span>时间范围：</span></span>
				<span>上周一 00:00  至周日</span></li>		
				<li id="WeeklyTime1" style="display:none"><span class=field-middle><span>生成时间：</span></span>
				<span>每周</span><select>
				<s:iterator  var="day" value="dayofweek"  status="stat">
						<s:if test="#day.key==reportbasevo.customTime">
							<option selected="selected"  value="<s:property value="#day.key" />"><s:property value="#day.value" /></option>
						</s:if>
						<s:else>
							<option  value="<s:property value="#day.key" />"><s:property value="#day.value" /></option>
						</s:else>										        	    	 			
				    </s:iterator>
				</select><span>生成周报</span></li>			
				
				<li id="MonthlyTime0" style="display:none"><span class=field-middle><span>时间范围：</span></span>
				<span>上月1号 00:00  至最后一天</span></li>		
				<li id="MonthlyTime1" style="display:none"><span class=field-middle><span>生成时间：</span></span>
				<span>每月</span><select>
				<s:iterator  var="day" value="dayofmonth"  status="stat">
						<s:if test="#day.key==reportbasevo.customTime">
							<option selected="selected"  value="<s:property value="#day.key" />"><s:property value="#day.value" /></option>
						</s:if>
						<s:else>
							<option  value="<s:property value="#day.key" />"><s:property value="#day.value" /></option>
						</s:else>										        	    	 			
				    </s:iterator>
				</select><span>生成月报</span></li>											
				<input type="hidden"    id="statisticReportTimeRange" name="reportbasevo.timeRangle" value="<s:property value="reportbasevo.timeRangle" />"/>
				<input type="hidden"    id="statisticReportCustomTime" name="reportbasevo.customTime" value="<s:property value="reportbasevo.customTime" />"/>										
			 </ul>
			 <ul class="fieldlist-n"><li class="line"> </li></ul>
			<ul class="fieldlist-n">
				<li><span class="field-middle">共享报告：</span>
				<s:if test="reportbasevo.reportShared=='true'"> 
					<input type="radio" name="reportbasevo.reportShared" value="true" checked="checked"/> <span>是</span> 
					<input type="radio" name="reportbasevo.reportShared"  value="false"/> <span>否 </span>
				</s:if>
				<s:else>
					<input type="radio" name="reportbasevo.reportShared" value="true" /> <span>是</span> 
					<input type="radio" name="reportbasevo.reportShared"  value="false" checked="checked"/> <span>否 </span>
				</s:else>					
				</li>
				<li ><span class="field-middle">共享范围：</span><span></span> 
				<s:if test="reportbasevo.reportShared=='true'">
				    <s:iterator  var="shareDomainId" value="shareDomainIds"  status="stat">
				        <s:if test="#shareDomainId.value.split(',')[1]=='true'">
				        	<input type="checkbox" name="reportbasevo.reportDomainIds" checked="checked"  value="<s:property value="#shareDomainId.key" />" /> <span><s:property value="#shareDomainId.value.split(',')[0]" /></span>
				        </s:if>
				        <s:else>
				        	<input type="checkbox" name="reportbasevo.reportDomainIds"  value="<s:property value="#shareDomainId.key" />" /> <span><s:property value="#shareDomainId.value.split(',')[0]" /></span>
				        </s:else>		    	 			
				    </s:iterator>				
				</s:if>
				<s:else>
					<s:iterator  var="domainId" value="domainIds"  status="stat">
				        <input type="checkbox" name="reportbasevo.reportDomainIds" disabled=true checked="checked"  value="<s:property value="#domainId.key" />" /> <span><s:property value="#domainId.value" /></span>		    	 			
				    </s:iterator>
				</s:else>						
				</li>
			</ul>
			</div>										
			    <div class="fold-blue">
				  <div class="fold-top"><span class="fold-top-title">2.选择报告类型</span><span class="red">*</span>		    
					    <select id="choiceReportTypeSelect" >
						<s:iterator  var="type" value="reportTypeArray"  status="stat">
							<s:if test="reportbasevo.reportType!=null">
								<s:if test="#type.name()==reportbasevo.reportType">
									<option selected="selected"  value="<s:property value="#type.name()" />"><s:property value="#type.getDesc()" /></option>	
								</s:if>
								<s:else>
									<option  value="<s:property value="#type.name()" />"><s:property value="#type.getDesc()" /></option>
								</s:else>
							</s:if>
							<s:else>
								<option  value="<s:property value="#type.name()" />"><s:property value="#type.getDesc()" /></option>
							</s:else>													
						</s:iterator>
						</select>
						<s:if test="reportbasevo.reportType!=null">
							<input id="statisticReportType" type="hidden" name="reportbasevo.reportType" value="<s:property value="reportbasevo.reportType" />"/>
						</s:if>
						<s:else>
							<input  id="statisticReportType" type="hidden" name="reportbasevo.reportType" value="<s:property value="reportTypeArray[0]" />"/>
						</s:else>	
					    <span class="ico ico-add" title="添加" id="addReportInfo"></span>
					    <span class="ico ico-delete" title="删除" id="deteleReport" onclick="deteleTableRow()"></span>
				 		<input type="hidden" id="isShowTr" value="true">
				  </div><div id="report">				  
			  	  <s:if test="reportbasevo.reportType=='MachineRoom'">
						<s:action name="RoomReportListVisit" namespace="/roomDefine"  executeResult="true" flush="false">
			       	 		<s:param name="reportID" ><s:property value="reportbasevo.id" /></s:param>
			       	 		<s:param name="reportType" >MachineRoom</s:param>			    
			       		</s:action>	
				  </s:if>
				  <s:elseif test="reportbasevo.reportType=='BusinessServices'">
				  		<s:action name="" namespace="/bizsmweb/bizsm/bizservice/ui/bizsm-report"  executeResult="true" flush="false">			    
			       		</s:action>
				  </s:elseif>
				  <s:else>
				  		<s:action name="statisticOper!loadReportInfo" namespace="/report/statistic"  executeResult="true" flush="false">
			       	 		<s:param name="reportID" ><s:property value="reportbasevo.id" /></s:param>
			       	 		<s:param name="reportType" ><s:property value="reportbasevo.reportType" /></s:param>			       	 				    
			       		</s:action>	
				  </s:else>			  	   		  	 	
			  	  </div>			  	  		  
			    </div>										
			</div>	
			</form>
	</page:param>
	</page:applyDecorator>	
	</body>
	<script  type="text/javascript">	
	var toast = new Toast({position:{top:250,left:300}}); 
	var popInfo = new information();
	popInfo.offset({top:'200px',left:'300px'});
	var popCon=new confirm_box(); 
	popCon.offset({top:'200px',left:'300px'});	
	var path = '${ctx}';
	var previewData="";
	var previewType="";	
	$(function(){				
		if(objValue.isNotEmpty($("#statisticReportId").val())){//判断是否为编辑
			showPeriodTime($("input[name$='reportbasevo.reportPeriod']:checked").val());//展示报告周期时间
			$("#choiceReportTypeSelect").attr("disabled",true);//报告类型不可编辑
			cacheObj.setReportType($("#statisticReportType").val());//记录报告类型
			cacheObj.setIsCreate(false);//编辑
		}else{
			cacheObj.setIsCreate(true);//新建
		}		
		$("#statisticUserId").val(userId);//获取登录用户
		$("#reportInfo").validationEngine();
		init();	
	});	
	$("input[name$='reportbasevo.reportPeriod']").click(function(){//显示不同报告周期 		
		showPeriodTime($(this).val());
	});
	$("input[name$='reportbasevo.reportShared']").click(function(){//报表共享 
		reportShare(this);
	});		
	$("#choiceReportTypeSelect").change(function(){//报告类型下拉列表
		var flag=false;
		$("input[name$='reportInfoName']").each(function(i){
			var name=$("#"+cacheObj.getReportType()+"_nameValue_"+this.id).val();
			if(objValue.isNotEmpty(name)){
				flag=true;
			}
		});
		if(flag){
			popCon.setContentText("切换报告类型后，已添加的内容将被清空，是否继续？"); //也可以在使用的
			popCon.show();
			popCon.setConfirm_listener(function(){
				popCon.hide();
				$.blockUI({message:$('#loading')});
				var reportType=$("#choiceReportTypeSelect").val();
				if(reportType=="MachineRoom"){
					$("#report").load("${ctx}/roomDefine/RoomReportListVisit.action",function(){$.unblockUI();});
				}else if(reportType=="BusinessServices"){
					$("#report").load("/bizsmweb/bizsm/bizservice/ui/bizsm-report",function(){$.unblockUI();});
				}else{
					$("#report").load("${ctx}/report/statistic/statisticOper!loadReportInfo.action","reportType="+reportType,function(){$.unblockUI();})
				}						
				$("#statisticReportType").val($("#choiceReportTypeSelect").val());//保存报告类型
				cacheObj.setReportType($("#choiceReportTypeSelect").val());				
				$("#isShowTr").val("true");
				cacheObj.init();
			});
			popCon.setCancle_listener(function(){
				popCon.hide();
				$("#choiceReportTypeSelect").val(cacheObj.getReportType());//保存报告类型
			});
		}else{
			$.blockUI({message:$('#loading')});
			var reportType=$("#choiceReportTypeSelect").val();
			if(reportType=="MachineRoom"){
				$("#report").load("${ctx}/roomDefine/RoomReportListVisit.action",function(){$.unblockUI();});
			}else if(reportType=="BusinessServices"){
				$("#report").load("/bizsmweb/bizsm/bizservice/ui/bizsm-report",function(){$.unblockUI();});
			}else{
				$("#report").load("${ctx}/report/statistic/statisticOper!loadReportInfo.action","reportType="+reportType,function(){$.unblockUI();})
			}					
			$("#statisticReportType").val($("#choiceReportTypeSelect").val());//保存报告类型
			cacheObj.setReportType($("#choiceReportTypeSelect").val());				
			$("#isShowTr").val("true");
			cacheObj.init();
		}
		init();
	});	
	$("#addReportInfo").click(function() {//添加报告
		var reportType=$("#choiceReportTypeSelect").val();
		if(reportType=="BusinessServices"){
			$("#BusinessServices_div0_BusinessServices").css("visibility","visible");
			$("#bizServiceTree input:checked").attr("checked",false);
		}else{
			addReportInfo();	
		}				
	});	
	$("#createCustomizationReport").click(function() {//确定 		
		 if(submitReport()){
			 dialogArguments.refresh();//刷新树和报告	
			 closeWindow();
		 }
	});	
	$("#applyCustomizationReport").click(function() {//应用   	
		 if(submitReport()){
			 cacheObj.setIsCreate(false);
			 toast.addMessage("保存成功");
		 }	
	});	
	$("#cancelCustomizationReport").click(function() {//取消
		dialogArguments.refresh();//刷新树和报告	
		closeWindow();
	});	
	$("#customizationReportID").click(function() {//关闭
		dialogArguments.refresh();//刷新树和报告	
		closeWindow();
	});		
	function submitReport(){//定制报告的确定和应用					
		printTimeRange();//时间段
		getCustomTime();//定制时间
		var flag=$("input[name$='reportbasevo.reportShared']:checked").val();
		if(flag=="true"){
			var filedValue;
			$("input[name$='reportbasevo.reportDomainIds']:checked").each(function(i){
				filedValue+=$(this).val()+";";
			});
			if(!objValue.isNotEmpty(filedValue)){
				popInfo.setContentText("共享域没有选择！");
				popInfo.show();
				return false;										
			}
			if(cacheObj.getReportType()=="Performance"||cacheObj.getReportType()=="Malfunction"){
				var show=true;
				var name="";
				$("#"+cacheObj.getReportType()+"Table input[name$='reportInfoName']").each(function(i){
					if(!$("#"+cacheObj.getReportType()+"_show1_"+this.id).attr("checked")
							&&!$("#"+cacheObj.getReportType()+"_show2_"+this.id).attr("checked")){
						name+=$("#"+cacheObj.getReportType()+"_nameValue_"+this.id).val()+"   ";
						show=false;
					}			
				});
				if(!show){
					popInfo.setContentText(name+" 中没有选择显示的报告内容！");
					popInfo.show();
					return false;
				}
			}
		}		
		var isExist=false;
		$("#"+cacheObj.getReportType()+"Table input[name$='reportInfoName']").each(function(i){
			isExist=true;
		});	
		if(isExist){
			var url=path+"/report/statistic/statisticOper!editCustomReport.action";//编辑
			if(cacheObj.getIsCreate()){//新建
				url=path+"/report/statistic/statisticOper!createCustomReport.action";
			}
			var ajaxParam=$("#reportInfo").serialize();	
			var flag=submitFrom(url,ajaxParam);
			if(flag){				
				return true;
			}
		}else{
			popInfo.setContentText("请添加报告内容");
			popInfo.show();
			return false;
		}	
	}	
	function reSet(obj){//设置 
		cacheObj.setRowID(getDivID(obj));
		var flag=$("#"+cacheObj.getReportType()+"_isLoad_"+cacheObj.getRowID()).val();
		if(flag=="false"){ 	
			showDiv(cacheObj.getReportType()+"_div0_"+cacheObj.getRowID());					
			if(cacheObj.getReportType()=="MachineRoom"){
				var resouresValue=$("#"+cacheObj.getReportType()+"_resouresValue_"+cacheObj.getRowID()).val();
				var metricValue=$("#"+cacheObj.getReportType()+"_metricValue_"+cacheObj.getRowID()).val();
				$("#"+cacheObj.getReportType()+"_div0_"+cacheObj.getRowID()).load("${ctx}/roomDefine/reportDingzhi.action?sign="+cacheObj.getRowID()+"&resources="+resouresValue+"&metrics="+metricValue,function(){$.unblockUI();});
			}else{
				loadPage("${ctx}/report/statistic/statisticOper!loadAddReportInfo.action?sign="+cacheObj.getRowID()+"&reportType="+cacheObj.getReportType(),cacheObj.getReportType()+"_div0_"+cacheObj.getRowID());
			}	
			$("#"+cacheObj.getReportType()+"_isLoad_"+cacheObj.getRowID()).val("true");
		}else{		
			showDiv(cacheObj.getReportType()+"_div0_"+cacheObj.getRowID());		
		}
		cacheObj.setDivID(cacheObj.getReportType()+"_div0_"+cacheObj.getRowID());
	}	
	function preview(obj){//预览
		if(!$.validate($("#reportInfo"))){
			return false;
		}
		previewData=$("#reportInfo").serialize();
		previewType=cacheObj.getReportType();
		popWindow("${ctx}/report/statistic/statisticOper!loadPreview.action",1024, 768);		
	}
	function init(){
		$.validationEngineLanguage.allRules.duplicateReportName = {
				  "file":path + "/report/statistic/statisticVal!duplicateReportName.action?userId="+userId+"&reportType="+$("#choiceReportTypeSelect").val()+"&reportId="+$("#statisticReportId").val(),
				  "alertTextLoad":"* 正在验证，请等待",
				  "alertText":"* 报告重名,请重新命名!"
		}	
	}
	</script>
