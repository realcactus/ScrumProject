/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Discuz.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author OovEver
 */
public class DBcon {
    private static Connection conn=null;
     public static Connection getConn()
     {
       
         try {
             Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//             conn = DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:54192;databaseName=db_Discuz","sa","123456");
//             conn=java.sql.DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:54192;databaseName=db_Discuz","sa","123456");
             conn = DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:49392;databaseName=db_Discuz","sa","Liyue321");
         } catch (SQLException ex) {
             Logger.getLogger(DBcon.class.getName()).log(Level.SEVERE, null, ex);
         } catch (ClassNotFoundException e) {
             e.printStackTrace();
         }

         return conn;
     }
    
}
