<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/common/taglibs.jsp" %>
    <%@ include file="/WEB-INF/common/meta.jsp" %>
    <%@page import="java.util.List"%>
    
    <%--
    <div id="loading" class="loading for-inline" style="display:none;">
  		<span class="vertical-middle loading-img for-inline"></span><span class="suojin1em">载入中，请稍候...</span>
	</div>
     --%>
<script src="${ctx}/js/component/date/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
$wdate = true;
</script>
<page:applyDecorator name="headfoot" >
	<page:param name="head">
		<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css">
	    <%--
	    <script src="${ctx}/js/jquery.blockUI.js" type="text/javascript"></script>
	    <script type="text/javascript">
	    	$.blockUI({message:$('#loading')});
	    </script>
	     --%>
		<script src="${ctx}/js/component/comm/winopen.js"></script>
		<script src="${ctx}/js/homepage/homepage.js"></script>
	</page:param>
    <page:param name="body" >
	<div class="business-monitor" style="height:500px;">
  		<div class="top-l">
    		<div class="top-r">
      			<div class="top-m">
      			<div class="logo">
      				<img id="pptlog" style="float:left" src="../${defaultView.imgPath}" alt="LOGO" onerror="this.style.display='none'" onload="javascript:resizeImg(this,190,40)">
      			</div>
        			<div class="title" id="homepage_title" style="max-width: 500px; text-overflow: ellipsis; overflow: hidden;white-space: nowrap;font-family: '黑体'">${defaultView.viewTitle}</div>
        			<div class="operation">
          			<div class="operation-btn0">
          <span class="operation-btn0-l"><span class="operation-btn0-r"><span class="operation-btn0-m">
          	  <span class="img full" id="pptplay" method="start" title="全屏" style="margin:0px 2px 0px 5px;"></span>
          	  <span class="img wall" method="setting" id="pptsetting" title="设置" style="margin:0px 2px 0px 5px;"></span></span></span></span>
          </div>
          <div class="operation-page">
            <ul id="homepage_btn">
            	<s:if test="viewList != null">
	            	<s:iterator value="viewList" status="s" id="view">
						<li pagenum="${view.id}" <s:if test="#view.id==defaultView.id">class="on"</s:if> <s:if test="#view.isEffective==true">url="${view.url}" pagename="${view.viewTitle}" imgpath="${ctx}/${view.imgPath}" bigImgPath="/pureportal/images/homepage-img/${view.id}.jpg" title="${view.viewTitle}"</s:if><s:else>class="not-allowed" title="未设置"</s:else> >${view.id}</li>
					</s:iterator>
            	</s:if>
            	<s:else>
            		<%for (int i = 1;i<=10;i++){%>
						<li pagenum="<%=i %>" class="not-allowed" title="未设置"><%=i %></li>
            		<%} %>
            	</s:else>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="mid-l">
    <div class="mid-r">
      <div class="mid-m" id="homepage_ppt" style="position:relative;overflow:hidden;height:590px;">
        <div class="layers"   style="z-index:99;position:relative;">
        	<img src="${ctx}/images/tishi.png" style="margin-top: 100px;margin-left: 500px;display: none;"/>
        </div>
      </div>
    </div>
  </div>
  <div class="bottom-l">
    <div class="bottom-r">
      <div class="bottom-m"></div>
    </div>
  </div>
</div>
</page:param>
    </page:applyDecorator>

<script type="text/javascript">
				var homepage = new HomePage();
				var f = '${frequency}' || 10;
				homepage.init({autostep:( f * 1000)});
				var $btn = $('#homepage_btn');
				var btns = $btn.children('[url]');
        $(function(){
           $("#homepage_ppt").width(Index.centerWidth()-40);
           $("#homepage_ppt").height(Index.centerHeight()-86);

        });


</script>