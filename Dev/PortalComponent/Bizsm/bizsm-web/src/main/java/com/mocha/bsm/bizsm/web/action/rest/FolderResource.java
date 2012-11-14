package com.mocha.bsm.bizsm.web.action.rest;
import java.io.IOException;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mocha.bsm.bizsm.struts2rest.DefaultHttpHeaders;
import com.mocha.bsm.bizsm.struts2rest.HttpHeaders;
import com.mocha.bsm.imagemanager.exception.FolderHasImageException;
import com.mocha.bsm.imagemanager.exception.FolderNotExistException;
import com.mocha.bsm.imagemanager.model.Folder;
import com.mocha.bsm.imagemanager.service.IImageManageService;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

/**
 * 
 * @author liuyong
 *
 */
public class FolderResource extends ActionSupport implements ModelDriven<Object>{
	
	/**
	 * Log Instance.
	 */
	private Log log = LogFactory.getLog(this.getClass());
	
	private Object model = new Folder();
	
	private IImageManageService imageService;
	
	private String id;	
	
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
	
	
	public Object getModel(){
		return this.model;
	}
	
	//webservices
	
	/**
	 * 获得所有的Folder
	 * Get /imagefolder/
	 * get all BizServices
	 * @return
	 */
	public HttpHeaders list(){
			
			List<Folder> folders = this.imageService.getAllFolders();
			this.model = folders;
			return new DefaultHttpHeaders("listFolder");
		
	}	
	
	/**
	 * 更新或者创建某一个folder
	 * PUT /imagefolder/{folderId}
	 * or
	 * POST /imagefolder/{folderId}?__http_method=PUT (模拟POST,应用于PUT表单提交(Tomcat不解析),或者前台无法发出PUT请求)
	 * @return
	 */
	public HttpHeaders createOrUpdate(){
		String folderId = this.getId();
		boolean result = this.imageService.createFolder(folderId);
		int responseCode = 200;
		if(result){
			responseCode = 201; //created
		}else{
			this.addActionError("该文件夹已经存在!");
		}
		return new DefaultHttpHeaders(Action.NONE).withStatus(responseCode).setLocation("/imagefolder/"+folderId);
	}
	
	/**
	 * 删除folder
	 * DELETE /imagefolder/59405420947923590011009151012201284559940531
	 * @see {@link http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html}
	 * @return
	 */
	public HttpHeaders remove(){
		
		try {
			this.imageService.deleteFolder(this.id);	
		} catch (FolderNotExistException fnee) {
			this.addActionError("需要删除的目录并不存在!");
		}catch(FolderHasImageException fhie){
			this.addActionError("需要删除的目录不是空的，在删除目录之前需要删除其下所有的图片!");
		}catch(IOException ioe){
			log.error(ioe);
		}
		return new DefaultHttpHeaders(Action.NONE).withStatus(204);//204 NO Content
		
	}
	
}
