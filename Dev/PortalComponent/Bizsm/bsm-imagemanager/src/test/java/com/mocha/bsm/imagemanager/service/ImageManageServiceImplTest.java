/**
 * 
 */
package com.mocha.bsm.imagemanager.service;

import java.io.File;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.mocha.bsm.bizsm.db4otemplate.core.IDb4oTemplate;
import com.mocha.bsm.bizsm.db4otemplate.database.Db4oEmbeddedServer;
import com.mocha.bsm.imagemanager.model.Folder;
import com.mocha.bsm.imagemanager.model.Image;
import com.mocha.bsm.imagemanager.model.ImageRelationshipType;

import junit.framework.TestCase;

/**
 * @author liuyong
 *
 */
public class ImageManageServiceImplTest extends TestCase {
	ApplicationContext context = null;
	IDb4oTemplate db4oTemplate = null;
	Db4oEmbeddedServer server = null;
	ImageManageServiceImpl imageManageService = null;
	/* (non-Javadoc)
	 * @see junit.framework.TestCase#setUp()
	 */
	protected void setUp() throws Exception {
		super.setUp();
		this.context = new ClassPathXmlApplicationContext("classpath*:/META-INF/mochasoft/services.xml");
		((AbstractApplicationContext)this.context).registerShutdownHook();
		this.db4oTemplate = (IDb4oTemplate)context.getBean("db4oTemplateSingleConn");
		this.server = (Db4oEmbeddedServer)context.getBean("db4oEmbeddedServer");
		this.imageManageService = (ImageManageServiceImpl)context.getBean("bsm.imageManager");
		this.server.startup();
		System.out.println(server.getContextPath());
	}

	/* (non-Javadoc)
	 * @see junit.framework.TestCase#tearDown()
	 */
	protected void tearDown() throws Exception {
		super.tearDown();
	}

	/**
	 * Test method for {@link com.mocha.bsm.imagemanager.service.ImageManageServiceImpl#getFolderPath(java.lang.String)}.
	 */
	public void testGetFolderPath() {
		String folderPath = this.imageManageService.getFolderPath("liuyong");
		System.out.println(folderPath);
	}

	/**
	 * Test method for {@link com.mocha.bsm.imagemanager.service.ImageManageServiceImpl#getFolder(java.lang.String)}.
	 */
	public void testGetFolder() {
		Folder folder = this.imageManageService.getFolder("bizsm");
		System.out.println(folder);
	}

	/**
	 * Test method for {@link com.mocha.bsm.imagemanager.service.ImageManageServiceImpl#createFolder(java.lang.String)}.
	 */
	public void testCreateFolder() throws Exception{
		String folderId = "bizsm";
		boolean result = this.imageManageService.createFolder(folderId);
		assertTrue(result);
		result = this.imageManageService.createFolder(folderId);
		TestCase.assertFalse(result);
		this.imageManageService.deleteFolder(folderId);
	}

	/**
	 * Test method for {@link com.mocha.bsm.imagemanager.service.ImageManageServiceImpl#deleteFolder(java.lang.String)}.
	 */
	public void testDeleteFolder()throws Exception {
		try {
			this.imageManageService.deleteFolder("bizsm");
		} catch (Exception e) {
			
		}
		
	}

	/**
	 * Test method for {@link com.mocha.bsm.imagemanager.service.ImageManageServiceImpl#createImage(java.lang.String, java.lang.String, java.io.File, java.util.Properties)}.
	 */
	public void testCreateImage() throws Exception {
		this.imageManageService.createFolder("bizsm");
		Image image = this.imageManageService.createImage("bizsm", new File("d:/我的文档/图片收藏/bs-03-01-01.JPG"), "bs-03-01-01.JPG","application/jpge","业务服务首页");
		this.imageManageService.deleteImage("bizsm", image.getImageId());
		this.imageManageService.deleteFolder("bizsm");
	}

	/**
	 * Test method for {@link com.mocha.bsm.imagemanager.service.ImageManageServiceImpl#deleteImage(java.lang.String, java.lang.String)}.
	 */
	public void testDeleteImage() throws Exception{
		this.imageManageService.createFolder("bizsm");
		Image image = this.imageManageService.createImage("bizsm", new File("d:/我的文档/图片收藏/bs-03-01-01.JPG"), "bs-03-01-01.JPG","application/jpge","业务服务首页");
		this.imageManageService.deleteImage("bizsm",image.getImageId());
		this.imageManageService.deleteFolder("bizsm");
	}

	/**
	 * Test method for {@link com.mocha.bsm.imagemanager.service.ImageManageServiceImpl#getAllFolders()}.
	 */
	public void testGetAllFolders() throws Exception{		
		List<Folder> list = this.imageManageService.getAllFolders();
		assertEquals(0,list.size());
		this.imageManageService.createFolder("bizsm");
		Image image = this.imageManageService.createImage("bizsm", new File("d:/我的文档/图片收藏/bs-03-01-01.JPG"), "bs-03-01-01.JPG","application/jpge","业务服务首页");
		list = this.imageManageService.getAllFolders();
		assertEquals(1,list.size());
		this.imageManageService.deleteImage("bizsm", image.getImageId());
		this.imageManageService.deleteFolder("bizsm");
	}

	/**
	 * Test method for {@link com.mocha.bsm.imagemanager.service.ImageManageServiceImpl#getFolderUri(java.lang.String)}.
	 */
	public void testGetFolderUri() {
		System.out.println(this.imageManageService.getFolderUri("bizsm"));
	}
	
	/**
	 * Test method for {@link com.mocha.bsm.imagemanager.service.ImageManageServiceImpl#getImageUri(java.lang.String, java.lang.String)}.
	 */
	public void testGetImageUri() {
		System.out.println(this.imageManageService.getImageUri("bizsm","liuyong"));
	}
	
	/**
	 * Test method for {@link com.mocha.bsm.imagemanager.service.ImageManageServiceImpl#getImagesByFolderId(java.lang.String)}.
	 */
	public void testGetImagesByFolderId() throws Exception{
		this.imageManageService.createFolder("bizsm");
		this.imageManageService.createImage("bizsm", new File("d:/我的文档/图片收藏/bs-03-01-01.JPG"), "bs-03-01-01.JPG","application/jpge","业务服务首页");
		List<Image> images = this.imageManageService.getImagesByFolderId("bizsm");
		assertEquals(1,images.size());
		this.imageManageService.deleteImage("bizsm", "liuyong");
		this.imageManageService.deleteFolder("bizsm");
	}

	/**
	 * Test method for {@link com.mocha.bsm.imagemanager.service.ImageManageServiceImpl#createRelationship(com.mocha.bsm.imagemanager.model.RelationshipType, java.lang.String, java.lang.String, java.lang.Object)}.
	 */
	public void testCreateRelationship() throws Exception{
		String objectId = "1";
		this.imageManageService.createFolder("bizsm");
		Image image = this.imageManageService.createImage("bizsm", new File("d:/我的文档/图片收藏/bs-03-01-01.JPG"), "bs-03-01-01.JPG","application/jpge","业务服务首页");
		
		this.imageManageService.createRelationship(ImageRelationshipType.USE_IMAGE, "bizsm", image.getImageId(), objectId);
		List<Image> images = this.imageManageService.getImagesByObject(objectId);
		assertEquals(1,images.size());
		this.imageManageService.deleteRelationship("bizsm", image.getImageId(), objectId);
		images = this.imageManageService.getImagesByObject(objectId);
		assertEquals(0,images.size());
		this.imageManageService.deleteImage("bizsm", image.getImageId());
		this.imageManageService.deleteFolder("bizsm");		
	}
	

	/**
	 * Test method for {@link com.mocha.bsm.imagemanager.service.ImageManageServiceImpl#hasImage(java.lang.String, java.lang.String)}.
	 */
	public void testHasImage() throws Exception{
		this.imageManageService.createFolder("bizsm");
		Image image = this.imageManageService.createImage("bizsm", new File("d:/我的文档/图片收藏/bs-03-01-01.JPG"), "bs-03-01-01.JPG","application/jpge","业务服务首页");
		
		assertTrue(this.imageManageService.hasImage("bizsm", image.getImageId()));
		
		this.imageManageService.deleteImage("bizsm",image.getImageId());
		this.imageManageService.deleteFolder("bizsm");			
	}

	/**
	 * Test method for {@link com.mocha.bsm.imagemanager.service.ImageManageServiceImpl#hasImageRel(java.lang.Object)}.
	 */
	public void testHasImageRel() throws Exception{
		String objectId = "1";
		this.imageManageService.createFolder("bizsm");
		Image image = this.imageManageService.createImage("bizsm", new File("d:/我的文档/图片收藏/bs-03-01-01.JPG"), "bs-03-01-01.JPG","application/jpge","业务服务首页");
		
		this.imageManageService.createRelationship(ImageRelationshipType.USE_IMAGE, "bizsm", image.getImageId(), objectId);
		assertTrue(this.imageManageService.hasImageRel(objectId));
		this.imageManageService.deleteRelationship("bizsm", image.getImageId(), objectId);
		TestCase.assertFalse(this.imageManageService.hasImageRel(objectId));
	}
	
	
}
