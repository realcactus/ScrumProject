/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Discuz.DAO;

import com.Discuz.Bean.Academy;
import com.Discuz.Bean.Course;
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
public class CourseManagerDao {
       private Connection conn;
    private String sql;
    private PreparedStatement pstat;
    private static CourseManagerDao instance = null;
       public static CourseManagerDao getInstance() {
        if (instance == null) {
            instance = new CourseManagerDao();
        }
        return instance;
    }
        /*
     检查课程是否存在
     */

    public int checkName(Course course) throws SQLException {
        int judge = 0;
        conn = DBcon.getConn();
        boolean i = false;
        i = false;
        sql = "select * from  db_Discuz.dbo.\"Course\" where Course=?";
          pstat = conn.prepareStatement(sql);
        pstat.setString(1,course.getCourese());
        ResultSet rs1 = pstat.executeQuery();
        rs1 = (ResultSet) pstat.executeQuery();
        if (rs1.next()) {
            return 0;//课程已存在
        }
        rs1.close();
        pstat.close();
        return 1;
    }
     /*
    添加课程
    */
       public boolean courseAddDao(Course course) {
        conn = DBcon.getConn();
        sql = "insert into db_Discuz.dbo.\"Course\" (School,Academy,Course,Img) values('" +course.getSchool()+"','"+course.getAcademy()+"','"+course.getCourese()+"','"+course.getImg()+"')";
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
        //查询课程信息
     public List<Course> selectEditCourseInfo() {
        List<Course> empList = new ArrayList<Course>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"Course\"");
            while (rs.next()) {                
                Course pu = new Course();
                 pu.setId(rs.getInt("id"));             
             pu.setSchool(rs.getString("School"));
             pu.setAcademy(rs.getString("Academy"));
             pu.setCourese(rs.getString("Course"));
             pu.setImg(rs.getString("Img"));
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
        删除课程
        */        
    public boolean deleteCourseDao(int id)
    { 
        try {
          conn=DBcon.getConn();
          String sql="delete from db_Discuz.dbo.\"Course\" where id=?";
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
      /*
    查询特定课程信息，编辑时候使用
    */
     public List<Course> selectEditCourseInfo(int id) {
        List<Course> empList = new ArrayList<Course>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            sql="select * from  db_Discuz.dbo.\"Course\" where id='"+id+"'";
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"Course\" where id='"+id+"'");
            while (rs.next()) {                
                Course pu = new Course();
                 pu.setId(rs.getInt("id"));             
             pu.setSchool(rs.getString("School"));
             pu.setAcademy(rs.getString("Academy"));
             pu.setCourese(rs.getString("Course"));     
             pu.setImg(rs.getString("Img"));
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
    查询特定课程信息，编辑时候使用
    */
     public List<Course> selectEditCourseInfo(String school,String academy) {
        List<Course> empList = new ArrayList<Course>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
        
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"Course\" where School='"+school+"' and Academy='"+academy+"'");
            while (rs.next()) {                
                Course pu = new Course();
                 pu.setId(rs.getInt("id"));             
             pu.setSchool(rs.getString("School"));
             pu.setAcademy(rs.getString("Academy"));
             pu.setCourese(rs.getString("Course"));    
             pu.setImg(rs.getString("Img"));
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
     课程的更新操作
     */
         public boolean updateCourseDao(Course course)
     {
         Connection conn = null;
        boolean i = false;
        try {
            
            conn = DBcon.getConn();
            String sql = "update db_Discuz.dbo.\"Course\"  set Course= '"+course.getCourese()+"',Img='"+course.getImg()+"' where id='"+course.getId()+"'";
              Statement stmt = conn.createStatement();
             int count = stmt.executeUpdate(sql);
           
            if (count!=0) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return false;
     }
          /*
         查询学院个数
         */
         public int selecSchoolNum(String school) throws SQLException
         {     conn = DBcon.getConn();
             Statement stmt;
          stmt = conn.createStatement();
              int schoolNum = 0;
     
        boolean i = false;
        i = false;
        sql = "select * from  db_Discuz.dbo.\"Academy\" where School='"+school+"'";
         ResultSet rs = stmt.executeQuery(sql);        
        while (rs.next()) {
          schoolNum++;//学院个数
        }
        rs.close();
        stmt.close();
        return schoolNum;
         }
          /*
         查询课程个数
         */
         public int selecCourseNum(String school,String academy) throws SQLException
         {     conn = DBcon.getConn();
             Statement stmt;
          stmt = conn.createStatement();
              int schoolNum = 0;
     
        boolean i = false;
        i = false;
        sql = "select * from  db_Discuz.dbo.\"Course\" where School='"+school+"' and Academy='"+academy+"'";
         ResultSet rs = stmt.executeQuery(sql);        
        while (rs.next()) {
          schoolNum++;//学院个数
        }
        rs.close();
        stmt.close();
        return schoolNum;
         }
}
