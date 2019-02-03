/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Discuz.DAO;

import com.Discuz.Bean.User;
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
public class UserManagerDao {
     private Connection conn;
    private String sql;
    private PreparedStatement pstat;
    private static UserManagerDao instance = null;
     public static UserManagerDao getInstance() {
        if (instance == null) {
            instance = new UserManagerDao();
        }
        return instance;
    }
     /*
     登录函数
     */
       public int logoin(User user) throws SQLException {
        int judge = 0;
        conn = DBcon.getConn();
        boolean i = false;
        sql = "select * from db_Discuz.dbo.\"User\" where userName=? and passWord=?";
        pstat = conn.prepareStatement(sql);
        pstat.setString(1, user.getUserName());
        pstat.setString(2, user.getPassWord());
        ResultSet rs1 = (ResultSet) pstat.executeQuery();
        if (rs1.next()) {
            i = true;
            rs1.close();
            pstat.close();
            return 1;//登录成功
        } else {
            i = false;
            sql = "select * from  db_Discuz.dbo.\"User\" where userName=?";
            pstat = conn.prepareStatement(sql);
            pstat.setString(1, user.getUserName());
            rs1 = (ResultSet) pstat.executeQuery();
            if (rs1.next()) {
                return 2;//密码错误
            }
            rs1.close();
            pstat.close();
        }
        conn.close();
        return 0;
    }
         /*
查询个人信息
*/
    
        public List<User> selectPersonInfo(String userName) {
        List<User> empList = new ArrayList<User>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"User\" where userName='"+userName+"'");
            while (rs.next()) {                
                User pu = new User();
                pu.setId(rs.getInt("id"));             
               pu.setNickName(rs.getString("NickName"));
               pu.setPassWord(rs.getString("passWord"));
               pu.setUserName(rs.getString("userName"));
               pu.setVip(rs.getInt("vip"));
               pu.setCredit(rs.getInt("credits"));
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
     检查用户名是否存在
     */

    public int checkName(User user) throws SQLException {
        int judge = 0;
        conn = DBcon.getConn();
        boolean i = false;
        i = false;
        sql = "select * from  db_Discuz.dbo.\"User\" where userName=?";
        pstat = conn.prepareStatement(sql);
        pstat = conn.prepareStatement(sql);
        pstat.setString(1, user.getUserName());
        ResultSet rs1 = pstat.executeQuery();
        rs1 = (ResultSet) pstat.executeQuery();
        if (rs1.next()) {
            return 0;//用户已存在
        }
        rs1.close();
        pstat.close();
        return 1;
    }
     /*
     注册
     */

    public boolean addUserDao(User user) {
        conn = DBcon.getConn();
        sql = "insert into db_Discuz.dbo.\"User\" (userName,passWord,NickName,vip,credits) values('" + user.getUserName() + "','" + user.getPassWord() + "','" + user.getNickName()+ "','" + user.getVip() + "','"+user.getCredit()+"')";
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
     public boolean rootAddDao(User user) {
        conn = DBcon.getConn();
        sql = "insert into db_Discuz.dbo.\"User\" (userName,passWord,NickName,vip,credits) values('" + user.getUserName() + "','" + user.getPassWord() + "','" + user.getNickName()+ "','" + user.getVip() + "','"+user.getCredit()+"')";
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
      public List<User> selectEditRootInfo() {
        List<User> empList = new ArrayList<User>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"User\" where vip=1 or vip=2");
            while (rs.next()) {                
                User pu = new User();
                 pu.setId(rs.getInt("id"));             
               pu.setNickName(rs.getString("NickName"));
               pu.setPassWord(rs.getString("passWord"));
               pu.setUserName(rs.getString("userName"));
               pu.setVip(rs.getInt("vip"));
               pu.setCredit(rs.getInt("credits"));
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
      public List<User> selectMasterInfo() {
        List<User> empList = new ArrayList<User>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"User\" where vip=3");
            while (rs.next()) {                
                User pu = new User();
                 pu.setId(rs.getInt("id"));             
               pu.setNickName(rs.getString("NickName"));
               pu.setPassWord(rs.getString("passWord"));
               pu.setUserName(rs.getString("userName"));
               pu.setVip(rs.getInt("vip"));
               pu.setCredit(rs.getInt("credits"));
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
          public List<User> selectSmallMasterInfo() {
        List<User> empList = new ArrayList<User>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"User\" where vip=4");
            while (rs.next()) {                
                User pu = new User();
                 pu.setId(rs.getInt("id"));             
               pu.setNickName(rs.getString("NickName"));
               pu.setPassWord(rs.getString("passWord"));
               pu.setUserName(rs.getString("userName"));
               pu.setVip(rs.getInt("vip"));
               pu.setCredit(rs.getInt("credits"));
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
        删除用户
        */
        
    public boolean deleteUserDao(int id)
    { 
        try {
          conn=DBcon.getConn();
          String sql="delete from db_Discuz.dbo.\"User\" where id=?";
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
    查询特定用户信息，编辑时候使用
    */
     public List<User> selectEditRootInfo(int id) {
        List<User> empList = new ArrayList<User>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            sql="select * from  db_Discuz.dbo.\"User\" where vip=1 or vip=2 and id='"+id+"'";
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"User\" where (vip=1 or vip=2) and id='"+id+"'");
            while (rs.next()) {                
                User pu = new User();
                  pu.setId(rs.getInt("id"));             
               pu.setNickName(rs.getString("NickName"));
               pu.setPassWord(rs.getString("passWord"));
               pu.setUserName(rs.getString("userName"));
               pu.setVip(rs.getInt("vip"));
               pu.setCredit(rs.getInt("credits"));
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
      public List<User> selectUserInfo(String userName) {
        List<User> empList = new ArrayList<User>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
          
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"User\" where userName='"+userName+"'");
            while (rs.next()) {                
                User pu = new User();
                  pu.setId(rs.getInt("id"));             
               pu.setNickName(rs.getString("NickName"));
               pu.setPassWord(rs.getString("passWord"));
               pu.setUserName(rs.getString("userName"));
               pu.setVip(rs.getInt("vip"));
               pu.setCredit(rs.getInt("credits"));
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
     管理员的更新操作
     */
         public boolean updateRootDao(User user)
     {
         Connection conn = null;
        boolean i = false;
        try {
            conn = DBcon.getConn();
            String sql = "update db_Discuz.dbo.\"User\"  set userName= '"+user.getUserName()+"', passWord='"+user.getPassWord()+"',NickName='"+user.getNickName()+"',credits='"+user.getCredit()+"',vip='"+user.getVip()+"' where id='"+user.getId()+"'";
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
           public boolean updateCredit(User user)
     {
         Connection conn = null;
        boolean i = false;
        try {
            conn = DBcon.getConn();
            String sql = "update db_Discuz.dbo.\"User\"  set credits='"+user.getCredit()+"' where userName='"+user.getUserName()+"'";
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
            查询一般用户信息
            */
              public List<User> selectEditDcManageInfo() {
        List<User> empList = new ArrayList<User>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"User\" where vip=3 or vip=4 or vip=5");
            while (rs.next()) {                
                User pu = new User();
                pu.setId(rs.getInt("id"));             
               pu.setNickName(rs.getString("NickName"));
               pu.setPassWord(rs.getString("passWord"));
               pu.setUserName(rs.getString("userName"));
               pu.setVip(rs.getInt("vip"));
               pu.setCredit(rs.getInt("credits"));
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
    查询一般用户信息，编辑时候使用
    */
     public List<User> selectEditDcMgInfo(int id) {
        List<User> empList = new ArrayList<User>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            sql="select * from  db_Discuz.dbo.\"User\" where vip=1 or vip=2 and id='"+id+"'";
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"User\" where (vip=3 or vip=4 or vip=5) and id='"+id+"'");
            while (rs.next()) {                
                User pu = new User();
                  pu.setId(rs.getInt("id"));             
               pu.setNickName(rs.getString("NickName"));
               pu.setPassWord(rs.getString("passWord"));
               pu.setUserName(rs.getString("userName"));
               pu.setVip(rs.getInt("vip"));
               pu.setCredit(rs.getInt("credits"));
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
     检查原密码是否正确 修改密码时候使用
     */
    public int checkPassWd(User user) throws SQLException {
        int judge = 0;
        conn = DBcon.getConn();
        boolean i = false;
        i = false;
        sql = "select * from  db_Discuz.dbo.\"User\" where passWord=? and userName=?";
        pstat = conn.prepareStatement(sql);
        pstat = conn.prepareStatement(sql);
        pstat.setString(1, user.getPassWord());
        pstat.setString(2, user.getUserName());
        ResultSet rs1 = pstat.executeQuery();
        rs1 = (ResultSet) pstat.executeQuery();
        if (rs1.next()) {
            return 1;//密码正确
        }
        rs1.close();
        pstat.close();
        return 0;
    }
    /*修改个人密码*/
     public boolean updatePasswdDao(User user)
     {
          Connection conn = null;
        boolean i = false;
        try {
            conn = DBcon.getConn();
            String sql = "update  db_Discuz.dbo.\"User\"  set passWord= '"+user.getPassWord()+"' where userName='"+user.getUserName()+"'";
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

