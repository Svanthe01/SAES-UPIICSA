<%-- 
    Document   : altaChat
    Created on : 8 ene. 2023, 01:26:11
    Author     : Dante
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.io.*, java.time.*, java.time.format.DateTimeFormatter"%>
<%
    Connection con = null;
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    con = DriverManager.getConnection( "jdbc:mysql://localhost:3306/bdatitos?autoReconnect=true&useSSL=false", "root", "s3mb3ll0");
    PreparedStatement st = null;
    String datos = "";    
    
    String asunto = request.getParameter("asunto");
    String descrip = request.getParameter("descrip");
    String tipo = request.getParameter("tipo");//borrador o chat
    String prob = request.getParameter("prob");    
    String user = request.getParameter("user");
    String status = request.getParameter("status");
    String fecha = ZonedDateTime.now(ZoneId.of("America/Mexico_City")).format(DateTimeFormatter.ofPattern("yyy-MM-dd HH:mm:ss"));
    
    datos = "INSERT INTO chat (asunto, fecha, tipo_problematica, estatus, boleta_fk, matricula_fk) values(?,?,?,?,?,?)";   
    
    st = con.prepareStatement (datos);    
    st.setString(1,asunto);
    st.setString(2,fecha);
    st.setString(3,prob);
    st.setString(4,status);//borrador, en espera, en curso y finalizado
    st.setString(5,user);
    st.setString(6,"Pendiente");
    st.executeUpdate();
    
    //guardamos la descripcion aparte en conversaciones  
    st = null;
    Statement statement = con.createStatement();
    ResultSet rs = statement.executeQuery("SELECT MAX(id_chat) from chat");
    rs.next();
    String id = rs.getString("MAX(id_chat)");
    datos = "INSERT INTO conversacion (id_chat_fk, fecha, mensaje, emisor, estatus) values(?,?,?,?,'Leido')";
    st = con.prepareStatement (datos);
    st.setInt(1, Integer.parseInt(id));
    st.setString(2, fecha);
    st.setString(3, descrip);
    st.setString(4, user);
    st.executeUpdate();
    
    rs.close();
    st.close();
    con.close();
    
    out.print("oki");
%>
