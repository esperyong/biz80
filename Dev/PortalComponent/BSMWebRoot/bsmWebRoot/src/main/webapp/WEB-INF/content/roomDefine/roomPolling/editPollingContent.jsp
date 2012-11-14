<!-- 机房-机房巡检-编辑巡检模板-编辑巡检内容 editPollingContent.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>编辑巡检内容 </title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" 
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/tongjifenxi.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
</head>

<script>
var toast = new Toast({position:"CT"});
if("<s:property value='modifyFlag' />" != null && "<s:property value='modifyFlag' />" == "true") {
	try{
		parent.window.toast.addMessage("操作成功");
		setTimeout(function(){
			parent.window.returnValue='true';
			parent.winClose();
			parent.opener.refreshWin();
			},1000);
	}catch(e){
		alert(e);
	}
}
</script>
<body>
<page:applyDecorator name="popwindow" >
<page:param name="title">编辑巡检内容</page:param>	
<page:param name="width">600px;</page:param>
<page:param name="topBtn_index_1">1</page:param>
<page:param name="topBtn_id_1">closeId</page:param>
<page:param name="topBtn_css_1">win-ico win-close</page:param>

<page:param name="bottomBtn_index_1">2</page:param>
<page:param name="bottomBtn_id_1">submit</page:param>
<page:param name="bottomBtn_text_1">确定</page:param>

<page:param name="bottomBtn_index_2">3</page:param>
<page:param name="bottomBtn_id_2">cancel</page:param>
<page:param name="bottomBtn_text_2">取消</page:param>

<page:param name="content">
<form id="editPollingContentFormID" action="" name="editPollingContentForm" method="post" >
<div class="pop" id="pollingContentId" style='height:100%;;overflow-x:hidden'>
<div class="pop-m">
	<div class="pop-content">
	<div class="margin3">
	<span class="black-btn-l right"><span class="btn-r"><span class="btn-m" id="addBtn"><a>添加</a></span></span></span>
	<span class="black-btn-l right"><span class="btn-r"><span class="btn-m" id="delBtn"><a>删除</a></span></span></span>
	</div>
      <table id="tb" class="black-grid black-grid-blackb">
      <tr>
      <th width="5%"><input type="checkbox" name="allCheck" id="allCheck" /></th>
	  <th width="40%">巡检内容</th>
	  <th width="40%">描述</th>
	  <th width="15%">顺序</th>
      </tr>
      <tr class="black-grid-graybg">
      <td><input type="checkbox" name="CK" id="CK" value=""/></td>
	  <td><input type="text" id="pollingContent" name="pollingContent" class="" /><span class="red">*</span></td>
	  <td><input type="text" id="desc" name="desc" class="" /></td>
	  <td>
	  	  <span class="tree-panel-ico tree-panel-ico-arrowup" style="cursor: pointer" onclick=offFun(this);></span>
		  <span class="tree-panel-ico tree-panel-ico-arrowdown" style="cursor: pointer" onclick=downFun(this);></span>
	  </td>
      </tr>
      </table>
	</div>  
</div>
</div>
<input type="hidden" name="pollingIndexId" id="pollingIndexId" value="<s:property value='pollingIndexId' />" />
<!-- 巡检内容（隐藏域）-->
<input type="hidden" name="pollingContentStr" id="pollingContentStr" value="<s:property value='pollingContentStr' />" />
<!-- 描述（隐藏域） -->
<input type="hidden" name="descStr" id="descStr" value="<s:property value='descStr' />" />
<!-- 展现巡检内容 ID（隐藏域） -->
<input type="hidden" name="pollingContentIdStr" id="pollingContentIdStr" value="<s:property value='pollingContentIdStr' />" />
<!-- 序号顺序（隐藏域） -->
<input type="hidden" name="indexNoStr" id="indexNoStr" value="<s:property value='indexNoStr' />" />
</form>
<iframe name="submitIframe" id="submitIframeId" frameborder="0" scrolling="no" height="0" width="0" src=""></iframe>
</page:param>
</page:applyDecorator>
</body>
</html>
<script>
$("#closeId").click(winClose);
$("#submit").click(function (){
	var $table = $("#tb");
	var trs = $table.find("tr");
	if(trs.length==2){
		window.toast.addMessage("没有巡检内容");
		//alert("没有巡检内容");
		return;
	}else{
		$("#editPollingContentFormID").attr("action","${ctx}/roomDefine/EditPollingContentVisit!editPollingContent.action");
		$("#editPollingContentFormID").attr("target","submitIframe");
		$("#tb tr:gt(0)").each(function() {
	        $(this).find("#CK").get(0).checked = true;
	    });
		$("#editPollingContentFormID").submit();
	}
});
$("#cancel").click(winClose);
function winClose() {
	window.close();
}
//初始颜色
function onloadGrey() {
	var $table = $("#tb");
	var trs = $table.find("tr");
	var $tr = $(trs[2]);
	for(var i=0;i<trs.length;i++){
		var forTr = $(trs[i]);
		$(forTr.find("span.tree-panel-ico")[0]).removeClass("tree-panel-ico-arrowup-off").addClass("tree-panel-ico-arrowup");
		$(forTr.find("span.tree-panel-ico")[1]).removeClass("tree-panel-ico-arrowdown-off").addClass("tree-panel-ico-arrowdown");
	}
	//首行箭头灰色
	$($tr.find("span.tree-panel-ico")[0]).removeClass("tree-panel-ico-arrowup").addClass("tree-panel-ico-arrowup-off");
	//last行向下箭头灰色
	$tr = $(trs[trs.length-1]);
	$($tr.find("span.tree-panel-ico")[1]).removeClass("tree-panel-ico-arrowdown").addClass("tree-panel-ico-arrowdown-off");
}
$(document).ready(function() {
	$("#editPollingContentFormID").validationEngine({
		promptPosition:"centerRight", 
		//validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	});
	 //隐藏模板tr
    $("#tb tr").eq(1).hide();
  	//默认有一行
	copyTR();
	//全选
	$("#allCheck").click(allCheckFun);
	$("#addBtn").bind("click",copyTR);
	$("#delBtn").bind("click",delTR);
    onloadGrey();

    var indexNoStr = $("#indexNoStr").val();
    var indexNoArr = indexNoStr.split(",");
    var pollingContentIdStr = $("#pollingContentIdStr").val();
    var pollingContentIdArr = pollingContentIdStr.split(",");
    var descStr = $("#descStr").val();
    var descArr = descStr.split(",");
    var pollingContentStr = $("#pollingContentStr").val();
    var pollingContentArr = pollingContentStr.split(",");
    if(null != indexNoStr && indexNoStr.length>0) {
	    for(var i=0;i<indexNoArr.length;i++){
	    	if(i==0){
			}else{
				copyTR();
			}
			setval(indexNoArr[i],pollingContentIdArr[i],descArr[i],pollingContentArr[i]);
	    }
    }
});
function allCheckFun() {
    $("#tb tr:gt(1)").each(function() {
        $(this).find("#CK").get(0).checked = $("#allCheck").get(0).checked;
    });
}
//上移一行
function offFun(obj) {
	var $obj = $(obj);
	if($obj.hasClass("tree-panel-ico-arrowup-off")){return;}
	var $tr = $obj.parent().parent();
	var $table = $obj.parent().parent().parent();
	var $pre = $tr.prev();
	//判断table的第一个元素（隐藏的）是不是点击的上一个元素。
	if($table.children().index($pre[0])==2){
		 $obj.removeClass("tree-panel-ico-arrowup").addClass("tree-panel-ico-arrowup-off");
		 $($pre.find("span.tree-panel-ico")[0]).removeClass("tree-panel-ico-arrowup-off").addClass("tree-panel-ico-arrowup");
		 $pre.before($tr);
	}
	if($table.children().index($pre[0])>2){
		$pre.before($tr);
	}
	if($table.children().index($pre[0])<2){
		$obj.removeClass("tree-panel-ico-arrowup").addClass("tree-panel-ico-arrowup-off");
		return;
	}
	onloadGrey();
}
//下移一行
function downFun(obj) {
	var $obj = $(obj);
	//if($obj.hasClass("tree-panel-ico-arrowdown-off")){return;}
	var $tr = $obj.parent().parent();
	var $table = $obj.parent().parent().parent();
	var $next = $tr.next();
	$next.after($tr);
	onloadGrey();
}
//删除一行
function delTR() {
	$("#tb tr:gt(1)").each(function() {
        if ($(this).find("#CK").get(0).checked == true) {
            $(this).remove();
        }
    });
    onloadGrey();
}
//整行复制
function copyTR() {
	var oldLen = $("#tb tr").length;
	$("#tb tr").eq(1).find("#pollingContent").addClass("validate[required]");
    var tr = $("#tb tr").eq(1).clone();
    $("#tb tr").eq(1).find("#pollingContent").removeClass("validate[required]");
    //tr.find("td").get(0).innerHTML = ++i;
    tr.show();
    tr.appendTo("#tb");
	onloadGrey();
}
/**
 *	设置默认值.
 */
 var viewIndex = 0;
function setval(indexNo,pollingContentId,desc,pollingContent) {
	//alert(indexNo+","+pollingContent);
	var pollingContentIdObj = $("#pollingContentId input[name='CK']");
	var pollingContentObj = $("#pollingContentId input[name='pollingContent']");
	var descObj = $("#pollingContentId input[name='desc']");
	$(pollingContentIdObj[viewIndex+1]).val($.trim(pollingContentId));
	$(pollingContentObj[viewIndex+1]).val($.trim(pollingContent));
	$(descObj[viewIndex+1]).val($.trim(desc));
	viewIndex++;
}
</script>