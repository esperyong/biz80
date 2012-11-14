/**
 * 
 */
package com.mocha.bsm.imagemanager.service;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.db4o.query.Predicate;
import com.mocha.bsm.bizsm.db4otemplate.core.IDb4oTemplate;
import com.mocha.bsm.bizsm.db4otemplate.database.IContextRoot;
import com.mocha.bsm.imagemanager.exception.FolderHasImageException;
import com.mocha.bsm.imagemanager.exception.FolderNotExistException;
import com.mocha.bsm.imagemanager.exception.ImageHasExistException;
import com.mocha.bsm.imagemanager.exception.ImageNotFoundException;
import com.mocha.bsm.imagemanager.helper.UidGenerator;
import com.mocha.bsm.imagemanager.model.Folder;
import com.mocha.bsm.imagemanager.model.Image;
import com.mocha.bsm.imagemanager.model.Relationship;
import com.mocha.bsm.imagemanager.model.RelationshipType;


/**
 * @author liuyong
 *
 */
public class ImageManageServiceImpl implements IImageManageService {
	/**
	 * Log Instance.
	 */
	private Log log = LogFactory.getLog(this.getClass());
	
	private IDb4oTemplate dbTemplate;
	
	private IContextRoot contextRoot;
	
	private String imageRootName = "imagestore";
	
	private String imageContextPath;
	
	public static final String IMAGE_META_FILENAME = "imagemeta.xml";
	
	public ImageManageServiceImpl(IDb4oTemplate dbTemplate,IContextRoot contextRoot){
		this.dbTemplate = dbTemplate;
		this.contextRoot = contextRoot;
		if(this.contextRoot != null && this.contextRoot.getContextRoot() != null){
			this.imageContextPath = this.contextRoot.getContextRoot();
		}
	}
	
	protected String getImageRootPath(){
		if(this.contextRoot != null && this.contextRoot.getContextRoot() != null){
			String contextRootPath = this.contextRoot.getContextRoot();
			this.imageContextPath = contextRootPath;
		}else{
			this.imageContextPath = ".";
		}
		return this.imageContextPath + "/" + this.imageRootName;
	}
	
	protected String getFolderPath(String folderId){
		return this.getImageRootPath() + "/" + folderId;
	}
	
	protected String getImagePath(String folderId,String imageId){
		return this.getImageRootPath() + "/" + folderId + "/" + imageId;
	}
	
	protected String getImageMetaFilePath(String folderId,String imageId){
		return this.getImageRootPath() + "/" + folderId + "/" + imageId + "-" + IMAGE_META_FILENAME;
	}
	
	protected File getImageMetaFile(String folderId,String imageId){
		String metaFilePath = this.getImageMetaFilePath(folderId, imageId);
		File metaFile = new File(metaFilePath);
		return metaFile;
	}
	
	protected File getImageFile(String folderId,String imageId){
		String imageFilePath = this.getImagePath(folderId, imageId);
		File imageFile = new File(imageFilePath);
		return imageFile;
	}
	
	public Folder getFolder(String folderId){
		Folder folder = new Folder(folderId,this.getFolderUri(folderId));
		File folderFile = new File(this.getFolderPath(folderId));
		
		File[] images = folderFile.listFiles(new FilenameFilter(){
			public boolean accept(File dir, String name) {
				return !name.endsWith(".xml");
			}
		});
		
		if(images != null){
			for (int j = 0; j < images.length; j++) {
				if(images[j].isFile()){
					String imageId = images[j].getName();
					File imageFile = images[j];
					File metaFile = this.getImageMetaFile(folderId, imageId);
					Image image = new Image(imageId,imageFile,metaFile,this.getImageUri(folderId, imageId),folder);
					folder.addImage(image);
				}
			}
		}
		return folder;
	}
	
	/**
	 * 创建一个目录,如果目录已经存在则返回false
	 * @param folderId
	 */
	public boolean createFolder(String folderId){
		String folderAbsolutePath = this.getFolderPath(folderId);
		File folderFile = new File(folderAbsolutePath);
		if(folderFile.exists()){
			return false;
		}else{
			boolean result = folderFile.mkdirs();
			return result;
		}
	}
	
	
	
	/**
	 * 删除一个目录如果目录下有图片
	 * 则抛出IOException
	 * @param folderId
	 * @return 成功success,如果目录不存在抛出异常
	 * @throws IOException
	 */
	public boolean deleteFolder(String folderId) throws IOException,FolderNotExistException,FolderHasImageException{
		boolean result = false;
		String folderAbsolutePath = this.getFolderPath(folderId);
		File folderFile = new File(folderAbsolutePath);
		if(folderFile.isFile()){
			throw new IOException("the folder [" + folderAbsolutePath + "] is a file,can not delete as folder.");
		}else if(!folderFile.exists()){
			throw new FolderNotExistException("the folder [" + folderAbsolutePath + "] isn't exist so cannot be deleted.");
		}else if(folderFile.listFiles().length > 0){
			throw new FolderHasImageException("the folder [" + folderAbsolutePath + "] isn't empty so cannot be deleted,Please delete all the image in it.");
		}else{
			result = folderFile.delete();
		}
		return result;
	}
	
	/**
	 * 创建一个图片
	 * @param folderId
	 * @param imageId
	 * @param imageFile
	 * @param imageMeta
	 * 如果folder不存在抛出FileNotFoundException提示folder不存在
	 * 如果已经存在则抛出IOException提示图片已存在 
	 * 如果imageId对应的文件夹不存在则创建
	 * 上述通过之后保存Propertes文件到imageId文件夹,然后保存图片本身
	 */
	/* 
	 * @see com.mocha.bsm.imagemanager.service.IImageManageService#createImage(java.lang.String, java.lang.String, java.io.File, java.util.Properties)
	 */
	public Image createImage(String folderId, File imageFile,
			String imageFileName,String contentType,String imageName) throws FileNotFoundException,IOException,ImageHasExistException{
		String folderAbsolutePath = this.getFolderPath(folderId);
		String imageId = UidGenerator.generateUid();
		String imageAbsolutePath = this.getImagePath(folderId, imageId);
		String imageMetaPropertiesAbsolutePath = this.getImageMetaFilePath(folderId, imageId);
		Properties imageMeta = new Properties();
		imageMeta.setProperty("ContentType", contentType);
		imageMeta.setProperty("imageName", imageName);
		imageMeta.setProperty("imageFileName", imageFileName);
		File folder = new File(folderAbsolutePath);
		File imageFileTarget = new File(imageAbsolutePath);
		File imageMetaFile = new File(imageMetaPropertiesAbsolutePath);
		if(!folder.exists()){
			throw new FileNotFoundException("the folder [" + folderAbsolutePath + "] isn't exist so cannot create image in it.");
		}else if(imageFileTarget.exists()){
			throw new ImageHasExistException("the image [" + imageAbsolutePath + "] exist so cannot create,Please delete exist image in it.");
		}
		//save meta
		this.saveImageMeta(imageMeta, imageMetaFile, folderId, imageId);
		//save image
		copyFile(imageFile,imageFileTarget);
		return this.getImage(folderId, imageId);
	}
	
	public Image updateImage(String folderId,String imageId,File imageFile,String imageFileName,String contentType,String imageName)throws IOException,FolderNotExistException,ImageHasExistException{
		String folderAbsolutePath = this.getFolderPath(folderId);
		String imageAbsolutePath = this.getImagePath(folderId, imageId);
		String imageMetaPropertiesAbsolutePath = this.getImageMetaFilePath(folderId, imageId);
		Properties imageMeta = new Properties();
		imageMeta.setProperty("ContentType", contentType);
		imageMeta.setProperty("imageName", imageName);
		imageMeta.setProperty("imageFileName", imageFileName);		
		File folder = new File(folderAbsolutePath);
		File imageFileTarget = new File(imageAbsolutePath);
		File imageMetaFile = new File(imageMetaPropertiesAbsolutePath);		
		if(!folder.exists()){
			throw new FileNotFoundException("the folder [" + folderAbsolutePath + "] isn't exist so cannot create image in it.");
		}
		//save meta
		this.saveImageMeta(imageMeta, imageMetaFile, folderId, imageId);
		//save image
		copyFile(imageFile,imageFileTarget);
		return this.getImage(folderId, imageId);
	}
	
		
	private void saveImageMeta(Properties imageMeta,File destFile,String folderId,String imageId) throws IOException {
		FileOutputStream metaout = new FileOutputStream(destFile);
		imageMeta.storeToXML(metaout, "folderid:[" + folderId + "],imageId:[" + imageId + "]" );
		metaout.close();
	}
	
	
	private boolean deleteImageMeta(File metaFile){
		return metaFile.delete();
	}
	
	private void copyFile(File srcFile, File destFile) throws IOException 
	{
	        InputStream oInStream = new FileInputStream(srcFile);
	        OutputStream oOutStream = new FileOutputStream(destFile);
	 
	        // Transfer bytes from in to out
	        byte[] oBytes = new byte[1024];
	        int nLength;
	        BufferedInputStream oBuffInputStream = new BufferedInputStream( oInStream );
	        while ((nLength = oBuffInputStream.read(oBytes)) > 0) 
	        {
	        	oOutStream.write(oBytes, 0, nLength);
	        }
	        oInStream.close();
	        oOutStream.close();
	        oBuffInputStream.close();
	}
	
	/**
	 * 在某一个对象和一个Image之间创建一个关联
	 * 如果该关联存在则直接返回
	 * 如果图片不存在则抛出ImageNotFoundException提示图片不存在无法建立关联
	 * @param relType
	 * @param imageId
	 * @param object
	 */
	/* 
	 * @see com.mocha.bsm.imagemanager.service.IImageManageService#createRelationship(com.mocha.bsm.imagemanager.model.RelationshipType, java.lang.String, java.lang.String, java.lang.Object)
	 */
	public Relationship createRelationship(final RelationshipType relType,
			final String folderId, final String imageId, final String objectId) throws ImageNotFoundException {
		
		List<Relationship> rels = this.dbTemplate.query(new Predicate<Relationship>(){
			
			public boolean match(Relationship rel) {
				
				return (rel.getObjectId().equals(objectId))
						&&
						rel.getType().equals(relType)
						&&
						rel.getImage().getImageId().equals(imageId)
						&&
						rel.getImage().getFolder().getFolderId().equals(folderId);
			}
			
		});
		
		if(rels.size()>0){
			return rels.get(0);
		}else{
			Image image = this.getImage(folderId, imageId);
			if(image == null){
				throw new ImageNotFoundException("createRelationship fail because the image[folderId=["+folderId+"],imageId=["+imageId+"]] want to bind with object["+objectId+"] doesn't exist!");
			}else{
				String relId = UidGenerator.generateUid();
				Relationship newRel = new Relationship();
				newRel.setId(relId);
				newRel.setImage(image);
				newRel.setObjectId(objectId);
				newRel.setType(relType);
				this.dbTemplate.save(newRel);
				return newRel;
			}
		}
		
	}
	
	/**
	 * 如果成功返回true,失败返回false
	 * @param relationshipId
	 * @return
	 */
	public boolean deleteRelationship(final String folderId,final String imageId, final String objectId){
		boolean result = true;
		this.dbTemplate.delete(new Predicate<Relationship>(){
			
			public boolean match(Relationship rel) {
				
				return rel.getObjectId().equals(objectId) 
				&& rel.getImage().getImageId().equals(imageId)
				&& rel.getImage().getFolder().getFolderId().equals(folderId);
				
			}
			
		});
		
		return result;
	}	

	/* 
	 * @see com.mocha.bsm.imagemanager.service.IImageManageService#deleteImage(java.lang.String, java.lang.String)
	 */
	public boolean deleteImage(String folderId, String imageId)
			throws IOException,ImageNotFoundException {
		String folderAbsolutePath = this.getFolderPath(folderId);
		String imageAbsolutePath = this.getImagePath(folderId, imageId);
		String imageMetaPropertiesAbsolutePath = this.getImageMetaFilePath(folderId, imageId);
		File folder = new File(folderAbsolutePath);
		File imageFileTarget = new File(imageAbsolutePath);
		File imageMetaFile = new File(imageMetaPropertiesAbsolutePath);
		boolean result = false;
		if(!folder.exists()){
			throw new FileNotFoundException("the folder [" + folderAbsolutePath + "] isn't exist so cannot create image in it.");
		}else if(!imageFileTarget.exists()){
			throw new ImageNotFoundException("the image [" + imageAbsolutePath + "] not exist so cannot be create,Please delete exist image in it.");
		}else{
			//save meta
			this.deleteImageMeta(imageMetaFile);
			//save image
			result = imageFileTarget.delete();
		}
		
		return result;
	}

	/* 
	 * @see com.mocha.bsm.imagemanager.service.IImageManageService#getAllFolders()
	 */
	public List<Folder> getAllFolders() {
		List<Folder> foldersList = new ArrayList<Folder>();
		File folderRoot = new File(this.getImageRootPath());
		if(folderRoot.exists() && folderRoot.isDirectory()){
			File[] folders = folderRoot.listFiles();
			for (int i = 0; i < folders.length; i++) {
				if(folders[i].isDirectory()){
					String folderId = folders[i].getName();
					
					Folder folder = this.getFolder(folderId);
					
					foldersList.add(folder);
				}		
			}
		}
		
		return foldersList;
	}

	public String getFolderUri(String folderId){
		return "/folder/" + folderId;
	}
	
	public String getImageUri(String folderId,String imageId){
		return "/folder/" + folderId + "/image/" + imageId;
	}
	
	/* 
	 * @see com.mocha.bsm.imagemanager.service.IImageManageService#getImage(java.lang.String, java.lang.String)
	 */
	public Image getImage(String folderId, String imageId) {
		File imageFile = this.getImageFile(folderId, imageId);
		File metaFile = this.getImageMetaFile(folderId, imageId);
		Folder folder = this.getFolder(folderId);
		Image image = new Image(imageId,imageFile,metaFile,this.getImageUri(folderId, imageId),folder);
		return image;
	}
	
	public List<Image> getImagesByName(String folderId,String imageName){
		List<Image> images = new ArrayList<Image>();
		List<Image> allImages = this.getImagesByFolderId(folderId);
		for (Image image:allImages) {
			if(image.getName().equals(imageName)){
				images.add(image);
			}
		}
		return images;
	}
	
	/* 
	 * @see com.mocha.bsm.imagemanager.service.IImageManageService#getImagesByFolderId(java.lang.String)
	 */
	public List<Image> getImagesByFolderId(String folderId) {
		return this.getFolder(folderId).getImages();
	}
	
	/* 
	 * @see com.mocha.bsm.imagemanager.service.IImageManageService#getImagesByObject(java.lang.Object)
	 */
	public List<Image> getImagesByObject(final String objectId) {
		
		List<Relationship> rels = this.dbTemplate.query(new Predicate<Relationship>(){
			public boolean match(Relationship rel) {
				return rel.getObjectId().equals(objectId);
			}
		});
		
		List<Image> images = new ArrayList<Image>();
		
		for(Relationship rel:rels){
			images.add(rel.getImage());
		}
		
		return images;
	}
	
	/* 
	 * @see com.mocha.bsm.imagemanager.service.IImageManageService#hasImage(java.lang.String, java.lang.String)
	 */
	public boolean hasImage(String folderId, String imageId) {
		return this.getImageFile(folderId, imageId).exists();
	}

	/* 
	 * @see com.mocha.bsm.imagemanager.service.IImageManageService#hasImageRel(java.lang.Object)
	 */
	public boolean hasImageRel(final String objectId) {
		List<Relationship> rels = this.dbTemplate.query(new Predicate<Relationship>(){
			public boolean match(Relationship rel) {
				return rel.getObjectId().equals(objectId);
			}
		});
		return rels.size() > 0;
	}
	
	
}
