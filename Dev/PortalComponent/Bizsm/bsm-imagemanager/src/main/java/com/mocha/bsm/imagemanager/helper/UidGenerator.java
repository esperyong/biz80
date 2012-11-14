package com.mocha.bsm.imagemanager.helper;

import java.util.Date;
import java.util.Random;

public abstract class UidGenerator {
	private static Random random = new Random();
	public static String generateUid(){
		return (random.nextLong())+""+new java.text.SimpleDateFormat("yyMMddhhmmss").format(new Date())+""+System.currentTimeMillis();
	}
}
