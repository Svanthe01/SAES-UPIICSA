<%-- 
    Document   : cMensajes
    Created on : 15 ene. 2023, 14:32:38
    Author     : Dante
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.io.*"%>
<%
    Connection con = null;
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    con = DriverManager.getConnection( "jdbc:mysql://localhost:3306/bdatitos?autoReconnect=true&useSSL=false", "root", "s3mb3ll0");
    String id = request.getParameter("id");
    
    Statement statement = con.createStatement();      
    PreparedStatement ps = null;
    ResultSet rs = statement.executeQuery("SELECT * FROM conversacion WHERE id_chat_fk = "+id+" AND estatus = 'Enviado' ORDER BY fecha DESC");
    String res = "";    
    ResultSet rs2;
    Statement stat;
    while(rs.next()){
        stat = con.createStatement();
        rs2 = stat.executeQuery("SELECT nombre FROM alumno WHERE boleta = '"+rs.getString("emisor")+"'");
        if(rs2.next()){
            
        }else{
            stat = null;
            rs2 = null;
            stat = con.createStatement();
            rs2 = stat.executeQuery("SELECT nombre FROM personal_admin WHERE matricula = '"+rs.getString("emisor")+"'");
            rs2.next();
        }
        
        String fecha = rs.getString("fecha");
        fecha = fecha.substring(11,16);
        res += fecha + "//" + rs2.getString(1) + "//" + rs.getString("mensaje")+"///"; 
        rs2 = null;
        stat = null;
    }
    if(res.length() != 0){//si se encontraron registros
        ps = con.prepareStatement("UPDATE conversacion SET estatus = 'Leido' WHERE estatus = 'Enviado'");
        ps.executeUpdate();    
        ps.close();
    }else{
        res = "vacio";
    }
    rs.close();
    con.close();
    out.print(res);
%>
