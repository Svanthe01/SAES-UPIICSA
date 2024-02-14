<%-- 
    Document   : altaTramites
    Created on : 16 ene. 2023, 08:37:03
    Author     : Dante
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.io.*, java.time.*, java.time.format.DateTimeFormatter"%>
<%
    Connection con = null;
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    con = DriverManager.getConnection( "jdbc:mysql://localhost:3306/bdatitos?autoReconnect=true&useSSL=false", "root", "s3mb3ll0");
    PreparedStatement st = null;
    String tipo = request.getParameter("tipo");
    String boleta = request.getParameter("boleta");
    String fecha = ZonedDateTime.now(ZoneId.of("America/Mexico_City")).format(DateTimeFormatter.ofPattern("yyy-MM-dd HH:mm:ss"));
    String datos = "INSERT INTO tramite(estatus,tipo,boleta_fk,matricula_fk,fecha) values('Pendiente',"+tipo+",'"+boleta+"','Pendiente','"+fecha+"')"; 

    st = con.prepareStatement (datos);
    st.executeUpdate();
    st = null;
    con.close();
%>
