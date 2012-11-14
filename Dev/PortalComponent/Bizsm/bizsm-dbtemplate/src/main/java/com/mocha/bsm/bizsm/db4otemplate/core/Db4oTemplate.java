package com.mocha.bsm.bizsm.db4otemplate.core;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.db4o.ObjectContainer;
import com.db4o.ObjectSet;
import com.db4o.ext.DatabaseClosedException;
import com.db4o.ext.DatabaseReadOnlyException;
import com.db4o.ext.Db4oIOException;
import com.db4o.ext.InvalidIDException;
import com.db4o.query.Predicate;
import com.db4o.query.Query;
import com.mocha.bsm.bizsm.db4otemplate.datasource.IDb4oDataSource;
import com.mocha.bsm.bizsm.db4otemplate.util.Assert;

public class Db4oTemplate implements IDb4oTemplate {
	
	/**
	 * Log Instance.
	 */
	private Log log = LogFactory.getLog(this.getClass());
	
	private IDb4oDataSource datasource;
	
	/**
	 * @see Db4oDBServer#getServerConfiguration()
	 */
	public Db4oTemplate(){
		
	}
	
	public Db4oTemplate(IDb4oDataSource datasource){
		this.datasource = datasource;
	}	
	
	public IDb4oDataSource getDatasource() {
		return datasource;
	}

	public void setDatasource(IDb4oDataSource datasource) {
		this.datasource = datasource;
	}
	
	/* 
	 * @see com.mocha.bsm.bizsm.db4otemplate.core.IDb4oTemplate#delete
	 */
	public <ExtentType> void delete(Predicate<ExtentType> predicate) {
		ObjectContainer oc = this.getDbConnection();
		try{
			ObjectSet<ExtentType> list  = oc.query(predicate);
			while(list.hasNext()){
				oc.delete(list.next());
			}
			oc.commit();
		}catch(Db4oIOException ioe){
			log.error("Error occur when DefaultDb4oDAOImpl#delete(Predicate)!", ioe);
			oc.rollback();			
		}catch (DatabaseClosedException dbcloseex){
			log.error("Error occur when DefaultDb4oDAOImpl#delete(Predicate)!", dbcloseex);
			oc.rollback();
		}catch(DatabaseReadOnlyException dbreadonlyex){
			log.error("Error occur when DefaultDb4oDAOImpl#delete(Predicate)!", dbreadonlyex);
			oc.rollback();
		}catch (Exception e) {
			log.error("Error occur when DefaultDb4oDAOImpl#delete(Predicate)!", e);
			oc.rollback();
		}finally {
			this.closeConnection(oc);
		}
	}
	
	/**
	 * @see IDb4oDAO#delete(QueryTemplate)
	 */
	public <T> void delete(IQueryCallback queryTemplate){
		Assert.notNull(queryTemplate,"IDb4oDAO#delete(QueryTemplate) QueryTemplate VO can not given null!");
		ObjectContainer oc = this.getDbConnection();
		ObjectSet<T> result = null;
		try{
			Query sodaquery = queryTemplate.generateQuery(oc);
			result = sodaquery.execute();
			while (result.hasNext()) {
				oc.delete(result.next());
			}
			oc.commit();
		}catch(Db4oIOException ioe){
			log.error("Error occur when DefaultDb4oDAOImpl#delete(Predicate)!", ioe);
			oc.rollback();		
		}catch (DatabaseClosedException dbcloseex){
			log.error("Error occur when DefaultDb4oDAOImpl#delete(Predicate)!", dbcloseex);
			oc.rollback();
		}catch(DatabaseReadOnlyException dbreadonlyex){
			log.error("Error occur when DefaultDb4oDAOImpl#delete(Predicate)!", dbreadonlyex);
			oc.rollback();
		}catch (Exception e) {
			log.error("Error occur when DefaultDb4oDAOImpl#delete(Predicate)!", e);
			oc.rollback();
		}finally {
			this.closeConnection(oc);
		}
	}
	
	/**
	 * @see IDb4oDAO#delete(long[])
	 */
	public void delete(long[] ids){
		ObjectContainer oc = this.getDbConnection();
		try{
			for (int i = 0; i < ids.length; i++) {
				oc.delete(oc.ext().getByID(ids[i]));
			}
			oc.commit();
		}catch(Db4oIOException ioe){
			log.error("Error occur when delete(long[])!", ioe);
			oc.rollback();			
		}catch (DatabaseClosedException dbcloseex){
			log.error("Error occur when delete(long[])!", dbcloseex);
			oc.rollback();
		}catch(DatabaseReadOnlyException dbreadonlyex){
			log.error("Error occur when delete(long[])!", dbreadonlyex);
			oc.rollback();
		}catch (Exception e) {
			log.error("Error occur when delete(long[])!", e);
			oc.rollback();
		}finally {
			this.closeConnection(oc);
		}
	}
	
	/**
	 * 删除某个对象
	 * @param obj
	 */
	public void delete(Object obj){
		ObjectContainer oc = this.getDbConnection();
		try{
			oc.delete(obj);
			oc.commit();
		}catch(Db4oIOException ioe){
			log.error("Error occur when delete(Object obj)!", ioe);
			oc.rollback();			
		}catch (DatabaseClosedException dbcloseex){
			log.error("Error occur when delete(Object obj)!", dbcloseex);
			oc.rollback();
		}catch(DatabaseReadOnlyException dbreadonlyex){
			log.error("Error occur when delete(Object obj)!", dbreadonlyex);
			oc.rollback();
		}catch (Exception e) {
			log.error("Error occur when delete(Object obj)!", e);
			oc.rollback();
		}finally {
			this.closeConnection(oc);
		}
	}
	
	/* 
	 * @see com.mocha.netfocus.db.IDb4oDAO#getByID(long)
	 */
	public Object getByID(long ID) {
		return this.getByID(ID,DEFAULT_ACTIVATIONDEPTH);
	}
	
	/**
	 * @see com.mocha.netfocus.db.IDb4oDAO#getByID(long, int)
	 */
	public Object getByID(long ID,int depth){
		ObjectContainer oc = this.getDbConnection();
		Object obj = null;
		try{
			obj = oc.ext().getByID(ID);
			oc.activate(obj, depth);
		}catch(InvalidIDException dbreadonlyex){
			log.error("Error occur when getByID(long ID,int depth)!", dbreadonlyex);
		}catch (DatabaseClosedException dbcloseex){
			log.error("Error occur when getByID(long ID,int depth)!", dbcloseex);
		}catch (Exception e) {
			log.error("Error occur when getByID(long ID,int depth)!", e);
		}finally {
			this.closeConnection(oc);
		}
		return obj;
	}
	
	/* 
	 * @see com.mocha.netfocus.db.IDb4oDAO#query(com.db4o.query.Predicate)
	 */
	public <T> List<T> query(Predicate<T> predicate) {
		ObjectContainer oc = this.getDbConnection();
		List<T> result = null;
		try{
			result = oc.query(predicate);
		}catch(Db4oIOException dbreadonlyex){
			log.error("Error occur when query(Predicate predicate)!", dbreadonlyex);
		}catch (DatabaseClosedException dbcloseex){
			log.error("Error occur when query(Predicate predicate)!", dbcloseex);
		}catch (Exception e) {
			log.error("Error occur when query(Predicate predicate)!", e);
		}finally {
			this.closeConnection(oc);
		}
		return result;
	}
	
	/**
	 * @see com.mocha.netfocus.db.IDb4oDAO#query(QueryTemplate)
	 */		
	public <T> List<T> query(IQueryCallback queryTemplate){
		Assert.notNull(queryTemplate,"pagingQuery QueryTemplate VO can not given null!");
		ObjectContainer oc = this.getDbConnection();
		List<T> result = null;
		try{
			Query sodaquery = queryTemplate.generateQuery(oc);
			result = sodaquery.execute();
		}catch(Db4oIOException dbreadonlyex){
			log.error("Error occur when query(QueryTemplate)!", dbreadonlyex);
		}catch (DatabaseClosedException dbcloseex){
			log.error("Error occur when query(QueryTemplate)!", dbcloseex);
		}catch (Exception e) {
			log.error("Error occur when query(QueryTemplate)!", e);
		}finally {
			this.closeConnection(oc);
		}
		return result;
	}
	
	/* 
	 * @see com.mocha.netfocus.db.IDb4oDAO#queryWithId(com.db4o.query.Predicate)
	 */
	public <T> Map<String,T> queryWithId(Predicate<T> predicate) {
		ObjectContainer oc = this.getDbConnection();
		Map<String,T> result = new HashMap<String,T>();
		try{
			ObjectSet<T> resultList = oc.query(predicate);
			long[] ids = resultList.ext().getIDs();
			for (int i = 0; i < resultList.size(); i++) {
				T obj = resultList.get(i);
				long id = ids[i];
				result.put(id+"", obj);
			}
		}catch(Db4oIOException dbreadonlyex){
			log.error("Error occur when queryWithId(Predicate predicate)!", dbreadonlyex);
		}catch (DatabaseClosedException dbcloseex){
			log.error("Error occur when queryWithId(Predicate predicate)!", dbcloseex);
		}catch (Exception e) {
			log.error("Error occur when queryWithId(Predicate predicate)!", e);
		}finally {
			this.closeConnection(oc);
		}
		return result;
	}
	
	/**
	 * @see com.mocha.netfocus.db.IDb4oDAO#queryAll(java.lang.Class)
	 */
	public <T> List<T> queryAll(Class<T> objClass) {
		ObjectContainer oc = this.getDbConnection();
		List<T> result = null;
		try{
			result = oc.query(objClass);
		}catch(Db4oIOException dbreadonlyex){
			log.error("Error occur when queryAll(Class objClass)!", dbreadonlyex);
		}catch (DatabaseClosedException dbcloseex){
			log.error("Error occur when queryAll(Class objClass)!", dbcloseex);
		}catch (Exception e) {
			log.error("Error occur when queryAll(Class objClass)!", e);
		}finally {
			this.closeConnection(oc);
		}
		return result;
	}
	/**
	 * @see com.mocha.netfocus.db.IDb4oDAO#queryAllWithId(java.lang.Class)
	 */	
	public <T> Map<String,T> queryAllWithId(Class<T> objClass){
		ObjectContainer oc = this.getDbConnection();
		ObjectSet<T> resultList = null;
		Map<String,T> result = new HashMap<String,T>();
		try{
			resultList = oc.query(objClass);
			long[] ids = resultList.ext().getIDs(); 
			for (int i = 0; i < resultList.size(); i++) {
				T obj = resultList.get(i);
				long id = ids[i];
				result.put(id+"", obj);
			}			
		}catch(Db4oIOException dbreadonlyex){
			log.error("Error occur when queryAllWithId(Class objClass)!", dbreadonlyex);
		}catch (DatabaseClosedException dbcloseex){
			log.error("Error occur when queryAllWithId(Class objClass)!", dbcloseex);
		}catch (Exception e) {
			log.error("Error occur when queryAllWithId(Class objClass)!", e);
		}finally {
			this.closeConnection(oc);
		}
		return result;
	}
	
	/**
	 * @see com.mocha.netfocus.db.IDb4oDAO#query(long[])
	 */			
	public <T> List<T> query(long[] objids){
		ObjectContainer oc = this.getDbConnection();
		List<T> resultList = new ArrayList<T>();
		try{
			for (int i = 0; i < objids.length; i++) {
				T obj = oc.ext().<T>getByID(objids[i]);
				oc.activate(obj, DEFAULT_DB4O_ACTIVATIONDEPTH);
				resultList.add(obj);
			}			
		}catch(Db4oIOException dbreadonlyex){
			log.error("Error occur when queryAllWithId(Class objClass)!", dbreadonlyex);
		}catch (DatabaseClosedException dbcloseex){
			log.error("Error occur when queryAllWithId(Class objClass)!", dbcloseex);
		}catch (Exception e) {
			log.error("Error occur when queryAllWithId(Class objClass)!", e);
		}finally {
			this.closeConnection(oc);
		}
		return resultList;
	}
	
	/**
	 * @see com.mocha.netfocus.db.IDb4oDAO#pagingQuery(QueryTemplate, int, int)
	 */		
	public <T> Pagination<T> pagingQuery(IQueryCallback queryTemplate,int pageNo,int numPerPage){
		Assert.notNull(queryTemplate,"pagingQuery QueryTemplate VO can not given null!");
		ObjectContainer oc = this.getDbConnection();
		Pagination<T> page = null;
		try{
			Query sodaquery = queryTemplate.generateQuery(oc);
			
			ObjectSet<T> objSet = sodaquery.execute();
			
			int allRecordSize = objSet.size();
			
			if(allRecordSize > 0){
				page = new Pagination<T>(allRecordSize,numPerPage,pageNo);
				int beginNo = page.getStartRecordNo();
				int endNo = page.getEndRecordNo();
				
		        for (int i = beginNo-1; i< endNo;i++) {
		        	T object = objSet.get(i);
					long id = oc.ext().getID(object);
					page.addRecordObj(id+"", object);
		        }
			}
		}catch(Db4oIOException dbreadonlyex){
			log.error("Error occur when IDb4oDAO#pagingQuery(QueryTemplate, int, int)!", dbreadonlyex);
		}catch (DatabaseClosedException dbcloseex){
			log.error("Error occur when IDb4oDAO#pagingQuery(QueryTemplate, int, int)!", dbcloseex);
		}catch (Exception e) {
			log.error("Error occur when IDb4oDAO#pagingQuery(QueryTemplate, int, int)!", e);
		}finally {
			this.closeConnection(oc);
		}
		return page;
	}

	
	
	/** 
	 * @see com.mocha.netfocus.db.IDb4oDAO#save(java.lang.Object)
	 */
	public void save(Object obj) {
		ObjectContainer oc = this.getDbConnection();
		try{
			oc.store(obj);
			oc.commit();
		}catch (DatabaseClosedException dbcloseex){
			log.error("Error occur when save(Object obj)!", dbcloseex);
			oc.rollback();
		}catch(DatabaseReadOnlyException dbreadonlyex){
			log.error("Error occur when save(Object obj)!", dbreadonlyex);
			oc.rollback();
		}catch (Exception e) {
			log.error("Error occur when save(Object obj)!", e);
			oc.rollback();
		}finally {
			this.closeConnection(oc);
		}
	}
	/**
	 * @see com.mocha.netfocus.db.IDb4oDAO#save(Collection objs)
	 */	
	public <T> void save(Collection<T> objs){
		ObjectContainer oc = this.getDbConnection();
		try{
			Iterator<T> iter = objs.iterator();
			while (iter.hasNext()) {
				T obj = iter.next();
				oc.store(obj);
			}
			oc.commit();
		}catch (DatabaseClosedException dbcloseex){
			log.error("Error occur when save(Collection objs)!", dbcloseex);
			oc.rollback();
		}catch(DatabaseReadOnlyException dbreadonlyex){
			log.error("Error occur when save(Collection objs)!", dbreadonlyex);
			oc.rollback();
		}catch (Exception e) {
			log.error("Error occur when save(Collection objs)!", e);
			oc.rollback();
		}finally {
			this.closeConnection(oc);
		}
	}
	/**
	 * @see IDb4oDAO#update(long, Refreshable)
	 */
	public void update(long objId,IRefreshable refreshStrategy){
		this.update(objId, refreshStrategy,IDb4oTemplate.DEFAULT_ACTIVATIONDEPTH);
	}	
	/**
	 *  @see IDb4oDAO#update(long, Refreshable, int)
	 */
	public void update(long objId,IRefreshable refreshStrategy,int depth){
		ObjectContainer oc = this.getDbConnection();
		try{
			Object objInDb = oc.ext().getByID(objId);
			oc.activate(objInDb, depth);
			if(objInDb != null && objInDb instanceof IRefreshable){
				IRefreshable refreshableObjInDb = (IRefreshable)objInDb;
				refreshableObjInDb.refresh(refreshStrategy);
				oc.store(refreshableObjInDb);
				oc.commit();
			}
		}catch (DatabaseClosedException dbcloseex){
			log.error("Error occur when update(long, Refreshable, int)!", dbcloseex);
			oc.rollback();
		}catch(DatabaseReadOnlyException dbreadonlyex){
			log.error("Error occur when update(long, Refreshable, int)!", dbreadonlyex);
			oc.rollback();
		}catch (Exception e) {
			log.error("Error occur when update(long, Refreshable, int)!", e);
			oc.rollback();
		}finally {
			this.closeConnection(oc);
		}
	}
	
	public void update(long[] objIds,IRefreshable[] refreshStrategys){
		this.update(objIds, refreshStrategys, IDb4oTemplate.DEFAULT_ACTIVATIONDEPTH);
	}
	
	/**
	 * @see IDb4oTemplate#update(long[], IRefreshable[], int)
	 */
	public void update(long[] objIds,IRefreshable[] refreshStrategys,int depth){
		ObjectContainer oc = this.getDbConnection();
		try{
			for (int i = 0; i < objIds.length; i++) {
				Object objInDb = oc.ext().getByID(objIds[i]);
				oc.activate(objInDb, depth);
				if(objInDb != null && objInDb instanceof IRefreshable){
					IRefreshable refreshableObjInDb = (IRefreshable)objInDb;
					refreshableObjInDb.refresh(refreshStrategys[i]);
					oc.store(refreshableObjInDb);
				}
			}
			oc.commit();
		}catch (DatabaseClosedException dbcloseex){
			log.error("Error occur when DefaultDb4oDAOImpl#update(long[], Refreshable[], int)!", dbcloseex);
			oc.rollback();
		}catch(DatabaseReadOnlyException dbreadonlyex){
			log.error("Error occur when DefaultDb4oDAOImpl#update(long[], Refreshable[], int)!", dbreadonlyex);
			oc.rollback();
		}catch (Exception e) {
			log.error("Error occur when DefaultDb4oDAOImpl#update(long[], Refreshable[], int)!", e);
			oc.rollback();
		}finally {
			this.closeConnection(oc);
		}
	}
	
	/**
	 * @see IDb4oDAO#update(long[], Refreshable, int)
	 */
	public void update(long[] objIds,IRefreshable refreshStrategy,int depth){
		ObjectContainer oc = this.getDbConnection();
		try{
			for (int i = 0; i < objIds.length; i++) {
				Object objInDb = oc.ext().getByID(objIds[i]);
				oc.activate(objInDb, depth);
				if(objInDb != null && objInDb instanceof IRefreshable){
					IRefreshable refreshableObjInDb = (IRefreshable)objInDb;
					refreshableObjInDb.refresh(refreshStrategy);
					oc.store(refreshableObjInDb);
					
				}				
			}
			oc.commit();
		}catch (DatabaseClosedException dbcloseex){
			log.error("Error occur when DefaultDb4oDAOImpl#update(long[], Refreshable, int)!", dbcloseex);
			oc.rollback();
		}catch(DatabaseReadOnlyException dbreadonlyex){
			log.error("Error occur when DefaultDb4oDAOImpl#update(long[], Refreshable, int)!", dbreadonlyex);
			oc.rollback();
		}catch (Exception e) {
			log.error("Error occur when DefaultDb4oDAOImpl#update(long[], Refreshable, int)!", e);
			oc.rollback();
		}finally {
			this.closeConnection(oc);
		}
	}	
	
	/**
	 * @see IDb4oDAO#update(long[], Refreshable)
	 */
	public void update(long[] objIds,IRefreshable refreshStrategy){
		this.update(objIds, refreshStrategy,IDb4oTemplate.DEFAULT_ACTIVATIONDEPTH);
	}
	
	/**
	 * @see IDb4oDAO#update(Predicate, Refreshable)
	 */
	public <T> void update(Predicate<T> predicate,IRefreshable refreshStrategy){
		this.update(predicate, refreshStrategy,IDb4oTemplate.DEFAULT_ACTIVATIONDEPTH);
	}		
	/**
	 * @see IDb4oDAO#update(Predicate, Refreshable)
	 */
	public <T> void update(Predicate<T> predicate,IRefreshable refreshStrategy,int depth){
		ObjectContainer oc = this.getDbConnection();
		try{
			List<T> result = oc.query(predicate);
			for (int i = 0; i < result.size(); i++) {
				T objInDb = result.get(i);
				oc.activate(objInDb, depth);
				if(objInDb != null && objInDb instanceof IRefreshable){
					IRefreshable refreshableObjInDb = (IRefreshable)objInDb;
					refreshableObjInDb.refresh(refreshStrategy);
					oc.store(refreshableObjInDb);
				}
			}
			oc.commit();
		}catch (DatabaseClosedException dbcloseex){
			log.error("Error occur when DefaultDb4oDAOImpl#update(long[], Refreshable, int)!", dbcloseex);
			oc.rollback();
		}catch(DatabaseReadOnlyException dbreadonlyex){
			log.error("Error occur when DefaultDb4oDAOImpl#update(long[], Refreshable, int)!", dbreadonlyex);
			oc.rollback();
		}catch (Exception e) {
			log.error("Error occur when DefaultDb4oDAOImpl#update(long[], Refreshable, int)!", e);
			oc.rollback();
		}finally {
			this.closeConnection(oc);
		}
	}	
	
	/**
	 * @see IDb4oDAO#executeSession(ISessionCallback)
	 */
	public Object executeSession(ISessionCallback sessionTemplate){
		Assert.notNull(sessionTemplate,"executeSession ISessionTemplate VO can not given null!");
		ObjectContainer oc = this.getDbConnection();
		Object result = null;
		try{
			result = sessionTemplate.execute(oc);
			oc.commit();
		}catch(Db4oIOException dbreadonlyex){
			log.error("Error occur when IDb4oDAO#executeSession(ISessionTemplate sessionTemplate)!", dbreadonlyex);
			oc.rollback();
		}catch (DatabaseClosedException dbcloseex){
			log.error("Error occur when IDb4oDAO#executeSession(ISessionTemplate sessionTemplate)!", dbcloseex);
			oc.rollback();
		}catch (Exception e) {
			log.error("Error occur when IDb4oDAO#executeSession(ISessionTemplate sessionTemplate)!", e);
			oc.rollback();
		}finally {
			this.closeConnection(oc);
		}
		
		return result;
	}
	
	/**
	 * @see IDb4oDAO#getID(Object)
	 * @param obj
	 * @return
	 */
	public long getID(Object obj){
		ObjectContainer oc = this.getDbConnection();
		long objid = oc.ext().getID(obj);
		this.closeConnection(oc);
		return objid;
	}
	/**
	 * @see IDb4oDAO#activate(Object)
	 */
	public void activate(Object obj){
		ObjectContainer oc = this.getDbConnection();
		oc.ext().activate(obj);
		this.closeConnection(oc);
	}
	
	/**
	 * @see IDb4oDAO#activate(Object, int)
	 */
	public void activate(Object obj,int depth){
		ObjectContainer oc = this.getDbConnection();
		oc.ext().activate(obj,depth);
		this.closeConnection(oc);
	}
	
	/**
	 * 获得数据库连接
	 * @return
	 */
	private ObjectContainer getDbConnection(){
		return this.datasource.getConnection();
	}
	
	/**
	 * 关闭数据库
	 * @param conn
	 */
	public void closeConnection(ObjectContainer conn){
		if(this.datasource.shouldClose(conn)){
			conn.close();
		}
	}

}
