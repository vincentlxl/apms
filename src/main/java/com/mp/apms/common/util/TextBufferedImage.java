package com.mp.apms.common.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

/**
 * 产生随机码
 * 
 */
public class TextBufferedImage extends HttpServlet
{
    /**
     * 处理POST请求
     */
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        doGet(request, response);
    }

    /**
     * 处理GET请求
     */
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException
    {
        // 产生随机密码
        String randomPassword = (String) req.getSession().getAttribute("randomCode");

        // 如果会话中的随机码不存在，返回
        if (randomPassword == null)
        {
            return;
        }

        OutputStream out = resp.getOutputStream();

        try
        {
            JPEGImageEncoder encode = JPEGCodec.createJPEGEncoder(out);
            BufferedImage bi = CreateBufferedImage(randomPassword);
            encode.encode(bi);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    /**
     * 把随机码写到图片上返回
     * 
     * @param randomPassword 随机码
     * @return
     */
    private BufferedImage CreateBufferedImage(String randomPassword)throws Exception
    {
        int width = 62;
        int height = 18;

        BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

        Graphics2D g2d = bufferedImage.createGraphics();
        g2d.clearRect(0, 0, width, height);
        g2d.setColor(Color.white);
        g2d.fillRect(0, 0, width, 20);
        g2d.setColor(Color.BLUE);
        g2d.setFont(new Font("", 1, 15));
        g2d.drawString(randomPassword, 2, 15);
        g2d.dispose();
        return bufferedImage;
    }
}