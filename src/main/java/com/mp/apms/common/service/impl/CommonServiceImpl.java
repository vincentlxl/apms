package com.mp.apms.common.service.impl;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mp.apms.common.dao.CommonBaseDao;
import com.mp.apms.common.service.CommonService;

@Service("commonService")
public class CommonServiceImpl implements CommonService
{
    private CommonBaseDao commonBaseDao;
    
    public CommonBaseDao getCommonBaseDao()
    {
        return commonBaseDao;
    }
    
    @Autowired
    public void setCommonBaseDao(CommonBaseDao commonBaseDao)
    {
        this.commonBaseDao = commonBaseDao;
    }
    
    @Override
    public String getNextVal(String name)
    {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("name", name);
        commonBaseDao.selectOne("common.queryNextVal", map);
        BigInteger bigInteger = (BigInteger)map.get("nextval");
        return bigInteger.toString();
    }
}
