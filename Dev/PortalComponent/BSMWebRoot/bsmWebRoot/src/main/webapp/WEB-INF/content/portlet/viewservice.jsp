<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%-- <%@ include file="/WEB-INF/common/userinfo.jsp" %> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<title></title>


<style type="text/css">
.focus {
	border: 1px solid #f00;
	background: #fcc;
}

#metricSetting table td {
	vertical-align: middle;
	text-align: center;
}

#metricSetting table th {
	vertical-align: middle;
	text-align: center;
}
</style>
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript"
	src="${ctx}/js/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$("#setting_service")
								.click(
										function() {
											var strservice = $("#strservice").val();
											var $popForm = $("<form action= \"${ctx}/portlet/service!setService.action\" method=\"post\" target=\"changeType\"></form>");
											$popForm.append($("<input type=\"hidden\" name=\"strservice\" value=\""+strservice+"\" />"));
											$popForm.submit(function() {
											var top = window.screen.height / 2 - 400 / 2;
											var left = window.screen.width / 2 - 300 / 2;
											window.open('about:blank', "changeType",
														'width=350,height=220,menubar=no,scrollbars=no,left='
														+ left + ',top=' + top);}); 
														
															$popForm.appendTo("body");
															$popForm.submit();
															$popForm.remove();
										});

						$(".txt-blue02").live('click',function(obj) {
											var $this = $(this);
											var Panel = undefined;
											if (Panel) {
												Panel.close();
												Panel = undefined;
											}
											var causesStr = $this.parent()
													.parent().find(
															"input:hidden")
													.val();
											var causesArr = causesStr
													.split(",");
											var causes = "";
											for ( var i = 0; i < causesArr.length; i++) {
												causes = causes + "<br>"
														+ causesArr[i];
											}
											causes = causes.substr(4,
													causes.length);
											Panel = new winPanel(
													{
														url : "",
														x : obj.pageX,
														y : obj.pageY,
														isautoclose : true,
														closeAction : "close",
														content : causes,
														listeners : {
															closeAfter : function() {
																effecteResPanel = null;
															},
															loadAfter : function() {
															}
														}
													},
													{
														winpanel_DomStruFn : "blackLayer_winpanel_DomStruFn_Portlet"
													});
										});
					});
	//自动刷新
	function refresh(){
		$.ajax({
			type : "POST",
			dataType : 'json',
			url : "${ctx}/portlet/service!refreshService.action",
			data : "userid=<%=userId%>",
			success : function(data, textStatus) {
				try {
					reWriteCallback(data);
				} catch (e) {
				}
			},
			fail : function(data, textStatus) {
				alert('fail');
			}
		});	
	}
	setInterval('refresh()',30000);
	//刷新页面数据
	function reWriteCallback(data) {
		$("#strservice").val(data.strservice);
		var viewList = data.viewList;
		var style = "line";
		var more = "";
		$("#main_div").attr("style", "display");
		$("#main_div1").attr("style", "display: none");
		$("#tbody").html("");
		if (viewList && viewList.length) {
			for ( var i = 0; i < viewList.length; i++) {
				if (style == "line") {
					style = "";
				} else {
					style = "line";
				}
				if (viewList[i]) {
				if (viewList[i].serviceName.length > 16) {
					var serviceName = viewList[i].serviceName.substring(
							0, 16)
							+ "...";
				} else {
					var serviceName = viewList[i].serviceName;
				}
				if (viewList[i].rootCauses[0].length > 10) {
					var rootCausesView = viewList[i].rootCauses[0].substring(
							0, 10)
							+ "...";
				} else {
					var rootCausesView = viewList[i].rootCauses[0];
				}
				if(viewList[i].rootCauses.length>1){
					more="<span style='cursor: hand' class='txt-blue02 for-inline'>more</span>";
				}else{
					more="";
				}
				$("#tbody")
							.append(
									"<tr class='"+style+"'><td width='20%' ><a href=\"#\" id=\""+viewList[i].serviceId+"\" onclick=\"openServicedetail(this)\" title=\""+viewList[i].serviceName+"\">"+serviceName+"</a></td><td width='30%' ><input type='hidden' value='"+viewList[i].rootCauses+"'/><span title='"+viewList[i].rootCauses[0]+"'>"+rootCausesView+"</span></td><td width='10%' >"+more+"</td><td width='15%' >"+viewList[i].mttr+"</td><td width='15%' >"+viewList[i].mtbf+"</td></tr>");
				}
			}
		}else{
			$("#main_div").attr("style", "display:none");
			$("#main_div1").attr("style", "margin:80px 0px 0px;display");
			$("#main_div1").html("请点击<span style='cursor: default' class='ico-21 ico-21-setting'></span>进行设置。");
		}
	//alert("fuwu");
	}

	//打开告警查询页面
	function openServicedetail(obj) {
		var id = obj.id;
		winOpen({
			url : "/bizsmweb/bizsm/bizservice/ui/bizservice-view?serviceId="+id,
			width : 1000,
			height : 600,
			name : 'Service'
		});
	}
</script>
</head>
<body bgcolor="black">
	<page:applyDecorator name="portlet" title="关注服务">
		<page:param name="topBtn_index_1">1</page:param>
		<%-- <page:param name="width">450px</page:param> --%>
		<page:param name="topBtn_id_1">setting_service</page:param>
		<page:param name="topBtn_css_1">ico-21 ico-21-setting right f-absolute</page:param>
		<page:param name="topBtn_style_1">right:0;top:0</page:param>
		<page:param name="topBtn_title_1">设置</page:param>
		<page:param name="content">
			<Form method="post" id="form">
				<input id="strservice" name="strservice" type="hidden" value="${strservice}">
				<div class="roundedform-content02"
					style="background: white; height: 240px">
					<s:if test="firstset == 'false'">
						<div id="main_div" class="margin8">
							<div class="grayhead-table  grayborder">
								<div class="grayhead-table-top">
									<table class="grayhead-table table-width100">
										<thead>
											<tr>
												<th width="20%" class="vertical-middle bold ">服务</th>
												<th width="40%" class="vertical-middle bold ">根本原因</th>
												<th width="15%" class="vertical-middle bold ">MTTR</th>
												<th width="15%" class="vertical-middle bold ">MTBF</th>
											</tr>
										</thead>
									</table>
								</div>
								<div class="grayhead-table-content" style="height: 190px; overflow-x: hidden;">
									<table class="grayhead-table table-width100">
										<tbody id="tbody" align="center">
											<s:iterator value="viewList" status="status">
												<s:if test='#status.odd == true '>
													<tr>
												</s:if>
												<s:else>
													<tr class="line">
												</s:else>
												<td width="20%"><a href="#"
													id="<s:property value="serviceId"/>" onclick="openServicedetail(this)" title="<s:property value="serviceName"/>"> <s:if
															test="serviceName.length()>16">
															<s:property value="serviceName.substring(0,16)" />...
                </s:if> <s:else>
															<s:property value="serviceName" />
														</s:else> </a>
												</td>
												<td width="30%"><input type="hidden"
													value="<s:property value="rootCauses"></s:property>" /> <span
													title="<s:property value="rootCauses[0]"/>"> <s:if
															test="rootCauses[0].length()>10">
															<s:property value="rootCauses[0].substring(0,10)" />...
                </s:if> <s:else>
															<s:property value="rootCauses[0]" />
														</s:else> </span>
												</td>
												<td width="10%"><s:if test="rootCauses.length>1">
														<span style="cursor: hand" class="txt-blue02 for-inline">more</span>
													</s:if>
												</td>
												<td width="15%"><s:property value="mttr"></s:property>
												</td>
												<td width="15%"><s:property value="mtbf"></s:property>
												</td>
												</tr>
											</s:iterator>
										</tbody>
									</table>

									</td>
									</tr>
									</tbody>
									</table>
								</div>
							</div>
						</div>
						<div id="main_div1" style="margin: 80px 0px 0px;display: none"
							class="textalign">
							请点击<span style="cursor: default" class='ico-21 ico-21-setting'></span>进行设置。
						</div>
					</s:if>
					<s:else>
						<div id="main_div" class="margin8" style="display: none">
							<div class="grayhead-table  grayborder">
								<div class="grayhead-table-top">
									<table class="grayhead-table table-width100">
									<thead>
										<tr>
											<th width="20%" class="vertical-middle bold ">服务</th>
											<th width="40%" class="vertical-middle bold ">根本原因</th>
											<th width="15%" class="vertical-middle bold ">MTTR</th>
											<th width="15%" class="vertical-middle bold ">MTBF</th>
										</tr>
									</thead>
									</table>
								</div>
								<div class="grayhead-table-content" style="height: 190px; overflow-x: hidden;">
									<table class="grayhead-table table-width100">
										<tbody id="tbody" align="center">
										</tbody>
									</table>
									</td>
									</tr>
									</tbody>
									</table>
								</div>
							</div>
						</div>
						<div id="main_div1" style="margin: 80px 0px 0px;"
							class="textalign">
							请点击<span style="cursor: default" class='ico-21 ico-21-setting'></span>进行设置。
						</div>
					</s:else>
				</div>
			</Form>
		</page:param>
		</div>
	</page:applyDecorator>
</body>
</html>
