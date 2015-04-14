package com.mp.apms.authority.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mp.apms.authority.bean.Menu;
import com.mp.apms.authority.bean.Role;
import com.mp.apms.authority.bean.User;
import com.mp.apms.authority.service.AuthorService;
import com.mp.apms.common.dao.CommonBaseDao;

@Service("authorService")
public class AuthorServiceImpl implements AuthorService
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
    public User queryUserInfo(String loginName)
    {
        return this.commonBaseDao.selectOne("authority.queryUserInfo", loginName);
    }
    
    @Override
    public Role queryRoleById(String id)
    {
        return this.commonBaseDao.selectOne("authority.queryRoleById", id);
    }
    
    @Override
    public List<Menu> queryMenusById(String ids)
    {
        return this.commonBaseDao.selectList("authority.queryMenus", ids);
    }

    @Override
    public List<Menu> queryMenus()
    {
        return this.commonBaseDao.selectList("authority.queryMenus");
    }
}
