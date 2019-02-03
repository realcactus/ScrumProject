/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Discuz.Servlet;

import com.Discuz.Bean.Card;
import com.Discuz.Bean.User;
import com.Discuz.DAO.CardManagerDao;
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
public class addCreditServlet extends HttpServlet {

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
            out.println("<title>Servlet addCreditServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet addCreditServlet at " + request.getContextPath() + "</h1>");
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
        String creditName=request.getParameter("creditName");
        User user=new User();
        Card card=new Card();
        card.setCardName(creditName);
        CardManagerDao dao=new CardManagerDao();
        int judgeI=0;
        try {
            judgeI = dao.checkName(card);
        } catch (SQLException ex) {
            Logger.getLogger(addCreditServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(judgeI==1)
        {
            response.sendRedirect("/Discuz/MyInfo/addCredit.jsp?error=yes");
        }
        else
        {
            int credit=0;
            int credit2=0;
            String usernameString=(String)session.getAttribute("username");
        
            List<Card> list=dao.selectEditRootInfo(creditName);
            for(Card pu:list)
            {
                credit=pu.getCardcredit();
            }           
            user.setUserName(usernameString);
            UserManagerDao dao2=new UserManagerDao();
             List<User> list2=dao2.selectUserInfo(usernameString);
             for(User pu2:list2)
             {
                 credit2=pu2.getCredit();
             }
             credit=credit2+credit;
             user.setCredit(credit);
             dao2.updateCredit(user);
            boolean flagB=dao.deleteCardDao(card);
            if(flagB)
            {
                response.sendRedirect("/Discuz/MyInfo/addCredit.jsp?error=yes2");
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
