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
public class Comment {
    private int id;
    private String comment;
    private String addPerson;
     private String School;
    private String Academy;
    private String Courese;
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
     * @return the comment
     */
    public String getComment() {
        return comment;
    }

    /**
     * @param comment the comment to set
     */
    public void setComment(String comment) {
        this.comment = comment;
    }

    /**
     * @return the addPerson
     */
    public String getAddPerson() {
        return addPerson;
    }

    /**
     * @param addPerson the addPerson to set
     */
    public void setAddPerson(String addPerson) {
        this.addPerson = addPerson;
    }

    /**
     * @return the School
     */
    public String getSchool() {
        return School;
    }

    /**
     * @param School the School to set
     */
    public void setSchool(String School) {
        this.School = School;
    }

    /**
     * @return the Academy
     */
    public String getAcademy() {
        return Academy;
    }

    /**
     * @param Academy the Academy to set
     */
    public void setAcademy(String Academy) {
        this.Academy = Academy;
    }

    /**
     * @return the Courese
     */
    public String getCourese() {
        return Courese;
    }

    /**
     * @param Courese the Courese to set
     */
    public void setCourese(String Courese) {
        this.Courese = Courese;
    }
    
}
