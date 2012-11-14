package com.mocha.bsm.bizsm.db4otemplate.core;

import java.util.LinkedHashMap;
import java.util.Map;

import com.mocha.bsm.bizsm.db4otemplate.util.Assert;

/**
 * 用来做模板页面的模板对象
 * 用来做分页查询之后的返回值
 * @author liuyong
 */
public class Pagination<T> {

	/**
	 * 查询结果对象集合
	 * Map< java.lang.String(objid),
	 * 		  java.lang.Object
	 *   	>
	 */
	private Map<String,T> resultMap;
	/**
	 * 所有的结果集数量
	 */
	private int allRecordSize;
	/**
	 * 页号码
	 */
	private int pageNo;
	/**
	 * 每页多少记录数
	 */
	private int numPerPage;
	/**
	 * 一共多少页
	 */
	private int pageSize;
	/**
	 * 该页中第一条记录的记录号
	 * 起始为1
	 */
	private int startRecordNo;
	/**
	 * 该页中最后一条记录的记录号
	 */
	private int endRecordNo;
	
	public Pagination(int allRecordSize,int numPerPage,int pageNo){
		this.allRecordSize = allRecordSize;
		this.numPerPage = numPerPage;
		this.pageNo = pageNo;
		this.pageSize = this.getPageSize(allRecordSize, numPerPage);
		int[] result = this.getCurrentBeginEnd(allRecordSize, numPerPage, pageNo);
		this.startRecordNo = result[0];
		this.endRecordNo = result[1];
		this.resultMap = new LinkedHashMap<String,T>();
	}
	/**
	 * 加入一个结果对象
	 * @param objId
	 * @param obj
	 */
	public void addRecordObj(String objId,T obj){
		this.resultMap.put(objId, obj);
	}
	
	public int getAllRecordSize() {
		return allRecordSize;
	}
	
	public int getPageNo() {
		return pageNo;
	}

	public int getNumPerPage() {
		return numPerPage;
	}

	public int getPageSize() {
		return pageSize;
	}
	
	public Map<String,T> getResultMap() {
		return resultMap;
	}
	
	public int getStartRecordNo() {
		return startRecordNo;
	}
	
	public int getEndRecordNo() {
		return endRecordNo;
	}
	
	/**
	 * 根据总数,每页的记录数
	 * 计算出来共需要多少页
	 * @param allRecordSize
	 * @param numPerPage
	 * @return
	 */
	protected int getPageSize(int allRecordSize,int numPerPage){
		Integer iallRecordSize = Integer.valueOf(allRecordSize);
		Integer inumPerPage = Integer.valueOf(numPerPage);
		double pageSize = iallRecordSize.doubleValue()/inumPerPage.doubleValue();
		int pagesizeInt = (int)Math.ceil(pageSize);
		return pagesizeInt;
	}	
	
	/**
	 * 根据总数,每页的记录数,请求页号码
	 * 计算出来起始的记录号和终止的记录号码
	 * 以1为开始
	 * @param allRecordSize - 查询结果总数
	 * @param numPerPage	- 每页的记录数
	 * @param pageNo		- 请求页号码
	 * @return
	 */
	protected int[] getCurrentBeginEnd(int allRecordSize,int numPerPage,int pageNo){
		int[] result = new int[2];
		int begin = 0;
		int end = 0;
		int pageSize = this.getPageSize(allRecordSize, numPerPage);
		//pageNo必须是非负并且不能大于总页数
	    Assert.isTrue((pageNo <= pageSize && pageNo > 0),"pageNo is <"+pageNo+">pageSize is <"+pageSize+">PageNo must less than or equal pageSize and greater than zero!");
		if(allRecordSize<=numPerPage){//小于等于一页
			begin = 1;
			end = allRecordSize;
		}else{//大于一页
			begin = (pageNo-1) * numPerPage + 1;
			if(pageNo == pageSize){//最后一页
				end = allRecordSize;
			}else{//中间页
				end = begin + numPerPage - 1;					
			}		
		}
		result[0] = begin;
		result[1] = end;
		return result;
	}
	
	/**
	 * toString for debug
	 */
	public String toString(){
		StringBuffer sbf = new StringBuffer();
		sbf.append(" /=========== One Pagination Begin ===========/ \n");
		sbf.append(" AllRecordSize : ["+this.allRecordSize+"] \n");
		sbf.append(" NumPerPage    : ["+this.numPerPage+"] \n");
		sbf.append(" PageNo        : ["+this.pageNo+"] \n");
		sbf.append(" PageSize      : ["+this.pageSize+"] \n");
		sbf.append(" StartRecordNo : ["+this.startRecordNo+"] \n");
		sbf.append(" EndRecordNo   : ["+this.endRecordNo+"] \n");
		sbf.append(" ResultMap     : ["+this.getResultMap()+"] \n");
		sbf.append(" /=========== One Pagination End   ===========/ \n");
		return sbf.toString();
	}
}




