<%-- 
    Document   : tablaNotificaciones
    Created on : 21 nov. 2022, 19:35:58
    Author     : Dante
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=0.7">
        <style>
            *{
                margin: 0px;
                padding: 0px;
                font-family: "Bahnschrift Light";                 
            }
            .notificaciones {
                color: black;
                width: 100%;
                max-width: 370px;
                margin: 0 auto;
                text-align: left;
                border-collapse: separate;
                border-spacing: 0;
            }


            .notificaiones th, .notificaciones td { /* cell */
                text-align: left;
                padding: 0.60rem;                
                font-size: 15px;
                border-bottom: 1px solid #343434;
            }

            .notificaciones th { /* header cell */
                font-weight: 700;
                text-align: left;
                color: #272838;
                border-bottom: 2px solid #EB9486;

                position: sticky;
                top: 0;
                background-color: #F9F8F8;
            }           
            .leida{
                background-color: #f1f1f1;
            }
            .notificaciones td:first-child {
                width: 30px;                             
            }                                      
            .notificaciones td:nth-child(2) {
                padding-left: 0px;
            }                                      
            .iconNotif{
                height: 25px;
                width: 25px;
                margin: 5px 2px;
            }
        </style>
    </head>
    <body>
        <div>
            <table class="notificaciones">            
                <tbody class="cuerpoTabla">
                    <%
                        Connection con = null;
                        Class.forName("com.mysql.jdbc.Driver").newInstance();
                        con = DriverManager.getConnection( "jdbc:mysql://localhost:3306/bdatitos?autoReconnect=true&useSSL=false", "root", "s3mb3ll0");

                        Statement statement = con.createStatement();                                        
                        ResultSet rs = statement.executeQuery("SELECT tipo,titulo,descripcion,estatus FROM notificacion INNER JOIN sesion ON receptor = usuario OR receptor = 'todos' WHERE estatus NOT IN ('enviada')");                        
                        while(rs.next()){
                            if(rs.getString("estatus").equals("leida")){
                                %>
                    <tr class="leida">
                                <%
                            }else{
                                %>
                    <tr>        
                                <%
                            }
                            switch(rs.getString("tipo")){
                                case "1":
                                    %>                    
                        <td><img class="iconNotif" src="utileria/media/iconos/usuarioN.png"></td>
                        <td>
                            <p><b><%=rs.getString("titulo")%></b></p>
                            <p><%=rs.getString("descripcion")%></p>
                        </td> 
                    </tr>  
                                    <%
                                    break;
                                case "2":
                                    %>                    
                        <td><img class="iconNotif" src="utileria/media/iconos/documento-firmadoN.png"></td>
                        <td>
                            <p><b><%=rs.getString("titulo")%></b></p>
                            <p><%=rs.getString("descripcion")%></p>
                        </td> 
                    </tr>  
                                    <%
                                    break;
                                case "3":   
                                    %>                    
                        <td><img class="iconNotif" src="utileria/media/iconos/users-altN.png"></td>
                        <td>
                            <p><b><%=rs.getString("titulo")%></b></p>
                            <p><%=rs.getString("descripcion")%></p>
                        </td> 
                    </tr>  
                                    <%
                            }                            
                        } 
                        rs.close();
                        con.close();
                    %>                      
                </tbody>
              </table>
        </div>
        <script src="utileria/librerias/jquery3.6.1.js"></script>
        <script src="utileria/librerias/notify.min.js"></script>
        <script>
            $(document).ready(function(){
                function refresh(){//cada 3s refrescamos la pagina y checamos si hay un nuevo registro
                    $.ajax({ //Comunicación jQuery hacia JSP
                        type: "POST",
                        url: "cNotificaciones.jsp",
                        data: "",
                        success: function(msg){  
                            msg = msg.trim();
                            if(msg === "vacio"){//si no se encuentran registros
                                
                            }else{
                                $('.nuevaNotif').css("display", "block");//se muestra el icono de nueva notificacion                                
                                const notif = msg.split("///");
                                
                                for (var i = 0; i < (notif.length-1); i++) {                                    
                                    const tif = notif[i].split("//");
                                    switch(tif[0]){
                                        case "1":
                                            $('.cuerpoTabla').prepend("<tr><td><img class='iconNotif' src='utileria/media/iconos/usuarioN.png'></td><td><p><b>" + tif[1] + "</b></p><p>"+ tif[2] +"</p></td></tr>");
                                            break;
                                        case "2":
                                            $('.cuerpoTabla').prepend("<tr><td><img class='iconNotif' src='utileria/media/iconos/documento-firmadoN.png'></td><td><p><b>" + tif[1] + "</b></p><p>"+ tif[2] +"</p></td></tr>");
                                            break;
                                        case "3":  
                                            $('.cuerpoTabla').prepend("<tr><td><img class='iconNotif' src='utileria/media/iconos/users-altN.png'></td><td><p><b>" + tif[1] + "</b></p><p>"+ tif[2] +"</p></td></tr>");
                                    }
                                }
                                $.notify((notif.length - 1) + " nueva(s) notificacion(es)", {position:"top center", className:"info"});
                            }
                        },
                        error: function(xml,msg){
                            alert("Ha ocurrido un error X_X");
                        }
                    }); 
                }                
                setInterval(refresh, 3000);
            });
            
        </script>
    </body>
</html>
