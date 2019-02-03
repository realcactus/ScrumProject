/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Discuz.Servlet;

import com.Discuz.Bean.SubmitFile;
import com.Discuz.Bean.User;
import com.Discuz.DAO.FileManagerDao;
import com.Discuz.DAO.UserManagerDao;
import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
public class downloadFileServlet extends HttpServlet {

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
            out.println("<title>Servlet downloadFileServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet downloadFileServlet at " + request.getContextPath() + "</h1>");
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
            String username=(String)session.getAttribute("username");
              String fileName = request.getParameter("name");
           
            if(username==null)
            {
                response.sendRedirect("/Discuz/User/StudentInfor/downloadFile.jsp?error=yes");
            }
            else{
               User user=new User();
            UserManagerDao dao=new UserManagerDao();
            FileManagerDao dao1=new FileManagerDao();
             List<User> list=dao.selectUserInfo(username);
             List<SubmitFile> list1=dao1.selectEditCourseInfo(fileName);
             int credit=0;
             int credit2=0;
             for(User pu:list)
             {
                 credit=pu.getCredit();
             }
           for(SubmitFile pu1:list1)
           {
               credit2=pu1.getCredit();
           }
          if(credit<credit2)
          {
                   response.sendRedirect("/Discuz/User/StudentInfor/downloadFile.jsp?error=yes2");
          }
          else{
              credit=credit-credit2;
              user.setUserName(username);
              user.setCredit(credit);
              dao.updateCredit(user);
            //新建一个smartUpload对象
            SmartUpload smartUpload = new SmartUpload();
            //初始化
            smartUpload.initialize(this.getServletConfig(), request, response);
            //设定contentDisposition为null以禁止浏览器自动打开文件
            //保证单击链接后是下载文件。
            smartUpload.setContentDisposition(null);
                try {
            smartUpload.downloadFile("/File/"+fileName);
           
        } catch (SmartUploadException ex) {
            Logger.getLogger(downloadFileServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
