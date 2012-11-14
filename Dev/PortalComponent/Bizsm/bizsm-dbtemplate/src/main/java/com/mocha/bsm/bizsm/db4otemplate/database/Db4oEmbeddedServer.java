package com.mocha.bsm.bizsm.db4otemplate.database;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Comparator;
import java.util.GregorianCalendar;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.db4o.Db4oEmbedded;
import com.db4o.EmbeddedObjectContainer;
import com.db4o.config.EmbeddedConfiguration;


public class Db4oEmbeddedServer implements IEmbeddedDb4oServer {
	/**
	 * Log Instance.
	 */
	private Log log = LogFactory.getLog(this.getClass());
	private String contextPath = "./bizsm_db4o_dbfile";
	private String dbfileRelativePath = "/conf/db/db4oj/";
	private String dbfileBackupRelativePath = "/conf/db/db4oj/bak/";
	public final static String DATABASE_FILENAME = "NETFOCUS_DB";
	private static byte[] lockForOpenOrStopOrBakServer = new byte[0];
	private EmbeddedObjectContainer dbserver = null;
	private IDb4oConfigurationLoader configurationLoader;
	private IContextRoot contextRoot;
	
	public IContextRoot getContextRoot() {
		return contextRoot;
	}
	//Inject
	public void setContextRoot(IContextRoot contextRoot) {
		this.contextRoot = contextRoot;
	}

	public Db4oEmbeddedServer(){
	}
	
	public Db4oEmbeddedServer(IDb4oConfigurationLoader configurationLoader){
		this.configurationLoader = configurationLoader;
	}
	
	public void setContextPath(String contextPath) {
		this.contextPath = contextPath;
	}

	public String getContextPath(){
		return this.contextPath;
	}
	
	/**
	 * 启动服务器
	 */
	public void startup(){
		if(this.contextRoot != null && this.contextRoot.getContextRoot() != null){
			this.setContextPath(this.contextRoot.getContextRoot());
		}
		String filePath = this.getContextPath() + this.dbfileRelativePath + Db4oEmbeddedServer.DATABASE_FILENAME;
		log.info("Db4oEmbeddedServer Start from File:["+filePath+"]");
		synchronized (lockForOpenOrStopOrBakServer) {
			if(this.dbserver == null){
					initDbPathFolder();
					this.dbserver = Db4oEmbedded.openFile(getServerConfiguration(), filePath);
			}
		}		
	}
	
	/**
	 * 关闭服务器
	 */
	public boolean shutdown(){
		boolean result = false;
		synchronized (lockForOpenOrStopOrBakServer) {
			if(this.dbserver != null){
					result = this.dbserver.close();
					this.dbserver = null;
			}
		}
		return result;
	}
	
	/**
	 * 备份数据库
	 * @return
	 */
	public boolean backup(){
		int backupfilenum = 2;//
		File file = this.backupDbBase();
		boolean result = true;
		if(file != null){
			File backupDir = file.getParentFile();
			if(backupDir.exists() && backupDir.isDirectory()){
				File[] bakfiles = backupDir.listFiles();
				
				Arrays.sort(bakfiles, new Comparator() {
					
					public int compare(Object o1, Object o2) {
						File file1 = (File)o1;
						File file2 = (File)o1;
						long file1time = file1.lastModified();
						long file2time = file2.lastModified();
						if(file1time > file2time){
							return -1;
						}else if(file1time < file2time){
							return 1;
						}else{
							return 0;
						}
					}
					
				});
				
				for (int i = (bakfiles.length-1),j=0; i >= 0; i--,j++) {
					if(j > backupfilenum - 1){
						if(result == true)
							result = bakfiles[i].delete();
					}
				}
				
			}
		}
		return result;		
	}
	
	/**
	 * 备份数据库并以流输出
	 * @param os - 输出流
	 * @return
	 */
	public boolean backup(OutputStream os) throws IOException{
		BufferedInputStream fin = null;
		BufferedOutputStream outs = null;
		try {
			File file = this.backupDbBase();
			if(file == null){
				return false;
			}

			if (file != null && file.isFile()) {
				byte bytes[] = new byte[4062];
				fin = new BufferedInputStream(new FileInputStream(file));
				outs = new BufferedOutputStream(os);
				int read = 0;
				while ((read = fin.read(bytes)) > 0) {
					outs.write(bytes, 0, read);
				}
				outs.flush();
			}
		} catch (Exception e) {
			log.error("error when output backupDbFile", e);
		} finally{
			if(fin!=null)fin.close();
		}
		return true;
	}
	
	/**
	 * 获得数据库
	 * @return
	 */
	public EmbeddedObjectContainer getDataBase(){
		return dbserver;		
	}	

	/**
	 * 
	 * @return File
	 */
	protected File backupDbBase(){
		String result = "";
		synchronized (lockForOpenOrStopOrBakServer) {
			try {
					if(this.dbserver != null){
						initDbBakPathFolder();
						Calendar calendar = new GregorianCalendar();
						int year = calendar.get(Calendar.YEAR);
						int month = calendar.get(Calendar.MONTH);
						int day = calendar.get(Calendar.DAY_OF_MONTH);
						int hour = calendar.get(Calendar.HOUR_OF_DAY);
						int minute = calendar.get(Calendar.MINUTE);
						int second = calendar.get(Calendar.SECOND);
						int millisecond = calendar.get(Calendar.MILLISECOND);
						String timestamp = year + "-" + (month+1) + "-" + day + "-" + hour + "-" + minute + "-" + second + "-" + millisecond;
						String bakFilePath = this.contextPath + this.dbfileBackupRelativePath + Db4oEmbeddedServer.DATABASE_FILENAME + timestamp;		
						this.dbserver.backup(bakFilePath);
						result = bakFilePath;
					}				
			} catch (Exception e) {
				log.error("error when backup DB4O!", e);
			}
		}
		File bakFile = new File(result);
		
		if(bakFile.exists() && bakFile.isFile()){
			return bakFile;
		}else{
			return null;
		}
	}
	
	/**
	 * 
	 * @param dbconfigPath
	 * @return
	 */
	private EmbeddedConfiguration getServerConfiguration(){
		EmbeddedConfiguration dbConfig = Db4oEmbedded.newConfiguration();
		//do some default configuration
		configurateFileConfig(dbConfig);
		return dbConfig;
	}
	
	/**
	 * 
	 * @param dbConfig
	 * @param dbconfigPath
	 */
	private void configurateFileConfig(EmbeddedConfiguration dbConfig){
		configurationLoader.loadDbConfig(dbConfig);
	}
	
	/**
	 * 
	 */
	private boolean initDbPathFolder(){
		boolean result = false;
		String filePath = this.contextPath + this.dbfileRelativePath;
		File file = new File(filePath);
		if(!file.exists()){
			result = file.mkdirs();
		}
		return result;
	}
	
	/**
	 * 
	 */
	private boolean initDbBakPathFolder(){
		boolean result = false;
		String filePath = this.contextPath + this.dbfileBackupRelativePath;
		File file = new File(filePath);
		if(!file.exists()){
			result = file.mkdirs();
		}
		return result;
	}
	
}
