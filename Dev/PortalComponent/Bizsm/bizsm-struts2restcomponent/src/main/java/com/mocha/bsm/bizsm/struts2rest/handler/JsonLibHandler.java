package com.mocha.bsm.bizsm.struts2rest.handler;
import java.io.IOException;
import java.io.Reader;
import java.io.Writer;
import com.mocha.bsm.bizsm.serializer.ISerializer;
import com.mocha.bsm.bizsm.serializer.JsonSerializer;

/**
 * Handles JSON content using json-lib
 */
public class JsonLibHandler implements IContentHandler {
	ISerializer serializer = null;
	public JsonLibHandler(){
		serializer = new JsonSerializer();
	}
	
    public void toObject(Reader in, Object target) throws IOException {
    	this.serializer.toObject(in, target);
    }

    public String fromObject(Object obj, String resultCode, Writer stream) throws IOException {
        this.serializer.fromObject(obj, stream);
        return null;


    }

    public String getContentType() {
        return "text/javascript";
    }
    
    public String getExtension() {
        return "json";
    }
    /**
     * @see IContentHandler#getEncoding()
     */
    public String getEncoding(){
    	return null;
    }    
    
}
