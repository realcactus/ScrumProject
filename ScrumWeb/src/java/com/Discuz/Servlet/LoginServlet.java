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
import java.sql.SQLException;
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
public class LoginServlet extends HttpServlet {

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
            out.println("<title>Servlet LoginServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
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
        try {
            HttpSession session = request.getSession();
            User user=new User();
            UserManagerDao dao=new UserManagerDao();
            String studentID=request.getParameter("studentID");
            String txtNewPwd=request.getParameter("txtNewPwd");
            user.setUserName(studentID);
            user.setPassWord(txtNewPwd);          
            int judge=dao.logoin(user);
            int vip=0;
        if(judge==1)
        {
              session.setAttribute("username", studentID);
          List<User> list=dao.selectPersonInfo(studentID);
          for(User pu :list)
          {
              vip=pu.getVip();
          }
          
                if(vip==5)
                {
                    response.sendRedirect("/Discuz/User/StudentInfor/index.jsp");
                }
                if(vip==4)
                {
                    response.sendRedirect("/Discuz/User/StudentInfor/smallMaster.jsp");
                }
                else if(vip==3){
        	 response.sendRedirect("/Discuz/User/StudentInfor/bigMaster.jsp");
                }
                else if(vip==1)
                {
                     response.sendRedirect("/Discuz/MyInfo/rootEdit.jsp");
                }
                else if(vip==2)
                {
                    response.sendRedirect("/Discuz/MyInfo/DcManagerEdit.jsp");
                }
        
        }
          else if(judge==2)
        {
        	response.sendRedirect("/Discuz/User/Account/Login.jsp?error=yes");
        	//response.sendRedirect("/Blog/register.html");
        }
        else if(judge==0)
        {
        	response.sendRedirect("/Discuz/User/Account/Login.jsp?error=yes2");
        }
        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
