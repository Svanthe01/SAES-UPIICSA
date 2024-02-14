<%-- 
    Document   : tablaBorradores
    Created on : 24 nov. 2022, 09:18:56
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
            .borradores {  
                color: black;
                min-width: 100%;
                margin: 0px 0px;
                height: 200px;
                border-collapse: separate;
                border-spacing: 0;
                
            }            
            .borradores thead{
                position: sticky;
                top: 0;
            }
            .borradores th, .borradores td { /* cell */
                padding: 0.60rem;                
                font-size: 15px;
                border-bottom: 1px solid #343434;
                text-align: center;
            }

            .borradores th { /* header cell */                       
                color: #272838;
                border-bottom: 2px solid #EB9486;                                
                position: sticky;
                padding: 0px;
                text-align: center;                
                height: 20px;                
                background-color: #F9F8F8;
            }                                                     
            .borradores td:nth-child(3) {
                width: 30px;
            }
            .iconNotif{
                height: 25px;
                width: 25px;
                margin: 5px 2px;
            }   
            .borradores a{
                color: #428CC6;
                cursor: pointer;
            }
            #eliminarBorradores:hover{
                cursor: pointer;                
            }
        </style>
    </head>
    <body>
        <div>
            <table class="borradores">
                <thead>
                    <tr>
                        <th>Asunto</th>
                        <th>Fecha</th>                        
                        <th><img title="Eliminar Borradores" class="iconNotif" id="eliminarBorradores" src="utileria/media/iconos/basuraN.png"></th>
                    </tr>
                </thead>

                <tbody>
                    <%
                        Connection con = null;
                        Class.forName("com.mysql.jdbc.Driver").newInstance();
                        con = DriverManager.getConnection( "jdbc:mysql://localhost:3306/bdatitos?autoReconnect=true&useSSL=false", "root", "s3mb3ll0");

                        Statement statement = con.createStatement();                                        
                        ResultSet rs = statement.executeQuery("SELECT * FROM chat INNER JOIN sesion ON boleta_fk = usuario OR boleta_fk = 'todos' WHERE estatus = 'Borrador'");                        
                        while(rs.next()){
                            String fecha = rs.getString("fecha");
                            fecha = fecha.substring(0,10);
                            %>
                    <tr>
                        <td><%=rs.getString("asunto")%></td>
                        <td><%=fecha%></td>                        
                        <td><u><a onclick="abrirBorrador(<%=rs.getInt("id_chat")%>)">Abrir</a></u></td>
                    </tr>
                            <%
                        }
                    %>                    
                </tbody>
              </table>
            <script src="utileria/librerias/jquery3.6.1.js"></script>
            <script src="utileria/librerias/notify.min.js"></script>
            <script>
                   function abrirBorrador(valor){
                    if($(".chat").is(":hidden") && $(".abrirChat").is(":hidden")){
                        $("#enviarChat").css("display", "none");
                        $("#actualizarBorrador").css("display", "block");
                        $('#cerrarBorrador').css("display", "block");
                        limpiarCampos();
                        $(".chat").slideDown();
                        
                    }else if($(".chat").is(":hidden") && !($(".abrirChat").is(":hidden"))){
                        $('.abrirChat').css("display", "none");                
                        $('.cerrarChat').css("display", "none");
                        $("#enviarChat").css("display", "none");
                        $("#actualizarBorrador").css("display", "block");
                        $('#cerrarBorrador').css("display", "block");
                        limpiarCampos();
                        $(".chat").slideDown();
                        
                    }else{//se cierra y se abre otra vez pero ahora limpio si ya estaba abierto
                        $(".chat").slideUp();
                        $('.abrirChat').css("display", "none");                
                        $('.cerrarChat').css("display", "none");
                        $("#enviarChat").css("display", "none");
                        $("#actualizarBorrador").css("display", "block");
                        $('#cerrarBorrador').css("display", "block");
                        limpiarCampos();
                        $(".chat").slideDown();
                        
                    }                  
                    $.ajax({ //Comunicación jQuery hacia JSP
                        type: "GET",
                        url: "cBorradores.jsp",
                        data: {id:valor},
                        success: function(msg){  
                            msg = msg.trim();
                            const datos = msg.split("//");
                            
                            if(datos[0]==="[Sin asunto]")
                                $("#asunto").val("");
                            else
                                $("#asunto").val(datos[0]);
                            if(datos[1] === "[Sin descripción]")
                                $("#descrip").val("");
                            else
                                $("#descrip").val(datos[1]);
                            if(datos[2] === "")
                                $('#problematica').prop('selectedIndex',0);
                            else
                                $("#problematica option[value='"+datos[2]+"']").attr("selected",true); 
                            
                            $("#aux").val(valor);/*Guardamos el id del chat en un campo auxiliar*/
                        },
                        error: function(xml,msg){
                            alert(msg);
                        }
                    });                    
                }
                
                $("#eliminarBorradores").click(function(){
                    $.ajax({ //Comunicación jQuery hacia JSP
                        type: "GET",
                        url: "eliminarBorradores.jsp",
                        data: "",
                        success: function(msg){  
                            $.notify("Borradores eliminados", {position:"top center", className:"info"});
                        },
                        error: function(xml,msg){
                            alert(msg);
                        }
                    });                    
                    location.reload(true);/*Volvemos a cargar la pagina*/
                });              
            </script>
        </div>        
    </body>
</html>
