/**
 * 
 */
package com.mocha.bsm.bizsm.core.model;
import com.thoughtworks.xstream.annotations.XStreamAlias;

/**
 * 可变长子网掩码
 * Variable Length Subnet Mask
 * @author liuyong
 */

@XStreamAlias("VLSM")
public class VLSM implements Comparable<VLSM>{
	
	@XStreamAlias("IpAddress")
	private IPv4 ip;
	
	@XStreamAlias("PrefixLength")
	private int prefixLength;
	
	
	private VLSM(IPv4 ip,int prefixLength){
		this.ip = ip;
		this.prefixLength = prefixLength;
	}
	
	public static VLSM getVLSM(IPv4 ip,int prefixLength){
		return new VLSM(ip,prefixLength);
	}
	
	public static VLSM getVLSM(IPv4 ip,String maskStr){
		IPv4 maskip = IPv4.getByName(maskStr);
		int prefixLength = Integer.bitCount(maskip.getInt());
		return new VLSM(ip,prefixLength);
	}
	
	public IPv4 getIp() {
		return ip;
	}
	
	public void setIp(IPv4 ip) {
		this.ip = ip;
	}
	
	public String getMaskStr() {
		return IPv4.getByNetworkPrefixLength(this.prefixLength).getIpStr();
	}

	public int getPrefixLength() {
		return prefixLength;
	}

	public void setPrefixLength(int prefixLength) {
		this.prefixLength = prefixLength;
	}
	
	/**
	 * 判断某一个IP是否属于这个VLSM
	 * @param testIp
	 * @return
	 */
	public boolean contains(IPv4 testIp){
		
		int testIpInt = testIp.getInt();
		
		int baseIpInt = this.ip.getInt();
		
		int maskInt = IPv4.getByNetworkPrefixLength(this.prefixLength).getInt();
		
		return (testIpInt & maskInt) == baseIpInt;
	}
	
	public int hashCode(){
		return this.ip.hashCode() * this.prefixLength;
	}
	
	public boolean equals(Object anObject){
    	if (this == anObject) {
    	    return true;
    	}
    	if (anObject instanceof VLSM) {
    		VLSM anotherVLSM = (VLSM)anObject;
    	    return 
	    	    this.ip.equals(anotherVLSM.ip) 
	    	    && 
	    	    (this.prefixLength == anotherVLSM.prefixLength);
    	}
    	return false;
	}	
	
	public int compareTo(VLSM other){
		int ipInt = this.getIp().getInt();
		int prefixLength = this.prefixLength;
		long value = 1L * ipInt * prefixLength;
		
		int otherIpInt = other.getIp().getInt();
		int otherPrefixLength = other.getPrefixLength();
		long otherValue = otherIpInt * otherPrefixLength;
		
		if(value > otherValue){
			return 1;
		}else if(value < otherValue){
			return -1;
		}else{
			return 0;
		}
	}
	
}
