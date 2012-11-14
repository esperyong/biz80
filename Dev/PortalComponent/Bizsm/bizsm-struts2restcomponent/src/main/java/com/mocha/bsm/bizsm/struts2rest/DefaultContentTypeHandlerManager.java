package com.mocha.bsm.bizsm.struts2rest;

import java.io.IOException;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.ServletActionContext;
import com.mocha.bsm.bizsm.struts2rest.handler.IContentHandler;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.config.entities.ActionConfig;
import com.opensymphony.xwork2.inject.Container;
import com.opensymphony.xwork2.inject.Inject;

/**
 * Manages {@link IContentHandler} instances and uses them to
 * process results
 */
public class DefaultContentTypeHandlerManager implements IContentTypeHandlerManager {

    /** ContentTypeHandlers keyed by the extension */
    Map<String,IContentHandler> handlersByExtension = new HashMap<String,IContentHandler>();
    /** ContentTypeHandlers keyed by the content-type */
    Map<String,IContentHandler> handlersByContentType = new HashMap<String,IContentHandler>();

    String defaultExtension;

    @Inject("struts.rest.defaultExtension")
    public void setDefaultExtension(String name) {
        this.defaultExtension = name;
    }

    @Inject
    public void setContainer(Container container) {
        Set<String> names = container.getInstanceNames(IContentHandler.class);
        for (String name : names) {
            IContentHandler handler = container.getInstance(IContentHandler.class, name);

            if (handler.getExtension() != null) {
                // Check for overriding handlers for the current extension
                String overrideName = container.getInstance(String.class, STRUTS_REST_HANDLER_OVERRIDE_PREFIX +handler.getExtension());
                if (overrideName != null) {
                    if (!handlersByExtension.containsKey(handler.getExtension())) {
                        handler = container.getInstance(IContentHandler.class, overrideName);
                    } else {
                        // overriding handler has already been registered
                        continue;
                    }
                }
                this.handlersByExtension.put(handler.getExtension(), handler);
            }

            if (handler.getContentType() != null) {
                this.handlersByContentType.put(handler.getContentType(), handler);
            }
        }
    }
    
    /**
     * Gets the handler for the request by looking at the request content type and extension
     * @param req The request
     * @return The appropriate handler
     */
    public IContentHandler getHandlerForRequest(HttpServletRequest req) {
        IContentHandler handler = null;
        String contentType = req.getContentType();
        if (contentType != null) {
        	int index = contentType.indexOf(';');
        	if( index != -1)
        		contentType = contentType.substring(0,index).trim();
            handler = handlersByContentType.get(contentType);
        }
        
        if (handler == null) {
            String extension = findExtension(req.getRequestURI());
            if (extension == null) {
                extension = defaultExtension;
            }
            handler = handlersByExtension.get(extension);
        }
        return handler;
    }

    /**
     * Gets the handler for the response by looking at the extension of the request
     * @param req The request
     * @return The appropriate handler
     */
    public IContentHandler getHandlerForResponse(HttpServletRequest req, HttpServletResponse res) {
        String extension = findExtension(req.getRequestURI());
        if (extension == null) {
            extension = defaultExtension;
        }
        return handlersByExtension.get(extension);
    }

    /**
     * Handles the result using handlers to generate content type-specific content
     * 
     * @param actionConfig The action config for the current request
     * @param methodResult The object returned from the action method
     * @param target The object to return, usually the action object
     * @return The new result code to process
     * @throws IOException If unable to write to the response
     */
    public String handleResult(ActionConfig actionConfig, Object methodResult, Object target)
            throws IOException {
        String resultCode = null;
        HttpServletRequest req = ServletActionContext.getRequest();
        HttpServletResponse res = ServletActionContext.getResponse();
        if (target instanceof ModelDriven) {
            target = ((ModelDriven)target).getModel();
        }

        boolean statusNotOk = false;
        if (methodResult instanceof HttpHeaders) {
            HttpHeaders info = (HttpHeaders) methodResult;
            resultCode = info.apply(req, res, target);
            if (info.getStatus() != HttpServletResponse.SC_OK) {

                // Don't return content on a not modified
                if (info.getStatus() == HttpServletResponse.SC_NOT_MODIFIED) {
                    target = null;
                } else {
                    statusNotOk = true;
                }

            }
        } else {
            resultCode = (String) methodResult;
        }
        
        //如果成功的话,PUT,DELETE,POST这三个方法都不需要返回任何内容
        //GET,OPTIONS,HEAD需要返回
        // Don't return any content for PUT, DELETE, and POST where there are no errors
		if (!statusNotOk 
				&& !"get".equalsIgnoreCase(req.getMethod())
				&& !"options".equalsIgnoreCase(req.getMethod())
				&& !"head".equalsIgnoreCase(req.getMethod())) {
			target = null;
		}
		        
        IContentHandler handler = getHandlerForResponse(req, res);
        
        if (handler != null) {
        	String encoding = handler.getEncoding();
            String extCode = resultCode+"-"+handler.getExtension();
            if (actionConfig.getResults().get(extCode) != null) {//有类似的xxx-xml的result则选择Result
                resultCode = extCode;
            } else {
                	
                    StringWriter writer = new StringWriter();
                    resultCode = handler.fromObject(target, resultCode, writer);
                    String text = writer.toString();
                    if (text.length() > 0) {
                    	byte[] data = null;
                    	if(encoding != null){
                    		data = text.getBytes(encoding);
                    	}else{
                    		data = text.getBytes();
                    	}
                        res.setContentLength(data.length);
                        res.setContentType(handler.getContentType());
                        res.getOutputStream().write(data);
                        res.getOutputStream().close();
                    }
            }
        }
        
        return resultCode;
        
    }
    
    /**
     * Finds the extension in the url
     * 
     * @param url The url
     * @return The extension
     */
    protected String findExtension(String url) {
        int dotPos = url.lastIndexOf('.');
        int slashPos = url.lastIndexOf('/');
        if (dotPos > slashPos && dotPos > -1) {
            return url.substring(dotPos+1);
        }
        return null;
    }
}
