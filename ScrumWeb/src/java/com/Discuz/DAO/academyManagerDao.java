/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Discuz.DAO;

import com.Discuz.Bean.Academy;
import com.Discuz.Bean.School;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author OovEver
 */
public class academyManagerDao {
        private Connection conn;
    private String sql;
    private PreparedStatement pstat;
    private static academyManagerDao instance = null;
    public static academyManagerDao getInstance() {
        if (instance == null) {
            instance = new academyManagerDao();
        }
        return instance;
    }
       /*
     检查学院是否存在
     */

    public int checkName(Academy academy) throws SQLException {
        int judge = 0;
        conn = DBcon.getConn();
        boolean i = false;
        i = false;
        sql = "select * from  db_Discuz.dbo.\"Academy\" where academy=?";
          pstat = conn.prepareStatement(sql);
        pstat.setString(1,academy.getAcademy());
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
    添加学院
    */
       public boolean academyAddDao(Academy academy) {
        conn = DBcon.getConn();
        sql = "insert into db_Discuz.dbo.\"Academy\" (School,academy,Img) values('" +academy.getSchool()+"','"+academy.getAcademy()+"','"+academy.getImg()+"')";
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
       //查询学院信息
     public List<Academy> selectEditAcademyInfo() {
        List<Academy> empList = new ArrayList<Academy>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"Academy\"");
            while (rs.next()) {                
                Academy pu = new Academy();
                 pu.setId(rs.getInt("id"));             
             pu.setSchool(rs.getString("School"));
             pu.setAcademy(rs.getString("academy"));
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
      public List<Academy> selectEditAcademyInfo(String school) {
        List<Academy> empList = new ArrayList<Academy>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"Academy\" where School='"+school+"'");
            while (rs.next()) {                
                Academy pu = new Academy();
                 pu.setId(rs.getInt("id"));             
             pu.setSchool(rs.getString("School"));
             pu.setAcademy(rs.getString("academy"));
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
        删除学院
        */        
    public boolean deleteSchoolDao(int id)
    { 
        try {
          conn=DBcon.getConn();
          String sql="delete from db_Discuz.dbo.\"Academy\" where id=?";
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
    查询特定学院信息，编辑时候使用
    */
     public List<Academy> selectEditAcademyInfo(int id) {
        List<Academy> empList = new ArrayList<Academy>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            sql="select * from  db_Discuz.dbo.\"Academy\" where id='"+id+"'";
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"Academy\" where id='"+id+"'");
            while (rs.next()) {                
                Academy pu = new Academy();
                pu.setId(rs.getInt("id"));             
             pu.setSchool(rs.getString("School"));
             pu.setAcademy(rs.getString("academy"));
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
    
       public List<Academy> selectEditAcademyInfo2(String academy) {
        List<Academy> empList = new ArrayList<Academy>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"Academy\" where Academy='"+academy+"'");
            while (rs.next()) {                
                Academy pu = new Academy();
                pu.setId(rs.getInt("id"));             
             pu.setSchool(rs.getString("School"));
             pu.setAcademy(rs.getString("academy"));
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
     学院的更新操作
     */
         public boolean updateAcademyDao(Academy academy)
     {
         Connection conn = null;
        boolean i = false;
        try {
            
            conn = DBcon.getConn();
            String sql = "update db_Discuz.dbo.\"Academy\"  set academy= '"+academy.getAcademy()+"',Img='"+academy.getImg()+"' where id='"+academy.getId()+"'";
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
}
