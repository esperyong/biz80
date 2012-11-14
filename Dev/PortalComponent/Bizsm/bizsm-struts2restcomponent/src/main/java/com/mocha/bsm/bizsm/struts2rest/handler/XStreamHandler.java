package com.mocha.bsm.bizsm.struts2rest.handler;

import com.mocha.bsm.bizsm.serializer.ISerializer;
import com.mocha.bsm.bizsm.serializer.XStreamSerializer;
import java.io.IOException;
import java.io.Reader;
import java.io.Writer;

/**
 * Handles XML content
 */
public class XStreamHandler implements IContentHandler {
	ISerializer serializer = null;
	public XStreamHandler(){
		serializer = new XStreamSerializer();
	}
    public String fromObject(Object obj, String resultCode, Writer out) throws IOException {
        this.serializer.fromObject(obj, out);
        return null;
    }

    public void toObject(Reader in, Object target)  throws IOException {
        this.serializer.toObject(in, target);
    }
    
    public String getContentType() {
        return "application/xml";
    }

    public String getExtension() {
        return "xml";
    }
    
    /**
     * @see IContentHandler#getEncoding()
     */
    public String getEncoding(){
    	return "UTF-8";
    }    
    
}
