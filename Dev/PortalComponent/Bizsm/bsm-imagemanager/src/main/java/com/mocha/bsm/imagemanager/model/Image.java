package com.mocha.bsm.imagemanager.model;

import java.io.File;
import java.io.FileInputStream;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class Image {
	
	/**
	 * Log Instance.
	 */
	private Log log = LogFactory.getLog(this.getClass());
	
	private String imageId;
	
	private File imageFile;
	
	private File imageMetaFile;
	
	private String uri;
	
	private Folder folder;
	
	private Properties imageMeta;
	
	public Image(){	
	}
	
	public Image(String imageId,File imageFile,File imageMetaFile,String uri,Folder parent){
		this.imageId = imageId;
		this.imageFile = imageFile;
		this.imageMetaFile = imageMetaFile;
		this.loadImageMeta();
		this.uri = uri;
		this.folder = parent;
	}
	
	public String getImageId() {
		return imageId;
	}
	
	public void setImageId(String imageId) {
		this.imageId = imageId;
	}
	
	public File getImageFile() {
		return imageFile;
	}
	
	public void setImageFile(File imageFile) {
		this.imageFile = imageFile;
	}
	
	public Properties getImageMeta() {
		if(this.imageMeta == null){
			this.loadImageMeta();
		}
		return this.imageMeta;
	}
	
	private void loadImageMeta(){
		Properties meta = new Properties();
		try {
			meta.loadFromXML(new FileInputStream(this.imageMetaFile));
		} catch (Exception e) {
			this.log.error(e);
		}
		this.imageMeta = meta;
	}
	
	public String getUri() {
		return uri;
	}
	
	public void setUri(String uri) {
		this.uri = uri;
	}
	
	public Folder getFolder() {
		return folder;
	}
	
	public void setFolder(Folder folder) {
		this.folder = folder;
	}
	
	public String getName(){
		return this.getImageMeta().getProperty("imageName");
	}
	
	public void setName(String name){
		this.getImageMeta().setProperty("imageName", name);
	}
	
	public String getContentType(){
		return this.getImageMeta().getProperty("ContentType");
	}
	
	public void setContentType(String contentType){
		this.getImageMeta().setProperty("ContentType",contentType);
	}
	
	public String getFileName(){
		return this.getImageMeta().getProperty("imageFileName");
	}	
	
	public void setFileName(String fileName){
		this.getImageMeta().setProperty("imageFileName",fileName);
	}
	
}
