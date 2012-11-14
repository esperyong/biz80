package com.mocha.bsm.bizsm.core.util;
import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.UnknownHostException;

public abstract class NetAddressUtil {
	
    public static final int toInt(InetSocketAddress address) {
        InetAddress inetAddr = address.getAddress();
        int result = toInt((Inet4Address) inetAddr);
        return result;
    }

    /**
     * @param address
     * @return
     */
    public static final int toInt(Inet4Address address) {
        return address.hashCode();
    }

    /**
     * 将字符串表示的IPv4地址转换为整型
     * 
     * @param address
     * @return
     */
    public static int toInt(String address) {
        int value = 0;
        int blockValue = 0;
        int dotCount = 0;
        int l = address.length();
        for (int i = 0; i <= l; i++) {
            if (i == l || address.charAt(i) == '.') {
                if (blockValue > 255)
                    throw new IllegalArgumentException("Invalid value [" + blockValue + "]");
                dotCount++;
                value <<= 8;
                value += blockValue;
                blockValue = 0;
                continue;
            }
            blockValue *= 10;
            int v = Character.digit(address.charAt(i), 10);
            if (v == -1)
                throw new IllegalArgumentException("Invalid character [" + address.charAt(i) + "]");
            blockValue += v;
        }

        if (dotCount != 4)
            throw new IllegalArgumentException("Incorrect amount of decimal points [" + (dotCount - 1) + "]");
        else
            return value;
    }

    public static final InetAddress toInetAddress(int raw) throws UnknownHostException {
        byte buf[] = new byte[4];
        buf[0] = (byte) (raw >>> 24);
        buf[1] = (byte) (raw >>> 16);
        buf[2] = (byte) (raw >>> 8);
        buf[3] = (byte) raw;
        return InetAddress.getByAddress(buf);
    }
    
    /**
     * 比较两个IP v4 地址的大小
     * 
     * @param ip1
     * @param ip2
     * @return 0 for equal; -1 for ip1 < ip2; 1 for ip1 > ip2
     */
    public static int compareInet4Address(Inet4Address ip1, Inet4Address ip2) {
        return compareInet4Address(ip1.hashCode(), ip2.hashCode());
    }

    /**
     * 比较整数形式的IP v4 地址
     * 
     * @param ip1
     * @param ip2
     * @return
     */
    public static int compareInet4Address(int ip1, int ip2) {
        int r = 0;
        if (ip1 == ip2) {
            r = 0;
        } else {
            if (0 == ip1) {
                r = -1;
            } else if (0 == ip2) {
                r = 1;
            } else if (ip1 > 0) {
                if (ip2 > 0) { // ip1>0, ip2>0
                    r = (ip1 > ip2) ? 1 : -1;
                } else {// ip1>0, ip2<0
                    r = -1;
                }
            } else {
                if (ip2 < 0) { // ip1<0, ip2<0 则数值较大的IP较靠前
                    r = (ip1 > ip2) ? 1 : -1;
                } else { // ip1<0, ip2>0
                    r = 1;
                }
            }
        }
        return r;
    }

    /**
     * 将有符号整型表示的IP v4 地址转换为无符号的表示
     * 
     * @param address
     * @return
     */
    public static long toUInt(int address) {
        long ret = address;
        if (address < 0) {
            ret = (1L << 32) + address;
        }
        return ret;
    }

    public static int toUShort(short value) {
        int ret = value;
        if (value < 0) {
            ret = (1 << 16) + value;
        }
        return ret;
    }

    public static int toUByte(byte value) {
        int ret = value;
        if (value < 0) {
            ret = (1 << 8) + value;
        }
        return ret;
    }

    /**
     * 将给定的int装换成十六进制字符串，结果字符串的长度由length指定.
     * 
     * 不足，补"0";length短，不截断
     * 
     * @param address
     * @param length
     * @return
     */
    public static String toFixedHexString(int address, int length) {
        StringBuilder sBuilder = new StringBuilder();
        sBuilder.append(Integer.toHexString(address).toUpperCase());
        if (length > 0) {
            int pad = length - sBuilder.length();
            if (pad > 0) {
                for (int i = 0; i < pad; i++) {
                    sBuilder.insert(0, "0");
                }
            }
        }
        return sBuilder.toString();
    }

    // 将十六进制表示的IP v4地址转换为.分隔的ip地址表示
    public static String toAddressString(String hexStringAddress) {
        String tmpStr = hexStringAddress;
        if (hexStringAddress.startsWith("#")) {
            tmpStr = hexStringAddress.substring(1);
        }
        int address = Long.valueOf(tmpStr, 16).intValue();
        StringBuilder sBuilder = new StringBuilder();
        sBuilder.append(((address >>> 24) & 0xFF)).append('.');
        sBuilder.append(((address >>> 16) & 0xFF)).append('.');
        sBuilder.append(((address >>> 8) & 0xFF)).append('.');
        sBuilder.append((address & 0xFF));
        return sBuilder.toString();
    }

    public static byte[] toBytes(String hexStringAddress) {
        if (0 != hexStringAddress.length() % 2) {
            throw new IllegalArgumentException("Invalid hex string: " + hexStringAddress);
        }
        int len = hexStringAddress.length() / 2;
        byte[] result = new byte[len];
        for (int i = 0; i < len; i++) {
            int beginIndex = i * 2;
            int endIndex = beginIndex + 2;
            String str = hexStringAddress.substring(beginIndex, endIndex);
            result[i] = Integer.valueOf(str, 16).byteValue();
        }
        return result;
    }
}
