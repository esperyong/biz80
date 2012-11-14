package com.mocha.bsm.imagemanager.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Properties;
import com.mocha.bsm.imagemanager.exception.FolderHasImageException;
import com.mocha.bsm.imagemanager.exception.FolderNotExistException;
import com.mocha.bsm.imagemanager.exception.ImageHasExistException;
import com.mocha.bsm.imagemanager.exception.ImageNotFoundException;
import com.mocha.bsm.imagemanager.model.Folder;
import com.mocha.bsm.imagemanager.model.Image;
import com.mocha.bsm.imagemanager.model.Relationship;
import com.mocha.bsm.imagemanager.model.RelationshipType;

public interface IImageManageService {
	
	/**
	 * 获得所有的Folder
	 * @return
	 */
	public List<Folder> getAllFolders();
	
	/**
	 * 获得文件夹下面所有的Image
	 * 如果没有返回null
	 * @param folderId
	 * @return
	 */
	public List<Image> getImagesByFolderId(String folderId);
	
	/**
	 * 根据folderId和imageName来获得所有这个名字的image
	 * @param folderId
	 * @param imageName
	 * @return
	 */
	public List<Image> getImagesByName(String folderId,String imageName);	
	
	/**
	 * 获得某一个文件夹
	 * @param folderId
	 * @return
	 */
	public Folder getFolder(String folderId);	
	
	/**
	 * 获得一个图片
	 * 如果没有返回null
	 * @param folderId
	 * @param imageId
	 * @return
	 */
	public Image getImage(String folderId,String imageId);

	/**
	 * 判断一个图片是否存在
	 * @param folderId
	 * @param imageId
	 * @return
	 */
	public boolean hasImage(String folderId,String imageId);	
	
	/**
	 * 在某一个对象和一个Image之间创建一个关联
	 * 如果该关联存在则直接返回
	 * 如果图片不存在则抛出ImageNotFoundException提示图片不存在无法建立关联
	 * @param relType
	 * @param imageId
	 * @param object
	 */
	public Relationship createRelationship(RelationshipType relType,String folderId,String imageId,String objectId) throws ImageNotFoundException;
	
	/**
	 * 如果成功返回true,失败返回false
	 * @param relationshipId
	 * @return
	 */
	public boolean deleteRelationship(String folderId,String imageId,String objectId);
	
	/**
	 * 判断一个对象是否绑定了图片
	 * 如果绑定的图片>0则返回true
	 * =0返回false
	 * @param object
	 * @return
	 */
	public boolean hasImageRel(String objectId);
	
	/**
	 * 根据一个对象察看这个对象所绑定的Image
	 * 如果没有绑定的图片则返回null
	 * @param object
	 * @return
	 */
	public List<Image> getImagesByObject(String objectId);
	
	/**
	 * 创建一个目录,如果目录已经存在则返回false
	 * @param folderId
	 */
	public boolean createFolder(String folderId);
	
	/**
	 * 删除一个目录如果目录下有图片
	 * 则抛出IOException
	 * @param folderId
	 * @return 成功success,如果目录不存在抛出异常
	 * @throws IOException
	 */
	public boolean deleteFolder(String folderId) throws IOException,FolderNotExistException,FolderHasImageException;
	
	/**
	 * 创建一个图片,或者说存入一个图片
	 * @param folderId
	 * @param imageId
	 * @param imageFile
	 * @param imageMeta
	 * 如果folder不存在抛出FolderNotExistException提示folder不存在
	 * 如果image不存在则创建
	 * 如果已经存在则抛出ImageHasExistException提示图片已存在
	 * 上述通过之后保存Propertes文件到imageId文件夹,然后保存图片本身
	 */
	public Image createImage(String folderId,File imageFile,String imageFileName,String contentType,String imageName)throws IOException,FolderNotExistException,ImageHasExistException;
	
	public Image updateImage(String folderId,String imageId,File imageFile,String imageFileName,String contentType,String imageName)throws IOException,FolderNotExistException,ImageHasExistException;
	
	/**
	 * 删除一个图片
	 * 成功true,失败false
	 * 如果图片不存在抛出异常
	 * @param folderId
	 * @param imageId
	 * @return
	 */
	public boolean deleteImage(String folderId,String imageId) throws IOException,ImageNotFoundException;
	
	
}







