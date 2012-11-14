<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
 author:qiaozheng
 description:用户自定义元素
 uri:{domainContextPath}/bizsm/bizservice/ui/custom-graph-element
 -->
<%@ page import="com.mocha.bsm.bizsm.adapter.event.BizServiceStateChangeEvent"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%
	String serviceID = request.getParameter("serviceId");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>用户自定义元素</title>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.nobrName{
        width: 200px;
        overflow: hidden;
        border: 0px solid red;
        text-overflow:ellipsis;
    }
-->
</style>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/ajaxcommon.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js "></script>
<script>
$(function(){
	$('div.sub-panel-content').hide();
	$('div.img-show').css({width:"100%"});
	$('div.set-panel-content-white').css({width:"100%",height:"270px",overflowY:"auto",overflowX:"hidden"});

	//绑定切换地图select change事件
	$('#custom-gp-map-sel').bind("change", function(){
		var mapSelVal = this.value;
		if("china" == mapSelVal){
			f_loadImage("folder/bizsm-customelement-map-china-icon/image/", "img-box-custom-gp-map");
		}else if("world" == mapSelVal){
			f_loadImage("folder/bizsm-customelement-map-world-icon/image/", "img-box-custom-gp-map");
		}
	});

	//绑定点击图标slab事件
	$('span[elID="userImg-open-hot"]').toggle(function(){
		var $this = $(this);
		var $content = $this.parents('div.sub-panel-open').find('div.sub-panel-content');
		var areaKey = $content.find('>div[id]').attr("id");
		if(areaKey == "img-box-custom-gp-baseshape"){
			f_loadImage("folder/bizsm-customelement-baseshape-icon/image/", areaKey);
		}else if(areaKey == "img-box-custom-gp-workflow"){
			f_loadImage("folder/bizsm-customelement-workflow-icon/image/", areaKey);
		}else if(areaKey == "img-box-custom-gp-areanode"){
			f_loadImage("folder/bizsm-customelement-areanode-icon/image/", areaKey);
		}else if(areaKey == "img-box-custom-gp-background"){
			f_loadImage("folder/bizsm-customelement-background-icon/image/", areaKey);
		}else if(areaKey == "img-box-custom-gp-map"){
			$('#custom-gp-map-sel').change();
		}

		$content.slideDown(300, function(){
			$this.removeClass("ico-plus").addClass("ico-minus");
		});
	}, function(){
		var $this = $(this);
		var $content = $this.parents('div.sub-panel-open').find('div.sub-panel-content');
		$content.slideUp(300, function(){
			$this.removeClass("ico-minus").addClass("ico-plus");
		});
	});
	//触发图标列表第一个slab
	if(parent.currentServiceRunState == "false"){
		$('span[elID="userImg-open-hot"]').eq(0).click();
	}

	//点击页面,取消选中图标
	$('div.set-panel-content-white').click(function(event){
		var $oldClicked = $('li.on');
		$oldClicked.removeClass("on");
		$oldClicked.attr("isClicked", "false");
		//call flash (取消当前tab页中选中的内容)
		parent.unChoose();
	});

});

/**
* 加载图标
* param uri 请求图标列表uri
* param areaKeyID 图标显示区域元素id
*/
function f_loadImage(uri, areaKeyID){
	//显示加载状态条
	$.blockUI({message:$('#loading')});

	$.get('${ctx}/'+uri,{},function(data){
		var dataDom = func_asXMLDom(data);
		var $data = $(dataDom);

		var $ul = $data.find('body>ul');
		var $imgHref = $ul.find('>li.image>a');

		var $imgUL = $("#"+areaKeyID);
		$imgUL.empty();

		$imgHref.each(function(cnt){
			var $href = $(this);
			var $img = $('<img src="${ctx}/'+$href.attr("uri")+'"/>');
			var $span = $('<span style="cursor:hand">'+$href.text()+'</span>');
			var $li = $('<li uri="'+$href.attr("uri")+'" shapeType="'+$href.attr("shapeType")+'"></li>');
			$li.append($img);
			$li.append($span);
			$imgUL.append($li);
		});
		//所有图标加载完成后,绑定图标选中效果.
		f_bindSelect(areaKeyID);

		$.unblockUI();// 屏蔽loading
	});
}

/**
* 绑定图标选中效果及点击事件
*
*/
function f_bindSelect(areaKeyID){
	//判断业务服务是否处于启用状态
	if(parent.currentServiceRunState == "false"){
		//设置鼠标移动图片选中效果
		$("#"+areaKeyID+'>li').hover(function(){
			var $this = $(this);
			$this.addClass("on");
		}, function(){
			var $this = $(this);
			if($this.attr("isClicked") != "true"){
				$this.removeClass("on");
			}
		});
	}

	//点击图片设置选中效果及标识
	$("#"+areaKeyID+'>li').click(function(event){
		var $this = $(this);

		event.stopPropagation();

		//判断业务服务是否处于启用状态
		if(parent.currentServiceRunState == "false"){
			var $oldClicked = $('li.on');

			$oldClicked.removeClass("on");
			$oldClicked.attr("isClicked", "false");

			$this.attr("isClicked", "true");
			$this.addClass("on");

			var uriStr = "${ctx}/"+$this.attr("uri");
			//var imgBoxID = $this.parents('div.img-show').attr("id");

			uriStr = uriStr.replace("-icon", "");
			if(areaKeyID == "img-box-custom-gp-baseshape"){
				var shapeTypeTemp = $this.attr("shapeType");
				//call flash.
				parent.createCustomShape(shapeTypeTemp, "");
			}else if(areaKeyID == "img-box-custom-gp-workflow"){
				var shapeTypeTemp = $this.attr("shapeType");
				if(shapeTypeTemp == "hSwim"
					|| shapeTypeTemp == "vSwim"){
					parent.choose("flow", shapeTypeTemp);//call flash.
				}else{
					parent.createCustomPicture("flow", uriStr, "");//call flash.
				}
			}else if(areaKeyID == "img-box-custom-gp-areanode"){
				parent.createCustomPicture("area", uriStr, "");//call flash.
			}else if(areaKeyID == "img-box-custom-gp-map"){
				parent.createCustomPicture("map", uriStr, "");//call flash.
			}else if(areaKeyID == "img-box-custom-gp-background"){
				parent.createCustomPicture("bgd", uriStr, "");//call flash.
			}
		}

	});
}


/*

//加载中国地图数据
function f_loadGpMapChina(){
	//显示加载状态条
	$.blockUI({message:$('#loading')});

	$.get('${ctx}/folder/bizsm-customelement-map-china-icon/image/',{},function(data){
		var dataDom = func_asXMLDom(data);
		var $data = $(dataDom);

		var $ul = $data.find('body>ul');
		var $imgHref = $ul.find('>li.image>a');

		var $imgUL = $('#img-box-custom-gp-map>ul');
		$imgUL.empty();

		$imgHref.each(function(cnt){
			var $href = $(this);
			var $img = $('<img src="${ctx}/'+$href.attr("uri")+'"/>');
			var $span = $('<span style="cursor:hand">'+$href.text()+'</span>');
			var $li = $('<li uri="'+$href.attr("uri")+'" shapeType="'+$href.attr("shapeType")+'"></li>');
			$li.append($img);
			$li.append($span);
			$imgUL.append($li);
		});
		//f_loadGpBackground();
		//所有图标加载完成后,绑定图标选中效果.
		f_bindSelect("img-box-custom-gp-map");
		$.unblockUI();// 屏蔽loading
	});
}

//加载世界地图数据
function f_loadGpMapWorld(){
	//显示加载状态条
	$.blockUI({message:$('#loading')});

	$.get('${ctx}/folder/bizsm-customelement-map-world-icon/image/',{},function(data){
		var dataDom = func_asXMLDom(data);
		var $data = $(dataDom);

		var $ul = $data.find('body>ul');
		var $imgHref = $ul.find('>li.image>a');

		var $imgUL = $('#img-box-custom-gp-map>ul');
		$imgUL.empty();

		$imgHref.each(function(cnt){
			var $href = $(this);
			var $img = $('<img src="${ctx}/'+$href.attr("uri")+'"/>');
			var $span = $('<span style="cursor:hand">'+$href.text()+'</span>');
			var $li = $('<li uri="'+$href.attr("uri")+'" shapeType="'+$href.attr("shapeType")+'"></li>');
			$li.append($img);
			$li.append($span);
			$imgUL.append($li);
		});
		//所有图标加载完成后,绑定图标选中效果.
		f_bindSelect("img-box-custom-gp-map");
		$.unblockUI();// 屏蔽loading
	});
}

//加载基本形状数据
function f_loadGpBaseShape(){
	$.get('${ctx}/folder/bizsm-customelement-baseshape-icon/image/',{},function(data){
		var dataDom = func_asXMLDom(data);
		var $data = $(dataDom);

		var $ul = $data.find('body>ul');
		var $imgHref = $ul.find('>li.image>a');

		var $imgUL = $('#img-box-custom-gp-baseshape>ul');
		$imgUL.empty();

		$imgHref.each(function(cnt){
			var $href = $(this);
			var $img = $('<img src="${ctx}/'+$href.attr("uri")+'"/>');
			var $span = $('<span style="cursor:hand">'+$href.text()+'</span>');
			var $li = $('<li uri="'+$href.attr("uri")+'" shapeType="'+$href.attr("shapeType")+'"></li>');
			$li.append($img);
			$li.append($span);
			$imgUL.append($li);
		});
		f_loadGpWorkFlow();
	});
}

//加载流程图数据
function f_loadGpWorkFlow(){
	$.get('${ctx}/folder/bizsm-customelement-workflow-icon/image/',{},function(data){
		var dataDom = func_asXMLDom(data);
		var $data = $(dataDom);

		var $ul = $data.find('body>ul');
		var $imgHref = $ul.find('>li.image>a');

		var $imgUL = $('#img-box-custom-gp-workflow>ul');
		$imgUL.empty();

		$imgHref.each(function(cnt){
			var $href = $(this);
			var $img = $('<img src="${ctx}/'+$href.attr("uri")+'"/>');
			var $span = $('<span style="cursor:hand">'+$href.text()+'</span>');
			var $li = $('<li uri="'+$href.attr("uri")+'" shapeType="'+$href.attr("shapeType")+'"></li>');
			$li.append($img);
			$li.append($span);
			$imgUL.append($li);
		});
		f_loadGpAreaAndNode();
	});
}

//加载区域与节点图数据
function f_loadGpAreaAndNode(){
	$.get('${ctx}/folder/bizsm-customelement-areanode-icon/image/',{},function(data){
		var dataDom = func_asXMLDom(data);
		var $data = $(dataDom);

		var $ul = $data.find('body>ul');
		var $imgHref = $ul.find('>li.image>a');

		var $imgUL = $('#img-box-custom-gp-areanode>ul');
		$imgUL.empty();

		$imgHref.each(function(cnt){
			var $href = $(this);
			var $img = $('<img src="${ctx}/'+$href.attr("uri")+'"/>');
			var $span = $('<span style="cursor:hand">'+$href.text()+'</span>');
			var $li = $('<li uri="'+$href.attr("uri")+'"></li>');
			$li.append($img);
			$li.append($span);
			$imgUL.append($li);
		});
		f_loadGpMapChina();
	});
}

//加载背景数据
function f_loadGpBackground(){
	$.get('${ctx}/folder/bizsm-customelement-background-icon/image/',{},function(data){
		var dataDom = func_asXMLDom(data);
		var $data = $(dataDom);

		var $ul = $data.find('body>ul');
		var $imgHref = $ul.find('>li.image>a');

		var $imgUL = $('#img-box-custom-gp-background>ul');
		$imgUL.empty();

		$imgHref.each(function(cnt){
			var $href = $(this);
			var $img = $('<img src="${ctx}/'+$href.attr("uri")+'"/>');
			var $span = $('<span style="cursor:hand">'+$href.text()+'</span>');
			var $li = $('<li uri="'+$href.attr("uri")+'"></li>');
			$li.append($img);
			$li.append($span);
			$imgUL.append($li);
		});
		//所有图标加载完成后,绑定图标选中效果.
		f_bindSelect();

		$.unblockUI();// 屏蔽loading
	});
}
*/

</script>
</head>
<body>
	 <div class="set-panel-content-white">
	   <!--基本形状 start-->
	   <div class="sub-panel-open">
		  <div class="sub-panel-top"><span elID="userImg-open-hot" class="ico ico-plus"></span><span class="sub-panel-title vertical-middle">基本形状</span></div>
		  <div class="sub-panel-content">
			<div id="img-box-custom-gp-baseshape" class="img-show">
			  <ul>
			  </ul>
			</div>
		  </div>
	   </div>
	   <!--基本形状 end-->
	   <!--流程 start-->
	   <div class="sub-panel-open">
		<div class="sub-panel-top"><span  elID="userImg-open-hot" class="ico ico-plus"></span><span class="sub-panel-title vertical-middle">流程</span></div>
		  <div class="sub-panel-content">
			<div id="img-box-custom-gp-workflow" class="img-show">
			  <ul>
			  </ul>
			</div>
		  </div>
		</div>
		<!--流程 end-->
		<!--区域与节点 start-->
		<div class="sub-panel-open">
		  <div class="sub-panel-top"><span  elID="userImg-open-hot" class="ico ico-plus"></span><span class="sub-panel-title vertical-middle">区域与节点</span></div>
		  <div class="sub-panel-content">
			<div id="img-box-custom-gp-areanode" class="img-show">
			  <ul>
			  </ul>
			</div>
		  </div>
		</div>
		<!--区域与节点 end-->
		<!--地图 start-->
		<div class="sub-panel-open">
		  <div class="sub-panel-top"><span  elID="userImg-open-hot" class="ico ico-plus"></span><span class="sub-panel-title vertical-middle">地图</span></div>
		  <div class="sub-panel-content">
			<div>
				&nbsp;&nbsp;&nbsp;&nbsp;请选择图片类型：
				<select id="custom-gp-map-sel">
					<option value="china">中国地图</option>
					<option value="world">世界地图</option>
				</select>
			 </div>
			<div id="img-box-custom-gp-map" class="img-show">
			  <ul>
			  </ul>
			</div>
		  </div>
		</div>
		<!--地图 end-->
		<!--背景 start-->
		<div class="sub-panel-open">
		  <div class="sub-panel-top"><span  elID="userImg-open-hot" class="ico ico-plus"></span><span class="sub-panel-title vertical-middle">背景</span></div>
		  <div class="sub-panel-content">
			<div id="img-box-custom-gp-background" class="img-show">
			  <ul>
			  </ul>
			</div>
		  </div>
		</div>
		<!--背景 end-->
	 </div>

	<div class="loading" id="loading" style="display:none;">
	 <div class="loading-l">
	  <div class="loading-r">
		<div class="loading-m">
		   <span class="loading-img">载入中，请稍候...</span>
		</div>
	  </div>
	  </div>
	</div>

</body>
</html>