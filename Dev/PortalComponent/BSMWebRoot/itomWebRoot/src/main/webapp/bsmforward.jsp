<%@ page contentType="text/html;charset=UTF-8"%>
<%
	//资源类型：Resource, Service ...
	String bsm_style_id = request.getParameter("bsm_style_id");

	//资源Id.
	String bsm_resource_id = request.getParameter("bsm_resource_id");

	//事件Id.
	String bsm_event_id = request.getParameter("bsm_event_id");

	String url = null;
	int width = 0;
	int height = 0;

	if (hasvalue(bsm_style_id)) {
		if(hasvalue(bsm_resource_id)) {
			width = 1024;
			height = 768;
			if("Resource".equals(bsm_style_id)) {
				url = "/mochabsm/plugins/common/detail/detailIndex.jsp?instanceId="+bsm_resource_id;
			} else if("Service".equals(bsm_style_id)) {
				url = "/mochaservice/modules/management/serviceNotInlineTimeFrame.jsp?serviceId="+bsm_resource_id;
			} else if("Room".equals(bsm_style_id)) {
				url = "/roommonitor/modules/main.jsp?roomId="+bsm_resource_id;//TODO
			} else {
				out.println("Not Known 'bsm_style_id' " + bsm_style_id);
			}

		} else if(hasvalue(bsm_event_id)) {
			if("Resource".equals(bsm_style_id)) {
				width = 600;
				height = 345;
				//老唐提供
				url = "/mochabsm/modules/eventforitpm/eventDetail.jsp?id="+bsm_event_id;
			} else if("Service".equals(bsm_style_id)) {
				width = 600;
				height = 345;
				url = "/mochaservice/modules/eventmangement/ServiceEventCauseForITPM.jsp?eventId="+bsm_event_id;
			} else if("Room".equals(bsm_style_id)) {
				width = 630;
				height = 340;
				url = "/roommonitor/modules/room/event_mg/eventProperty.jsp?manageId="+bsm_event_id;
			} else {
				out.println("Not Known 'bsm_style_id' " + bsm_style_id);
			}
		} else {
			out.println("both 'bsm_resource_id' and 'bsm_event_id' are null.");
		}
	} else {
		out.println("'bsm_style_id' is null");
	}

	 String path = request.getContextPath();
	 String theme_path = com.mocha.bsm.itom.ItpmConfig.get("theme_path");
	 String jsRootPath = path + theme_path + "/js";
%>
<%@ page language="java" contentType="text/html;charset=UTF-8" errorPage="/modules/common/error.jsp"%>
<SCRIPT language=JavaScript src="<%=jsRootPath%>/common.js"></SCRIPT>
<script src="<%=jsRootPath %>/checkForm.js"></script>
<script>
function openWin(str_url,width,height,target){
  if(str_url=='') return false;

  if(target=='') target = "_blank";
  if(height==null) height = screen.height;
  if(width==null) width = screen.width;


  var left = (screen.width - width)/2;
  var top = (screen.height - height)/2;

  var str_style = "toolbar=0, menubar=0, scrollbars=0, resizable=0, width=" + width + ", height=" + height + ", left=" + left + ", top=" + top;
  window.open(str_url,target,str_style);
}
</script>
<%if(url != null) {
	if(bsm_resource_id != null) {
%>
<script>
openPreWindow("<%=url%>","<%=width%>","<%=height%>","detailinfo");
</script>
<%} else if(bsm_event_id != null) { %>
<script>
openWin("<%=url%>","<%=width%>","<%=height%>","_blank");
</script>
<%}} %>
<%! boolean hasvalue(String s) {return s!=null && s.length()>0 && !"null".equals(s);}

%>