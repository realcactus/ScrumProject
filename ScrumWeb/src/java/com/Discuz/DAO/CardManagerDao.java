/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Discuz.DAO;

import com.Discuz.Bean.Card;
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
public class CardManagerDao {
     private Connection conn;
    private String sql;
    private PreparedStatement pstat;
    private static CardManagerDao instance = null;
      public static CardManagerDao getInstance() {
        if (instance == null) {
            instance = new CardManagerDao();
        }
        return instance;
    }
        /*
     检查卡号是否存在
     */

    public int checkName(Card card) throws SQLException {
        int judge = 0;
        conn = DBcon.getConn();
        boolean i = false;
        i = false;
        sql = "select * from  db_Discuz.dbo.\"card\" where cardname=?";
        pstat = conn.prepareStatement(sql);
        pstat = conn.prepareStatement(sql);
        pstat.setString(1,card.getCardName());
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
    添加卡片
    */
       public boolean cardAddDao(Card card) {
        conn = DBcon.getConn();
        sql = "insert into db_Discuz.dbo.\"card\" (cardname,cardcredit) values('" +card.getCardName() + "','" + card.getCardcredit()+ "')";
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
       public List<Card> selectEditCardInfo() {
        List<Card> empList = new ArrayList<Card>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"card\"");
            while (rs.next()) {                
                Card pu = new Card();
                 pu.setId(rs.getInt("id"));             
             pu.setCardName(rs.getString("cardname"));
             pu.setCardcredit(rs.getInt("cardcredit"));
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
        
    public boolean deleteCardDao(int id)
    { 
        try {
          conn=DBcon.getConn();
          String sql="delete from db_Discuz.dbo.\"card\" where id=?";
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
      public boolean deleteCardDao(Card card)
    { 
        try {
          conn=DBcon.getConn();
          String sql="delete from db_Discuz.dbo.\"card\" where cardname=?";
           PreparedStatement stmt=conn.prepareStatement(sql);
            stmt.setString(1, card.getCardName());
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
    查询特定卡片信息，编辑时候使用
    */
     public List<Card> selectEditRootInfo(int id) {
        List<Card> empList = new ArrayList<Card>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();
            sql="select * from  db_Discuz.dbo.\"card\" where id='"+id+"'";
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"card\" where  id='"+id+"'");
            while (rs.next()) {                
                Card pu = new Card();
                   pu.setId(rs.getInt("id"));             
             pu.setCardName(rs.getString("cardname"));
             pu.setCardcredit(rs.getInt("cardcredit"));
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
       public List<Card> selectEditRootInfo(String cardname) {
        List<Card> empList = new ArrayList<Card>();
         conn = DBcon.getConn();
        Statement stmt;
        try {
            stmt = conn.createStatement();           
            ResultSet rs = stmt.executeQuery("select * from  db_Discuz.dbo.\"card\" where  cardname='"+cardname+"'");
            while (rs.next()) {                
                Card pu = new Card();
                   pu.setId(rs.getInt("id"));             
             pu.setCardName(rs.getString("cardname"));
             pu.setCardcredit(rs.getInt("cardcredit"));
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
     卡片的更新操作
     */
         public boolean updateCardtDao(Card card)
     {
         Connection conn = null;
        boolean i = false;
        try {
            conn = DBcon.getConn();
            String sql = "update db_Discuz.dbo.\"card\"  set cardname= '"+card.getCardName()+"', cardcredit='"+card.getCardcredit()+"' where id='"+card.getId()+"'";
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
