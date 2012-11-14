package com.mocha.bsm.bizsm.struts2rest.handler;

import java.io.IOException;
import java.io.Reader;
import java.io.Writer;

/**
 * Handles transferring content to and from objects for a specific content type
 */
public interface IContentHandler {
    
    /**
     * Populates an object using data from the input stream
     * @param in The input stream, usually the body of the request
     * @param target The target, usually the action class(通常target就是Action对象)
     */
    void toObject(Reader in, Object target) throws IOException;
    
    /**
     * Writes content to the stream
     * 
     * @param obj The object to write to the stream, usually the Action class
     * @param resultCode The original result code
     * @param stream The output stream, usually the response
     * @return The new result code
     * @throws IOException If unable to write to the output stream
     */
    String fromObject(Object obj, String resultCode, Writer stream) throws IOException;
    
    /**
     * 获得该序列化器的编码,如果返回值是null则使用默认编码的Writer或者Reader进行处理
     * @return The historical name of this encoding, or possibly null if use default encoding
     */
    public String getEncoding();
    
    /**
     * Gets the content type for this handler
     * 
     * @return The mime type
     */
    String getContentType();
    
    /**
     * Gets the extension this handler supports
     * 
     * @return The extension
     */
    String getExtension();
}
