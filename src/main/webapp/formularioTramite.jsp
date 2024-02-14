<%-- 
    Document   : formularioTramite
    Created on : 14 ene. 2023, 09:41:24
    Author     : Dante
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.io.*"%>
<%
    Connection con = null;
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    con = DriverManager.getConnection( "jdbc:mysql://localhost:3306/bdatitos?autoReconnect=true&useSSL=false", "root", "s3mb3ll0");

    Statement statement = con.createStatement();                                        
    ResultSet rs = statement.executeQuery("SELECT creditos_totales,creditos_cursados,estado_academico,beca,promedio,boleta FROM alumno INNER JOIN sesion ON boleta = usuario INNER JOIN carrera on id_carrera_fk = id_carrera");                        
    rs.next();   
    double cursados = rs.getInt("creditos_cursados");
    double totales = rs.getInt("creditos_totales");
    double num = cursados/totales*100;
    double decimal = num%1;
    double res = num - decimal;
    int fin = (int)Math.round(res);
    fin = 100-fin;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            *{
                margin: 0px;
                padding: 0px;
            }
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
                margin: 0;
                padding: 10px;
                box-sizing: border-box;
                font-size: 14px;
            }               
            .progreso {
                position: relative;
                display: block;
                width: 350px;
                height: 30px;
                border: 0px;
                border-radius: 4px; 
                background: #6B1740;
            }
            .progreso:after {
                position: absolute;
                right: 0;
                top: 0px;
                display: block;
                content: "";
                height: 30px;
                width: <%=fin%>%;
                border-top-right-radius: 4px;
                border-bottom-right-radius: 4px;
                background-color: #ccccff;
            }
            .contenTramite{                  
                margin: 20px 20px;  
                color: black;
            }
            .flexConten{
                display:flex; 
                gap: 12px;
                align-items: center;
                padding: 5px 0;
            }            
            #tramite{
                width: 350px;
            }
        </style>
    </head>
    <body>
        <div class="contenTramite">
            <form>
                <div class="flexConten">
                    <p>Seleccione el trámite a realizar: </p>
                    <select id="tramite">
                        <option value="" disabled selected>Tipo de trámite</option>
                        <option value="1">Constancia de Estudios</option>
                        <option value="2">Constancia de Inscripción</option>
                        <option value="3">Constancia para Becas</option>
                        <option value="4">Boleta Global</option>
                        <option value="5">Boleta de Tres Firmas para Egreso</option>
                        <option value="6">Boleta de Tres Firmas para Certificado Parcial</option>
                        <option value="7">Boleta de Tres Firmas para Trámite personal</option>
                        <option value="8">Boleta de Tres Firmas para Beca</option>
                        <option value="9">Boleta de Tres Firmas para Excelencia Académica</option>
                        <option value="10">Boleta de Tres Firmas para Egreso subsecuente</option>
                    </select>                    
                </div>
                <br>                                
                <h3 style="float:left; margin-top:10px;">Información del alumno</h3>
                <br>                
                <br>                
                <div class="flexConten">
                    <p>Situación académica: <b><%=rs.getString("estado_academico")%>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</b></p>
                    <p>Créditos cursados: <b><%=rs.getInt("creditos_cursados")%></b>/<b><%=rs.getInt("creditos_totales")%></b></p>
                </div>
            </form>            
            <div  class="flexConten" >
                <p>Procentaje de créditos: </p>
                <div class="progreso"></div>
                <h2><%=fin%>%</h2>
            </div>                      
                <br>
            <div class="flexConten" style="justify-content: center;">
                <button id="soliTramite">ENVIAR SOLICITUD</button>                
            </div>
        </div>   
        <script src="utileria/librerias/jquery3.6.1.js"></script>
        <script src="utileria/librerias/notify.min.js"></script>
        <script>
            $("#soliTramite").click(function(){
                var tipo = $("#tramite").val().trim();
                if(tipo === "")
                    $.notify("Seleccione un tramite para continuar", {position:"top center", className:"error"});
                else{
                    if(tipo === "1" || tipo === "2" || tipo === "3" || tipo === "4" || tipo === "7"){/*tipoD*/
                        altaTramite(tipo);                        
                    }else if(tipo === "5" || tipo === "6" || tipo === "10"){/*tipoA Creditos*/
                        var cur = <%=cursados%>;
                        var tot = <%=totales%>;
                        if(tot > cur){
                            $.notify("Creditos insuficientes para este trámite", {position:"top center", className:"error"});
                        }else{                            
                            altaTramite(tipo);                            
                        }
                    }else if(tipo === "8"){/*tipoB Beca*/
                        var beca = <%=rs.getInt("beca")%>;
                        if(beca === 0){
                            $.notify("Necesitas ser becario para este trámite", {position:"top center", className:"error"});
                        }else{
                            altaTramite(tipo);                            
                        }
                    }else{/*tipoC Promedio*/
                        var prom = <%=rs.getInt("promedio")%>;
                        if(prom < 9){
                            $.notify("No cuentas con promedio suficiente para este tramite", {position:"top center", className:"error"});
                        }else{
                            altaTramite(tipo);                            
                        }
                    }
                }
                $('#tramite').prop('selectedIndex',0);
            });
            function altaTramite(type){
                $.ajax({ //Comunicación jQuery hacia JSP
                    type: "GET",
                    url: "altaTramites.jsp",
                    data: {tipo: type,boleta:<%=rs.getString("boleta")%>},
                    success: function(msg){  
                        $.notify("Solicitud de chat enviada", {position:"top center", className:"success"});
                    }, error: function(xml,msg){
                        alert(msg);
                    }
                });
            }
        </script>
    </body>
</html>
