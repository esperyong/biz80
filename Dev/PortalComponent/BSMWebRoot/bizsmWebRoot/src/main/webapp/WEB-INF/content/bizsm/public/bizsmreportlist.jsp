<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<style type="text/css">	.selectedTr{background:gray;color:white}
</style>
<script src="${ctx}/js/component/treeView/MTree.js" type="text/javascript"></script>
<script type="text/javascript">

	$(function(){
		//初始化业务服务Tree
		var bizServiceTree = new MTree("${ctx}/images/tree-img/mtree");
		bizServiceTree.setTreeName("BizServiceTree01");
		//执行AJAX请求,获取当前所有定义的业务服务列表.
		$.get('${ctx}/bizservice/.xml',{},function(data){
			var $serviceNodes = $(data).find('BizServices:first>BizService');//.not('[reference]');
			if($serviceNodes.size() == 0){
				bizServiceTree.addNode(new MTreeNode("root","0","","","","<a>没有服务</a>","","","","","",""));
			}else{
				bizServiceTree.addNode(new MTreeNode("root","0","","","","<a>服务</a>","","checkbox","bizService_reportInfoNameAllID","bizService_reportInfoNameAllName","",""));
			}

			$serviceNodes.each(function(i){
				var $thisService = $(this);
				var bizServiceID = $thisService.find('>bizId').text();
				var bizServiceName = $thisService.find('>name').text();
				var runStateStr = $thisService.find('>monitered').text();
				if(runStateStr == null || runStateStr == ""){
					runStateStr = false;
				}

				bizServiceTree.addNode(new MTreeNode(bizServiceID,"root","","","","<a resId="+bizServiceID+" value="+bizServiceName+" style=\"cursor:default;display:inline;overflow-x:hidden;width:250px;text-overflow:ellipsis\" title="+bizServiceName+">"+bizServiceName+"</a>","","checkbox","bizService_reportInfoNameID","bizService_reportInfoNameName",bizServiceID, ""));
			});


			var bizServiceTreeHtml = bizServiceTree.getTreeHtml();
			//alert(bizServiceTreeHtml);
			//$("#bizServiceTree").html("<A id='BizServiceTree-1_RootLink' href='#' style='DISPLAY:none'></A><DIV id='BizServiceTree-1' class='MzTreeView' onclick='BizServiceTree-1.clickHandle(event)' ondblclick='BizServiceTree-1.dblClickHandle(event)'></DIV>");
			//alert(bizServiceTreeHtml.substring(0,69)+bizServiceTreeHtml.substring(214,bizServiceTreeHtml.length-6));
			$("#bizServiceTree").html(bizServiceTreeHtml);
		});

		//关闭tree组件
		$("#bizserviceCancelBtn").bind("click", function(){
			$("#BusinessServices_div0_BusinessServices").css("visibility","hidden");
		});

		//点击tree组件确定按钮
		$("#bizserviceSubBtn").bind("click", function(){
			if($("#bizServiceTree input:checked").size()>0){
				var leftResource=document.getElementsByName("bizService_reportInfoNameName");
				var serviceId = "";
				var servicename = "";
				for (var i = 0; i < leftResource.length; i++) {//得到左侧树当前的状态：选中，没选中，全部
					var curResId = leftResource[i].value;
					var curResName = $("a[resId='"+curResId+"']").attr("value");

					if(leftResource[i].checked){
						if(serviceId == ""){
							serviceId = curResId;
							serviceName = curResName;
						}else{
							serviceId = serviceId + ";" + curResId;
							serviceName = serviceName + ";" + curResName;
						}
					}
				}
				var value = serviceId + "!" + serviceName;
				$("#BusinessServices_div0_BusinessServices").css("visibility","hidden");
				//增加行时准备数据

				var valueList = value.split("!");
				var idGroup = valueList[0];
				var nameGroup = valueList[1];

				var idList = idGroup.split(";");
				var nameList = nameGroup.split(";");
				var metrics = "AVAILABILITY;MTBF;MTTR;FAILURETIMES";
				//var id = "uid"+(new Date()).getTime()+parseInt(Math.random()*100000);

				$("#BusinessServicesTable tr:gt(0)").detach();
				for(i=0;i<idList.length;i++){
					$("#BusinessServicesTable tr:last").after("<tr id='BusinessServices_tr_"+i+"'><td><input type='checkbox' name='reportInfoName' id='"+i+"'/><input type='hidden' name='reportInfo["+i+"].id' value=''/><input type='hidden'  name='reportInfo["+i+"].metrics' value='"+metrics+"' /><input type='hidden'  name='reportInfo["+i+"].resources' value='"+idList[i]+"' /><input type='hidden'  name='reportInfo["+i+"].name' value='"+nameList[i]+"' /></td><td style='width:150px'>"+nameList[i]+"</td><td></td><td></td><td></td><td></td><td><input type='checkbox' checked='checked' disabled='disabled' name='reportInfo["+i+"].show1'/></td><td><input type='checkbox' name='reportInfo["+i+"].show2'/></td></tr>");
				}
				$('#Performance_showAddButton').hide();
			}else{
				$("#BusinessServices_div0_BusinessServices").css("visibility","hidden");
			}
		});

		//弹出tree组件
		$("#popBizTree").bind("click", function(){
			$("#BusinessServices_div0_BusinessServices").css("visibility","visible");
			$("#bizServiceTree input:checked").attr("checked",false);
		});
	});

</script>
<div id="BusinessServices_div0_BusinessServices" style="position:absolute;left:10%;top:1%;width:40%;height:90%;z-index:1000;visibility:hidden;overflow:auto">
	<div class="pop" style="width:100%,height:284px">
		<div class="pop-top-l">
			<div class="pop-top-r">
				<div class="pop-top-m">
					<span class="pop-top-title">业务服务选择</span>
				</div>
			</div>
		</div>
		<div class="pop-m">
			<div class="pop-content">
				<div  style="height:20px">&nbsp;</div>
				<div id="bizServiceTree"></div>
			</div>
		</div>
		<div class="pop-bottom-l">
			<div class="pop-bottom-r">
				<div class="pop-bottom-m">
					<span id="bizserviceCancelBtn" class="win-button"><span class="win-button-border"><a>取消</a></span></span>
					<span id="bizserviceSubBtn" class="win-button"><span class="win-button-border"><a>确定</a></span></span>
				</div>
			</div>
		</div>
	</div>
</div>
<table  class="tongji-grid table-width100 whitebg grayborder" style="border: 1px solic #ccc; overflow: scroll;">
	<tr>
		<th rowspan="2"><input type="checkbox" id="BusinessServices_Checkbox" onclick="choiceAll(this)" />序号</th>
		<th rowspan="2" style="width:150px">服务<span class="red">*</span></th>
		<th rowspan="2">可用性比率(%) </th>
		<th rowspan="2">故障次数(次)</th>
		<th rowspan="2">MTTR(小时)<span class="ico ico-what" title="MTTR(Mean Time To Repair)：平均恢复时间"></span></th>
		<th rowspan="2">MTBF(天)<span class="ico ico-what" title="MTBF(Mean Time Between Failure)：平均故障间隔时间"></span></th>
		<th colspan="2" class="rt  textalign">显示内容</th>
	</tr>
	<tr id="title">
		<th class="rb textalign">汇总数据<span class="ico ico-what" title="当前报告周期内采集到的所有指标值汇总为一条记录。"></span></th>
		<th class="rb textalign">事件<span class="ico ico-what" title="当前报告周期内，各个服务产生的不可用与恢复事件。"></span></th>
	</tr>
	<tr>
		<td colspan="8" style="padding: 0 0 0 0;">
			<div style="width: 100%;height: 226px;overflow-y:auto; overflow-x:hidden; padding: 0 0 0 0; margin:0;">
				<s:if test="model!=null">
					<table id="BusinessServicesTable">
						<tr style="display:none" id="BusinessServices_showAddButton">
							<td><span></span></td>
							<td style="width: 150px"><span></span></td>
							<td><span></span></td>
							<td><span></span></td>
							<td><span></span></td>
							<td><span></span></td>
							<td><span></span></td>
							<td><span></span></td>
						</tr>
						<s:iterator  var="info" value="model.bizServiceReportInfos"  status="stat">
							<tr id="BusinessServices_tr_<s:property value='#stat.index' />">
								<td>
									<input type="checkbox" name="reportInfoName" id="<s:property value='#stat.index' />"/>

									<input type="hidden"  name="reportInfo[<s:property value='#stat.index' />].id" value=""  />
									<input type="hidden"  name="reportInfo[<s:property value='#stat.index' />].metrics" value="<s:property value='#info.metrics' />"  />
									<input type="hidden"  name='reportInfo[<s:property value="#stat.index" />].resources' value='<s:property value="#info.resources" />'/>
									<input type="hidden"  name='reportInfo[<s:property value="#stat.index" />].name' value='<s:property value="#info.name" />'/>
								</td>
								<td>
									<s:property value="#info.name" />
								</td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td>
									<s:if test="#info.show1!='true'">
										<input type="checkbox" name='reportInfo[<s:property value="#stat.index" />].show1' />
									</s:if>
									<s:else>
										<input type="checkbox" checked="checked" name='reportInfo[<s:property value="#stat.index" />].show1' />
									</s:else>
									<span>汇总数据</span>
								</td>
								<td>
									<s:if test="#info.show2!='true'">
										<input type="checkbox" name="reportInfo[<s:property value='#stat.index' />].show2" />
									</s:if>
									<s:else>
										<input type="checkbox" checked="checked" name="reportInfo[<s:property value='#stat.index' />].show2" />
									</s:else>
									<span>事件</span>
								</td>
							</tr>
						</s:iterator>
					</table>
				</s:if>
				<s:else>
					<table id="BusinessServicesTable">
						<tr style="display:none" id="BusinessServices_showAddButton">
							<td><span></span></td>
							<td style="width: 150px"><span></span></td>
							<td><span></span></td>
							<td><span></span></td>
							<td><span></span></td>
							<td><span></span></td>
							<td><span></span></td>
							<td><span></span></td>
						</tr>
					</table>
					<div class="textalign" id="Performance_showAddButton" style="margin-top:80px;"><span >请点击</span><span class="ico ico-add" title="添加" id="Performance_add" ></span><span>按钮</span></div>
				</s:else>
			</div>

		</td>
	</tr>

</table>
<script type="text/javascript">
	//全选或全不选
	function choiceAll(obj){
		var checkboxList = $("input[name='reportInfoName']");

		for(i=0;i<checkboxList.size();i++){
			checkboxList[i].checked = obj.checked;
		}
	}

	//删除表格中选中行
	function delTableRow(){
		var checkboxList = $("input[name='reportInfoName']").filter(":checked");
		if(checkboxList.size() == 0){
			alert("请选择至少一条数据！");
		}else{
			//var aa = $("#BusinessServicesTable tr:gt(0):has(input[name='reportInfoName']:checked) input[name='reportInfo[BusinessServices]show1']").size();
			//for(i=0;i<aa;i++){
				//alert($("#BusinessServicesTable tr:gt(0):has(input[name='reportInfoName']:checked) input[name='reportInfo[BusinessServices]show1']").get(i).checked);
			//}
			$("#BusinessServicesTable tr:gt(0):has(input[name='reportInfoName']:checked)").detach();
			$("#BusinessServices_Checkbox").get(0).checked=false;

		}
	}
</script>
