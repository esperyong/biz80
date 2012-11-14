<!-- WEB-INF\content\location\define\handles.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>

<!--按钮群 -->
<div class="button-module">
    <ul class="button-module" id="topbtn">
	<s:if test="location==null || location.type==@com.mocha.bsm.location.enums.LocationTypeEnum@LOCATION_DOMAIN.key">
        <li href="${ctx}/location/define/defineflash.action" class="focus" ><span></span><s:a href="javascript:void(0);">定义区域结构</s:a></li>
        <li href="${ctx}/location/design/locationmapdesign!showPaintArea.action"><span></span><s:a href="javascript:void(0);">绘制区域</s:a></li>
        <li href="${ctx}/location/relation/device!showAssociateFixing.action"><span></span><s:a href="javascript:void(0);">关联设备</s:a></li>
        <li href="${ctx}/location/status/status!showDefineStatus.action"><span></span><s:a href="javascript:void(0);">定义状态</s:a></li>
	</s:if>
	<s:elseif test="location.type==@com.mocha.bsm.location.enums.LocationTypeEnum@LOCATION_BUILDER.key || location.type==@com.mocha.bsm.location.enums.LocationTypeEnum@LOCATION_AREA.key">
        <li href="${ctx}/location/design/locationmapdesign!showPaintArea.action" ><span></span><s:a href="javascript:void(0);">绘制子区域</s:a></li>
        <li href="${ctx}/location/relation/device!showAssociateFixing.action" class="focus"><span></span><s:a href="javascript:void(0);">关联设备</s:a></li>
        <li href="${ctx}/location/status/status!showDefineStatus.action" ><span></span><s:a href="javascript:void(0);">定义状态</s:a></li>
	</s:elseif>
    <s:elseif test="location.type==@com.mocha.bsm.location.enums.LocationTypeEnum@LOCATION_FLOOR.key">
        <li href="${ctx}/location/design/locationmapdesign!showPaintArea.action" ><span></span><s:a href="javascript:void(0);">绘制子区域</s:a></li>
        <li href="${ctx}/location/relation/device!showAssociateFixing.action" class="focus"><span></span><s:a href="javascript:void(0);">关联设备</s:a></li>
        <li href="${ctx}/location/status/status!showDefineStatus.action" ><span></span><s:a href="javascript:void(0);">定义状态</s:a></li>
        <s:if test="netLicense == 'yes'">
        	<li href="${ctx}/location/relation/network.action" ><span></span><s:a href="javascript:void(0);">关联拓扑</s:a></li>
        </s:if>
        <li href="${ctx}/location/relation/electricityMap!showAssociateElectricityMap.action" ><span></span><s:a href="javascript:void(0);">关联布电图</s:a></li>
	</s:elseif>
    <s:else>
        <li href="${ctx}/location/design/locationmapdesign!showPaintArea.action" ><span></span><s:a href="javascript:void(0);">绘制子区域</s:a></li>
        <li href="${ctx}/location/relation/device!showAssociateFixing.action" class="focus"><span></span><s:a href="javascript:void(0);">关联设备</s:a></li>
        <li href="${ctx}/location/status/status!showDefineStatus.action" ><span></span><s:a href="javascript:void(0);">定义状态</s:a></li>
        <s:if test="netLicense == 'yes'">
        	<li href="${ctx}/location/relation/network.action" ><span></span><s:a href="javascript:void(0);">关联拓扑</s:a></li>
        </s:if>
   	</s:else>
	</ul>
  <div class="clear"></div>
</div>
<s:if test="location==null">
<!--透明层按钮 -->
<div class="alpha"></div>
</s:if>

<script type="text/javascript">
	$(document).ready(function () {
		topBtn();
		$("#topbtn li")[0].click();
	});
	
	function topBtn(){
		
		var $currentLi = null;
		var $lis = $("#topbtn li");
		function click(){
			var $li = $(this);
			var href = $li.attr("href");
			var locationId = $li.attr("locationId");
			//start 切换页签 判断flash是否变化
			if($("#location_flashchangeflag").val()==1){
				var _confirm = new confirm_box({text:"页面已修改，是否保存？"});
				_confirm.setConfirm_listener(function(){
					doIt();
					$("#location_flashchangeflag").val(0);
					_confirm.hide();
					loadContent(href,locationId);
				});
				_confirm.setCancle_listener(function(){
					//doIt();
					$("#location_flashchangeflag").val(0);
					_confirm.hide();
					loadContent(href,locationId);
				});
				_confirm.show();
				}else{
					loadContent(href,locationId);
					}
				//end
			$currentLi.removeClass("focus");
			$li.addClass("focus");
			$currentLi = $li;
		}

		for(var i=0,len=$lis.length;i<len;i++){
			var $li = $($lis[i]);
			if($li.hasClass("focus")){
				$currentLi=$li;
			}
			$li.click(click);
		}
	}
</script>