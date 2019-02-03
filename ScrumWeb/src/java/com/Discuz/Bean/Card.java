/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Discuz.Bean;

/**
 *
 * @author OovEver
 */
public class Card {
    private int id;
    private String cardName;
    private int cardcredit;

    /**
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * @return the cardName
     */
    public String getCardName() {
        return cardName;
    }

    /**
     * @param cardName the cardName to set
     */
    public void setCardName(String cardName) {
        this.cardName = cardName;
    }

    /**
     * @return the cardcredit
     */
    public int getCardcredit() {
        return cardcredit;
    }

    /**
     * @param cardcredit the cardcredit to set
     */
    public void setCardcredit(int cardcredit) {
        this.cardcredit = cardcredit;
    }
    
}
