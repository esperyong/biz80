package com.mocha.bsm.bizsm.struts2rest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Default implementation of rest info that uses fluent-style construction
 */
public class DefaultHttpHeaders implements HttpHeaders {
    String resultCode;
    int status = HttpServletResponse.SC_OK;
    Object etag;
    Object locationId;
    String location;
    boolean disableCaching;
    boolean noETag = false;
    Date lastModified;
    Map<String,String> customHeaders;
    public static final String customHeaderPrefix = "X-";
    
    public DefaultHttpHeaders() {
    	this(null);
    }
    
    public DefaultHttpHeaders(String result) {
        resultCode = result;
        customHeaders = new HashMap<String,String>();
    }
    
    public DefaultHttpHeaders renderResult(String code) {
        this.resultCode = code;
        return this;
    }
    
    public DefaultHttpHeaders withStatus(int code) {
        this.status = code;
        return this;
    }
    
    public DefaultHttpHeaders withETag(Object etag) {
        this.etag = etag;
        return this;
    }

    public DefaultHttpHeaders withNoETag() {
        this.noETag = true;
        return this;
    }
    
    public DefaultHttpHeaders setLocationId(Object id) {
        this.locationId = id;
        return this;
    }
    
    public DefaultHttpHeaders setLocation(String loc) {
        this.location = loc;
        return this;
    }
    
    public DefaultHttpHeaders lastModified(Date date) {
        this.lastModified = date;
        return this;
    }
    
    public DefaultHttpHeaders disableCaching() {
        this.disableCaching = true;
        return this;
    }
    
    public DefaultHttpHeaders addCustomHeader(String key,String value) {
        this.customHeaders.put(customHeaderPrefix + key, value);
        return this;
    }
    
    
    /* (non-Javadoc)
     * @see com.mocha.bsm.bizsm.struts2rest.HttpHeaders#apply(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Object)
     */
    public String apply(HttpServletRequest request, HttpServletResponse response, Object target) {

        if (disableCaching) {
            response.setHeader("Cache-Control", "no-cache");
        }
        if (lastModified != null) {
            response.setDateHeader("Last-Modified", lastModified.getTime());
        }
        if (etag == null && !noETag && target != null) {
            etag = String.valueOf(target.hashCode());
        }
        if (etag != null) {
            response.setHeader("ETag", etag.toString());
        }

        if (locationId != null) {
            String url = request.getRequestURL().toString();
            int lastSlash = url.lastIndexOf("/");
            int lastDot = url.lastIndexOf(".");
            if (lastDot > lastSlash && lastDot > -1) {
                url = url.substring(0, lastDot)+"/"+locationId+url.substring(lastDot);
            } else {
                url += "/"+locationId;
            }
            response.setHeader("Location", url);
            status = HttpServletResponse.SC_CREATED;
        } else if (location != null) {
            response.setHeader("Location", location);
            status = HttpServletResponse.SC_CREATED;
        }

        if (status == HttpServletResponse.SC_OK && !disableCaching) {
            boolean etagNotChanged = false;
            boolean lastModifiedNotChanged = false;
            String reqETag = request.getHeader("If-None-Match");
            if (etag != null) {
                if (etag.equals(reqETag)) {
                    etagNotChanged = true;
                }
            }

            String reqLastModified = request.getHeader("If-Modified-Since");
            if (lastModified != null) {
                if (String.valueOf(lastModified.getTime()).equals(reqLastModified)) {
                    lastModifiedNotChanged = true;
                }

            }

            if ((etagNotChanged && lastModifiedNotChanged) ||
                (etagNotChanged && reqLastModified == null) ||
                (lastModifiedNotChanged && reqETag == null)) {
                status = HttpServletResponse.SC_NOT_MODIFIED;
            }
        }

        response.setStatus(status);
        
        //add custom ResponseHeader
        if(this.customHeaders.entrySet() != null){
        	for (Map.Entry<String, String> entry : this.customHeaders.entrySet()) {
        		if(entry != null){
            		String key = entry.getKey();
            		String value = entry.getValue();
            		if(!key.equals("Cache-Control")
            				&&!key.equals("Last-Modified")
            				&&!key.equals("ETag")
            				&&!key.equals("Location")){
            			response.setHeader(key,value);	
            		}    			
        		}
    		}        	
        }
     	
        return resultCode;
    }

    public int getStatus() {
        return status;
    }
    
    
    
    
}
