/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Discuz.Servlet;

import com.jspsmart.upload.File;
import com.jspsmart.upload.Files;
import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author OovEver
 */
public class updateCoursePicture extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet updateCoursePicture</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet updateCoursePicture at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        this.doPost(request, response);
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
           SmartUpload upload = new SmartUpload();
              //初始化上传组件
              upload.initialize(this.getServletConfig(), request, response);
        try {      
            //开始上传
            upload.upload();
        } catch (SmartUploadException ex) {
            Logger.getLogger(upSchoolPicture.class.getName()).log(Level.SEVERE, null, ex);
        }
           //获取上传的文件列表对象
              Files f = upload.getFiles();
              //获取文件对象
              File fil = f.getFile(0);
             
                String urlString= fil.getFileName();            
        HttpSession session = request.getSession();
        session.setAttribute("url3", urlString);
              //去的文件后缀
            //  String ext = fil.getFileExt();
              //判断文件类型是否是jpg格式
          try {
            //满足条件进行文件的上传 需要注意的是upload使我们webRoot文件夹下的一个目录
            upload.save("/coursePicture");
            fil.saveAs("/coursePicture/" + fil.getFileName());
              fil.saveAs("/coursePicture/" + fil.getFileName());
        } catch (SmartUploadException ex) {
            Logger.getLogger(addUserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
          String id=(String)session.getAttribute("id");
          response.sendRedirect("/Discuz/User/Account/courseEditDetail.jsp?id="+id+"");
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
