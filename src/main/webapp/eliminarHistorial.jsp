<%-- 
    Document   : eliminarHistorial
    Created on : 13 ene. 2023, 10:16:43
    Author     : Dante

    solo elimina los chats finalizados
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.io.*"%>
<%
    Connection con = null;
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    con = DriverManager.getConnection( "jdbc:mysql://localhost:3306/bdatitos?autoReconnect=true&useSSL=false", "root", "s3mb3ll0");
    PreparedStatement ps = null;    
       
    ps = con.prepareStatement("DELETE FROM chat WHERE estatus = 'Finalizado'");
    ps.executeUpdate();
    ps.close();    
    con.close();
    
    out.print("ok");
%>
