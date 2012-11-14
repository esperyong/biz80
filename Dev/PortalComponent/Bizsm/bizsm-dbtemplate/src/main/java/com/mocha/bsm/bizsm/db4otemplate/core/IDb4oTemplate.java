package com.mocha.bsm.bizsm.db4otemplate.core;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import com.db4o.query.Predicate;

/**
 * ObjectDB GRUD Operation
 * 每一个DML方法都是独立的事务
 * 如果要进行自定义事务
 * 需要通过IObjDAO#getSession
 * 获取一个DB来进行事务控制
 * create read update delete
 * @author liuyong
 *
 */
public interface IDb4oTemplate {
	
	/**
	 * defaut activation depth
	 */
	public static final int DEFAULT_ACTIVATIONDEPTH = 10;
	
	/**
	 * defaut db4o query activation depth
	 */
	public static final int DEFAULT_DB4O_ACTIVATIONDEPTH = 5;	
	
	/**
	 * 保存一个对象
	 * @param obj
	 */
	public void save(Object obj);
	
	/**
	 * 在一个事务中保存一组对象
	 * @param objs
	 */
	public <T> void save(Collection<T> objs);
	
	/**
	 * 根据internal objid 更新一个对象,需要该对象实现Refreshable接口
	 * 说明一下更新策略
	 * 更新深度为{@link IDb4oDAO#DEFAULT_ACTIVATIONDEPTH}
	 * @param objId
	 * @param refreshable - 
	 */
	public void update(long objId,IRefreshable refreshStrategy);
	
	/**
	 * 根据internal objid 更新一个对象,需要该对象实现Refreshable接口
	 * 说明一下更新策略
	 * 需要指定更新深度
	 * @param objId
	 * @param refreshable
	 * @param depth - 更新对象深度
	 */
	public void update(long objId,IRefreshable refreshStrategy,int depth);
	
	/**
	 * 在一个事务中
	 * 根据internal objid 数组更新一批对象
	 * 需要该对象实现Refreshable接口说明一下更新策略
	 * 需要指定更新深度
	 * @param objIds - 一组对象的internal obj id
	 * @param refreshStrategy
	 * @param depth
	 */
	public void update(long[] objIds,IRefreshable refreshStrategy,int depth);
	
	/**
	 * 在一个事务中
	 * 根据internal objid 数组更新一批对象
	 * 需要该对象实现Refreshable接口说明一下更新策略
	 * 更新深度为{@link IDb4oDAO#DEFAULT_ACTIVATIONDEPTH}
	 * @param objIds - 一组对象的internal obj id
	 * @param refreshStrategy
	 * @param depth
	 */
	public void update(long[] objIds,IRefreshable refreshStrategy);	
	/**
	 * 在一个事务中
	 * 根据internal objid 数组更新一批对象
	 * 需要该对象实现Refreshable接口说明一下更新策略
	 * 需要指定更新深度
	 * @param objIds - 一组对象的internal obj id
	 * @param refreshStrategy
	 * @param depth
	 */
	public void update(long[] objIds,IRefreshable[] refreshStrategys,int depth);	
	/**
	 * 在一个事务中
	 * 根据internal objid 数组更新一批对象
	 * 需要该对象实现Refreshable接口说明一下更新策略
	 * 更新深度为{@link IDb4oDAO#DEFAULT_ACTIVATIONDEPTH}
	 * @param objIds - 一组对象的internal obj id
	 * @param refreshStrategy
	 * @param depth
	 */
	public void update(long[] objIds,IRefreshable[] refreshStrategys);
	
	/**
	 * 在一个事务中
	 * 根据Predicate查出来的结果更新一批对象
	 * 需要该对象实现Refreshable接口说明一下更新策略
	 * 更新深度为{@link IDb4oDAO#DEFAULT_ACTIVATIONDEPTH}
	 * @param objIds - 一组对象的internal obj id
	 * @param refreshStrategy
	 */
	public <T> void update(Predicate<T> predicate,IRefreshable refreshStrategy);
	
	/**
	 * 在一个事务中
	 * 根据Predicate查出来的结果更新一批对象
	 * 需要该对象实现Refreshable接口说明一下更新策略
	 * @param objIds - 一组对象的internal obj id
	 * @param refreshStrategy
	 * @param depth - 更新深度
	 */	
	public <ExtentType> void update(Predicate<ExtentType> predicate,IRefreshable refreshStrategy,int depth);
	
	/**
	 * 根据db4o中的NQ(NativeQuery)查询方式来删除一组对象
	 * @param obj
	 */
	public <ExtentType> void delete(Predicate<ExtentType> predicate);
	
	/**
	 * 根据db4o中的SODA查询方式来删除一组对象
	 * @param queryTemplate - SODA Query Template
	 */
	public <ExtentType> void delete(IQueryCallback queryTemplate);
	
	/**
	 * 根据对象ID数组删除一组对象
	 * @param ids
	 */
	public void delete(long[] ids);
	
	/**
	 * 删除一个对象
	 * @param obj
	 */
	public void delete(Object obj);
	
	/**
	 * 查询某个类型的所有对象
	 * @param objClass
	 * @return
	 */
	public <T> List<T> queryAll(Class<T> objClass);
	
	/**
	 * 根据提供的类型获取该类型所有的对象
	 * @param Class objClass
	 * @return - Map<String objectinternalid,Object resultObj>
	 */
	public <T> Map<String,T> queryAllWithId(Class<T> objClass);
	
	/**
	 * 根据一个NQ断言来获取一组对象
	 * @param predicate
	 * @return
	 */
	public <T> List<T> query(Predicate<T> predicate);
	
	/**
	 * 根据查询条件NQ断言获取一个带ID的Map
	 * @param predicate
	 * @return - Map<String objectinternalid,Object resultObj>
	 */
	public <T> Map<String,T> queryWithId(Predicate<T> predicate);
	
	/**
	 * 根据db4o中的SODA查询方式来获取一组对象
	 * @param queryTemplate - SODA Query Template
	 * @return
	 */
	public <T> List<T> query(IQueryCallback queryTemplate);
	
	/**
	 * 根据一组DB4OID查出一组对象
	 * 默认深度和DB4O保持一致深度是
	 * DEFAULT_DB4O_ACTIVATIONDEPTH
	 * @param objids
	 * @return
	 */
	public <T> List<T> query(long[] objids);
	
	/**
	 * 根据用户实现的Query进行分页查询
	 * @param queryTemplate - SODA Query Template
	 * @param pageNo 		- 请求的页号码
	 * @param numPerPage 	- 每页多少行
	 * @return - {@link Pagination}
	 */
	public <T> Pagination<T> pagingQuery(IQueryCallback queryTemplate,int pageNo,int numPerPage);
	
	/**
	 * 根据internalId获取一个对象
	 * 默认深度为 @see {@link IDb4oDAO#DEFAULT_ACTIVATIONDEPTH} 
	 * @param ID
	 * @return
	 */
	public Object getByID(long ID);
	
	/**
	 * 根据internalId和制定的load深度来获取一个对象
	 * 如果指定深度为0
	 * 默认只取顶级对象除了基本类型属性一概不会取出
	 * @param ID
	 * @param depth - 对象树深度
	 * @return
	 */
	public Object getByID(long ID,int depth);
	
	/**
	 * 根据客户程序开发的事务定义模板
	 * 执行一个事务,IDb4oDAO负责管理数据库的session获取和释放
	 * @param sessionTemplate
	 * @return result object if need
	 */
	public Object executeSession(ISessionCallback sessionTemplate);
	
	/**
	 * 根据所给的对象找到在数据库中的id
	 * @param obj
	 * @return
	 */
	public long getID(Object obj);
	/**
	 * activate an object with the current activation strategy
	 * The preconfigured "activation depth" db4o uses in the default setting is 5.  
	 * @see {@link Db4oDBServer#configurateFileConfig}
	 * @param obj
	 */
	public void activate(Object obj);
	
	/**
	 * activates all members on a stored object to the specified depth. 
	 * @param obj
	 * @param depth
	 */
	public void activate(Object obj,int depth);
}
