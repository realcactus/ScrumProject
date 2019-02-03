/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Discuz.DAO;

import com.Discuz.Bean.Comment;
import com.Discuz.Bean.User;
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
public class bigMasterMgDao {
    private Connection conn;
    private String sql;
    private PreparedStatement pstat;
    private static bigMasterMgDao instance = null;
     public static bigMasterMgDao getInstance() {
        if (instance == null) {
            instance = new bigMasterMgDao();
        }
        return instance;
    }
      public List<bigMaster> selectMasterInfo() {
        List<bigMaster> empList = new ArrayList<bigMaster>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"bigMaster\"");
            while (rs.next()) {                
                bigMaster pu = new bigMaster();
                 pu.setId(rs.getInt("id"));             
                 pu.setSchool(rs.getString("School"));
               pu.setUserName(rs.getString("userName"));
              
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
       public List<bigMaster> selectMasterInfo(String school) {
        List<bigMaster> empList = new ArrayList<bigMaster>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"bigMaster\" where School='"+school+"'");
            while (rs.next()) {                
                bigMaster pu = new bigMaster();
                 pu.setId(rs.getInt("id"));             
                 pu.setSchool(rs.getString("School"));
               pu.setUserName(rs.getString("userName"));
              
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
   public boolean addMasterDao(bigMaster user) {
        conn = DBcon.getConn();
        sql = "insert into db_Discuz.dbo.\"bigMaster\" (userName,School) values('" + user.getUserName() + "','" + user.getSchool()+ "')";
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
    public boolean deleteMasterDao(int id)
    { 
        try {
          conn=DBcon.getConn();
          String sql="delete from db_Discuz.dbo.\"bigMaster\" where id=?";
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
       public List<bigMaster> selectMasterInfo2(String username) {
        List<bigMaster> empList = new ArrayList<bigMaster>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"bigMaster\" where userName='"+username+"'");
            while (rs.next()) {                
                bigMaster pu = new bigMaster();
                 pu.setId(rs.getInt("id"));             
                 pu.setSchool(rs.getString("School"));
               pu.setUserName(rs.getString("userName"));
             
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
}
