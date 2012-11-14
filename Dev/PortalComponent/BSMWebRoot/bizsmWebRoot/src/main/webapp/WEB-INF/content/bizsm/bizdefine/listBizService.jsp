<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
 author:qiaozheng
 description:业务服务列表
 uri:{domainContextPath}/bizservice/?canAdoptByServiceId={bizserviceId}

 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>列出所有业务服务列表选择业务服务到topo</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	.bizimgnobr{display:inline-block;width:70px;overflow:hidden;border:0px solid red;text-overflow:ellipsis;cursor:hand}
</style>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/ajaxcommon.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>
<script>
 $(function(){

		//OVERFLOW-Y: scroll; OVERFLOW-X: hidden; WIDTH: 100%; HEIGHT: 275px;
		$('div.img-show').css({width:"100%",height:"250px",overflowY:"auto",overflowX:"hidden"});


		$('#bizServiceImg-box>ul>li').click(function(event){
			var $this = $(this);

			event.stopPropagation();

			var $oldClicked = $('#bizServiceImg-box>ul>li.on');
			$oldClicked.removeClass("on");
			$oldClicked.attr("isClicked", "false");

			$this.attr("isClicked", "true");
			$this.addClass("on");
			//call flash
			parent.choose("bizservice", $this.find(">nobr>span").attr("uri"));
		});

		$('#bizServiceImg-box>ul>li').hover(function(){
			var $this = $(this);
			$this.addClass("on");
		}, function(){
			var $this = $(this);
			if($this.attr("isClicked") != "true"){
				$this.removeClass("on");
			}
		});

		$('div.set-panel-content-white').click(function(event){
			var $oldClicked = $('#bizServiceImg-box>ul>li.on');
			$oldClicked.removeClass("on");
			$oldClicked.attr("isClicked", "false");

			//call flash (取消当前tab页中选中的内容)
			parent.unChoose();
		});

 });
</script>
</head>
<body>
	<div class="set-panel-content-white">
		<div class="sub-panel-open">
			<div class="sub-panel-top">
				<span class="sub-panel-title"><s:text name="i18n.bizservice.bizdefine.2" /></span>
			</div>
			<s:if test="model.services.size == 0">
				<div id="bizServiceImg-box" class ="img-show">
					<span class='nodata-l'><span class='nodata-r'><span class='nodata-m'><span class='icon'>当前无数据</span></span></span></span>
				</div>
			</s:if>
			<s:else>
				<div id="bizServiceImg-box" class ="img-show">
					<ul>
					<s:iterator value="model.services" status="status">
						<s:if test="#status.count>0">
						<li>
							<nobr>
							<img src="${ctx}/images/bizservice-default/default-bizservice-icon.png"/>
							<span class="bizimgnobr" title='<s:property value="name"/>' uri='<s:property value="uri"/>' bizId='<s:property value="bizId"/>'>
								<s:property value="name"/>
								<input type="hidden" name="uri" value="<s:property value="uri"/>" />
								<input type="hidden" name="bizId" value="<s:property value="bizId"/>" />
							</span>
							</nobr>
						</li>
						</s:if>
					</s:iterator>
					</ul>
				</div>
			</s:else>
		</div>
	</div>
</body>
</html>