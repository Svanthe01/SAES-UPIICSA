<%-- 
    Document   : cNotificaciones
    Created on : 5 ene. 2023, 20:09:05
    Author     : Dante
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.io.*"%>
<%
    Connection con = null;
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    con = DriverManager.getConnection( "jdbc:mysql://localhost:3306/bdatitos?autoReconnect=true&useSSL=false", "root", "s3mb3ll0");

    Statement statement = con.createStatement();                
    PreparedStatement ps = null;
    ResultSet rs = statement.executeQuery("SELECT tipo,titulo,descripcion FROM notificacion "
            + "INNER JOIN sesion ON receptor = usuario OR receptor = 'todos' WHERE estatus='enviada'");
    String res = "";
    while(rs.next()){
        res += rs.getInt("tipo") + "//" + rs.getString("titulo") + "//" + rs.getString("descripcion")+"///";        
    }    
    if(res.length() != 0){//si se encontraron registros
        ps = con.prepareStatement("UPDATE notificacion SET estatus = 'recibida' WHERE estatus = 'enviada'");
        ps.executeUpdate();    
        ps.close();
    }else{
        res = "vacio";
    }
    rs.close();
    con.close();
    
    out.print(res);
%>
