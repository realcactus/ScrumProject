/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Discuz.Servlet;

import com.Discuz.Bean.Course;
import com.Discuz.DAO.CourseManagerDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author OovEver
 */
@WebServlet(name = "courseFSAddServlet", urlPatterns = {"/courseFSAddServlet"})
public class courseFSAddServlet extends HttpServlet {

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
            out.println("<title>Servlet courseFSAddServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet courseFSAddServlet at " + request.getContextPath() + "</h1>");
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
            HttpSession session=request.getSession();
            String school=(String)session.getAttribute("school");
            String academy=(String)session.getAttribute("academy");
            String courseName=request.getParameter("courseName");
            String url=(String)session.getAttribute("url3");
            Course course=new Course();
            course.setCourese(courseName);
            course.setAcademy(academy);
            course.setSchool(school);
            course.setImg(url);
            CourseManagerDao dao=new CourseManagerDao();            
            int judgeAddr=dao.checkName(course);
           
            
                boolean flag=dao.courseAddDao(course);
            
            if(flag)
            {
                response.sendRedirect("/Discuz/User/Account/courseFSADD.jsp");
            }
            
            
        } catch (SQLException ex) {
            Logger.getLogger(courseAddServlet.class.getName()).log(Level.SEVERE, null, ex);
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
