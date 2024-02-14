<%-- 
    Document   : actualizarBorrador
    Created on : 13 ene. 2023, 17:57:39
    Author     : Dante
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.io.*, java.time.*, java.time.format.DateTimeFormatter"%>
<%
    Connection con = null;
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    con = DriverManager.getConnection( "jdbc:mysql://localhost:3306/bdatitos?autoReconnect=true&useSSL=false", "root", "s3mb3ll0");
    PreparedStatement ps = null; 
    
    String fecha = ZonedDateTime.now(ZoneId.of("America/Mexico_City")).format(DateTimeFormatter.ofPattern("yyy-MM-dd HH:mm:ss"));
    String id = request.getParameter("id");
    String asunto = request.getParameter("asunto");
    String descrip = request.getParameter("descripcion");
    String prob = request.getParameter("problematica");
    
    ps = con.prepareStatement("UPDATE chat SET estatus = 'En espera', asunto = '"+asunto+"', tipo_problematica = '"+prob+"', fecha = '"+fecha+"' WHERE id_chat = "+id+"");
    ps.executeUpdate();
    
    ps = null;
    ps = con.prepareStatement("UPDATE conversacion SET mensaje = '"+descrip+"' WHERE id_chat_fk = "+id+"");
    ps.executeUpdate();
    ps.close();    
    con.close();
    
    out.print("ok");
%>
