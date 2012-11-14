<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css" />
<link href="${ctxCss}/tongjifenxi.css" rel="stylesheet" type="text/css" />
<link href="${ctxCss}/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/button-module.css" rel="stylesheet"type="text/css">
<link href="${ctxCss}/jquery-ui/jquery.ui.treeview.css" rel="stylesheet"type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctxJs}/report/statistic/statisticUtil.js"></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript" src="${ctxJs}/component/tabPanel/tab.js"></script>
<script type="text/javascript" src="${ctxJs}/component/treeView/tree.js"></script>
<script type="text/javascript" src="${ctxJs}/component/menu/menu.js"></script> 
<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctxJs}/component/accordionPanel/accordionLeft.js"></script>
<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.timeentry.min.js"></script>
<page:applyDecorator name="popwindow" title="添加报告内容">
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">addReportInfo</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submitEditorUser</page:param>
	<page:param name="bottomBtn_text_1" >确定</page:param>

	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancelEditorUser</page:param>
	<page:param name="bottomBtn_text_2" >取消</page:param>

	<page:param name="content">
		<page:applyDecorator name="tabPanel">
		<page:param name="id">editorUserTable</page:param>
		<page:param name="width">600</page:param>
		<page:param name="tabBarWidth">500</page:param>
		<page:param name="cls">tab-grounp</page:param>
		<page:param name="current">1</page:param>
		<page:param name="tabHander">[{text:"常规信息",id:"rgeneralInfo"},{text:"访问权限设置",id:"accessingAuthority"},{text:"访问时间设置",id:"accessingTime"}]</page:param>
		<page:param name="content_1">
				<ul class="fieldlist-n">
					<li><span class="field-middle">用户类型：</span> <span id="userType">域管理员</span></li>
					<li><span class="field-middle">用户名：</span><span id="userByname">admin</span></li>
					<li><span class="field-middle">密码：</span><input type="text" id="userPassword"/> 
					</li>
					<li><span class="field-middle">确认密码：</span> <input type="text" id="userRePassword" onblur="checkoutPassword()"/>
					</li>
					<li><span class="field-middle">姓名：</span> <input type="text" id="userName" />
					</li>
					<li><span class="field-middle">所在部门：</span><span id="userDepartment">IT部门</span>
					</li>
					<li><span class="field-middle">手机号：</span> <input type="text" id="userPhone" onblur="checkoutNumber()"/>
					</li>
					<li><span class="field-middle">电子邮件：</span> <input type="text" id="userMail" onblur="checkoutMail()"/>
					</li>
					<li class="last"><span  class="field-middle multi-line">备注：</span> <textarea ></textarea></li>
				</ul>
			</page:param>	
		<page:param name="content_2">	
			
		</page:param>
		<page:param name="content_3">	
			<ul class="fieldlist-n">
					<li><span class="field-middle">访问时间：</span> <input type="radio"/><span>全天</span></li>
					<li><input type="radio"/><span>从</span><input type="text"  id="natPanel"/><span>到</span><input type="text"/></li>
					<li><span class="field-middle">用户锁定：</span><input
						type="checkbox" /><span>开启 ( 输入三次错误密码，系统锁定用</span><select>
						<option value="30">30分钟</option>
						<option value="60">60分钟</option>
						<option value="90">90分钟</option>
					</select>
					<span>)</span>
					</li>
				</ul>
		</page:param>
		</page:applyDecorator>
	</page:param>
</page:applyDecorator>
<script type="text/javascript">
$.timeEntry.setDefaults({show24Hours: true,showSeconds:true,spinnerImage: '/profile/images/time-select.gif',spinnerSize: [15, 16, 0],spinnerIncDecOnly: true,useMouseWheel: false,defaultTime: '09:00:00',timeSteps: [1, 1, 1]});
//校验密码
function checkoutPassword(){
	var password=$("#userPassword").val();
	var rePassword=$("#userRePassword").val();
	if(password!=rePassword){
		$("#userRePassword").val("");
		$("#userRePassword").focus();
	}
}
//邮箱校验
function checkoutMail(){
	var mail=$("#userMail").val();
	 var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	 if(!myreg.test(mail)){
		 $("#userMail").val("");
		 $("#userMail").focus();
	 }	 
}
//校验号码
function checkoutNumber(){
	var num=$("#userPhone").val();
	var mobile=/^1[3-9]\d{9}$/;
	if(!mobile.test(num)){
		$("#userPhone").val("");
		 $("#userPhone").focus();
	}
}
$("#natPanel").timeEntry();
function setTimeStyle(){
	$('[name$=Time]','#natPanel').timeEntry();
}
$(document).ready(function(){
	//标志是否再次加载页面,true表示加载,flase标识不再加载
	var statisticFlag=new Array(false,true);
	var statisticFunction=new Array("loadResource","loaduserDefined");	
	var tp = new TabPanel({id:"editorUserTable",
		listeners:{
	        change:function(tab){	        	        		        	
	        }
    	}}
	);	
});
//确定提交
$("#submitEditorUser").click(function(){
	closeWindow();
})
//取消提交
$("#cancelEditorUser").click(function(){
	closeWindow();
})
</script>
