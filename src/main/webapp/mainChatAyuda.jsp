<%-- 
    Document   : mainChatAyuda
    Created on : 10 ene. 2023, 00:12:44
    Author     : Dante
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.io.*"%>
<%
    Connection con = null;
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    con = DriverManager.getConnection( "jdbc:mysql://localhost:3306/bdatitos?autoReconnect=true&useSSL=false", "root", "s3mb3ll0");

    Statement statement = con.createStatement();			
    ResultSet rs = statement.executeQuery("SELECT sesion.usuario,alumno.nombre FROM sesion INNER JOIN alumno WHERE usuario = boleta");
    rs.next();
    String user = rs.getString("usuario");
    String nombre = rs.getString("nombre");    
    rs.close();
    con.close();
%>
<!DOCTYPE html>
<html>
    <head>       
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=0.7">
        <style>            
            *, p{
                margin: 0px;
                padding: 0px;
                font-family: "Bahnschrift Light"; 
            }                        
            .header {    
                top: 0px;
                width: 100%;                
                background-image: url(utileria/media/fondoChatAyuda.png);
                background-position: center center;
                background-repeat: no-repeat;
                background-size: cover;
                color: white;
                position: sticky;
                height: 75px;                   
                z-index: 100;
            }                       
            .cuerpo {                        
                width: 100%;
                height: 3000px;
                color: white;
                background-color: whitesmoke;                                
                text-align: center;                
            }                        
            .header_logo {
                float: left;
                font-family: "Bahnschrift Light";   
                margin-top: 23px;
                margin-left: 10px;
                font-size: 30px;                    
            }
            .icono{
                height: 30px;
                width: 30px;    
                padding: 4px 4px;   
                transition: 0.5s;
            }             
            .icono.ham:hover,.icono.conf:hover,.icono.cruz:hover,.icono.notif:hover,
            .icono.user:hover, .icono.avion:hover, .icono.marcarLeido:hover, .icono.borrarNotif:hover{    
                cursor: pointer;    
                border-radius: 8px;
                background-color: rgba(0, 0, 0, 0.4); 
            }           
            .icono.cruz{  
                display: none;
                top: 0px;
                float: right;    
                margin-top: 20px;
                margin-right: 15px; 
            }
            .icono.ham{                   
                float: left;    
                margin-top: 20px;
                margin-left: 15px; 
            }                                    
            .icono.conf, .icono.notif, .icono.user{    
                float: right;        
                margin-top: 20px;
                margin-right: 15px;  
            }                               
            .engrane{
                position: fixed;
                top: 75px;
                right: 0px;                                
                height: 170px;
                width: 215px;
                background-color: #efeff5;
                display: none;                
                z-index: 100;
                border-bottom-left-radius: 8px;
            }
            .campana{
                border-bottom-left-radius: 8px;
                position: fixed;
                top: 75px;
                right: 0px;                               
                height: 220px;
                width: 370px;
                background-color: #efeff5;
                display: none;                
                z-index: 100;
            }
            .headerConf,.headerNotif{                
                display: block;                                
                width: 100%;
                height: 35px;
                background-color: #6B1740; 
            }
            .headerConf h4,.headerNotif h4{
                color: white;
                float: left;
                margin-top: 10px;
                margin-left: 10px;
            }            
            .contConf{
                text-align: center;
                align-items: center;
                display: block;                   
                margin: 15px 10px;
            }
            .contConf div{
                display: inline;
            }            
            .contConf button{
                height: 30px;
                padding: 5px 20px;
            }            
            .contNotif{
                scroll-behavior: inherit;                             
                display: block;
                overflow: scroll;
                overflow-x: hidden;
                width: 100%;
                height: 185px;
                border-bottom-left-radius: 8px;
            }
            .contNotif::-webkit-scrollbar , .tab-contents::-webkit-scrollbar{                
                display: none;
            }
            .iconNotif{
                height: 25px;
                width: 25px;
                margin: 5px 2px;
            }
            input[type="radio"] {
                margin-top: -5px; /*Alinear texto alterno*/
                vertical-align: middle; /*Alinear texto alterno*/
                transition: 0.4s;
                appearance: none;                
                -webkit-appearance: none;
                border: 0.2rem solid #fff;
                background-color: #999999;
                border-radius: 50%;            
                height: 1.2rem;
                width: 1.2rem;
                cursor:pointer;
                box-shadow: 0 0 0 1px lightgray;                
            }              
            input[type="radio"]:checked {
                box-shadow: 0 0 0 1px #660033;
                background-color: #660033;
                border-width: 0.2rem;
            }
            .nuevaNotif{           
                display: none;
                position: absolute;
                background-color: red;
                height: 12px;
                width: 12px;
                top: 20px;
                right: 20px;
                border-radius: 50%;                
            }
            
            .borradores {                
                min-width: 100%;
                margin: 0px 0px;
                height: 200px;
                border-collapse: separate;
                border-spacing: 0;
                
            }            
            .borradores thead{
                position: sticky;
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
            }
            #eliminarBorradores:hover{
                cursor: pointer;                
            }
            .Historial_chats {                
                min-width: 100%;
                margin: 0px 0px;                
                border-collapse: separate;
                border-spacing: 0;
                
            }

            .Historial_chats thead{
                position: sticky;
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
                position: aticky;
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
            }
            #eliminarHistorialChats:hover{
                cursor: pointer;                
            }
            /*TABS*/            
            .tabs {
                max-width: 100%;
                height: 100%;
                margin: 0 auto;
                padding: 0 0px;                
            }
            #tab-button {
                display: table;
                table-layout: fixed;
                width: 100%;
                margin: 0;
                padding: 0;
                list-style: none;
            }
            #tab-button li {
                
                display: table-cell;
                width: 20%;
            }
            #tab-button li a {                
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
                display: block;
                padding: .5em;
                background: #ccccff;
                border: 1px solid #ddd;
                text-align: center;
                color: #000;
                text-decoration: none;
            }
            #tab-button li:not(:first-child) a {
                border-left: none;
            }
            #tab-button li a:hover,
            #tab-button .is-active a {
                border-bottom-color: transparent;
                background-color: #F9F8F8;
            }
            .tab-contents {
                margin: 0px;
                padding: 0px;
                scroll-behavior: inherit;                             
                display: block;
                overflow: scroll;
                overflow-x: hidden;
                background-color: #efeff5;
                height: 364px;
                width: 100%;
                border-bottom-left-radius: 8px;
                border-bottom-right-radius: 8px;
            }
            .tab-contents::-webkit-scrollbar{                
                display: none;
            }
            .tab-button-outer {
                display: none;
            }            
            .tab-select-outer {
                height: 37px;
                width: 100%;
            }
            #tab-select{
                background-color: #F9F8F8;
                padding: 0px 10px;
                margin: 0px;
                height: 37px;
                width: 100%;
            }
            /* VENTANA MODAL*/
            button{
                cursor: pointer;
                background-color: #6B1740;
                border: 0;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
                color: #fff;
                font-size: 14px;
                padding: 6px 15px;
                padding-top: 9px;
                transition: 0.4s;
            }
            button:hover{
                background-color: #262626;
            }
            form input, form select, form textarea {
                border-radius: 5px;
                font-family: "Roboto", sans-serif;
                outline: 0;
                background:  #ccccff;
                width: 100%;
                border: 1px;
                margin: 0 0 15px;
                padding: 15px;
                box-sizing: border-box;
                font-size: 14px;
            }   
            select{
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
                font-family: "Roboto", sans-serif;
                outline: 0;
                background:  #ccccff;
                width: 100%;
                border: 1px;
                margin: 0 0 15px;
                padding: 15px;
                box-sizing: border-box;
                font-size: 14px;
            }
            
            /*CHAT*/
            .contenedor{
                height: 100%;
                width: 100%;
                display: flex;
                flex-wrap: wrap;
                justify-content: center;                
                gap: 15px;     
                padding-top: 15px;
            }
            .principal{      
                color: black;
                width: 600px;
                height: 400px;
                background-color: #efeff5;
                border-radius: 8px;
            }
            .extra{      
                color: black;
                width: 200px;
                height: 205px;
                background-color: #efeff5;
                border-radius: 8px;
                text-align: center;
                display: block;                
            } 
            .extraCont{
                margin: 20px;                                
            }
            .abrirChat{                
                display: flex;
                align-items: center;
                justify-content: center;
                background-color: #6B1740;
                height: 50px;
                width: 50px;                    
                transition: 0.5s;
                border-radius: 50%;
                bottom: 0px;
                right: 0px;
                margin: 15px 15px;
                position: fixed;                
            } 
            .abrirChat:hover{    
                cursor: pointer;    
                background-color: #262626; 
            }   
            #cerrarBorrador, #actualizarBorrador{
                display: none;
            }
            .chat{
                color:black;
                position: fixed;                
                bottom: 0px;
                right: 60px;
                margin: 15px 15px;                
                height: 300px;
                width: 500px;
                background-color: #f6eeee;
                display: none; 
                z-index: 230;      
                border-radius: 8px;
            }    
            .headerChat{ 
                color:white;
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
                display: block;                
                align-items: center;
                width: 100%;
                height: 38px;
                background-color: #6B1740; 
            }            
            .icono.avion{
                height: 20px;
                width: 20px;
                float: right;
                margin-right: 10px;
                margin-top: 5px;
            }
            .icono.borrarNotif, .icono.marcarLeido{
                height: 20px;
                width: 20px;
                float: right;
                margin-right: 10px;
                margin-top: 4px;
            }
            .headerChat h3{
                float: left;
                padding-left: 15px;
                padding-top: 10px;
            }
            .infoUser{
                margin: 15px 15px;
                display: flex;
                align-items: center;                
                gap: 4px;
            }
            .contChat{                
                display: block;
                height: 100%;
                width: 100%;
            }
            .contChat form{
                margin: 15px 15px;
            }
            .cerrarChat{
                display: flex;
                align-items: center;
                justify-content: center;
                bottom: 30px;
                right: 30px;
                position: fixed;                
                bottom: 50px;
                right: 15px;
                padding: 3px 3px;
                border-radius: 50%;
                height: 13px;
                width: 13px;
                background-color: #404040;                
                z-index: 230;
            }
            .cerrarChat:hover{                
                cursor: pointer;
            }
            .tacha{
                height: 9px;
                width: 9px;
            }
            .us{
                height: 20px;
                width: 20px;
            }
            #asunto{                
                height: 50px;
                width: 265px;
                float: left;
            }
            #problematica{
                height: 50px;
                width: 190px;     
                float: right;
            }
            #descrip{
                resize: none;
                height: 130px;
            }  
            #aux{
                display: none;
            }
            @media(max-width:700px){   
                .chat{
                    width: 370px;
                    height: 360px;
                }
                #asunto{
                    height: 50px;
                    width: 100%;
                    float: none;
                }
                #problematica{
                    height: 50px;
                    width: 100%;     
                    float: none;
                }                
            }
            @media screen and (min-width: 640px) {
                .tab-button-outer {
                    position: relative;
                    z-index: 2;
                    display: block;
                    margin: 0px;
                    padding: 0px;
                    height: 37px;
                }
                .tab-select-outer {
                    display: none;                    
                }
                .tab-contents {
                    margin-top: 0px;
                    position: relative;
                    top: -1px;                    
                }
            }
        </style>
    </head>

    <body>        
        <div class="header">                        
            <img class="icono ham" src="utileria/media/iconos/menu.png" alt="alt" title="Esconder menu">                                
            <p class="header_logo">CHAT DE AYUDA</p>            
            <img class="icono notif" src="utileria/media/iconos/notif.png" alt="alt" title="Notificaciones">    
            <div class="nuevaNotif" title="Nueva Notificación"></div>
            <img class="icono conf" src="utileria/media/iconos/conf.png" alt="alt" title="Configuraciones">                        
            <img class="icono user" src="utileria/media/iconos/usuario.png" alt="alt" title="Perfil">                        
        </div>
        <div class="engrane">
            <div class="headerConf">
                <h4>CONFIGURACIONES</h4>                
            </div>
            <div class="contConf">
                <h4 style="margin: 4px 10px;">Tamaño de la fuente</h4>                
                <button id="up">↑A</button>
                &nbsp
                <button id="down">↓A</button>                
                <h4 style="margin: 4px 10px; margin-top: 10px;">Tema</h4>                
                <div><input id="oscuro" type="radio" value="ocuro" name="tema"/><label for="oscuro">&nbspOscuro&nbsp</label></div>
                <div><input id="claro" type="radio" value="claro" checked name="tema"/><label for="claro">&nbspClaro</label></div>
            </div>
        </div>
        <div class="campana">
            <div class="headerNotif">
                <h4>NOTIFICACIONES</h4> 
                <img class="icono borrarNotif" id="borrarNotif" src="utileria/media/iconos/basura.png" title="Eliminar notificaciones" alt="alt">
                <img class="icono marcarLeido" id="marcarLeido" src="utileria/media/iconos/leido.png" title="Marcar como leidas" alt="alt">
            </div>
            <div class="contNotif">
                
            </div>            
        </div>
        <div class="cuerpo">            
            <div class="infoExtra">
                <div class="contenedor">
                    <div class="principal">
                        <div class="tabs">
                            <div class="tab-button-outer">
                                <ul id="tab-button">
                                    <li><a href="#tab01"><b>HISTORIAL DE CHATS</b></a></li>
                                    <li><a href="#tab02"><b>BORRADORES</b></a></li>                                    
                                </ul>
                            </div>
                            <div class="tab-select-outer">                              
                                <select id="tab-select">
                                    <option value="#tab01">HISTORIAL DE CHATS</option>
                                    <option value="#tab02">BORRADORES</option>                               
                                </select>
                            </div>

                            <div id="tab01" class="tab-contents">      
                                
                            </div>
                            <div id="tab02" class="tab-contents">
                                
                            </div>                           
                        </div>
                        
                    </div>
                    <div class="extra">
                        <div class="extraCont">
                            <h3 style="margin-bottom: 5px;">¿Necesitas ayuda?</h3>
                            <p style="margin-bottom: 10px;">
                                Inicia un nuevo chat para obtener ayuda de un personal administrativo o para aclarar alguna duda
                            </p>                            
                            <button class="crearChat">CREAR CHAT</button>                            
                        </div>
                    </div>
                    <div class="cerrarChat">
                        <img class="tacha" src="utileria/media/iconos/cruz.png" alt="alt">
                    </div>
                    <div class="abrirChat">
                        <img src="utileria/media/iconos/chat.png" alt="alt" title="Abrir chat" class="icono">                
                    </div>
                    <div class="chat">
                        <div class="headerChat">
                            <h3>NUEVO CHAT</h3>
                            <img src="utileria/media/iconos/cruz.png" id="cerrarBorrador" class="icono avion" alt="alt" title="Cerrar">
                            <img src="utileria/media/iconos/enviar.png" id="actualizarBorrador" class="icono avion" alt="alt" title="Enviar">
                            <img src="utileria/media/iconos/enviar.png" id="enviarChat" class="icono avion" alt="alt" title="Enviar">
                        </div>
                        <div class="contChat">
                            <div class="infoUser">
                                <img src="utileria/media/iconos/usuarioN.png" class="us" alt="alt">
                                <p><%=nombre%> &nbsp&nbsp&nbsp Boleta: <%=user%></p>                                
                            </div>
                            <form class="formChat">
                                <input id="aux" type="text" placeholder="Nah"/>
                                <input id="asunto" type="text" placeholder="Asunto" required maxlength="35"/>
                                <select id="problematica">
                                    <option value="" disabled selected>Tipo de problematica</option>
                                    <option value="Inscripcion">Inscripcion</option>
                                    <option value="Reincripciones">Reincripciones</option>
                                    <option value="ETS">ETS</option>
                                    <option value="ESPA">ESPA</option>
                                    <option value="Creditos">Creditos</option>
                                    <option value="Electivas">Electivas</option>
                                    <option value="Otro">Otro</option>
                                </select>
                                <textarea placeholder="Descripcion" id="descrip" required></textarea>
                            </form>                            
                        </div>
                    </div>
                </div>                
            </div>
        </div>             
        <script src="utileria/librerias/jquery3.6.1.js"></script>
        <script src="utileria/librerias/notify.min.js"></script>
        <script type="text/javascript">              
            
            $(".contNotif").load("tablaNotificaciones.jsp");
            $("#tab01").load("tablaHistorialChats.jsp");
            $("#tab02").load("tablaBorradores.jsp");
            
            //hace falta agregar cuando se marquen o se borren los mensajes el quitar la marca de nueva notificacion
            //y llamar a otro jsp para cambiar el estatus en o eliminar el tbody en caso de borrar
            
            /*TABS*/
            $(function() {
                var $tabButtonItem = $('#tab-button li'),
                    $tabSelect = $('#tab-select'),
                    $tabContents = $('.tab-contents'),
                    activeClass = 'is-active';

                $tabButtonItem.first().addClass(activeClass);
                $tabContents.not(':first').hide();

                $tabButtonItem.find('a').on('click', function(e) {
                    var target = $(this).attr('href');

                    $tabButtonItem.removeClass(activeClass);
                    $(this).parent().addClass(activeClass);
                    $tabSelect.val(target);
                    $tabContents.hide();
                    $(target).show();
                    e.preventDefault();
                });

                $tabSelect.on('change', function() {
                    var target = $(this).val(),
                        targetSelectNum = $(this).prop('selectedIndex');

                    $tabButtonItem.removeClass(activeClass);
                    $tabButtonItem.eq(targetSelectNum).addClass(activeClass);
                    $tabContents.hide();
                    $(target).show();
                });
            });
            
            /*ACTIVAR BURBUJA DE CHAT*/
            $('.crearChat').click(function (){
                $('.abrirChat').css("display", "flex");  
                $('.cerrarChat').css("display", "flex");  
            });
            
            /*AL CERRAR SE GUARDA EL CHAT EN BORRADORES, SOLO SI TIENE CONTENIDO*/
            $('.cerrarChat').click(function(){
                if(!($('.chat').is(":hidden")))
                    $('.chat').slideUp();
                    
                $('.abrirChat').css("display", "none");                
                $('.cerrarChat').css("display", "none");  
                //checamos si hay contenido en el formulario
                if(($('#asunto').val().length === 0) && ($('#descrip').val().length === 0) && ($('#problematica').val().trim() === '')){
                    
                }else if($("#asunto").val().length !== 0 || $("#descrip").val().length !== 0 || $('#problematica').val().trim() !== ''){
                    altaChat(2);
                    limpiarCampos();
                }
            });
            
            
            $('.abrirChat').click(function(){
                if ($('.chat').is(':hidden'))
                    $('.chat').slideDown();
                else{
                    $('.chat').slideUp();
                    //checamos si hay contenido en el formulario
                    if(($('#asunto').val().length === 0) && ($('#descrip').val().length === 0) && ($('#problematica').val().trim() === '')){

                    }else if($("#asunto").val().length !== 0 || $("#descrip").val().length !== 0 || $('#problematica').val().trim() !== ''){
                        altaChat(2);
                        limpiarCampos();
                    }
                }
            });
            
            $("#enviarChat").click(function(){
                //checamos si hay contenido en el formulario
                if(($('#asunto').val().length === 0) || ($('#descrip').val().length === 0) || ($('#problematica').val().trim() === '')){
                    $.notify("Rellene todos los campos antes de continuar", {position:"top center", className:"error"});
                }else{
                    altaChat(1);
                    limpiarCampos();                    
                }
            });
            
            /*PANEL DE BORRADORES*/
            $("#cerrarBorrador").click(function(){
                limpiarCampos();                
                $(".chat").slideUp();
                $("#cerrarBorrador").css("display", "none");
                $("#actualizarBorrador").css("display", "none");                
                $("#enviarChat").css("display", "block");                
            });
            
            $("#actualizarBorrador").click(function(){
                var ide = $("#aux").val();
                var asunto = $('#asunto').val();
                var descrip = $('#descrip').val();
                var prob = $('#problematica').val();
                
                if((asunto.length === 0) || (descrip.length === 0) || (prob.trim() === '')){
                    $.notify("Rellene todos los campos antes de continuar", {position:"top center", className:"error"});
                }else{                    
                    $.ajax({ //Comunicación jQuery hacia JSP
                        type: "GET",
                        url: "actualizarBorrador.jsp",
                        data: {id: ide, asunto:asunto, descripcion:descrip, problematica:prob},
                        success: function(msg){  
                            $.notify("Solicitud de chat enviada", {position:"top center", className:"info"});
                        }, error: function(xml,msg){
                            alert(msg);
                        }
                    });

                    limpiarCampos();                
                    $(".chat").slideUp();
                    $("#cerrarBorrador").css("display", "none");
                    $("#actualizarBorrador").css("display", "none");                
                    $("#enviarChat").css("display", "block");
                    /*Volvemos a cargar la pagina*/
                    location.reload(true);
                }
            });
             
            function altaChat(type){
                var asunto = $('#asunto').val();
                var descrip = $('#descrip').val();
                var prob = $('#problematica').val();
                var status = "";
                
                if(asunto === null)
                    asunto = "[Sin asunto]";
                if(descrip === null)
                    descrip = "[Sin descripción]";
                if(prob === null)
                    prob = "[Sin problemática]"; 
                else
                    prob = prob.trim();
                if(type === 1)
                    status = "En espera";
                else
                    status = "Borrador";               
                
                $.ajax({ //Comunicación jQuery hacia JSP
                    type: "GET",
                    url: "altaChat.jsp",
                    data: {asunto:asunto, descrip:descrip, tipo:type, user:<%=user%>, prob:prob, status:status},
                    success: function(msg){  
                        if(type === 1)
                            $.notify("Solicitud de chat enviada", {position:"top center", className:"info"});
                        else
                            $.notify("Elemento guardado en borradores", {position:"top center", className:"info"}); 
                    },
                    error: function(xml,msg){
                        alert(msg);
                    }
                });
            }
            
            function limpiarCampos(){
                $("#asunto").val("");
                $("#descrip").val("");
                $('#problematica').prop('selectedIndex',0);
            }
            
            function submitUserForm(){
                var response = grecaptcha.getResponse();
                let campo = document.getElementById("boleta");
                let valor = parseInt(campo.value);
                
                if(response.length == 0){
                    document.getElementById('g-recaptcha-error').innerHTML = '<span style="color: red;">Este campo es obligatorio</span>';
                    return false;
                }else{
                    if (!Number.isInteger(valor)) {
                        return false;
                    }else{
                        return true;                        
                    }
                }
            }
            
            function verifyCaptcha(){
                document.getElementById('g-recaptcha-error').innerHTML = "";
            }
            
            $('.icono.conf').click(function(){                
                if ($('.engrane').is(':hidden')){
                    if($('.campana').is(':hidden')){
                        $('.engrane').slideDown();
                    }else{
                        $('.campana').slideUp();
                        $('.nuevaNotif').css("display", "none");
                        $('.engrane').slideDown();                           
                    }
                }else{
                    $('.engrane').slideUp();
                }
            }); 
            
            $('.icono.notif').click(function(){     
                
                if ($('.campana').is(':hidden')){
                    if($('.engrane').is(':hidden')){
                        $('.campana').slideDown();                        
                    }else{
                        $('.engrane').slideUp();
                        $('.campana').slideDown();                            
                    }
                }else{
                    $('.campana').slideUp();
                    $('.nuevaNotif').css("display", "none");
                }
            }); 
            
            $('.icono2.der.cruz').click(function(){
                $('.icono2.der.cruz').css("display", "none");
                $('.menu').css("position", "fixed");
                $('.menu').addClass('hide');                
            });
            $('.icono.ham').click(function(){                
                if($(window).width() < 700){
                    $('.icono2.der.cruz').css("display", "block");
                    $('.menu').css("position", "absolute");
                    $('.menu').removeClass('hide');
                }else{
                    if($('.menu').hasClass('hide')){
                        $('.menu').removeClass('hide');                
                        $('.main').removeClass('wide');    
                    }else{
                        $('.menu').addClass('hide');                
                        $('.main').addClass('wide');                                            
                    }                                                                        
                }
            }); 
                        
            
            /* NOTIFICACIONES */
            $("#marcarLeido").click(function(){
                $.ajax({ //Comunicación jQuery hacia JSP
                    type: "GET",
                    url: "marcarNotifLeidas.jsp",
                    data: "",
                    success: function(msg){  
                        
                    },error: function(xml,msg){
                        alert(msg);
                    }
                });
                location.reload(true);/*Volvemos a cargar la pagina*/               
            });
            
            $("#borrarNotif").click(function(){
                $.ajax({ //Comunicación jQuery hacia JSP
                    type: "GET",
                    url: "eliminarNotificaciones.jsp",
                    data: "",
                    success: function(msg){  
                        $.notify("Notificaciones eliminadas", {position:"top center", className:"info"});
                    }, error: function(xml,msg){
                        alert(msg);
                    }
                });
                location.reload(true);/*Volvemos a cargar la pagina*/
            });
        </script>
    </body>
</html>

