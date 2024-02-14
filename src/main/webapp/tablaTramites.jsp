<%-- 
    Document   : tablaTramites
    Created on : 14 ene. 2023, 09:40:58
    Author     : Dante
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            *{
                margin: 0px;
                padding: 0px;
                font-family: "Bahnschrift Light"; 
            }
            .tramites {                
                color: black;
                min-width: 100%;
                margin: 0px 0px;
                height: 200px;
                border-collapse: separate;
                border-spacing: 0;
                
            }            
            .tramites thead{
                position: sticky;
                top: 0;
            }
            .tramites th, .tramites td { /* cell */
                height: 20px;
                padding: 0px; 
                margin: 0px;
                font-size: 15px;
                border-bottom: 1px solid #343434;
                text-align: center;
            }
            .tramites tr{
                height: 20px;
            }
            .tramites th { /* header cell */                       
                color: #272838;
                border-bottom: 2px solid #EB9486;                                
                position: sticky;
                padding: 0px;
                text-align: center;                
                height: 20px;                
                background-color: #F9F8F8;
            }                                                     
            .tramites td:nth-child(4) {
                width: 30px;
            }
            .iconNotif{
                height: 25px;
                width: 25px;
                margin: 5px 2px;
            }   
            .tramites a{
                color: #428CC6;
                cursor: pointer;
            }
            #eliminarBorradores:hover{
                cursor: pointer;                
            }
        </style>
    </head>
    <body>
        <table class="tramites">
            <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Fecha</th>
                    <th>Estado</th>                        
                    <th><img title="Eliminar tramites finalizados" class="iconNotif" id="eliminarTramites" src="utileria/media/iconos/basuraN.png"></th>
                </tr>
            </thead>

            <tbody>
                <%
                    Connection con = null;
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    con = DriverManager.getConnection( "jdbc:mysql://localhost:3306/bdatitos?autoReconnect=true&useSSL=false", "root", "s3mb3ll0");

                    Statement statement = con.createStatement();                                        
                    ResultSet rs = statement.executeQuery("SELECT * FROM tramite INNER JOIN sesion ON boleta_fk = usuario ORDER BY fecha ASC");                        
                    while(rs.next()){
                        String nombre = "";
                        switch(rs.getInt("tipo")){
                            case 1:
                                nombre = "Constancia de Estudios";
                                break;
                            case 2:
                                nombre = "Constancia de Inscripción";
                                break;
                            case 3:
                                nombre = "Constancia de Becas";
                                break;
                            case 4:
                                nombre = "Boleta Global";
                                break;
                            case 5:
                                nombre = "Boleta de Tres Firmas para Egreso";
                                break;
                            case 6:
                                nombre = "Boleta de Tres Firmas para Certificado parcial";
                                break;
                            case 7:
                                nombre = "Boleta de Tres Firmas para Tramite personal";
                                break;
                            case 8:
                                nombre = "Boleta de Tres Firmas para Beca";
                                break;
                            case 9:
                                nombre = "Boleta de Tres Firmas para Excelencia Académica";
                                break;
                            case 10:        
                                nombre = "Boleta de Tres Firmas para Egreso subsecuente";
                        }
                        String fecha = rs.getString("fecha");
                        fecha = fecha.substring(0,10);
                        %>
                <tr>
                    <td><%=nombre%></td>
                    <td><%=fecha%></td>                        
                    <td><%=rs.getString("estatus")%></td>                        
                    <td></td>                                            
                </tr>
                        <%
                    }
                %>                
            </tbody>
          </table>
    </body>
</html>
