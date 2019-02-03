/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Discuz.DAO;

import com.Discuz.Bean.bigMaster;
import com.Discuz.Bean.smallMaster;
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
public class smallMasterMgDao {
     private Connection conn;
    private String sql;
    private PreparedStatement pstat;
      private static smallMasterMgDao instance = null;
        public static smallMasterMgDao getInstance() {
        if (instance == null) {
            instance = new smallMasterMgDao();
        }
        return instance;
    }
        public List<smallMaster> selectMasterInfo() {
        List<smallMaster> empList = new ArrayList<smallMaster>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"smallMaster\"");
            while (rs.next()) {                
                smallMaster pu = new smallMaster();
                 pu.setId(rs.getInt("id"));             
                 pu.setSchool(rs.getString("School"));
                 pu.setUserName(rs.getString("userName"));
                 pu.setAcademy(rs.getString("Academy"));
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
         public boolean addMasterDao(smallMaster user) {
        conn = DBcon.getConn();
        sql = "insert into db_Discuz.dbo.\"smallMaster\" (userName,School,Academy) values('" + user.getUserName() + "','" + user.getSchool()+ "','"+user.getAcademy()+"')";
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
          public List<smallMaster> selectMasterInfo(String school,String academy) {
        List<smallMaster> empList = new ArrayList<smallMaster>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"smallMaster\" where School='"+school+"'and Academy='"+academy+"'");
            while (rs.next()) {                
                smallMaster pu = new smallMaster();
                 pu.setId(rs.getInt("id"));             
                 pu.setSchool(rs.getString("School"));
               pu.setUserName(rs.getString("userName"));
              pu.setAcademy(rs.getString("Academy"));
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
            public List<smallMaster> selectMasterInfo2(String school) {
        List<smallMaster> empList = new ArrayList<smallMaster>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"smallMaster\" where School='"+school+"'");
            while (rs.next()) {                
                smallMaster pu = new smallMaster();
                 pu.setId(rs.getInt("id"));             
                 pu.setSchool(rs.getString("School"));
               pu.setUserName(rs.getString("userName"));
              pu.setAcademy(rs.getString("Academy"));
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
               public List<smallMaster> selectMasterInfo(String username) {
        List<smallMaster> empList = new ArrayList<smallMaster>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"smallMaster\" where userName='"+username+"'");
            while (rs.next()) {                
                smallMaster pu = new smallMaster();
                 pu.setId(rs.getInt("id"));             
                 pu.setSchool(rs.getString("School"));
               pu.setUserName(rs.getString("userName"));
              pu.setAcademy(rs.getString("Academy"));
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
            public boolean deleteMasterDao(int id)
    { 
        try {
          conn=DBcon.getConn();
          String sql="delete from db_Discuz.dbo.\"smallMaster\" where id=?";
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
     public int selectMasterInfo3(String school) {
        List<smallMaster> empList = new ArrayList<smallMaster>();
         conn = DBcon.getConn();
         int i=0;
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"smallMaster\" where School='"+school+"'");
            while (rs.next()) {                
                smallMaster pu = new smallMaster();
                 pu.setId(rs.getInt("id"));             
                 pu.setSchool(rs.getString("School"));
               pu.setUserName(rs.getString("userName"));
              pu.setAcademy(rs.getString("Academy"));
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
