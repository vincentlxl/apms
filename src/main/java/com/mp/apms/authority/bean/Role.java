package com.mp.apms.authority.bean;

public class Role
{
    private String id;
    
    private String name;
    
    private String desc;
    
    private String menus;

    public String getId()
    {
        return id;
    }

    public void setId(String id)
    {
        this.id = id;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getDesc()
    {
        return desc;
    }

    public void setDesc(String desc)
    {
        this.desc = desc;
    }

    public String getMenus()
    {
        return menus;
    }

    public void setMenus(String menus)
    {
        this.menus = menus;
    }
}
