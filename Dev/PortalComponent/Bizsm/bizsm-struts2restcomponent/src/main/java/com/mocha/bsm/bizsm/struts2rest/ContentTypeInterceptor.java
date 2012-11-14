package com.mocha.bsm.bizsm.struts2rest;

import com.mocha.bsm.bizsm.struts2rest.handler.IContentHandler;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.inject.Inject;
import com.opensymphony.xwork2.interceptor.Interceptor;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;

/**
 * Uses the content handler to apply the request body to the action
 */
public class ContentTypeInterceptor implements Interceptor {

    private static final long serialVersionUID = 1L;
    private IContentTypeHandlerManager selector;
    
    @Inject
    public void setContentTypeHandlerSelector(IContentTypeHandlerManager sel) {
        this.selector = sel;
    }
    
    public void destroy() {}

    public void init() {}

    public String intercept(ActionInvocation invocation) throws Exception {
        HttpServletRequest request = ServletActionContext.getRequest();
        IContentHandler handler = selector.getHandlerForRequest(request);
        
        Object target = invocation.getAction();
        if (target instanceof ModelDriven) {
            target = ((ModelDriven)target).getModel();
        }
        
        if (request.getContentLength() > 0) {
            InputStream is = (InputStream) request.getInputStream();
            String encoding = handler.getEncoding();
            InputStreamReader reader = null;
            if(encoding != null){
            	reader = new InputStreamReader(is, encoding);
            }else{
            	reader = new InputStreamReader(is);
            } 
            handler.toObject((Reader) reader, target);
        }
        return invocation.invoke();
    }

}
