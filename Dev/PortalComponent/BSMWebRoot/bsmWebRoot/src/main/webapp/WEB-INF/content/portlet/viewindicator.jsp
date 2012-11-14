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
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css">
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

<script src="${ctx}/js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript"
	src="${ctx}/js/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript">
	var _information, _noting;
	$(document)
			.ready(
					function() {
						//添加事件
						$("#add_indicator")
								.click(
										function() {
											var winOpenObj = {};
											winOpenObj.height = '250';
											winOpenObj.width = '500';
											winOpenObj.name = window;
											winOpenObj.url = "${ctx}/portlet/indicator!addIndicator.action?userid=<%=userId%>";
											winOpenObj.scrollable = false;
											winOpenObj.resizeable = false;
											modalinOpen(winOpenObj);
										});
						//删除事件
						$("#del_indicator")
								.click(
										function() {
											_noting = new information({
												text : "没有要删除的记录。"
											});
											_information = new information({
												text : "请至少选择一项。"
											});
											if ($("input[type='checkbox']").length == 0) {
												_noting.show();
												return;
											} else if ($("input[type='checkbox']:checked").length == 0) {
												_information.show();
												return;
											} else {
												var _confirm = new confirm_box({
													text : "是否确认删除？"
												});
												_confirm.show();
												_confirm
														.setConfirm_listener(function() {
															if (confirm) {
																var ajaxParam = $(
																		"#form")
																		.serialize();
																$
																		.ajax({
																			type : "POST",
																			dataType : 'json',
																			url : "${ctx}/portlet/indicator!delIndicator.action",
																			data : ajaxParam,
																			success : function(
																					data,
																					textStatus) {
																				try {
																					rewrite(data.viewList);
																				} catch (e) {
																				}
																			},
																			fail : function(
																					data,
																					textStatus) {
																				alert('fail');
																			}
																		});
																_confirm.hide();
															}
														});
											}
										});
					});
	//自动刷新
	function refresh(){ 
		$.ajax({
			type : "POST",
			dataType : 'json',
			url : "${ctx}/portlet/indicator!refreshIndicator.action",
			data : "userid=<%=userId%>",
			success : function(data, textStatus) {
				try {
					rewrite(data.viewList);
				} catch (e) {
				}
			},
			fail : function(data, textStatus) {
				alert('fail');
			}
		});	
	}
	setInterval('refresh()',30000);
	//页面刷新数据
	function rewrite(viewList) {
		
		var style = "line";
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
					$("#tbody")
							.append(
									"<tr class='"+style+"'><td width='40%' ><input name='delids' type='checkbox' value='"+viewList[i].categoryGroupId+"&"+viewList[i].childResourceId+"&"+viewList[i].metiricId+"'/>"
											+ viewList[i].typeName
											+ "</td><td width='30%' >"
											+ viewList[i].metiricName
											+ "</td><td width='30%' ><span class='lamp lamp-lingred'></span><a href='#' name='redlink' id='"
											+ viewList[i].categoryGroupId
											+ ","
											+ viewList[i].childResourceId
											+ ","
											+ viewList[i].metiricId
											+ "' onclick='showdetail(this)'>"
											+ viewList[i].redCount
											+ "</a><span class='lamp lamp-lingyellow'></span><a href='#' name='yellowlink' id='"
											+ viewList[i].categoryGroupId
											+ ","
											+ viewList[i].childResourceId
											+ ","
											+ viewList[i].metiricId
											+ "' onclick='showdetail(this)'>"
											+ viewList[i].yellowCount
											+ "</a><span class='lamp lamp-linggrey'></span><a href='#' name='greylink' id='"
											+ viewList[i].categoryGroupId
											+ ","
											+ viewList[i].childResourceId
											+ ","
											+ viewList[i].metiricId
											+ "' onclick='showdetail(this)'>"
											+ viewList[i].greyCount
											+ "</a></td></tr>");
				}
			}
		}else{
			$("#main_div").attr("style", "display:none");
			$("#main_div1").attr("style", "padding:80px 0px 0px;display");
			$("#main_div1").html("请点击<span style='cursor:default' class='ico ico-add '></span>进行设置。");
		}
		
	}
	//显示详细信息
	function showdetail(obj) {
		var id = obj.id;
		var name = obj.name;
		var indName = $(obj).parent().prev().text();
		var colorType;
		if ("redlink" == name) {
			//$("#colorType").val("red");
			colorType = "red";
		} else if ("yellowlink" == name) {
			//$("#colorType").val("yellow");
			colorType = "yellow";
		} else {
			//$("#colorType").val("grey");
			colorType = "grey";
		}
		$("#indName").val(indName);
		$("#showDetailId").val(id);
		var $popForm = $("<form action= \"${ctx}/portlet/indicator!viewDetailIndicator.action\" method=\"post\" target=\"changeType\"></form>");
		$popForm
				.append($("<input type=\"hidden\" name=\"colorType\" value=\""+colorType+"\" />"));
		$popForm
				.append($("<input type=\"hidden\" name=\"indName\" value=\""+indName+"\" />"));
		$popForm
				.append($("<input type=\"hidden\" name=\"showDetailId\" value=\""+id+"\" />"));
		$popForm
				.append($("<input type=\"hidden\" name=\"userid\" value=\"<%=userId%>\" />"));
		$popForm.submit(function() {
			var top = window.screen.height / 2 - 450 / 2;
			var left = window.screen.width / 2 - 700 / 2;
			window.open('about:blank', "changeType",
					'width=600,height=500,menubar=no,scrollbars=no,left='
							+ left + ',top=' + top);
		});
		$popForm.appendTo("body");
		$popForm.submit();
		$popForm.remove();
	}
</script>
</head>
<body bgcolor="black">
	<page:applyDecorator name="portlet" title="关注指标">
		<page:param name="topBtn_index_1">1</page:param>
		<page:param name="topBtn_id_1">add_indicator</page:param>
		<page:param name="topBtn_css_1">ico ico-add right</page:param>
		<page:param name="topBtn_style_1">right:0;top:0</page:param>
		<page:param name="topBtn_title_1">添加</page:param>
		<page:param name="topBtn_index_2">2</page:param>
		<page:param name="topBtn_id_2">del_indicator</page:param>
		<page:param name="topBtn_css_2">ico ico-delete right</page:param>
		<page:param name="topBtn_style_2">right:0;top:0</page:param>
		<page:param name="topBtn_title_2">删除</page:param>
		<page:param name="content">
			<Form method="post" id="form">
				<div class="roundedform-content02"
					style="background: white; height: 240px">
					<s:if test="firstset == 'false'">
						<div id="main_div" class="margin8">
							<div class="grayhead-table  grayborder">
								<div class="grayhead-table-top">
									<table class="grayhead-table table-width100">
										<thead>
											<tr>
												<th width="5%" class="vertical-middle bold "></th>
												<th width="35%" class="vertical-middle bold ">资源类型</th>
												<th width="30%" class="vertical-middle bold ">指标名称</th>
												<th width="30%" class="vertical-middle bold ">问题指标</th>
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
												<td width="40%"><input name="delids" type="checkbox"
													value="<s:property value='categoryGroupId'/>&<s:property value='childResourceId'/>&<s:property value='metiricId'/>" />
													<s:if test="typeName.length()>16">
														<span title="<s:property value='typeName'/>"><s:property
																value="typeName.substring(0,16)" />...</span>
													</s:if> <s:else>
														<span title="<s:property value='typeName'/>"
															onclick="opendeil(this)"><s:property
																value="typeName" />
														</span>
													</s:else></td>
												<td width="30%"><s:if test="metiricName.length()>16">
														<span title="<s:property value='metiricName'/>"><s:property
																value="metiricName.substring(0,16)" />...</span>
													</s:if> <s:else>
														<span title="<s:property value='metiricName'/>"><s:property
																value="metiricName" />
														</span>
													</s:else></td>
												<td width="30%" id="test"><span
													class="lamp lamp-lingred"></span><a href="#" name="redlink"
													id="<s:property value='categoryGroupId'/>,<s:property value='childResourceId'/>,<s:property value='metiricId'/>"
													onclick="showdetail(this)"><s:property value="redCount"></s:property>
												</a><span class="lamp lamp-lingyellow"></span><a href="#"
													name="yellowlink"
													id="<s:property value='categoryGroupId'/>,<s:property value='childResourceId'/>,<s:property value='metiricId'/>"
													onclick="showdetail(this)"><s:property
															value="yellowCount"></s:property>
												</a><span class="lamp lamp-linggrey"></span><a href="#"
													name="greylink"
													id="<s:property value='categoryGroupId'/>,<s:property value='childResourceId'/>,<s:property value='metiricId'/>"
													onclick="showdetail(this)"><s:property
															value="greyCount"></s:property>
												</a>
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
						<div id="main_div1" style="padding:80px 0px 0px;display:none" class="textalign">
							请点击<span style="cursor:default" class='ico ico-add '></span>进行设置。
						</div>
					</s:if>
					<s:else>
						<div id="main_div" class="margin8" style="display: none">
							<div class="grayhead-table  grayborder">
								<div class="grayhead-table-top">
									<table class="grayhead-table table-width100">
										<thead>
											<tr>
												<th width="5%" class="vertical-middle bold "></th>
												<th width="35%" class="vertical-middle bold ">资源类型</th>
												<th width="30%" class="vertical-middle bold ">指标名称</th>
												<th width="30%" class="vertical-middle bold ">问题指标</th>
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
						<div id="main_div1" style="padding:80px 0px 0px;display" class="textalign">
							请点击<span style="cursor:default" class='ico ico-add '></span>进行设置。
						</div>
					</s:else>
				</div>
			</Form>
		</page:param>
		</div>
	</page:applyDecorator>
</body>
</html>
