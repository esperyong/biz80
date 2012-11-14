<!-- WEB-INF\content\location\design\imageEdit.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>图片管理</title>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/component/cfncc.js"></script>
<script src="${ctxJs}/component/tabPanel/tab.js"></script>
<script src="${ctxJs}/component/panel/panel.js" type="text/javascript"></script>
<script src="${ctxJs}/component/accordionPanel/accordionPanel.js" type="text/javascript"></script>
<script src="${ctxJs}/component/accordionPanel/accordionAddSubPanel.js" type="text/javascript"></script>
<script src="${ctxJs}/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctxJs}/component/combobox/simplebox.js"></script>
<script type="text/javascript" src="${ctxJs}/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctxJs}/component/popwindow/popwin.js"></script>
<script type="text/javascript">
function showMess(mes){
	var toast = new Toast({position:"CT"});
	toast.addMessage(mes);
	}


$(document).ready(function() {
	var win;
	
	var one = new AccordionPanel({id:"one"},
			{DomStruFn:"addsub_accordionpanel_DomStruFn",
			DomCtrlFn:"addsub_accordionpanel_DomCtrlFn"
				});

	var two = new AccordionPanel({id:"two"},
			{DomStruFn:"addsub_accordionpanel_DomStruFn",
			DomCtrlFn:"addsub_accordionpanel_DomCtrlFn"
				});
	
	$("#add").click(function(){
		win=window.open("${ctx}/location/design/designImage!uploadImage.action?designImage.type="+$("#image_type").val(),"open_image_1","width=510,height=175");
	});
	$("#del").click(function(){
		var ids="designImage.id=";
		
		var jsonids=$("input[name='designImage.id']:checked");	
		jsonids.each(function(i,e){
		ids+=$(e).val()+",";
		
		});
		
		if($("input[name='designImage.id']:checked").length>0){
			
			var confirm_batdel = new confirm_box({text:"该操作不可恢复，是否确认删除？"});
	    		confirm_batdel.show();
	    		confirm_batdel.setConfirm_listener(function(){
	    		confirm_batdel.hide();
		    				$.ajax({
								url: 		"designImage!delete.action",
								data:		ids,//$("input[name='designImage.id']:checked").serialize(),
								dataType: 	"json",
								cache:		false,
								success: function(data, textStatus){
									if(data.operationFlag=="succee"){
										showMess("自定义图片删除成功");
										window.location.reload();
									} else {
										showMess("自定义图片删除失败");
									}
								}
							});
		    	});
		    	
		    	confirm_batdel.setCancle_listener(function(){
		    		confirm_batdel.hide();
					});
			
			
		
		} else {
			showMess("请选择要删除的自定义图片");
		}

	});
	$("#edit").click(function(){
		if($("input[name='designImage.id']:checked").length>0){
			if($("input[name='designImage.id']:checked").length>1){
				showMess("请选择1个要修改的自定义图片");
				return ;
			}
			window.open("${ctx}/location/design/designImage!editImage.action?designImage.id="+$("input[name='designImage.id']:checked").val())
		} else {
			showMess("请选择要修改的自定义图片");
		}
	});
	$("#image_type").change(function(){
		window.location.reload("${ctx}/location/design/designImage!imageEdit.action?designImage.type="+$("#image_type").val())
	})
	$("#submit").click(function(){
		opener.reloadPageSlab();
		window.close();
		if(win!=null){
			win.close();
			}
	});
	$("#cancel").click(function(){
		window.close();
		if(win!=null){
			win.close();
			}
	});
	$("#closeId").click(function(){
		window.close();
		if(win!=null){
			win.close();
			}
	});
	$("#apply").click(function(){
		$("#submit").click();
	});
	
});
</script>
</head>
<body >

<page:applyDecorator name="popwindow"  title="图片管理">
	
	<page:param name="width">370px</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submit</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
	<page:param name="content">
<s:form id="editImage">
	<s:select name="designImage.type" id="image_type" list="imageTypeList" listKey="key" listValue="%{getText(value)}"></s:select>
	
	<page:applyDecorator name="accordionAddSubPanel">  
		<page:param name="id">one</page:param>
		<page:param name="title">默认图片</page:param>
		<page:param name="width">350px</page:param>
	   <page:param name="height">170px</page:param>
		<page:param name="cls">fold-blue</page:param>
		<page:param name="content" >
		<div class="img-show" style="overflow:auto;height:165px">
			<s:iterator value="images" id="image">
				<s:if test="#image.isdefault=='true'">
					<li  id="${id }">
					<img src="${ctx}/location/design/designImage!getImage.action?designImage.id=${id}" id="${id}" height="40" width="40"/>
					<span class="more">${name }</span>
					</li>
				</s:if>
			</s:iterator>
		</div>
		</page:param>
	</page:applyDecorator>
	
    <page:applyDecorator name="accordionAddSubPanel">  
       <page:param name="id">two</page:param>
       <page:param name="title">自定义图片</page:param>
       <page:param name="width">350px</page:param>
	   <page:param name="height">150px</page:param>
       <page:param name="cls">fold-blue</page:param>
       
       <page:param name="topBtn_Index_3">3</page:param>
       <page:param name="topBtn_Id_3">add</page:param>
       <page:param name="topBtn_Text_3">添加</page:param>
       <page:param name="topBtn_Index_2">2</page:param>
       <page:param name="topBtn_Id_2">edit</page:param>
       <page:param name="topBtn_Text_2">修改</page:param>
       <page:param name="topBtn_Index_1">3</page:param>
       <page:param name="topBtn_Id_1">del</page:param>
       <page:param name="topBtn_Text_1">删除</page:param>
       <page:param name="content">
      <div class="img-show" style="overflow:auto;height:145px">
			<s:iterator value="images" id="image">
				
			<s:if test="#image.isdefault=='false'">
				<li  id="${id }">
					<img src="${ctx}/location/design/designImage!getImage.action?designImage.id=${id}" id="${id}" height="40" width="40"/>
					<span class="more"><INPUT type="checkbox" name="designImage.id" value="${id}">${name }</span>
				</li>
			</s:if> 
			</s:iterator>
		</div>
	   </page:param>
    </page:applyDecorator>
</s:form>
	</page:param>
</page:applyDecorator>

</body>
</html>