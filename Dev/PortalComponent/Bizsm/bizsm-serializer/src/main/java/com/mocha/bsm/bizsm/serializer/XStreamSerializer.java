/**
 * 
 */
package com.mocha.bsm.bizsm.serializer;

import java.io.Reader;
import java.io.Writer;

import com.mocha.bsm.bizsm.annotation.XStreamDisableEscapeXml;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.core.util.QuickWriter;
import com.thoughtworks.xstream.io.HierarchicalStreamDriver;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;
import com.thoughtworks.xstream.io.xml.DomDriver;
import com.thoughtworks.xstream.io.xml.PrettyPrintWriter;

/**
 * @author liuyong
 *
 */
public class XStreamSerializer implements ISerializer {

	/* 
	 * @see com.mocha.bsm.bizsm.serializer.ISerializer#fromObject(java.lang.Object, java.io.Writer)
	 */
	public void fromObject(Object obj, Writer out) {
        if (obj != null) {
        	XStream xstream = null;
        	if(this.disableEscapeXml(obj)){
        		xstream = this.createDisableEscapeXml();
        	}else{
        		xstream = this.createXStream();
        	}
            
            xstream.processAnnotations(obj.getClass());
            xstream.toXML(obj, out);            	
         }
	}
	
	/* 
	 * @see com.mocha.bsm.bizsm.serializer.ISerializer#toObject(java.io.Reader, java.lang.Object)
	 */
	public void toObject(Reader in, Object target) {
    	XStream xstream = null;
    	if(this.disableEscapeXml(target)){
    		xstream = this.createDisableEscapeXml();
    	}else{
    		xstream = this.createXStream(new DomDriver());
    	}
        xstream.processAnnotations(target.getClass());
        xstream.fromXML(in, target);
	}
	
    protected XStream createXStream() {
    	XStream xs = new XStream();
    	xs.setMode(XStream.NO_REFERENCES);
        return xs;
    }
    
    protected XStream createXStream(HierarchicalStreamDriver driver) {
    	XStream xs = new XStream(driver);
    	xs.setMode(XStream.NO_REFERENCES);
        return xs;
    }
    
    public boolean disableEscapeXml(Object obj){
    	return obj.getClass().isAnnotationPresent(XStreamDisableEscapeXml.class);
    }
    
    protected XStream createDisableEscapeXml(){
        XStream xs = new XStream(
                new DomDriver() {
                    public HierarchicalStreamWriter createWriter(Writer out) {
                        return new MyWriter(out);}});
        xs.setMode(XStream.NO_REFERENCES);
        return xs;
    }
    
    static class MyWriter extends PrettyPrintWriter {
        public MyWriter(Writer writer) {
            super(writer);
        }
        
        protected void writeText(QuickWriter writer, String text) { 
            if (text.indexOf('<') < 0) {
                writer.write(text);
            }
            else { 
                writer.write("<![CDATA["); writer.write(text); writer.write("]]>"); 
            }
        }
    }
    
}
