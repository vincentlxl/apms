package com.mp.apms.common.util;

import org.apache.commons.lang.StringUtils;

import com.mp.apms.common.service.CommonService;

public class CommonUtil
{
    /**
     * 
     * 获取指定填充位数sequence下一个值
     * 
     * @param name
     * @param fixedLen
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static String getNextVal(String name, int fixedLen)
    {
        String nextVal = getNextVal(name);
        String preStr = "";
        
        for (int i = 0; i < fixedLen - nextVal.length(); i++)
        {
            preStr += "0";
        }
        
        return preStr + nextVal;
    }
    
    /**
     * 
     * 获取sequence下一个值
     * 
     * @param name
     * @param fixedLen
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static String getNextVal(String name)
    {
        CommonService commonService = (CommonService)ApplicationContextUtil.getBean("commonService");
        String nextValString = commonService.getNextVal(name);
        
        if (StringUtils.isEmpty(nextValString))
        {
            throw new RuntimeException("getNextVal failed! " + name + " isn't defined!");
        }
        
        return nextValString;
    }
}
