<%-- 
    Document   : mainTramites
    Created on : 14 ene. 2023, 09:33:15
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
                background-image: url(utileria/media/fondoTramites.png);
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
                height: 274px;
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
                padding: 7px 15px;                
                transition: 0.4s;
            }
            button:hover{
                background-color: #262626;
            }
            form input, form select, form textarea {
                border-radius: 5px;
                font-family: "Bahnschrift Light";
                outline: 0;
                background:  #ccccff;
                width: 100%;
                border: 1px;                
                padding: 10px;
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
                width: 630px;
                height: 310px;
                background-color: whitesmoke;
                border-radius: 8px;
            }
            .extra{                
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
                position: fixed;                
                bottom: 0px;
                right: 60px;
                margin: 15px 15px;                
                height: 300px;
                width: 500px;
                background-color: #efeff5;
                display: none; 
                z-index: 230;      
                border-radius: 8px;
            }    
            .headerChat{  
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
            <p class="header_logo">TRÁMITES</p>            
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
                                    <li><a href="#tab01"><b>TRÁMITES</b></a></li>
                                    <li><a href="#tab02"><b>SEGUIMIENTO</b></a></li>                                    
                                </ul>
                            </div>
                            <div class="tab-select-outer">                              
                                <select id="tab-select">
                                    <option value="#tab01">TRÁMITES</option>
                                    <option value="#tab02">SEGUIMIENTO</option>                               
                                </select>
                            </div>

                            <div id="tab01" class="tab-contents">      
                                
                            </div>
                            <div id="tab02" class="tab-contents">
                                
                            </div>                           
                        </div>
                        
                    </div>                                        
                </div>                
            </div>
        </div>             
        <script src="utileria/librerias/jquery3.6.1.js"></script>
        <script src="utileria/librerias/notify.min.js"></script>
        <script type="text/javascript">              
            
            $(".contNotif").load("tablaNotificaciones.jsp");            
            $("#tab01").load("formularioTramite.jsp");
            $("#tab02").load("tablaTramites.jsp");
            
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
                        
        </script>
    </body>
</html>
