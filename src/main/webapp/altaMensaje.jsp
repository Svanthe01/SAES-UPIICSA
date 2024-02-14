<%-- 
    Document   : altaMensaje
    Created on : 15 ene. 2023, 12:10:14
    Author     : Dante
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.io.*, java.time.*, java.time.format.DateTimeFormatter"%>
<%
    Connection con = null;
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    con = DriverManager.getConnection( "jdbc:mysql://localhost:3306/bdatitos?autoReconnect=true&useSSL=false", "root", "s3mb3ll0");
    PreparedStatement st = null;
    
    String mensaje = request.getParameter("mensaje");
    String id = request.getParameter("id");
    String fecha = ZonedDateTime.now(ZoneId.of("America/Mexico_City")).format(DateTimeFormatter.ofPattern("yyy-MM-dd HH:mm:ss"));
    Statement statement = con.createStatement();
    ResultSet rs = statement.executeQuery("SELECT usuario from sesion WHERE tipo_us = 1");
    rs.next();
    String user = rs.getString(1);
    String datos = ""; 
    datos = "INSERT INTO conversacion (id_chat_fk, mensaje, fecha, emisor, estatus) values("+id+",?,?,?,'Enviado')";   
    
    st = con.prepareStatement (datos);
    st.setString(1,mensaje);
    st.setString(2,fecha);
    st.setString(3,user);
    st.executeUpdate();
    
    rs.close();
    st.close();
    con.close();
    out.print("ok");
%>
