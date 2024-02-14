<%-- 
    Document   : tablaHistorialChats
    Created on : 24 nov. 2022, 09:19:15
    Author     : Dante
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.io.*, java.time.*, java.time.format.DateTimeFormatter"%>
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
            .Historial_chats {              
                color: black;
                min-width: 100%;
                margin: 0px 0px;                
                border-collapse: separate;
                border-spacing: 0;
                
            }

            .Historial_chats thead{
                position: sticky;
                top: 0;
            }
            .Historial_chats th, .Historial_chats td { /* cell */
                padding: 0.60rem;                
                font-size: 15px;
                border-bottom: 1px solid #343434;
                text-align: center;
            }

            .Historial_chats th { /* header cell */                        
                color: #272838;
                border-bottom: 2px solid #EB9486;                                
                position: flex;
                padding: 0px;
                text-align: center;                
                height: 20px;                
                background-color: #F9F8F8;
            }                                                     
            .Historial_chats td:nth-child(4) {
                width: 30px;
            }
            .iconNotif{
                height: 25px;
                width: 25px;
                margin: 5px 2px;
            }   
            .Historial_chats a{
                color: #428CC6;
                cursor: pointer;
            }
            #eliminarHistorialChats:hover{
                cursor: pointer;                
            }
            /*VENTANA DE CHAT*/
            #live-chat a { text-decoration: none; }

            #live-chat fieldset {
                border: 0;
                margin: 0;
                padding: 0;
            }

            #live-chat h4, #live-chat h5 {
                line-height: 1.5em;
                margin: 0;
            }

            #live-chat hr {
                background: #999999;
                border: 0;
                -moz-box-sizing: content-box;
                box-sizing: content-box;
                height: 1px;
                margin: 0;
                min-height: 1px;
            }

            #live-chat img {
                border: 0;
                display: block;
                height: auto;
                max-width: 100%;
            }

            #live-chat input {
                border: 0;
                color: inherit;
                font-family: inherit;
                font-size: 100%;
                line-height: normal;
                margin: 0;
            }

            #live-chat p { margin: 0; }

            .clearfix { *zoom: 1; } /* For IE 6/7 */
            .clearfix:before, .clearfix:after {
                content: "";
                display: table;
            }
            .clearfix:after { clear: both; }

            /* ---------- LIVE-CHAT ---------- */

            #live-chat {
                display: none;
                bottom: 0;
                font-size: 12px;
                right: 24px;
                position: fixed;
                width: 350px;
            }
            #live-chat header {
                background: #6B1740;
                border-radius: 5px 5px 0 0;
                color: #fff;
                cursor: pointer;
                padding: 16px 24px;
            }
            #live-chat h4:before {
                background: #1a8a34;
                border-radius: 50%;
                content: "";
                display: inline-block;
                height: 8px;
                margin: 0 8px 0 0;
                width: 8px;
            }
            #live-chat h4 {
                text-align: left;
                font-size: 15px;
            }
            #live-chat h5 {
                font-size: 10px;
            }
            #live-chat form {
                padding: 24px;
                padding-right: 10px;
            }
            #live-chat input[type="text"] {
                border: 1px solid #ccc;
                border-radius: 3px;
                padding: 5px;
                outline: none;
                width: 235px;
            }
            .chat-message-counter {
                background: #e62727;
                border: 1px solid #fff;
                border-radius: 50%;
                display: none;
                font-size: 12px;
                font-weight: bold;
                height: 28px;
                left: 0;
                line-height: 28px;
                margin: -15px 0 0 -15px;
                position: absolute;
                text-align: center;
                top: 0;
                width: 28px;
            }
            .chat-close {     
                width: 16px;
                height: 16px;
                display: block;
                float: right;                                               
                margin: 2px 0 0 0;
                text-align: center;                
            }
            #live-chat .cConversacion {                
                background: #fff;
            }
            .chat-history {
                color: black;
                height: 252px;
                padding: 8px 8px;
                overflow-y: scroll;
                scroll-behavior: inherit;   
                background-color: whitesmoke;
            }
            .chat-message {
                margin: 16px 0;
            }
            .chat-message img {
                border-radius: 50%;
                float: left;
                margin-left: 10px;
            }
            .chat-message-content {
                text-align: left;
                margin-left: 56px;
            }
            .chat-time {
                float: right;
                font-size: 10px;
            }     
            .enviarMensaje{
                margin-top: 5px;
                width: 20px;
                height: 20px;
                display: block;
                float: right;                                               
                margin: 2px 0 0 0;
                text-align: center; 
                cursor: pointer;
            }
            #aux2{
                display: none;
            }
            #mssg{               
                float: left;
                display: block;
            }            
        </style>
    </head>
    <body>
        <div>
            <table class="Historial_chats">
                <thead>
                    <tr>
                        <th>Asunto</th>
                        <th>Fecha</th>
                        <th>Estado</th>
                        <th><img class="iconNotif" title="Eliminar Chats" id="eliminarHistorialChats" src="utileria/media/iconos/basuraN.png"></th>
                    </tr>
                </thead>

                <tbody>
                    <%
                        Connection con = null;
                        Class.forName("com.mysql.jdbc.Driver").newInstance();
                        con = DriverManager.getConnection( "jdbc:mysql://localhost:3306/bdatitos?autoReconnect=true&useSSL=false", "root", "s3mb3ll0");

                        Statement statement = con.createStatement();                                        
                        ResultSet rs = statement.executeQuery("SELECT * FROM chat INNER JOIN sesion ON boleta_fk = usuario OR boleta_fk = 'todos' WHERE estatus NOT IN ('Borrador')");                        
                        while(rs.next()){
                            String fecha = rs.getString("fecha");
                            fecha = fecha.substring(0,10);
                            %>
                    <tr>
                        <td><%=rs.getString("asunto")%></td>
                        <td><%=fecha%></td>
                        <td><%=rs.getString("estatus")%></td>
                        <%
                            if(rs.getString("estatus").equals("En curso")){
                            %>
                        <td><u><a onclick="abrirConversacion(<%=rs.getInt("id_chat")%>)">Ver</a></u></td>                            
                            <%
                            }else{
                            %>
                        <td></td>                            
                            <%        
                            }                            
                        %>
                    </tr>
                            <%
                        }
                    %>                    
                </tbody>
          </table>                
        </div>        
        <div id="live-chat">
            <header class="clearfix">
                <img src="utileria/media/iconos/cruz.png" class="chat-close" title="Cerrar chat">
                <h4>Conversación</h4>
                <span class="chat-message-counter">2</span>
            </header>
            
            <div class="cConversacion">                
                <div class="chat-history">                                                       
                    <form id="nuevoChat" action="#" method="post">
                        <fieldset>
                            <input type="text" id="mssg" placeholder="Nuevo Mensaje" autofocus>
                            <input type="text" id="aux2">
                            <img src="utileria/media/iconos/enviarN.png" class="enviarMensaje" title="Enviar">
                        </fieldset>
                    </form>
                </div>
            </div> <!-- end chat -->
	</div> <!-- end live-chat -->

        <script src="utileria/librerias/jquery3.6.1.js"></script>
        <script src="utileria/librerias/notify.min.js"></script>
        <script>
            $(document).ready(function(){
                function refresh(){
                    if(!$('#live-chat').is(":hidden")){
                        var valor = $("#aux2").val();
                        $.ajax({ //Comunicación jQuery hacia JSP
                            type: "GET",
                            url: "cMensajes.jsp",
                            data: {id:valor},
                            success: function(msg){ 
                                msg = msg.trim();
                                if(msg === "vacio"){
                                    
                                }else{
                                    const cadena = msg.split("///");
                                    for (var i = 0; i < (cadena.length-1); i++) {
                                        const pieza = cadena[i].split("//");                                    
                                        $("<div class='chat-message clearfix'><img src='utileria/media/iconos/usuarioN.png' alt='' width='32' height='32'><div class='chat-message-content clearfix'><span class='chat-time'>"+pieza[0]+"</span><h5>"+pieza[1]+"</h5><p>"+pieza[2]+"</p></div></div><hr class='espacio'>" ).insertBefore( "#nuevoChat" );
                                    }
                                    var num = parseInt($(".chat-message-counter").html());
                                    $(".chat-message-counter").html((num + cadena.length-1));                                    
                                }
                            },
                            error: function(xml,msg){
                                
                            }
                        });
                    }                        
                }setInterval(refresh, 3000);                                
            });
                                    
            $(".enviarMensaje").click(function(){
                if($("#mssg").val().length === 0)
                    $.notify("Introduzca un mensaje para continuar", {position:"top center", className:"error"});
                else{
                    $.ajax({ //Comunicación jQuery hacia JSP
                        type: "GET",
                        url: "altaMensaje.jsp",
                        data: {mensaje:$("#mssg").val(),id:$("#aux2").val()},
                        success: function(msg){  
                            
                        },
                        error: function(xml,msg){
                            alert(msg);
                        }
                    });  
                    $("#mssg").val("");
                }
            });
            function abrirConversacion(valor){
                /*Quitamos las cosas que estorban*/
                if($(".chat").is(":hidden") && $(".abrirChat").is(":hidden")){                    
                    limpiarCampos();                    

                }else if($(".chat").is(":hidden") && !($(".abrirChat").is(":hidden"))){
                    $('.abrirChat').css("display", "none");                
                    $('.cerrarChat').css("display", "none");                    
                    limpiarCampos();                    

                }else{//se cierra y se abre otra vez pero ahora limpio si ya estaba abierto
                    $(".chat").slideUp();
                    $('.abrirChat').css("display", "none");                
                    $('.cerrarChat').css("display", "none");                    
                    limpiarCampos();                    
                }      
                        
                /*cada que se abra el chat se eliminan los mensajes*/
                $(".chat-message.clearfix").remove();
                $(".espacio").remove();                                
                $("#live-chat").slideDown();
                
                $.ajax({ //Comunicación jQuery hacia JSP
                    type: "GET",
                    url: "cChat.jsp",
                    data: {id:valor},
                    success: function(msg){  
                        msg = msg.trim();
                        const cadena = msg.split("///");
                        for (var i = 0; i < (cadena.length-1); i++) {
                            const pieza = cadena[i].split("//");
                            $(".chat-history").prepend("<div class='chat-message clearfix'><img src='utileria/media/iconos/usuarioN.png' alt='' width='32' height='32'><div class='chat-message-content clearfix'><span class='chat-time'>"+pieza[0]+"</span><h5>"+pieza[1]+"</h5><p>"+pieza[2]+"</p></div></div><hr class='espacio'>");
                        }
                        $(".chat-message-counter").html(cadena.length-1);
                        $("#aux2").val(valor);
                    },
                    error: function(xml,msg){
                        alert(msg);
                    }
                });
                /*consultamos si hay nuevos mensajes mientras se muestre el chat*/                
            }
            $("#eliminarHistorialChats").click(function(){
                $.ajax({ //Comunicación jQuery hacia JSP
                    type: "GET",
                    url: "eliminarHistorial.jsp",
                    data: "",
                    success: function(msg){  
                        $.notify("Chats finalizados eliminados", {position:"top center", className:"info"});
                    },
                    error: function(xml,msg){
                        alert(msg);
                    }
                });
                location.reload(true);/*Volvemos a cargar la pagina*/
            });                       
            
            (function() {
                $('#live-chat header').on('click', function() {
                    $('.cConversacion').slideToggle(300, 'swing');
                    $('.chat-message-counter').fadeToggle(300, 'swing');
                });

                $('.chat-close').on('click', function(e) {                    
                    $('#live-chat').slideUp();
                });
            }) ();
        </script>
    </body>
</html>
