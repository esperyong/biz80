package com.mocha.bsm.bizsm.db4otemplate.database;

import java.io.IOException;
import java.io.OutputStream;
import com.db4o.EmbeddedObjectContainer;

public interface IEmbeddedDb4oServer {
	
	/**
	 * 启动服务器
	 */
	public void startup();
	
	/**
	 * 关闭服务器
	 */
	public boolean shutdown();	
	
	/**
	 * 备份数据库
	 * @return
	 */
	public boolean backup();
	
	/**
	 * 备份数据库并以流输出
	 * @param os - 输出流
	 * @return
	 */
	public boolean backup(OutputStream os) throws IOException;
	
	/**
	 * 获得数据库
	 * @return
	 */
	public EmbeddedObjectContainer getDataBase();

}