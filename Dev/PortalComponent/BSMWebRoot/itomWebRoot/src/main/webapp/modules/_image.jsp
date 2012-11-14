<%
String workformId = request.getParameter("workformId");
String userId = request.getParameter("userId");
String userdomainId = request.getParameter("userDomainId");
byte[] bytes = com.mocha.bsm.itom.mgr.XmlCommunication.getInstance().query_process_image(workformId, userId, userdomainId);
java.io.InputStream is = new java.io.ByteArrayInputStream(bytes);
response.reset();
response.setContentType("image/jpeg");
java.io.OutputStream os = response.getOutputStream();
byte[] all = new byte[4048];
while (true) {
	int len = is.read(all);
	if (len > 0) {
		os.write(all, 0, len);
	} else {
		break;
	}
}
os.flush();
out = null;
%>