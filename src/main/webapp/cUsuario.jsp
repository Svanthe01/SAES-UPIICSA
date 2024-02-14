<%-- 
    Document   : cUsuario
    Created on : 16 ene. 2023, 11:29:01
    Author     : Dante
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.io.*"%>
<%
    Connection con = null;
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    con = DriverManager.getConnection( "jdbc:mysql://localhost:3306/bdatitos?autoReconnect=true&useSSL=false", "root", "s3mb3ll0");    
    
    String boleta = "2021602506";
    String pass = "n0m3l0";
    String res = "";
    Statement statement = con.createStatement();                                        
    ResultSet rs = statement.executeQuery("SELECT * FROM alumno WHERE boleta = '"+boleta+"' AND password = '"+pass+"'");
    if(rs.next()){
        res = "ok";
    }else{
        res = "nop";
    }
    out.print(res);
%>
