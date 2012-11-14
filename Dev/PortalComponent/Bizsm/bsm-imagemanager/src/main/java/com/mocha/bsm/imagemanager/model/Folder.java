package com.mocha.bsm.imagemanager.model;

import java.util.ArrayList;
import java.util.List;
import com.thoughtworks.xstream.annotations.XStreamAlias;
@XStreamAlias("Folder")
public class Folder {
	@XStreamAlias("folderId")
	private String folderId;
	@XStreamAlias("uri")
	private String uri;
	@XStreamAlias("images")
	private List<Image> images;
	
	public Folder(){
		this.images = new ArrayList<Image>();
	}
	
	public Folder(String folderId,String uri){
		this.folderId = folderId;
		this.uri = uri;
		this.images = new ArrayList<Image>();
	}
	
	public String getFolderId() {
		return folderId;
	}
	
	public void setFolderId(String folderId) {
		this.folderId = folderId;
	}
	
	public String getUri() {
		return uri;
	}
	
	public void setUri(String uri) {
		this.uri = uri;
	}
	
	public List<Image> getImages() {
		return images;
	}
	
	public void addImage(Image image) {
		image.setFolder(this);
		this.images.add(image);
	}
	
}
