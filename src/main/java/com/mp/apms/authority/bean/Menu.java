package com.mp.apms.authority.bean;

public class Menu implements Comparable<Menu>
{
    private String id;
    
    private String name;
    
    private String url;
    
    private String parentId;
    
    private int order;
    
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
    
    public String getUrl()
    {
        return url;
    }
    
    public void setUrl(String url)
    {
        this.url = url;
    }
    
    public String getParentId()
    {
        return parentId;
    }
    
    public void setParentId(String parentId)
    {
        this.parentId = parentId;
    }
    
    public int getOrder()
    {
        return order;
    }
    
    public void setOrder(int order)
    {
        this.order = order;
    }
    
    @Override
    public int compareTo(Menu menu)
    {
        if (this.order > menu.getOrder())
        {
            return 1;
        }
        else if (this.order < menu.getOrder())
        {
            return -1;
        }
        
        return 0;
    }
}
