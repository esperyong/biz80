<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="com.mocha.bsm.bizsm.web.util.SpringBeanUtil"%>
<%@ page import="com.mocha.bsm.bizsm.adapter.bsmres.IBSMClientAdapter"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title></title>
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" />

<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/ajaxcommon.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script language="javascript">
	$(function() {
		$('#close').bind("click", function(){
			window.close();
		});

		var popId;
		$.get('${ctx}/bsmhint/bizserviceanalysis.xml',{},function(data){
			var popupIndex = $(data).find('BizServicePopup>value').text();
			if(popupIndex == "false"){
				$("#chk")[0].checked = false;
			}else{
				$("#chk")[0].checked = true;
			}
			popId = $(data).find('BizServicePopup>popupId').text();
		})

		$('#confirm').bind("click",function(){
			var value = $('#chk')[0].checked;
			if(popId == null){
				var aa = '<BizServicePopup><popupId></popupId><from>bizserviceanalysis</from><value>'+value+'</value></BizServicePopup>';
			}else{
				var aa = '<BizServicePopup><popupId>bizserviceanalysis</popupId><from>bizserviceanalysis</from><value>'+value+'</value></BizServicePopup>';
			}
			$.ajax({
				type: 'PUT',
				url: "${ctx}/bsmhint/bizserviceanalysis.xml",
				contentType: "application/xml",
				data: aa,
				processData: false,
				cache:false,
				success: function(msg){
					window.close();
				}
			});
		});
	});

</script>
</head>
<body>
	<form id="newForm" name="newForm"  action="self" style="height:280px">
		<div class="roundedform">
			<div class="roundedform-top">
				<div class="top-right">
					<div class="top-min">
						<table class="hundred"><thead><tr><th>
							<div class="theadbar">
								<a id="close" title="ر" class="win-ico win-close"></a>
							</div></th></tr></thead>
						</table>
					</div>
				</div>
			</div>
			<div style="height:20px">&nbsp;</div>

			<div class="roundedform-content02">
				<div>
					<ul class="fieldlist">
						<li>
						</li>
						<li>
							<input type="checkbox" id="chk">下次不在询问？
						</li>
						<li>
							<span class="black-btn02-l  black-btn02-l-blank"><span class="btn-r"><span id="confirm" class="btn-m"><a >确定</a></span></span></span>
						</li>
					</ul>
				</div>
			</div>
			<div class="roundedform-bottom">
				<div class="bottom-right">
					<div class="bottom-min"></div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>
