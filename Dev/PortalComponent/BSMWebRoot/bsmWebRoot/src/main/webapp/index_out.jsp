<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<meta name="decorator" content="headfoot" /> 
<iframe name="iFrameObj" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" onload="iFrameHeight()" width="100%" src="/netfocus/test.html"></iframe>
<script type="text/javascript">
	var ifm = document.getElementById("iFrameObj");  
	hideIframe("iFrameObj"); 
	var subWeb = document.frames ? document.frames["iFrameObj"].document : null;   
	function iFrameHeight() {
		if(subWeb != null) {
		   	ifm.height =  document.documentElement.clientHeight-80;
		}   
	}  
	$(function(){
		<%
			if("admincontrol".equals(request.getParameter("current"))){
		%>
				currentHref="/mochaadmin/index.action";
		<%
		}
		%>
    if(currentHref.indexOf("ispopup=true")!=-1){
      window.open(currentHref);
    }else{
			subWeb.location = currentHref;
			showIframe("iFrameObj");
    }
	})
	function hideIframe(ifmId){
		var ifm = document.getElementById(ifmId);   
		var $ifm = $(ifm);
		$ifm.hide()
		
	}
	function showIframe(ifmId){
		var ifm = document.getElementById(ifmId);   
		var $ifm = $(ifm);
		$ifm.ready( function () {
			$ifm.show(); 
		});
	}
</script>
