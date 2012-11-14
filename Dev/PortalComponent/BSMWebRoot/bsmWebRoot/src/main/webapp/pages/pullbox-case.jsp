<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
	author:qiaozheng
	description:推拉工具箱组件
	uri:{domainContextPath}/pages/pullbox-case.jsp
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>Pullbox Case</title>

<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.accordion.js"></script>

<script type="text/javascript" src="${ctx}/js/component/accordionPanel/j-dynamic-accordion.js"></script>
<script type="text/javascript" src="${ctx}/js/component/tabPanel/j-dynamic-tab.js"></script>
<script type="text/javascript" src="${ctx}/js/component/pullBox/j-dynamic-pullbox.js"></script>

<script language="javascript">
	
	$(function() {
				
				$('body #rightRoot').empty();
				
				//创建tab页组件对象
				var tabPanelTemp = new JDynamicTabPanel({id:"jTabsOne"});
				//添加一个tab页
				//第一个参数：json对象(tabID:tab页id,label:tab页label,height:tab页content部分的高度值)
				//第二个参数：字符串(tab页content部分引入的具体url路径)
				//第三个参数：json对象(需要添加的用户参数信息，这个参数信息会在点击tab页的回调函数中传递到具体的用户回调函数中)
				//第四个参数：函数对象引用(点击tab页的时候会调用这个回调函数并将该tab页对应的参数信息及用户参数信息传递到具体的用户回调函数中)
				tabPanelTemp.addPageTab({tabID:"tab-1",label:"常规信息",height:"400px"}, "", null, function(dataMap){
					// alert(dataMap["tabID"]);
				});
				tabPanelTemp.addPageTab({tabID:"tab-2",label:"业务服务",height:"300px"}, "", null, null);
				tabPanelTemp.addPageTab({tabID:"tab-3",label:"资源",height:"430px"}, "", null, null);
				tabPanelTemp.addPageTab({tabID:"tab-4",label:"业务单位",height:"200px"}, "", null, null);
				tabPanelTemp.addPageTab({tabID:"tab-5",label:"自定义元素",height:"200px"}, "", null, null);

				//设置哪个tab页处于展开状态
				tabPanelTemp.expanseTab("tab-1");

				var tabPanelTemp3 = new JDynamicTabPanel({id:"jTabsTwo"});
				tabPanelTemp3.addPageTab({tabID:"tab-1",label:"tab1",height:"200px"}, "", null, null);
				tabPanelTemp3.addPageTab({tabID:"tab-2",label:"tab2",height:"300px"}, "", null, null);
				tabPanelTemp3.addPageTab({tabID:"tab-3",label:"tab3",height:"200px"}, "", null, null);
				tabPanelTemp3.expanseTab("tab-3");
				
				//创建折叠组建对象(slid:设置折叠动作是否带有滑动动画效果,panelBlockStyle:设置折叠样式风格，目前只支持blackbox和tree两种风格)
				var accordionPanelBox = new JDynamicAccordionPanel({id:"bizServiceDefinedAccordion3", slid:true, panelBlockStyle:"blackbox"});
				//添加折叠页（折叠页content部分引用的是另外一个组件）
				//第一个参数：json对象(slabID:slab页id,label:slab页label,contentHeight:slab页content部分的高度值)
				//第二个参数：需要引入的另一个组建的ComponetHandle(每个组建都有getComponetHandle()方法来获取组建句柄)
				//第三个参数：json对象(需要添加的用户参数信息，这个参数信息会在点击折叠页的回调函数中传递到具体的用户回调函数中)
				//第四个参数：函数对象引用(点击折叠页的时候会调用这个回调函数并将该折叠页对应的参数信息及用户参数信息传递到具体的用户回调函数中)
				accordionPanelBox.addInnerComponetSlab({slabID:"slab-1",label:"服务定义",contentHeight:"475px"}, tabPanelTemp.getComponetHandle(), null, null);

				//添加折叠页（折叠页content部分引用的是一个具体url）
				//第一个参数：json对象(slabID:slab页id,label:slab页label,contentHeight:slab页content部分的高度值)
				//第二个参数：字符串(折叠页content部分引入的具体url路径)
				//第三个参数：json对象(需要添加的用户参数信息，这个参数信息会在点击折叠页的回调函数中传递到具体的用户回调函数中)
				//第四个参数：函数对象引用(点击折叠页的时候会调用这个回调函数并将该折叠页对应的参数信息及用户参数信息传递到具体的用户回调函数中)
				accordionPanelBox.addPageSlab({slabID:"slab-2",label:"状态定义",contentHeight:"400px"}, "", null, null);

				accordionPanelBox.addInnerComponetSlab({slabID:"slab-3",label:"警告定义",contentHeight:"450px"}, tabPanelTemp3.getComponetHandle(), null, null);
				//设置折叠组建,处于展开状态的折叠页
				accordionPanelBox.expanseSlab("slab-1");

				//创建推拉box组件(animated:推拉速度("slow", "normal", "fast", or number))
				var jpullPanelObj = new JDynamicPullPanel({id:"jPull-1", label:"绘图", contentWidth:"400px", animated:"slow"});
				
				//添加标题工具按钮
				//第一个参数：json对象(btnID:按钮id,title:按钮title,icoClassName:按钮ico样式名称)
				//第三个参数：json对象(需要添加的用户参数信息，这个参数信息会在点击图标按钮的回调函数中传递到具体的用户回调函数中)
				//第四个参数：函数对象引用(点击按钮图标的时候会调用这个回调函数并将该折叠页对应的参数信息及用户参数信息传递到具体的用户回调函数中)
				jpullPanelObj.addTitleToolBtn({btnID:"btn-1", title:"按钮title", icoClassName:"set-panel-title-icomanagement"}, null, function(dataMap){
					alert(dataMap["btnID"]);
				});
				jpullPanelObj.addTitleToolBtn({btnID:"btn-2", title:"按钮title", icoClassName:"set-panel-title-icomanagement"}, null, function(dataMap){
					alert(dataMap["btnID"]);
				});
				jpullPanelObj.addTitleToolBtn({btnID:"btn-3", title:"按钮title", icoClassName:"set-panel-title-icomanagement"}, null, function(dataMap){
					alert(dataMap["btnID"]);
				});
				//添加推拉组件内部引入的组件
				jpullPanelObj.addInnerComponet(accordionPanelBox.getComponetHandle());
				//将推拉组件添加到id=rightRoot的div中
				jpullPanelObj.appendToContainer('body>div[id="rightRoot"]');

			
	});
	
</script>
</head>
<body>
	
	<div id="rightRoot" style="position:absolute;top:0px;left:0px;z-index:100;height:100%;width:100%"></div>

</body>
</html>