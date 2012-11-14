package com.mocha.bsm.bizsm.struts2rest.handler;

import java.io.IOException;
import java.io.Reader;
import java.io.Writer;

/**
 * Handles HTML content, usually just a simple passthrough to the framework
 * 和不用该组件一样
 */
public class HtmlHandler implements IContentHandler {

    public String fromObject(Object obj, String resultCode, Writer out) throws IOException {
        return resultCode;
    }

    public void toObject(Reader in, Object target) {
    }

    public String getExtension() {
        return "xhtml";
    }

    public String getContentType() {
        return "application/xhtml+xml";
    }
    
    /**
     * @see IContentHandler#getEncoding()
     */
    public String getEncoding(){
    	return null;
    }
    
}
