package com.mocha.bsm.bizsm.web.action.rest;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mocha.bsm.bizsm.core.model.BizService;
import com.mocha.bsm.bizsm.struts2rest.DefaultHttpHeaders;
import com.mocha.bsm.bizsm.struts2rest.HttpHeaders;
import com.mocha.bsm.imagemanager.model.Image;
import com.mocha.bsm.imagemanager.service.IImageManageService;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

/**
 * 图片资源
 * @author liuyong
 */
public class ImageResource extends ActionSupport implements ModelDriven<Object>{
	/**
	 * Log Instance.
	 */
	private Log log = LogFactory.getLog(this.getClass());	
	private IImageManageService imageService;
	private String id;
	private String folder;
	private File imageFile;
	private String imageName;
	private Object model;
	private String imageFileContentType;
	private String imageFileFileName;
	private String fileContentName;//用来校验必填写的文件路径
	
	public String getFileContentName() {
		return fileContentName;
	}

	public void setFileContentName(String fileContentName) {
		this.fileContentName = fileContentName;
	}

	public String getImageFileContentType() {
		return imageFileContentType;
	}

	public void setImageFileContentType(String imageFileContentType) {
		this.imageFileContentType = imageFileContentType;
	}

	public String getImageFileFileName() {
		return imageFileFileName;
	}

	public void setImageFileFileName(String imageFileFileName) {
		this.imageFileFileName = imageFileFileName;
	}

	public String getImageName() {
		return imageName;
	}

	public void setImageName(String imageName) {
		this.imageName = imageName;
	}

	public String getFolder() {
		return this.folder;
	}

	public void setFolder(String folder) {
		this.folder = folder;
	}

	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	/**
	 * @inject{bsm.imageManager}
	 */
	public void setImageService(IImageManageService imageService){
		this.imageService = imageService;
	}
	
	/**
	 * 获得一个目录下面的所有image的列表
	 * Get /folder/{folderId}/image/
	 * @return
	 */	
	public HttpHeaders list(){
		String folderId = this.getFolder();
		this.model = this.imageService.getFolder(folderId);
		return new DefaultHttpHeaders("listImage");
	}
	
	/**
	 * 获取一个Image
	 * Get /folder/{folderId}/image/{imageId}
	 * @return
	 */
	public HttpHeaders view(){
		DefaultHttpHeaders headers = new DefaultHttpHeaders("viewImage");
		Image image = this.imageService.getImage(this.folder, id);		
		String contentType = image.getContentType();
		if(contentType != null && !contentType.equals("")){
			this.setImageFileContentType(contentType);
		}
		File imageFile = image.getImageFile();
		this.imageFile = imageFile;
		return headers;
	}
	
	/**
	 * 创建一个image
	 * POST /folder/{folderId}/image/
	 * @return
	 */
	public HttpHeaders createSubResource(){
		String folderId = this.getFolder();
		String imageName = this.getImageName();
		String imageContentType = this.getImageFileContentType();
		String imageFileName = this.getImageFileFileName();
		File imageF = this.getImageFile();
		String imageUri = "";
		
		if(imageF == null){//校验通过时走得逻辑,因为ajax无法实现真正的文件上传
			return new DefaultHttpHeaders(Action.NONE).withStatus(204);//No Content
		}else{
			try {
				Image imageObj = this.imageService.createImage(folderId, imageF, imageFileName,imageContentType,imageName);
				imageUri = imageObj.getUri();
			} catch (Exception e) {
				log.error(e);
			}
			return new DefaultHttpHeaders(Action.NONE).setLocation(imageUri).withStatus(201);//Created
		}
	}
	
	/**
	 * 校验createSubResource方法
	 */
	public void validateCreateSubResource(){
		String folderId = this.getFolder();
		String imageName = this.getImageName();
		String fileContentName = this.getFileContentName();
		File imageFile = this.getImageFile();
		if(imageName == null || imageName.equals("")){
			this.addFieldError("imageName", "图片名称为必填项,请重新输入!");
			return;
		}
		if((fileContentName == null || fileContentName.equals("")) && (imageFile == null)){
			this.addFieldError("imageFile", "文件为必填项,请选择!");
			return;
		}
		List<Image> images = this.imageService.getImagesByName(folderId, imageName);
		if(images.size() > 0){
			this.addFieldError("imageName", "输入的图片名称重复,请重新输入!");
		}	
	}
	
	/**
	 * 更新一个Image
	 * PUT /folder/{folderId}/image/{imageId}
	 * or
	 * POST /folder/{folderId}?__http_method=PUT (模拟POST,应用于PUT表单提交(Tomcat不解析),或者前台无法发出PUT请求)
	 * @return
	 */
	public HttpHeaders createOrUpdate(){
		String folderId = this.getFolder();
		String imageId = this.getId();
		String imageName = this.imageName;
		String imageContentType = this.getImageFileContentType();
		String imageFileName = this.getImageFileFileName();
		File imageF = this.getImageFile();
		String imageUri = "";
		try {
			Image imageObj = this.imageService.updateImage(folderId, imageId, imageF, imageFileName,imageContentType,imageName);
			imageUri = imageObj.getUri();
		} catch (Exception e) {
			log.error(e);
		}
		return new DefaultHttpHeaders(Action.NONE).setLocation(imageUri);
	}
	
	public InputStream getImageStream() throws FileNotFoundException{
		FileInputStream fileInputStream = new FileInputStream(this.imageFile);
		return fileInputStream;
	}

	public File getImageFile() {
		return imageFile;
	}

	public void setImageFile(File imageFile) {
		this.imageFile = imageFile;
	}
	
	public Object getModel(){
		return this.model;
	}	
	
}
