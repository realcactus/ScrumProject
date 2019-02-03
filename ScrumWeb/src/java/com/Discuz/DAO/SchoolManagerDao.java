/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Discuz.DAO;

import com.Discuz.Bean.Card;
import com.Discuz.Bean.School;
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
public class SchoolManagerDao {
     private Connection conn;
    private String sql;
    private PreparedStatement pstat;
    private static SchoolManagerDao instance = null;
      public static SchoolManagerDao getInstance() {
        if (instance == null) {
            instance = new SchoolManagerDao();
        }
        return instance;
    }
       /*
     检查学校是否存在
     */

    public int checkName(School school) throws SQLException {
        int judge = 0;
        conn = DBcon.getConn();
        boolean i = false;
        i = false;
        sql = "select * from  db_Discuz.dbo.\"School\" where School=?";
        pstat = conn.prepareStatement(sql);
        pstat = conn.prepareStatement(sql);
        pstat.setString(1,school.getSchool());
        ResultSet rs1 = pstat.executeQuery();
        rs1 = (ResultSet) pstat.executeQuery();
        if (rs1.next()) {
            return 0;//学校已存在
        }
        rs1.close();
        pstat.close();
        return 1;
    }
       /*
    添加卡片
    */
       public boolean schoolAddDao(School school) {
        conn = DBcon.getConn();
        sql = "insert into db_Discuz.dbo.\"School\" (School,Img) values('" +school.getSchool()+ "','"+school.getImg()+"')";
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
     public List<School> selectEditSchoolInfo() {
        List<School> empList = new ArrayList<School>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"School\"");
            while (rs.next()) {                
                School pu = new School();
                 pu.setId(rs.getInt("id"));             
             pu.setSchool(rs.getString("School"));
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
        删除卡片
        */
        
    public boolean deleteSchoolDao(int id)
    { 
        try {
          conn=DBcon.getConn();
          String sql="delete from db_Discuz.dbo.\"School\" where id=?";
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
    查询特定学校信息，编辑时候使用
    */
     public List<School> selectEditSchoolInfo(int id) {
        List<School> empList = new ArrayList<School>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            sql="select * from  db_Discuz.dbo.\"School\" where id='"+id+"'";
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"School\" where id='"+id+"'");
            while (rs.next()) {                
                School pu = new School();
                 pu.setId(rs.getInt("id"));             
             pu.setSchool(rs.getString("School"));
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
      public List<School> selectEditSchoolInfo(String schoolName) {
        List<School> empList = new ArrayList<School>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();        
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"School\" where School='"+schoolName+"'");
            while (rs.next()) {                
                School pu = new School();
                 pu.setId(rs.getInt("id"));             
             pu.setSchool(rs.getString("School"));
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
     学校的更新操作
     */
         public boolean updateSchoolDao(School school)
     {
         Connection conn = null;
        boolean i = false;
        try {
            
            conn = DBcon.getConn();
            String sql = "update db_Discuz.dbo.\"School\"  set School= '"+school.getSchool()+"',Img='"+school.getImg()+"' where id='"+school.getId()+"'";
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
         查询学校个数
         */
         public int selecSchoolNum() throws SQLException
         {     conn = DBcon.getConn();
             Statement stmt;
          stmt = conn.createStatement();
              int schoolNum = 0;
     
        boolean i = false;
        i = false;
        sql = "select * from  db_Discuz.dbo.\"School\"";
         ResultSet rs = stmt.executeQuery(sql);        
        while (rs.next()) {
          schoolNum++;//学校个数
        }
        rs.close();
        stmt.close();
        return schoolNum;
         }
}
