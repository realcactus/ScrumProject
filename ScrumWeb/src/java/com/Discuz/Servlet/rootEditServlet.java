/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Discuz.Servlet;

import com.Discuz.Bean.User;
import com.Discuz.DAO.UserManagerDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author OovEver
 */
public class rootEditServlet extends HttpServlet {

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
            out.println("<title>Servlet rootEditServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet rootEditServlet at " + request.getContextPath() + "</h1>");
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
          User user=new User();
            UserManagerDao dao=new UserManagerDao();
              String idString=request.getParameter("id");
              int id=Integer.parseInt(idString);
               PrintWriter out = response.getWriter();
            String studentID=request.getParameter("studentID");
            String studentName=request.getParameter("studentName");
            String txtNewPwd=request.getParameter("txtNewPwd");
            String credit=request.getParameter("credit");
            String select=request.getParameter("select");
             int vip=Integer.parseInt(select);
             int creditI=Integer.parseInt(credit);
               user.setUserName(studentID);
            user.setPassWord(txtNewPwd);
            user.setNickName(studentName);
            user.setId(id);
            user.setVip(vip);
            user.setCredit(creditI);
             boolean flag=dao.updateRootDao(user);
            if(flag)
            {
                response.sendRedirect("/Discuz/MyInfo/rootEdit.jsp?id='"+idString+"'");
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
