package com.mp.apms.common.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Encryption
{
    
    /**
     * 加密方法MD5
     * 
     * @param plainText 加密字符串
     */
    public static String md5(String plainText)
        throws Exception
    {
        String str = "";
        try
        {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(plainText.getBytes());
            byte b[] = md.digest();
            
            int i;
            
            StringBuffer buf = new StringBuffer("");
            for (int offset = 0; offset < b.length; offset++)
            {
                i = b[offset];
                if (i < 0)
                    i += 256;
                if (i < 16)
                    buf.append("0");
                buf.append(Integer.toHexString(i));
            }
            str = buf.toString();
            System.out.println("32位的加密result: " + buf.toString());// 32位的加密
        }
        catch (NoSuchAlgorithmException e)
        {
            e.printStackTrace();
            throw e;
        }
        return str;
    }
}
