/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.atossyntel.pojo;

/**
 *
 * @author LS5028230
 */
public class User {
    String userName;
    String pass;
    boolean isAdmin;

    public User() {
        this.userName = "NA";
        this.pass = "NA";
        this.isAdmin = false;
    }

    public void setIsAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }

    public User(String userName, String password, boolean isAdmin) {
        this.userName = userName;
        this.pass = password;
        this.isAdmin = isAdmin;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return pass;
    }

    public void setPassword(String password) {
        this.pass = password;
    }

    @Override
    public String toString() {
        return "User{" + "userName=" + userName + ", password=" + pass + ", isAdmin=" + isAdmin + '}';
    }

    void setIsAdmin(String string) {
        this.isAdmin = (string.trim().equalsIgnoreCase("y"));
    }

    public boolean isAdmin() {
        return isAdmin;
    } 
}
