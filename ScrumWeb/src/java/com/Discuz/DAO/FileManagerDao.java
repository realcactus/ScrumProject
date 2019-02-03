/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Discuz.DAO;

import com.Discuz.Bean.Card;
import com.Discuz.Bean.Comment;
import com.Discuz.Bean.SubmitFile;
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
public class FileManagerDao {
       private Connection conn;
    private String sql;
    private PreparedStatement pstat;
     private static FileManagerDao instance = null;
      public static FileManagerDao getInstance() {
        if (instance == null) {
            instance = new FileManagerDao();
        }
        return instance;
    }
        /*
    添加文件
    */
       public boolean FileAddDao(SubmitFile file) {
        conn = DBcon.getConn();
        sql = "insert into db_Discuz.dbo.\"File\" (fileName,url,credit,addPerson,School,Academy,Course) values('" +file.getFileName()+ "','" +file.getUrl()+ "','"+file.getCredit()+"','"+file.getAddPerson()+"','"+file.getSchool()+"','"+file.getAcademy()+"','"+file.getCourese()+"')";
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
           public List<SubmitFile> selectEditCourseInfo() {
        List<SubmitFile> empList = new ArrayList<SubmitFile>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"File\"");
            while (rs.next()) {                
                SubmitFile pu = new SubmitFile();
                 pu.setId(rs.getInt("id"));             
             pu.setFileName(rs.getString("fileName"));
             pu.setAddPerson(rs.getString("addPerson"));
             pu.setUrl(rs.getString("url"));
             pu.setCredit(rs.getInt("credit"));
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
            public List<SubmitFile> selectEditCourseInfo(String fileName) {
        List<SubmitFile> empList = new ArrayList<SubmitFile>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"File\" where fileName='"+fileName+"'");
            while (rs.next()) {                
                SubmitFile pu = new SubmitFile();
                 pu.setId(rs.getInt("id"));             
             pu.setFileName(rs.getString("fileName"));
             pu.setAddPerson(rs.getString("addPerson"));
             pu.setUrl(rs.getString("url"));
             pu.setCredit(rs.getInt("credit"));
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
             public List<SubmitFile> selectEditCourseInfo2(String fileName) {
        List<SubmitFile> empList = new ArrayList<SubmitFile>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"File\" where fileName like'"+fileName+"'");
            while (rs.next()) {                
                SubmitFile pu = new SubmitFile();
                 pu.setId(rs.getInt("id"));             
             pu.setFileName(rs.getString("fileName"));
             pu.setAddPerson(rs.getString("addPerson"));
             pu.setUrl(rs.getString("url"));
             pu.setCredit(rs.getInt("credit"));
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
           /*查询特定信息*/
           
            public List<SubmitFile> selectEditCourseInfo(String School,String Academy,String Course) {
        List<SubmitFile> empList = new ArrayList<SubmitFile>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"File\" where School='"+School+"'and Academy='"+Academy+"'and Course='"+Course+"'");
            while (rs.next()) {                
                SubmitFile pu = new SubmitFile();
                 pu.setId(rs.getInt("id"));             
             pu.setFileName(rs.getString("fileName"));
             pu.setAddPerson(rs.getString("addPerson"));
             pu.setUrl(rs.getString("url"));
             pu.setCredit(rs.getInt("credit"));
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
        删除文件
        */
        
    public boolean deleteCommentDao(int id)
    { 
        try {
          conn=DBcon.getConn();
          String sql="delete from db_Discuz.dbo.\"File\" where id=?";
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
    public int selectFileNum()
    {
         List<SubmitFile> empList = new ArrayList<SubmitFile>();
         conn = DBcon.getConn();
         int i=0;
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"File\"");
            while (rs.next()) {                
                SubmitFile pu = new SubmitFile();
                 pu.setId(rs.getInt("id"));             
             pu.setFileName(rs.getString("fileName"));
             pu.setAddPerson(rs.getString("addPerson"));
             pu.setUrl(rs.getString("url"));
             pu.setCredit(rs.getInt("credit"));
               pu.setSchool(rs.getString("School"));
             pu.setAcademy(rs.getString("Academy"));
             pu.setCourese(rs.getString("Course"));
                empList.add(pu);
                i++;
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

        return i;
        
    }
    
}
