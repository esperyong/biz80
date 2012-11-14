/**
 * 
 */
package com.mocha.bsm.bizsm.serializer;

import java.io.IOException;
import java.io.Reader;
import java.io.Writer;
import java.util.Collection;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

/**
 * @author liuyong
 *
 */
public class JsonSerializer implements ISerializer {

	/* (non-Javadoc)
	 * @see com.mocha.bsm.bizsm.serializer.ISerializer#fromObject(java.lang.Object, java.io.Writer)
	 */
	public void fromObject(Object obj, Writer out)  throws IOException {
        if (obj != null) {
            if (isArray(obj)) {
                JSONArray jsonArray = JSONArray.fromObject(obj);
                out.write(jsonArray.toString());
            } else {
                JSONObject jsonObject = JSONObject.fromObject(obj);
                out.write(jsonObject.toString());
            }
        }
	}

	/* (non-Javadoc)
	 * @see com.mocha.bsm.bizsm.serializer.ISerializer#toObject(java.io.Reader, java.lang.Object)
	 */
	public void toObject(Reader in, Object target)  throws IOException {
        StringBuilder sb = new StringBuilder();
        char[] buffer = new char[1024];
        int len = 0;
        while ((len = in.read(buffer)) > 0) {
            sb.append(buffer, 0, len);
        }
        if (target != null && sb.length() > 0 && sb.charAt(0) == '[') {
            JSONArray jsonArray = JSONArray.fromObject(sb.toString());
            if (target.getClass().isArray()) {
                JSONArray.toArray(jsonArray, target, new JsonConfig());
            } else {
                JSONArray.toList(jsonArray, target, new JsonConfig());
            }

        } else {
            JSONObject jsonObject = JSONObject.fromObject(sb.toString());
            JSONObject.toBean(jsonObject, target, new JsonConfig());
        }
	}
	
    private boolean isArray(Object obj) {
        return obj instanceof Collection || obj.getClass().isArray();
    }

}
