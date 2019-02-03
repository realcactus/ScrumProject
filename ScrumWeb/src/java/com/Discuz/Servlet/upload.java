/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Discuz.Servlet;

import com.Discuz.Bean.SubmitFile;
import com.Discuz.DAO.FileManagerDao;
import com.jspsmart.upload.File;
import com.jspsmart.upload.SmartUpload;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author OovEver
 */
public class upload extends HttpServlet {

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
            out.println("<title>Servlet upload</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet upload at " + request.getContextPath() + "</h1>");
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
        HttpSession session=request.getSession();
       String credit="";
       response.setContentType("text/html;charset=gb2312");
  response.setCharacterEncoding("utf-8");
        String path ="/File/";  
        SmartUpload smartUpload = new SmartUpload();  
        
    //上传初始化  
    smartUpload.initialize(this.getServletConfig(),request,response);  
    try {  
      //设定上传限制  
      //限制每个上传文件的最大长度;将最大设定为1024*1024*20  
      smartUpload.setMaxFileSize(1024*1024*10);     
      //限制总上传数据的长度  
      smartUpload.setTotalMaxFileSize(1024*1024*20);  
      //限制允许上传的文件类型、允许doc、txt、bat文件  
     // smartUpload.setAllowedFilesList("doc,txt,bat,rar,zip");  
      //限制禁止上传的文件类型,禁止exe、jsp、和没有扩展名的文件  
      //smartUpload.setDeniedFilesList("exe,jsp,,");  
      //上传文件  
      smartUpload.upload();  
      //将文件保存到指定的目录下  
      credit=smartUpload.getRequest().getParameter("credit");
      smartUpload.save(path);  
      
    } catch (Exception e) {  
      e.printStackTrace();  
    } 
    for (int i = 0; i < smartUpload.getFiles().getCount(); i++) {  
      com.jspsmart.upload.File  myFile =smartUpload.getFiles().getFile(i);  
      //若文件表单中的文件选项没有选择文件则继续  
      if(myFile.isMissing())  
        continue;  
      //显示当前文件的信息  
      response.setContentType("text/html;charset=utf-8");  
      PrintWriter out = response.getWriter();  
      out.println("<table border='1'>");  
      out.println("<tr><td>表单选项</td><td>"+myFile.getFieldName()+"</td></tr>");  
      out.println("<tr><td>文件长度:</td><td>"+myFile.getSize()+"</td></tr>");  
      out.println("<tr><td>文件名</td><td>"+myFile.getFileName()+"</td></tr>");  
      out.println("<tr><td>文件扩展名</td><td>"+myFile.getFileExt()+"</td></tr>");  
      out.println("<tr><td>文件全名</td><td>"+myFile.getFilePathName()+"</td></tr>");  
      out.println("</table><br>");  
      String usernameString=(String)session.getAttribute("username");
      String school=(String)session.getAttribute("school");
      String academy=(String)session.getAttribute("academy");
      String course=(String)session.getAttribute("Course");
      SubmitFile file=new SubmitFile();
      file.setAcademy(academy);
      file.setAddPerson(usernameString);
      file.setCourese(course);
      file.setSchool(school);
      file.setUrl(myFile.getFileName());
      file.setFileName(myFile.getFileName());
      int creditI=Integer.parseInt(credit);
      file.setCredit(creditI);
        FileManagerDao dao=new FileManagerDao();
        boolean flag=dao.FileAddDao(file);
        if(flag){
      response.sendRedirect("/Discuz/User/StudentInfor/submitFile.jsp");
        }
    }  
        
   
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
