package com.mocha.bsm.bizsm.core.util;

import java.util.Date;
import java.util.Random;

public abstract class UidGenerator {
	private static Random random = new Random();
	private static java.text.SimpleDateFormat formater = new java.text.SimpleDateFormat("yyMMddhhmmss");
	public static String generateUid(){
		return ("s" + random.nextLong()) + "" + formater.format(new Date())+""+System.currentTimeMillis();
	}
}
