package com.mocha.bsm.bizsm.struts2rest.handler;

import java.io.Writer;
import java.io.IOException;
import java.io.Reader;

/**
 * Handles the default content type for requests that originate from a browser's HTML form
 *
 * content-type: application/x-www-form-urlencoded
 *
 * This handler is intended for requests only, not for responses
 *
 * {@link http://www.w3.org/TR/html401/interact/forms.html#h-17.13.4}
 *
 */
public class FormUrlEncodedHandler implements IContentHandler {

    public static final String CONTENT_TYPE = "application/x-www-form-urlencoded";

    public String fromObject(Object obj, String resultCode, Writer out) throws IOException {
        throw new IOException("Conversion from Object to '"+getContentType()+"' is not supported");
    }

    /** No transformation is required as the framework handles this data */
    public void toObject(Reader in, Object target) {
    }

    /**
     * The extension is not used by this handler
     * @return
     */
    public String getExtension() {
        return null;
    }

    public String getContentType() {
        return CONTENT_TYPE;
    }
    
    /**
     * @see IContentHandler#getEncoding()
     */
    public String getEncoding(){
    	return null;
    }
    
}
