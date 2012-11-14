<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<title>发现页面</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/topn.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
var ctxpath = "${ctx}";
function resizeFrameHeight() {
  var ifm= document.getElementById("iframe_discovery");
  var subWeb = document.frames ? document.frames["iframe_discovery"].document : ifm.contentDocument;
  if(ifm != null && subWeb != null) {
    ifm.height = subWeb.body.scrollHeight;
  }
  parent.resizeFrameHeight();
};
</script>
</head>
<body>

<div class="loading" id="loading" style="display:none;">
  <div class="loading-l">
    <div class="loading-r">
      <div class="loading-m"><span class="loading-img"><s:text name="page.loading.msg" /></span></div>
   </div>
  </div>
</div> 

<div id="find-right">
<div class="h1"><span class="title">批量添加</span></div>
<div class="h2"><div class="ico-title ico-title-explain">1. Excle导入的方式添加路由器、交换机、服务器等网络设备。2. 设备直接入资源库。3. 只能监控设备的可用性和响应时间。</div></div>
<div>

	<page:applyDecorator name="accordionPanel">
		<page:param name="id">panel_disc_domain</page:param>
		<page:param name="title">1.选择所属<%=domainPageName%></page:param>
		<page:param name="height"></page:param>
		<page:param name="width">690px</page:param>
		<page:param name="cls">fold</page:param>
		<page:param name="display"></page:param>
		
    <page:param name="content">
			<ul class="fieldlist">
				<li>
					<span class="" style="word-break:break-all;">所属<%=domainPageName%></span>：<span><s:select id="domainId" name="domainId" list="allDomainList" listKey="ID" listValue="name"></s:select>
					<span class="red">*</span><span class="ico ico-what" title="待发现资源的所属<%=domainPageName%>，设置其管理权限。"></span></span>
				</li>
			</ul>
		</page:param>		  
	</page:applyDecorator>
	
	<form id="uploadForm" name="uploadForm" method="post" enctype="multipart/form-data">
	<page:applyDecorator name="accordionPanel">
		<page:param name="id">panel_disc_upload</page:param>
		<page:param name="title">2.上传Excel文件</page:param>
		<page:param name="height"></page:param>
		<page:param name="width">690px</page:param>
		<page:param name="cls">fold</page:param>
		<page:param name="display">false</page:param>
		<page:param name="content">
			<ul class="fieldlist">
				<li>上传Excel文件：<input type="file" name="upload" id="upload" class="example" style="height:21px;line-height:21px;" /><span class="black-btn-l" id="uploadBtn"><span class="btn-r"><span class="btn-m"><a>上传</a></span></span></span></li>
				<li><span class="ico ico-note-blue" style="margin-right:5px;"></span>1.可使用自定义Excle文件或在<span id="downloadId" class="red" style="cursor:pointer">此处</span>下载模板。<br/>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.默认取第一个Sheet页的内容。<br/>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.文件大小不能超过5MB。</li>
			</ul>
		</page:param>		  
	</page:applyDecorator>
	</form>

  <form id="form1" name="form1" method="post">
  <div id="div_disc_matchform" style="display:none">
  <page:applyDecorator name="accordionPanel">
    <page:param name="id">panel_disc_matchform</page:param>
    <page:param name="title">3.匹配表单项</page:param>
    <page:param name="height"></page:param>
    <page:param name="width">690px</page:param>
    <page:param name="cls">fold</page:param>
    <page:param name="display">false</page:param>
    <page:param name="content">
	    <ul>
	      <li class="margin5">
	        <table class="topn-table">
	          <tr>
	            <th width="16%">导入设备项</th>
	            <th width="84%">Excel表单列名 （表头起始<input size="4" name="beginLine" id="beginLine" value="2" class="validate[required,onlyPositiveNumber]" /><span class="ico ico-what" title="修改行号获取Excel表头信息"></span>）</th>
	            </tr>
	          <tr>
	            <td>设备名称</td>
	            <td><span class="STYLE3">
	              <select id="name" name="name" style="width:120px;">
	              </select>
	            </span><span class="txt-red">*</span></td>
	            </tr>
	          <tr class="line02">
	            <td>IP地址</td>
	            <td class="td-gray01-white"><span class="STYLE3">
	              <select id="ip" name="ip" style="width:120px;">
	              </select>
	              </span><span class="txt-blue02"><span class="txt-red">*</span><span class="txt-black">&nbsp;&nbsp;</span>&nbsp;&nbsp;</span></td>
	            </tr>
	          <tr class="line02">
	            <td>MAC地址</td>
	            <td class="td-gray01-white">
	              <span class="STYLE3">
	              <select id="mac" name="mac" style="width:120px;">
	              </select>
	              </span>
	            </td>
	          </tr>
	          <tr>
	            <td>设备类型</td>
	            <td class="td-gray01-white"><span class="STYLE3">
	              <select id="type" name="type" style="width:120px;">
	              </select>
	              <span class="txt-red">*</span>&nbsp;</span></td>
	            </tr>
	          <tr class="line02">
	            <td>备注</td>
	            <td class="td-gray01-white"><span class="STYLE3">
	              <select id="remark" name="remark" style="width:120px;">
	              </select>
	              </span></td>
	            </tr>
	          </table>
	      </li>
	      <li class="margin5 lineheight21"><span class="ico ico-note-blue" style="margin-right:5px;"></span>1.列表下拉框选择为空时，表示没有匹配项。<br />
	            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.设备类型匹配项与系统规定类型不符时默认类型为其它。<br />
        </li>
        <li class="margin8"><span class="black-btn-l right" id="import"><span class="btn-r"><span class="btn-m"><a >导入</a></span></span></span></li>
      </ul>
    </page:param>     
  </page:applyDecorator>
  </div>
  </form>

  <div id="div_disc_result" style="display:none">
    <page:applyDecorator name="accordionPanel">  
      <page:param name="id">panel_disc_addmonitor</page:param>
      <page:param name="title">4.导入及监控</page:param>
      <page:param name="height"></page:param>
      <page:param name="width">690px</page:param>
      <page:param name="cls">fold</page:param>
      <page:param name="display"></page:param>
      
      <page:param name="topBtn_Index_1">1</page:param>
      <page:param name="topBtn_div_1"><span class="black-btn-l right" id="stopBtn"><span class="btn-r"><span class="btn-m"><a>终止</a></span></span></span></page:param>
      
      <page:param name="content">     
        <div class="fold-content">
          <div class="border-bottom">
            <div class="find-center"><img id="imgLoading" src="${ctx}/images/loading.gif" width="32" height="32" vspace="6" /><br />
              <span id="spLoading">0%</span>
            </div>
          </div>
	        <div class="h3">
	          <div class="f-right">
	            <span>耗用时间：<span id="compact">00:00:00</span></span>
	            <!-- <span class="ico ico-excel"></span> -->
	          </div>
	          <span class="bold">导入结果：</span>
	          <span id="sp_disc_result"></span>
	        </div>
	        
          <iframe id="iframe_discovery" name="iframe_discovery" src="" scrolling="no"
            frameborder="0" marginheight="0" marginwidth="0" width="100%" onload="resizeFrameHeight();"></iframe>
        </div>
      </page:param>     
    </page:applyDecorator>
    
    <div class="t-right">
      <span class="black-btn-l" id="sp_monitor" style="display:none;"><span class="btn-r"><span class="btn-m"><a>加入监控</a></span></span></span>
      <span class="black-btn-l" id="sp_continue" style="display:none;"><span class="btn-r"><span class="btn-m"><a>继续导入</a></span></span></span>
      <span class="black-btn-l" id="sp_finish" style="display:none;"><span class="btn-r"><span class="btn-m"><a>完成并退出</a></span></span></span>
    </div>
  </div>
  
  <iframe name="submitIframe" id="submitIframe" frameborder="0" scrolling="no" height="0" width="0" src=""></iframe>
</div>
</div>

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.countdown.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctxJs}/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctx}/js/discovery/handworkBatchAdd.js" ></script>
</body>
</html>