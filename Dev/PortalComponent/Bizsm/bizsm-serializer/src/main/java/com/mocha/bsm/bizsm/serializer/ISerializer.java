package com.mocha.bsm.bizsm.serializer;
import java.io.IOException;
import java.io.Reader;
import java.io.Writer;
/**
 * 序列化接口
 * @author liuyong
 *
 */
public interface ISerializer {
	/**
	 * 序列化对象
	 * @param obj
	 * @param out
	 * @return
	 */
    public void fromObject(Object obj,Writer out)  throws IOException;
    /**
     * 反序列化对象
     * @param in
     * @param target
     */
    public void toObject(Reader in,Object target)  throws IOException;
    
}
