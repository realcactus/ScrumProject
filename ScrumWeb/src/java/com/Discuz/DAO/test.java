/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Discuz.DAO;

import java.sql.Connection;

/**
 *
 * @author OovEver
 */
public class test {
    public static void main(String[] args) {        
    
    Connection con=DBcon.getConn();
    if(con!=null){
            System.out.println("连接成功");     
    }
    else{
        System.out.println("连接失败");
    }
    }
}
