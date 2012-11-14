package com.mocha.bsm.bizsm.core.model;

import java.net.Inet4Address;
import java.net.InetAddress;
import org.apache.commons.logging.LogFactory;

import com.mocha.bsm.bizsm.core.util.NetAddressUtil;
import com.thoughtworks.xstream.annotations.XStreamAlias;


@XStreamAlias("IPv4")
public class IPv4  implements Comparable<IPv4>{
	
	@XStreamAlias("ipStr")
	private String ipStr;
	
	private IPv4(){
	}
	
	public static IPv4 getByName(String ipStr){
		IPv4 ip = new IPv4();
		try {
			InetAddress ipobj = Inet4Address.getByName(ipStr);
			ip.ipStr = ipobj.getHostAddress();			
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return ip;
	}
	
	public static IPv4 getByInt(int ipint){
		IPv4 ip = new IPv4();
		try {
			InetAddress ipobj = NetAddressUtil.toInetAddress(ipint);
			ip.ipStr = ipobj.getHostAddress();	
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return ip;
	}
	
	public static IPv4 getByAddress(byte[] ipbyte){
		IPv4 ip = new IPv4();
		try {
			InetAddress ipobj = Inet4Address.getByAddress(ipbyte);
			ip.ipStr = ipobj.getHostAddress();			
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return ip;
	}
	
	/**
	 * 24 等于255.255.255.0
	 * @param length - 根据前缀长度获得一个IP,通常用来获得掩码
	 * @return
	 */
	public static IPv4 getByNetworkPrefixLength(int length){
		return IPv4.getByInt((0xffffffff << (32-length)));
	}
	
	public String getIpStr() {
		return ipStr;
	}

	public void setIpStr(String ipStr) {
		this.ipStr = ipStr;
	}
	
	private InetAddress getIPObj(){
		InetAddress ipobj = null;
		try {
			ipobj = Inet4Address.getByName(this.ipStr);
		} catch (Exception e) {
			LogFactory.getLog(this.getClass()).error(e);
		}
		return ipobj;
	}
	
	public InetAddress getIp() {
		return this.getIPObj();
	}
	
	public int getInt(){
		return this.hashCode();
	}
	
	public int hashCode(){
		return this.getIPObj().hashCode();
	}
	
	public boolean equals(Object anObject){
    	if (this == anObject) {
    	    return true;
    	}
    	if (anObject instanceof IPv4) {
    		IPv4 anotherIP = (IPv4)anObject;
    	    return this.ipStr.equals(anotherIP.ipStr);
    	}
    	return false;
	}
	
	public int compareTo(IPv4 other){
		if(this.getInt() > other.getInt()){
			return 1;
		}else if(this.getInt() < other.getInt()){
			return -1;
		}else{
			return 0;
		}
	}
	
}
