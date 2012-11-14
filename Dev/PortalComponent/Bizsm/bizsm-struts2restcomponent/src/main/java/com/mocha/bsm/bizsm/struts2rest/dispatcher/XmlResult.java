package com.mocha.bsm.bizsm.struts2rest.dispatcher;


import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.StrutsResultSupport;

import com.mocha.bsm.bizsm.struts2rest.ValidateErrors;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.util.logging.Logger;
import com.opensymphony.xwork2.util.logging.LoggerFactory;
import com.thoughtworks.xstream.XStream;

import java.io.IOException;
import java.io.OutputStream;
import java.io.StringWriter;
import java.io.Writer;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
/**
 * 用来给后缀不是.xml的uri,提供错误信息的打印
 * @author liuyong
 *
 */
public class XmlResult  extends StrutsResultSupport{
	private final static Logger LOG = LoggerFactory.getLogger(XmlResult.class);
    // CONSTRUCTORS ----------------------------

    public XmlResult() {
        super();
    }
    
    protected void fromObject(Object obj, Writer out) throws IOException {
        if (obj != null) {
            XStream xstream = createXStream();
            xstream.processAnnotations(obj.getClass());
            xstream.toXML(obj, out);
        }
    }
    
    protected XStream createXStream() {
        return new XStream();
    }    
    
    /**
     * Executes the result. Writes the given chart as a PNG or JPG to the servlet output stream.
     *
     * @param invocation an encapsulation of the action execution state.
     * @throws Exception if an error occurs when creating or writing the chart to the servlet output stream.
     */
    public void doExecute(String finalLocation, ActionInvocation invocation) throws Exception {
    	Boolean hasErrors = (Boolean)invocation.getStack().findValue("errors", Boolean.class);
    	if(hasErrors!=null && hasErrors){
    		this.printErrors(invocation);
    	}
    }    
    
    protected void printErrors(ActionInvocation invocation)throws IOException{
    	Collection<String> actionErrors = (Collection<String>)invocation.getStack().findValue("actionErrors");
    	Map<String, List<String>> fieldErrors = (Map<String, List<String>>)invocation.getStack().findValue("fieldErrors");
        // get a reference to the servlet output stream to write our chart image to
    	ValidateErrors errors = new ValidateErrors(actionErrors,fieldErrors);
        HttpServletResponse response = ServletActionContext.getResponse();
        OutputStream os = response.getOutputStream();
        try {
                StringWriter writer = new StringWriter();
                this.fromObject(errors, writer);
                String text = writer.toString();
                if (text.length() > 0) {
                    byte[] data = text.getBytes("UTF-8");
                    response.setContentLength(data.length);
                    response.setContentType("application/xml");
                    os.write(data);
                    os.close();
                }
         } finally {
            if (os != null) os.flush();
        }    	
    }
    
}
