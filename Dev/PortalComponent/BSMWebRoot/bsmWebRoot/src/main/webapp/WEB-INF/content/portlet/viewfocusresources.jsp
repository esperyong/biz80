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
<title>焦点资源</title>
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
<script type="text/javascript">
	var path = "${ctx}";
	$(document)
			.ready(
					function() {
						$("#setting_focus").click(function() {
							var ext = [];
							$("#main_div").find("a").each(function() {
								ext.push($(this).attr("id"));
							})
							createChooseDeviceWindow(false, ext);
						});
						//调用选择资源组件
						function createChooseDeviceWindow(isRoot, exceptIdArray) {
							var isSingleSelection = isRoot;
							var idcode = "main";
							//var isSystemAdmin = "${isAdmin}";
							//var userId = "${userId}";
							var $popForm = $("<form action= \"" + path + "/businesscomponent/resChoice.action\" method=\"post\" target=\"changeType\"></form>");
							//$popForm.append($("<input type=\"hidden\" name=\"queryVO.isSingleSelection\" value=\"" + isSingleSelection + "\" />"));
							$popForm
									.append($("<input type=\"hidden\" name=\"queryVO.category\" value=\"Resource\" />"));
							$popForm
									.append($("<input type=\"hidden\" name=\"queryVO.isSystemAdmin\" value=\"true\" />"));
							//$popForm.append($("<input type=\"hidden\" name=\"queryVO.userId\" value=\""+userId+" />"));
							$popForm
									.append($("<input type=\"hidden\" name=\"queryVO.isSystemAdmin\" value=\"true\" />"));
							$popForm
									.append($("<input type=\"hidden\" name=\"queryVO.userId\" value=\"<%=userId%>\" />"));
							$popForm
									.append($("<input type=\"hidden\" name=\"queryVO.domains\" value=\"no_choice\" />"));
							$popForm
									.append($("<input type=\"hidden\" name=\"queryVO.categoryLevel\" value=\"1\" />"));
							$popForm
									.append($("<input type=\"hidden\" name=\"queryVO.idcode\" value=\""+idcode+"\" />"));
							$popForm
									.append($("<input type=\"hidden\" name=\"queryVO.reserveCategorys\" value=\"server\" />"));
							$popForm
									.append($("<input type=\"hidden\" name=\"queryVO.reserveCategorys\" value=\"pc\" />"));
							$popForm
									.append($("<input type=\"hidden\" name=\"queryVO.reserveCategorys\" value=\"networkdevice\" />"));
							if (exceptIdArray && exceptIdArray.length > 0) {
								var length = exceptIdArray.length;
								for ( var i = 0; i < length; i++) {
									$popForm
											.append($("<input type=\"hidden\" name=\"queryVO.exceptInstanceIds\" value=\""+exceptIdArray[i]+"\" />"));
								}
							}
							$popForm.submit(function() {
								var top = window.screen.height / 2 - 450 / 2;
								var left = window.screen.width / 2 - 700 / 2;
								window.open('about:blank', "changeType",
										'width=700,height=500,menubar=no,scrollbars=no,left='
												+ left + ',top=' + top);
							});
							$popForm.appendTo("body");
							$popForm.submit();
							$popForm.remove();
						}

					});
	//资源组件返回数据接收
	function choiceResourceCallback(obj) {
		var param = "&userid=<%=userId%>&Devices=";
		if (obj.resourceInstances && obj.resourceInstances.length
				&& obj.resourceInstances.length > 0) {
			for ( var i = 0; i < obj.resourceInstances.length; i++) {
				param += obj.resourceInstances[i] + ",";
			}
		}
		$.ajax({
			type : "POST",
			dataType : 'json',
			url : "${ctx}/portlet/focus!setFocusResources.action",
			data : param,
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
	//自动刷新
	function refresh(){
		$.ajax({
			type : "POST",
			dataType : 'json',
			url : "${ctx}/portlet/focus!refreshResources.action",
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
	//页面数据刷新
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
					if (viewList[i].instanceName.length > 16) {
						var instanceName = viewList[i].instanceName.substring(
								0, 16)
								+ "...";
					} else {
						var instanceName = viewList[i].instanceName;
					}
					if(viewList[i].mttr==null){
						var mttr = "-";
					}else{
						var mttr = viewList[i].mttr;
					}
					if(viewList[i].mtbf==null){
						var mtbf = "-";
					}else{
						var mtbf = viewList[i].mtbf;
					}
					$("#tbody")
							.html(
									$("#tbody").html()
											+ "<tr class='"+style+"'><td width='7%' ><span onclick='openStatedetail(this)' id='"+viewList[i].device+"' class='ico "+viewList[i].state+"'></span></td><td width='23%' ><span style='cursor:hand' onclick='opendetail(this)' title='"
											+ viewList[i].instanceName
											+ "'>"
											+ instanceName
											+ "</span></td><td width='20%' >"
											+ viewList[i].avail
											+ "%</td><td width='10%' >"
											+ mttr
											+ "</td><td width='10%' >"
											+ mtbf
											+ "</td><td width='25%' ><span class='"+viewList[i].alarmSeverityId+"' style='cursor:default;margin-left: 0px;'></span>(<a href='#' onclick='openAlarmdetail(this)' id='"
											+ viewList[i].device + "'>"
											+ viewList[i].alarm24HCount
											+ "</a>)</td></tr>");
				}
			}
		}else{
			$("#main_div").attr("style", "display:none");
			$("#main_div1").attr("style", "margin:80px 0px 0px;display");
			$("#main_div1").html("请点击<span style='cursor: default' class='ico-21 ico-21-setting'></span>进行设置。");
		}
		//alert("jiaodian");
	}
	//打开详细资源页面
	function opendetail(obj) {
		var id = obj.id;
		winOpen({
			url : path + '/detail/resourcedetail.action?instanceId='
					+ id,
			width : 980,
			height : 600,
			scrollable : false,
			name : 'resdetail_' + id
		});
	}
	//打开详细状态信息页面
	function openStatedetail(obj) {
		var id = obj.id;
		winOpen({
			url : path + "/monitor/resourceStateDetail.action?instanceId=" + id,
			width : 640,
			height : 555,
			name : 'stateDetail'
		});
	}
	//打开告警查询页面
	function openAlarmdetail(obj) {
		var id = obj.id;
		winOpen({
			url : path + "/detail/insalarmoverview.action?resInstanceId="+id+"&sendTime=RECENT_1_DAY",
			width : 1000,
			height : 600,
			name : 'detailAlarm'
		});
	}
</script>
</head>
<body bgcolor="black">
	<page:applyDecorator name="portlet" title="焦点资源">
		<page:param name="topBtn_index_1">1</page:param>
		<page:param name="topBtn_id_1">setting_focus</page:param>
		<page:param name="topBtn_css_1">ico-21 ico-21-setting right f-absolute</page:param>
		<page:param name="topBtn_style_1">right:0;top:0</page:param>
		<page:param name="topBtn_title_1">设置</page:param>
		<page:param name="content">
			<div class="roundedform-content02"
				style="background: white; height: 240px">
				<s:if test="firstSet == 'false'">
					<div id="main_div" class="margin8">
						<div class="grayhead-table  grayborder">
							<div class="grayhead-table-top">
								<table class="grayhead-table table-width100">
									<thead>
										<tr>
											<th width="7%" class="vertical-middle bold "></th>
											<th width="23%" class="vertical-middle bold ">资源</th>
											<th width="20%" class="vertical-middle bold ">今天可用性</th>
											<th width="10%" class="vertical-middle bold ">MTTR</th>
											<th width="10%" class="vertical-middle bold ">MTBF</th>
											<th width="25%" class="vertical-middle bold ">最近24小时报警</th>
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
											<td width="7%"><span
												onclick="openStatedetail(this)" id="<s:property value='device'/>" class="ico <s:property value='state'></s:property>"></span>
											</td>
											<td width="23%"><s:if test="instanceName.length()>16">
													<span style="cursor: hand" onclick="opendetail(this)"
														id="<s:property value='device'/>"
														title="<s:property value='instanceName'/>"><s:property
															value="instanceName.substring(0,16)" />...</span>
												</s:if> <s:else>
													<span style="cursor: hand" onclick="opendetail(this)"
														id="<s:property value='device'/>"
														title="<s:property value='instanceName'/>"><s:property
															value="instanceName" />
													</span>
												</s:else></td>
											<td width="20%"><s:property value="avail"></s:property>%
											</td>
											<td width="10%">
											<s:if test="mttr==null">
											-
											</s:if>
											<s:else>
											<s:property value="mttr"></s:property>
											</s:else>
											</td>
											<td width="10%">
											<s:if test="mtbf==null">
											-
											</s:if><s:else>
											<s:property value="mtbf"></s:property>
											</s:else>
											</td>
											<td width="25%"><span
												class="<s:property value='alarmSeverityId'></s:property>"
												style="cursor:default; margin-left: 0px;"></span>(<a href="#"
												onclick="openAlarmdetail(this)"
												id="<s:property value="device"></s:property>"><s:property
														value="alarm24HCount"></s:property>
											</a>)</td>
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
					<div id="main_div1" style="margin:80px 0px 0px;display:none" class="textalign">
						请点击<span style="cursor:default"  class='ico-21 ico-21-setting'></span>进行设置。
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
											<th width="25%" class="vertical-middle bold ">资源</th>
											<th width="20%" class="vertical-middle bold ">今天可用性</th>
											<th width="10%" class="vertical-middle bold ">MTTR</th>
											<th width="10%" class="vertical-middle bold ">MTBF</th>
											<th width="25%" class="vertical-middle bold ">最近24小时报警</th>
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
					<div id="main_div1" style="margin:80px 0px 0px;display" class="textalign">
						请点击<span style="cursor:default"  class='ico-21 ico-21-setting'></span>进行设置。
					</div>
				</s:else>
			</div>
		</page:param>
		</div>
	</page:applyDecorator>
</body>
</html>
