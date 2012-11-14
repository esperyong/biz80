<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<%

	String current = request.getParameter("current");
	if(current==null){
		current ="moniter.resourcePage";
	}
	String currentHref = "";
	String [] menus = {"busi_server","network","moniter","roommnager","positon","event","fenxi"};

	Map<String,List<Map<String,String>>> Items = new HashMap<String,List<Map<String,String>>>();
	
	//业务服务
	List<Map<String,String>> busi_server = new ArrayList<Map<String,String>>();
	Map<String,String> bsmPage = new HashMap<String,String>();
	bsmPage.put("id","bsmPage");
	bsmPage.put("text","业务服务管理");
	
	bsmPage.put("href","/bizsmweb/bizsm/bizservice/ui/bizmanagement-main?busi_server=bsmPage");
	busi_server.add(bsmPage);
	
	Map<String,String> bsdDef = new HashMap<String,String>();
	bsdDef.put("id","bsdDef");
	bsdDef.put("text","业务服务定义");
	bsdDef.put("href","/bizsmweb/bizsm/bizservice/ui/bizdefine-main?busi_server=bsdDef");
	busi_server.add(bsdDef);
	
	Items.put("busi_server",busi_server);
	
		
	//网络管理
	List<Map<String,String>> network = new ArrayList<Map<String,String>>();	

	Map<String,String> topoPage = new HashMap<String,String>();
	topoPage.put("id","topoPage");
	topoPage.put("text","网络拓扑");
	topoPage.put("href","/netfocus/index.jsp?network=topoPage");
	network.add(topoPage);
	Map<String,String> macBindPage = new HashMap<String,String>();
	macBindPage.put("id","macBindPage");
	macBindPage.put("text","IP-MAC绑定");
	macBindPage.put("href","/netfocus/modules/ipmac/ipmac_main.jsp?domainId=-1&network=macBindPage");
	network.add(macBindPage);
	Map<String,String> ipAddrManagePage = new HashMap<String,String>();
	ipAddrManagePage.put("id","ipAddrManagePage");
	ipAddrManagePage.put("text","IP地址管理");
	ipAddrManagePage.put("href","/netfocus/modules/addr/ipmanagement/ipmanager.jsp?domainId=-1&network=ipAddrManagePage");
	network.add(ipAddrManagePage);
	Map<String,String> backboardPage = new HashMap<String,String>();
	backboardPage.put("id","backboardPage");
	backboardPage.put("text","背板管理");
	backboardPage.put("href","/netfocus/modules/backboard/deviceManage.jsp?domainId=-1&network=backboardPage");
	network.add(backboardPage);
	Map<String,String> ipServerPage = new HashMap<String,String>();
	ipServerPage.put("id","ipServerPage");
	ipServerPage.put("text","IP服务分布");
	ipServerPage.put("href","/netfocus/netfocus.do?action=ipscanservice@getname&forward=/modules/addr/ipmanagement/ipdistribution.jsp&domainId=-1&network=ipServerPage");
	network.add(ipServerPage);
	Map<String,String> ntaPage = new HashMap<String,String>();
	ntaPage.put("id","ntaPage");
	ntaPage.put("text","流量分析");
	ntaPage.put("href","/nta/nta.jsp?network=ntaPage");	
	network.add(ntaPage);
	Items.put("network",network);
		
	//监控管理
	List<Map<String,String>> moniter = new ArrayList<Map<String,String>>();		
	
	Map<String,String> resourcePage = new HashMap<String,String>();
	resourcePage.put("id","resourcePage");
	resourcePage.put("text","资源");
	resourcePage.put("href",request.getContextPath()+"/monitor/monitorList.action?current=moniter.resourcePage");	
	moniter.add(resourcePage);

	Map<String,String> extMoniter = new HashMap<String,String>();
	extMoniter.put("id","extMoniter");
	extMoniter.put("text","扩展监控");
	extMoniter.put("href",request.getContextPath()+"/scriptmonitor/menu.action?current=moniter.extMoniter");	
	moniter.add(extMoniter);
	
	
	Map<String,String> logPage = new HashMap<String,String>();
	logPage.put("id","logPage");
	logPage.put("text","日志");
	logPage.put("href","null.jsp");	
	moniter.add(logPage);
	Map<String,String> responseTimePage = new HashMap<String,String>();
	responseTimePage.put("id","responseTimePage");
	responseTimePage.put("text","响应时间");
	responseTimePage.put("href","null.jsp");	
	moniter.add(responseTimePage);
	Map<String,String> sysLogPage = new HashMap<String,String>();
	sysLogPage.put("id","sysLogPage");
	sysLogPage.put("text","Syslog");
	sysLogPage.put("href","/syslog/modules/syslog/searchTreeSyslogProfile.action?current=moniter.sysLogPage");	
	moniter.add(sysLogPage);
	Map<String,String> snmpTrpPage = new HashMap<String,String>();
	snmpTrpPage.put("id","snmpTrpPage");
	snmpTrpPage.put("text","SnmpTrp");
	snmpTrpPage.put("href","null.jsp");	
	moniter.add(snmpTrpPage);
	Items.put("moniter",moniter);
	
	
	
	//机房管理
	List<Map<String,String>> roommnager = new ArrayList<Map<String,String>>();		
	
	Map<String,String> roomMoniterPage = new HashMap<String,String>();
	roomMoniterPage.put("id","roomMoniterPage");
	roomMoniterPage.put("text","机房监控");
	roomMoniterPage.put("href",request.getContextPath()+"/roomDefine/MonitorVisit.action?current=roommnager.roomMoniterPage");		
	roommnager.add(roomMoniterPage);
	Map<String,String> roomPollingPage = new HashMap<String,String>();
	roomPollingPage.put("id","roomPollingPage");
	roomPollingPage.put("text","机房巡检");
	roomPollingPage.put("href","null.jsp");		
	roommnager.add(roomPollingPage);
	Map<String,String> roomDefPage = new HashMap<String,String>();
	roomDefPage.put("id","roomDefPage");
	roomDefPage.put("text","机房定义");
	roomDefPage.put("href",request.getContextPath()+"/roomDefine/IndexVisit.action?current=roommnager.roomDefPage");		
	roommnager.add(roomDefPage);
	Items.put("roommnager",roommnager);
	
	
	//物理位置
	List<Map<String,String>> positon = new ArrayList<Map<String,String>>();	
	
	Map<String,String> physicalPositionViewPage = new HashMap<String,String>();
	physicalPositionViewPage.put("id","physicalPositionViewPage");
	physicalPositionViewPage.put("text","物理位置一览");
	physicalPositionViewPage.put("href",request.getContextPath()+"/location/define/location!browse.action?current=positon.physicalPositionViewPage");
	positon.add(physicalPositionViewPage);
	Map<String,String> physicalPositionDefPage = new HashMap<String,String>();
	physicalPositionDefPage.put("id","physicalPositionDefPage");
	physicalPositionDefPage.put("text","物理位置定义");
	physicalPositionDefPage.put("href",request.getContextPath()+"/location/define/location.action?current=positon.physicalPositionDefPage");	
	positon.add(physicalPositionDefPage);
	Items.put("positon",positon);
	
	
	//事件管理
	List<Map<String,String>> event = new ArrayList<Map<String,String>>();	

	Map<String,String> alertManagePage = new HashMap<String,String>();
	alertManagePage.put("id","alertManagePage");
	alertManagePage.put("text","告警台");
	alertManagePage.put("href",request.getContextPath()+"/notification/management.action?current=event.alertManagePage");	
	event.add(alertManagePage);
	Map<String,String> alertLogPage = new HashMap<String,String>();
	alertLogPage.put("id","alertLogPage");
	alertLogPage.put("text","告警日志");
	alertLogPage.put("href",request.getContextPath()+"/notification/notificationlistSearch.action?current=event.alertLogPage");
	event.add(alertLogPage);
	Map<String,String> eventManagePage = new HashMap<String,String>();
	eventManagePage.put("id","eventManagePage");
	eventManagePage.put("text","事件管理");
	eventManagePage.put("href",request.getContextPath()+"/event/eventManage.action?current=event.eventManagePage");	
	event.add(eventManagePage);
	Items.put("event",event);

	
	//统计分析
	List<Map<String,String>> fenxi = new ArrayList<Map<String,String>>();

	Map<String,String> rtaPage = new HashMap<String,String>();
	rtaPage.put("id","rtaPage");
	rtaPage.put("text","实时分析");
	rtaPage.put("href",request.getContextPath()+"/report/real/realManage.action?current=fenxi.rtaPage");
	fenxi.add(rtaPage);
	
	Map<String,String> haPage = new HashMap<String,String>();
	haPage.put("id","haPage");
	haPage.put("text","历史分析");
	haPage.put("href","null.jsp");
	fenxi.add(haPage);
	
	
	Map<String,String> trendPage  = new HashMap<String,String>();
	trendPage.put("id","haPage");
	trendPage.put("text","趋势分析");
	trendPage.put("href","null.jsp");
	fenxi.add(trendPage);
	
	
	Map<String,String> statisticsReportPage = new HashMap<String,String>();
	statisticsReportPage.put("id","statisticsReportPage");
	statisticsReportPage.put("text","统计报表");
	statisticsReportPage.put("href",request.getContextPath()+"/report/statistic/statisticManage.action?current=fenxi.statisticsReportPage");
	fenxi.add(statisticsReportPage);
	Items.put("fenxi",fenxi);
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css">
<decorator:head />
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<title><decorator:title default="" /></title>

 <decorator:getProperty property="head"/>
</head>
<body>
<!-- manually attach allowOverflow method to pane --> 
<div class="ui-layout-north">
	<div id="header">
		<div id="topNav">
			<ul>
				<li>搜索</li>
				<li id="found" href="${ctx}/discovery/discovery-main.action"><a href="javascript:void(0)">发现</a></li>
				<li id="mochaadmin" href="/mochaadmin/index.action"><a href="javascript:void(0)">系统管理</a></li>
				<li>使用向导</li>
				<li  class="last">退出</li>
			</ul>
		</div>
		<div id="logo"></div>
	</div>
</div>  
<!-- allowOverflow auto-attached by option: west__showOverflowOnHover = true <div class="ui-layout-west">1</div> --> 
<div class="ui-layout-center">
    	<decorator:body />
    <decorator:getProperty property="body"/>
</div> 
<div class="ui-layout-south">
	<div class="menuToolBar-div">
		<ul id="menuToolBar" class="menuToolBar">
				<li notExpend="true"><div class="index" id="indexPage"></div></li>
				<%
					for(int i=0,len=menus.length;i<len;i++){
						List<Map<String,String>> items = Items.get(menus[i]);
						String width="";
						String style="";
						String currentt = "";
						if(current.indexOf(menus[i])!=-1){//一级节点
							 width="style=\"width:450px\"";
							 style="style=\"display: block; margin-left: 0px;\"";
							 currentt = "current=\"true\"";							 
						}
						if(menus[i].equals(current)){//如果当前的标示正好只是一级节点
							currentHref = current;
						}
				%>
					<li <%=width %> <%=currentt %>>
						<div class="<%=menus[i] %>"></div>
						<ul class="sub_option_menu" <%=style %>>
				<%
						for(int j=0,jlen=items.size();j<jlen;j++){
							Map<String,String> item = items.get(j);
							String cls = "";
								String href = item.get("href");
							if(current.indexOf(item.get("id"))!=-1){
								cls="on";
				%>
							<script type="text/javascript">var currentHref ="<%=href%>"</script>
					<%
							}
						
							
							if(href.indexOf("pureportal")==-1){
								href = "/pureportal/index_out.jsp?current="+menus[i]+"."+item.get("id");								
							}
				%>
							<li><a class="<%=cls %>" href="<%=href %>" id="<%=item.get("id") %>"><%=item.get("text") %></a></li>
				<%
						}
				%>
						</ul>
					</li>
				<%
					}
				%>
			</ul>	
	</div>
</div> 

<script src="${ctx}/js/jquery.layout-1.2.0.js"></script>
<script src="${ctx}/js/index.js"></script>
<script src="${ctx}/js/component/comm/winopen.js"></script>
<script type="text/javascript">
	$("#found").click(function(){
		var height = window.screen.availHeight-50;
		var width = 918;

		winOpen({
				url:$(this).attr("href"),
				width:width,
				height:height,
				name:"found",
				scrollable:true
			});
		//window.open(,"found","height="+ height + ",width="+width+",left="+left+",top="+top+",scrollbars=yes,resizable=yes");

		});
	$("#mochaadmin").click(function(){
		
		//window.open($(this).attr("href") ,"mochaadmin","height="+ height + ",width="+width+",left="+left+",top="+top+",scrollbars=yes,resizable=yes");
		window.location="/pureportal/index_out.jsp?current=admincontrol";
		});	
</script>
</body>
</html>