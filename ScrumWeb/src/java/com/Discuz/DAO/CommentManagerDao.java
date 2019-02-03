/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Discuz.DAO;

import com.Discuz.Bean.Card;
import com.Discuz.Bean.Comment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author OovEver
 */
public class CommentManagerDao {
      private Connection conn;
    private String sql;
    private PreparedStatement pstat;
    private static CommentManagerDao instance = null;
    public static CommentManagerDao getInstance() {
        if (instance == null) {
            instance = new CommentManagerDao();
        }
        return instance;
    }
      /*
    添加评论
    */
       public boolean commentAddDao(Comment comment) {
        conn = DBcon.getConn();
        sql = "insert into db_Discuz.dbo.\"Comment\"(comment,commentPerson,School,Academy,Course) values('" +comment.getComment() + "','" + comment.getAddPerson()+ "','"+comment.getSchool()+"','"+comment.getAcademy()+"','"+comment.getCourese()+"')";
        //sql="insert into dbo.\"a\"(id)values('1')";
        try {
            Statement stmt = conn.createStatement();
            int count = stmt.executeUpdate(sql);

            if (count != 0) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserManagerDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }
         public List<Comment> selectEditCourseInfo() {
        List<Comment> empList = new ArrayList<Comment>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"Comment\"");
            while (rs.next()) {                
                Comment pu = new Comment();
                 pu.setId(rs.getInt("id"));             
             pu.setComment(rs.getString("comment"));
             pu.setAddPerson(rs.getString("commentPerson"));
             pu.setSchool(rs.getString("School"));
             pu.setAcademy(rs.getString("Academy"));
             pu.setCourese(rs.getString("Course"));
                empList.add(pu);
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserManagerDao.class.getName()).log(Level.SEVERE, null, ex);

        } finally {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return empList;
    }
         public List<Comment> selectCommentInfo() {
        List<Comment> empList = new ArrayList<Comment>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select top 5 * from  db_Discuz.dbo.\"Comment\"");
            while (rs.next()) {                
                Comment pu = new Comment();
                 pu.setId(rs.getInt("id"));             
             pu.setComment(rs.getString("comment"));
             pu.setAddPerson(rs.getString("commentPerson"));
             pu.setSchool(rs.getString("School"));
             pu.setAcademy(rs.getString("Academy"));
             pu.setCourese(rs.getString("Course"));
                empList.add(pu);
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserManagerDao.class.getName()).log(Level.SEVERE, null, ex);

        } finally {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return empList;
    }
          public List<Comment> selectCommentInfo(String school,String academy,String course) {
        List<Comment> empList = new ArrayList<Comment>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select  * from  db_Discuz.dbo.\"Comment\" where School='"+school+"' and Academy='"+academy+"' and Course='"+course+"'");
            while (rs.next()) {                
                Comment pu = new Comment();
                 pu.setId(rs.getInt("id"));             
             pu.setComment(rs.getString("comment"));
             pu.setAddPerson(rs.getString("commentPerson"));
             pu.setSchool(rs.getString("School"));
             pu.setAcademy(rs.getString("Academy"));
             pu.setCourese(rs.getString("Course"));
                empList.add(pu);
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserManagerDao.class.getName()).log(Level.SEVERE, null, ex);

        } finally {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return empList;
    }
            public List<Comment> selectCommentInfo2(String school,String academy,String course) {
        List<Comment> empList = new ArrayList<Comment>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select top 5  * from  db_Discuz.dbo.\"Comment\" where School='"+school+"' and Academy='"+academy+"' and Course='"+course+"'");
            while (rs.next()) {                
                Comment pu = new Comment();
                 pu.setId(rs.getInt("id"));             
             pu.setComment(rs.getString("comment"));
             pu.setAddPerson(rs.getString("commentPerson"));
             pu.setSchool(rs.getString("School"));
             pu.setAcademy(rs.getString("Academy"));
             pu.setCourese(rs.getString("Course"));
                empList.add(pu);
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserManagerDao.class.getName()).log(Level.SEVERE, null, ex);

        } finally {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return empList;
    }
     /*
        删除评论
        */
        
    public boolean deleteCommentDao(int id)
    { 
        try {
          conn=DBcon.getConn();
          String sql="delete from db_Discuz.dbo.\"Comment\" where id=?";
           PreparedStatement stmt=conn.prepareStatement(sql);
            stmt.setInt(1, id);
            int i=stmt.executeUpdate();
            if(i==1){
            return true;
            }
        } catch (Exception e) {
            e.printStackTrace();        
        }
    finally{
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }  
        return false;
    }
}
