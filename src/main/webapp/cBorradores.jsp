<%-- 
    Document   : cBorradores
    Created on : 11 ene. 2023, 23:20:36
    Author     : Dante
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.io.*"%>
<%
    Connection con = null;
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdatitos?autoReconnect=true&useSSL=false", "root", "s3mb3ll0");

    Statement statement = con.createStatement();  
    String id = request.getParameter("id");                        
    ResultSet rs = statement.executeQuery("SELECT asunto,mensaje,tipo_problematica FROM chat INNER JOIN conversacion ON id_chat = id_chat_fk WHERE id_chat = "+id+"");                        
    rs.next();
    String res = rs.getString("asunto") + "//" + rs.getString("mensaje") + "//" + rs.getString("tipo_problematica"); 
    rs.close();
    con.close();
    out.print(res);                        
%>
