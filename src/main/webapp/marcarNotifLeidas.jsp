<%-- 
    Document   : marcarNotifLeidas
    Created on : 13 ene. 2023, 10:25:41
    Author     : Dante
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.io.*"%>
<%
    Connection con = null;
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    con = DriverManager.getConnection( "jdbc:mysql://localhost:3306/bdatitos?autoReconnect=true&useSSL=false", "root", "s3mb3ll0");
    PreparedStatement ps = null;    
       
    ps = con.prepareStatement("UPDATE notificacion SET estatus = 'leida' WHERE estatus = 'recibida'");
    ps.executeUpdate();
    ps.close();    
    con.close();
    
    out.print("ok");
%>      