<%@ page import="static com.proyecto.moviesplay.CircularServlet.lc" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="static com.proyecto.moviesplay.DoblementeEnlazadaServlet.lde" %>
<%@ page import="com.proyecto.moviesplay.Actores" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Stack" %>
<%@ page import="com.proyecto.moviesplay.AVLServlet" %>
<%@ page import="static com.proyecto.moviesplay.AVLServlet.root" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="images/favicon.png" type="image/x-icon">
    <title>Descripción | Movies </title>

    <!--=== Color de barra superior ====-->
    <meta name="theme-color" content="#131313"/>

    <!-- Inicio Meta Etiquetas para Redes Sociales y SEO -->
    <meta property="og:image" itemprop="image" content="images/favicon.png"/>
    <meta property="og:site_name" content="Movies | Peliculas y Series"/>
    <meta property="og:title" content="Movies | Peliculas y Series"/>
    <meta property="og:description" content="Disfruta de una gran variedad de películas, series, documentales y mucho más."/>
    <meta property="og:url" content="https://movies.ga/"/>
    <meta property="og:type" content="website"/>
    <meta name="description" content="Disfruta de una gran variedad de películas, series, documentales y mucho más.">
    <!-- Fin Meta Etiquetas para Redes Sociales y SEO -->

    <%-- Estilos --%>
    <link rel="stylesheet" href="css/style.css">

    <%-- Fuente de letras --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300&display=swap" rel="stylesheet">

    <%-- Iconos --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">

    <%-- Deslizador Principal --%>
    <link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css"/>

    <!-- Materialize Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">


    <style>
        .back {
            font-size: 35px;
        }

        @media screen and (max-width: 768px){
            .back {
                font-size: 30px;
            }
        }
    </style>
</head>
<body>

<header>
    <nav style="background-color: transparent; box-shadow: none">
        <div><span><a href="javascript:history.back()" class="btn waves-effect" style="background: transparent;"><i class="bi bi-arrow-left back"></i></a></span></div>
    </nav>
</header>

<main>

    <!-- ------------ -->
    <!-- De Cartelera -->
    <!-- ------------ -->

    <%

        Boolean encontrado = false;
        if(request.getParameter("idc")!=null){
    %>
    <section class="cartelera">
        <%
            int cont = 0;
            String videoTrailer = "";
            String star = "";

            if(lc.getCantidad() > 0){

                //1. ubicar el ultimo elemento de la lista
                lc.setActual(lc.getUltimo());

                while (cont < lc.getCantidad() && lc.getActual()!=null){

                    if(lc.getActual().getId().equals(request.getParameter("idc"))){

                        encontrado = true;

                        double res = Double.parseDouble(lc.getActual().getResenia());
                        //Estrellas
                        if(res>=1 && res<=1.2){
                            star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                        }else if(res>=1.3 && res<=1.9){
                            star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                        }else if(res>=2 && res<=2.2){
                            star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                        }else if(res>=2.3 && res<=2.9){
                            star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                        }else if(res>=3 && res<=3.2){
                            star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                        }else if(res>=3.3 && res<=3.9){
                            star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i>";
                        }else if(res>=4 && res<=4.2){
                            star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i>";
                        }else if(res>=4.3 && res<=4.9){
                            star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i>";
                        }else if(res>=5 && res<=5.2){
                            star = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i>";
                        }else if(res>=0 && res<=0.2){
                            star = "<i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                        }else if(res>=0.3 && res<=0.9){
                            star = "<i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                        }

                        if(lc.getActual().getTrailer()!=null) {

                            if (lc.getActual().getTrailer().equals("null") || lc.getActual().getTrailer().equals("")){
                                videoTrailer = lc.getActual().getImagen();

        %>

                                <div>
                                    <img class="video-fondo-desc" id="hero-video" title="Video" style="transform: scale(1.1)" src="<%= videoTrailer %>"/>
                                </div>

        <%
                            }else{
                                if (lc.getActual().getTrailer().contains("watch?v=")) {
                                    String separador = Pattern.quote("watch?v=");
                                    String[] videoParts = lc.getActual().getTrailer().split(separador);
                                    videoTrailer = videoParts[0] + "embed/" + videoParts[1] + "?playlist=" + videoParts[1] + "&autoplay=1&mute=1&loop=1&controls=0&rel=0";
                                } else if(lc.getActual().getTrailer().contains("embed/")) {
                                    String separador2 = Pattern.quote("embed/");
                                    String[] videoParts2 = lc.getActual().getTrailer().split(separador2);
                                    videoTrailer = videoParts2[0] + "embed/" + videoParts2[1] + "?playlist=" + videoParts2[1] + "&autoplay=1&mute=1&loop=1&controls=0&rel=0";
                                }
        %>
                                    <!--trailer video-->
                                    <div class="desktop-pelicula-fondo trailer-desc">
                                        <iframe class="video-fondo-desc" id="hero-video" title="Video" style="transform: scale(3.1)" src="<%= videoTrailer %>">
                                        </iframe>
                                    </div>

                                    <div class="movil-pelicula-fondo">
                                        <img class="video-fondo-desc" id="hero-video" title="Video" style="transform: scale(1.1)" src="<%= lc.getActual().getImagen() %>"/>
                                    </div>
        <%
                            }

                        }else{
                            videoTrailer = lc.getActual().getImagen();
                        %>

                            <div>
                                <img class="video-fondo-desc" id="hero-video" title="Video" style="transform: scale(1.1)" src="<%= videoTrailer %>"/>
                            </div>

                        <%
                            }
                        %>

        <div class="capa-sombra-desc wrap-break-word">
            <h4 style="font-weight:700; margin-bottom: -20px; font-size: 2rem; padding: 20px"><%= lc.getActual().getNombrePelicula() %></h4>
        </div>

        <section class="descripcion-pelicula">
            <div class="contenedor-portada-titulos">
                <div class="img-portada">
                    <img src="<%= lc.getActual().getImagen() %>" alt="Imagen de <%= lc.getActual().getNombrePelicula() %>">
                </div>

                <div class="contenedor-titulos wrap-break-word">
                                  <span class="nombre_pelicula">
                                    <%= lc.getActual().getNombrePelicula() %>
                                  </span>

                    <span class="nombre_original">
                                    <%= lc.getActual().getNombreOriginal() %>
                                  </span>

                    <span class="resenia">
                                    <%= star %> <%= lc.getActual().getResenia() %>
                                </span>
                </div>
            </div>

            <div class="contenedor-sinopsis">
                <p style="display: block"><%= lc.getActual().getSinopsis() %></p><br>
            </div>

            <%
                if(lc.getActual().getVideo()!=null){

                    if (!lc.getActual().getVideo().equals("null") && !lc.getActual().getVideo().equals("")){

            %>

                        <div class="contenedor-pelicula" >
                            <IFRAME SRC="<%= lc.getActual().getVideo() %>" class="contenedor-pelicula" FRAMEBORDER=0 MARGINWIDTH=0 MARGINHEIGHT=0 SCROLLING=NO WIDTH=100% allowfullscreen></IFRAME>
                        </div><br>

            <%
                    }
                }

                if(session.getAttribute("idadmin")!=null){
            %>

            <div class="botones-admin2">

                <!-- Modal Trigger -->
                <a class="waves-effect waves-light btn modal-trigger" title="Editar Película" href="#modificar<%= lc.getActual().getId() %>">
                    <i class="bi bi-pencil-square"></i>
                </a>

                <a class="btn waves-effect waves-light eliminar-btn modal-trigger" title="Eliminar" href="#eliminar<%= lc.getActual().getId() %>" style="background: red">
                    <i class="bi bi-trash3-fill"></i>
                </a>

                <!-- Modal Structure Edit -->
                <div id="modificar<%= lc.getActual().getId() %>" class="modal bottom-sheet" style="background: #131313">
                    <div class="modal-content">
                        <h4 class="titulo-form" style="display: flex; justify-content: center; background: linear-gradient(90deg, #1CB5E0 0%, #000851 100%); padding: 15px; border-radius: 1rem; text-align: center">
                            Modificar Detalles de la Película
                        </h4><br>
                        <p>Puedes editar a continuación todos los detalles de la película.</p><br>

                        <div class="row">
                            <form class="col s12" action="CircularServlet" method="post">
                                <div class="row">

                                    <input type="hidden" name="op" value="edit" />
                                    <input type="hidden" name="from" value="desc" />
                                    <input type="hidden" name="idcircular" value="<%= lc.getActual().getId() %>" />

                                    <div class="input-field col s6">
                                        <input id="nombre_pelicula" name="nombre_pelicula_n" type="text" class="validate" required value="<%= lc.getActual().getNombrePelicula() %>"/>
                                        <label for="nombre_pelicula">Nombre</label>
                                    </div>

                                    <div class="input-field col s6">
                                        <input id="nombre_original" name="nombre_original_n" type="text" class="validate" required value="<%= lc.getActual().getNombreOriginal() %>"/>
                                        <label for="nombre_original">Nombre original</label>
                                    </div>

                                    <div class="input-field col s12" style="display: flex; justify-content:center;">
                                        <p class="range-field">
                                            <label for="resenia">Indique la reseña. De 1 a 5 estrellas</label>
                                            <input type="range" id="resenia" name="resenia_n" min="0" max="5" step="0.5" required value="<%= lc.getActual().getResenia() %>"/>
                                        </p>
                                    </div>

                                    <div class="input-field col s12">
                                        <textarea id="sinopsis" name="sinopsis_n" class="materialize-textarea" style="color:#fff" required><%= lc.getActual().getSinopsis() %></textarea>
                                        <label for="sinopsis">Sinopsis (Descripción)</label>
                                    </div>

                                    <div class="input-field col s6">
                                        <input id="imagen" name="imagen_n" type="text" class="validate" title="Enlace de imagen" required value="<%= lc.getActual().getImagen() %>"/>
                                        <label for="imagen" title="Enlace de imagen">Imagen</label>
                                    </div>

                                    <div class="input-field col s6">
                                        <input id="video" name="video_n" type="text" class="validate" title="Enlace de video" value="<%= lc.getActual().getTrailer() %>"/>
                                        <label for="video" title="Enlace de video">Video trailer</label>
                                    </div>

                                    <div class="input-field col s12">
                                        <input id="pelicula" name="pelicula_n" type="text" class="validate" title="Enlace de la película completa" value="<%= lc.getActual().getVideo() %>"/>
                                        <label for="pelicula" title="Enlace de la película completa">Película completa</label>
                                    </div>

                                </div>

                                <div class="input-field col s12" style="display: flex; justify-content:center;">
                                    <button class="btn waves-effect waves-light" type="submit" style="background: #E50914;">
                                        Modificar Película
                                    </button>
                                </div>

                            </form>


                        </div>
                    </div>
                </div>

                <!-- Modal Structure Delete -->
                <div id="eliminar<%= lc.getActual().getId() %>" class="modal modal-fixed-footer" style="background: #131313; height: 18rem; overflow: auto; border-radius: 0.5rem">
                    <div class="modal-content">
                        <h4 style="display: flex; text-align: center; font-size: 1.5rem; background-color: #AA0000; padding: 15px; border-radius: 0.5rem">Eliminar Película <%= lc.getActual().getNombrePelicula() %> de la Cartelera </h4> <br>
                        <h6 style="text-align: center; font-size: 1.2rem">¿Está seguro que desea eliminar la película <%= lc.getActual().getNombreOriginal() %> de la cartelera?</h6>
                    </div>
                    <div class="modal-footer" style="background: #131313">
                        <a href="#!" class="modal-close waves-effect waves-green btn-flat" style="background-color: #005b9b; color: #ffffff; border-radius: .5rem;">Cancelar</a>
                        <a href="#!" class="waves-effect waves-green btn-flat" onclick="eliminarDeCircular(<%= lc.getActual().getId() %>)" style="background-color: red; color: #ffffff; border-radius: .5rem;">Aceptar</a>
                    </div>
                </div>

            </div>

            <%
                }

                if (lc.getActual().getRaiz()!=null){
            %>

            <!-- ----------------------->
            <!-- Actores de Cartelera -->
            <!-- ----------------------->
            <h4 style="font-weight:700; margin-bottom: -20px; font-size: 1.8rem; padding: 20px">Reparto</h4>
            <div class="carousel carousel2">

                <%
                    if(session.getAttribute("idadmin")!=null){
                %>

                <%--RECORRIDO PREORDEN DE LOS ACTORES DE LA CARTELERA--%>
                <%
                    root = lc.getActual().getRaiz();
                    if(root==null) return;
                    Stack<Actores> s = new Stack<>();
                    while (!s.isEmpty()||root!=null){
                        while(root!=null){

                %>
                                <div class="carousel-item actor-item tarjeta2"><img src="<%= root.getFotoActor() %>" loading="lazy" alt="<%= root.getNombreActor() %>">
                                    <a href="actordesc.jsp?idactor=<%= root.getId() %>"><span><%= root.getNombreActor() %></span></a>

                                    <div class="capa-desc2 blur-desc">

                                        <div class="botones-admin">
                                            <a class="btn waves-effect waves-light modal-trigger" title="Eliminar" href="#eliminarActor<%= root.getNombreActor() %>" style="background: red">
                                                <i class="bi bi-trash3-fill"></i>
                                            </a>

                                        </div>

                                    </div>

                                </div>
                <%

                            s.push(root);
                            root=root.getNodoIzq();
                        }
                        if(!s.isEmpty()){
                            Actores t = s.pop();
                            root=t.getNodoDer();
                        }
                    }


                }else{
                %>


                    <%--RECORRIDO PREORDEN DE LOS ACTORES DE LA CARTELERA--%>
                    <%
                        root = lc.getActual().getRaiz();
                        if(root==null) response.sendRedirect("./");
                        Stack<Actores> s = new Stack<>();
                        while (!s.isEmpty()||root!=null){
                            while(root!=null){

                    %>

                                    <a class="carousel-item actor-item" href="actordesc.jsp?idactor=<%= root.getId() %>"><img src="<%= root.getFotoActor() %>"> <span><%= root.getNombreActor() %></span></a>

                    <%

                                s.push(root);
                                root=root.getNodoIzq();
                            }
                            if(!s.isEmpty()){
                                Actores t = s.pop();
                                root=t.getNodoDer();
                            }
                        }

                    %>

                <%
                    }
                %>


            </div>

            <%
                if(session.getAttribute("idadmin")!=null){
            %>

            <%--BOTON ELIMINAR DE RECORRIDO PREORDEN DE LOS ACTORES DE LA CARTELERA--%>
            <%
                root = lc.getActual().getRaiz();
                if(root==null) return;
                Stack<Actores> s = new Stack<>();
                while (!s.isEmpty()||root!=null){
                    while(root!=null){

            %>

                        <!-- Modal Structure Delete -->
                        <div id="eliminarActor<%= root.getNombreActor() %>" class="modal modal-fixed-footer" style="background: #131313; height: 18rem; overflow: auto; border-radius: 0.5rem">
                            <div class="modal-content">
                                <h4 style="display: flex; text-align: center; font-size: 1.5rem; background-color: #AA0000; padding: 15px; border-radius: 0.5rem">Eliminar Actor <%= root.getNombreActor() %> del Reparto </h4> <br>
                                <h6 style="text-align: center; font-size: 1.2rem">¿Está seguro que desea eliminar al Actor <%= root.getNombreActor() %> del Reparto?</h6>
                            </div>
                            <div class="modal-footer" style="background: #131313">
                                <a href="#!" class="modal-close waves-effect waves-green btn-flat" style="background-color: #005b9b; color: #ffffff; border-radius: .5rem;">Cancelar</a>
                                <%
                                    application.setAttribute("nodoLista", lc.getActual());
                                    application.setAttribute("raizArbol", lc.getActual().getRaiz());
                                %>
                                <a href="#!" onclick="eliminarActor('<%= root.getNombreActor() %>','<%= lc.getActual().getId() %>')" class="waves-effect waves-green btn-flat" style="background-color: red; color: #ffffff; border-radius: .5rem;">Aceptar</a>
                            </div>
                        </div>

            <%


                        s.push(root);
                        root=root.getNodoIzq();
                    }
                    if(!s.isEmpty()){
                        Actores t = s.pop();
                        root=t.getNodoDer();
                    }
                }

            %>

            <%
                }
            %>


            <!-- -------------------------------->
            <!-- Árbol de actores en cartelera -->
            <!-- -------------------------------->
            <ul class="collapsible popout" style="width: 100%; max-width: 1200px">
                <li>
                    <h4 class="collapsible-header" style="font-weight:700; margin-bottom: -20px; font-size: 1.7rem; padding: 20px; background: #131313; color: #ffffff; border: none; display: flex; justify-content: center; align-items: center; border-radius: 0.75rem;">
                        <img src="https://www.clipartmax.com/png/full/238-2381156_computer-science-clip-art.png" alt="Tree" width="30">&nbsp;&nbsp;
                        <span>Árbol AVL de Actores </span>&nbsp;
                        <i class="bi bi-caret-down-fill" style="margin-top: 5px"></i>
                    </h4>
                    <div class="collapsible-body" style="background: #131313; color: #ffffff; border: none; width: 100%">

                        <div id="botones-zoom">
                            <div class="botones-zoom-container">
                                <i class="bi bi-search"></i>&nbsp;
                                <span id="zoom-porcentaje">ZOOM</span>&nbsp;
                                <button id="zoom-out" class="waves-effect" title="Zoom Out"><i class="bi bi-dash"></i></button>
                                <button id="zoom-in" class="waves-effect" title="Zoom In"><i class="bi bi-plus"></i></button>
                            </div>
                        </div>

                        <div id="arbol-container">

                            <%
                                if(session.getAttribute("idadmin")!=null){


                            // RECORRIDO PREORDEN DE LOS ACTORES DE LA CARTELERA

                                boolean isRaiz = true;
                                String estilos = "";
                                String flecha = "";
                                int ejeX = 0;
                                int ejeY = 0;
                                int tempX = 0;
                                int tempY = 0;
                                Stack<Integer> tempEjeX = new Stack<>();
                                Stack<Integer> tempEjeY = new Stack<>();
                                root = lc.getActual().getRaiz();
                                if(root==null) return;
                                Stack<Actores> s = new Stack<>();
                                while (!s.isEmpty()||root!=null){
                                    while(root!=null){

                                        if (isRaiz==true) {
                                            ejeX = 100;
                                            ejeY = 0;
                                            estilos = "margin-left: "+ejeX+"px; margin-top: "+ejeY+"px;";
                                            flecha = "f-left";
                                            isRaiz = false;
                                        }

                            %>

                                        <div class="actor-nodo" style="<%= estilos %>">

                                            <img src="<%= root.getFotoActor() %>" alt="<%= root.getNombreActor() %>" class="actor-nodo-img">
                                            <a href="actordesc.jsp?idactor=<%= root.getId() %>" class="actor-nodo-nombre">
                                                <span><%= root.getNombreActor() %></span>
                                            </a>

                                            <%
                                                if (flecha.equals("f-right")) {
                                            %>
                                                <div class="f-right"></div>
                                            <%
                                                }

                                                if (flecha.equals("f-left")) {
                                            %>

                                                <div class="f-left"></div>

                                            <%
                                                }
                                            %>

                                            <div class="capa-desc3">

                                                <div class="botones-admin">
                                                    <a class="btn waves-effect waves-light modal-trigger" title="Eliminar" href="#eliminarActor<%= root.getNombreActor() %>" style="background: red">
                                                        <i class="bi bi-trash3-fill"></i>
                                                    </a>
                                                </div>

                                            </div>


                                        </div>

                            <%
                                        tempEjeX.push(ejeX);
                                        tempEjeY.push(ejeY);

                                        s.push(root);
                                        root=root.getNodoIzq();

                                        if (root!=null) {
                                            ejeX = ejeX-300;
                                            ejeY = ejeY+30;
                                            estilos = "margin-left: "+ejeX+"px; margin-top: "+ejeY+"px;";
                                            flecha = "f-left";
                                        }
                                    }
                                    if(!s.isEmpty()){
                                        if (!tempEjeX.isEmpty()) {
                                            tempX = tempEjeX.pop();
                                            tempY = tempEjeY.pop();
                                        }

                                        Actores t = s.pop();
                                        root=t.getNodoDer();

                                        if (root!=null) {
                                            ejeX = tempX+300;
                                            ejeY = (tempY+180)*-1;
                                            estilos = "margin-left: "+ejeX+"px; margin-top: "+ejeY+"px;";
                                            flecha = "f-right";
                                        }
                                    }
                                }

                            }else{

                               // RECORRIDO PREORDEN DE LOS ACTORES DE LA CARTELERA
                                boolean isRaiz = true;
                                String estilos = "";
                                String flecha = "";
                                int ejeX = 0;
                                int ejeY = 0;
                                int tempEjeX = 0;
                                int tempEjeY = 0;
                                root = lc.getActual().getRaiz();
                                if(root==null) return;
                                Stack<Actores> s = new Stack<>();
                                while (!s.isEmpty()||root!=null){
                                    while(root!=null){

                                        if (isRaiz==true) {
                                            ejeX = 0;
                                            ejeY = 0;
                                            estilos = "transform: translate("+ejeX+"px,"+ejeY+"px);";
                                            flecha = "f-left";
                                            isRaiz = false;
                                        }

                            %>

                                            <div class="actor-nodo" style="<%= estilos %>">

                                                <a href="actordesc.jsp?idactor=<%= root.getId() %>">
                                                    <img src="<%= root.getFotoActor() %>" alt="<%= root.getNombreActor() %>" class="actor-nodo-img">
                                                    <span class="actor-nodo-nombre"><%= root.getNombreActor() %></span>
                                                </a>

                                                <%
                                                    if (flecha.equals("f-right")) {
                                                %>
                                                <div class="f-right"></div>
                                                <%
                                                    }

                                                    if (flecha.equals("f-left")) {
                                                %>

                                                <div class="f-left"></div>

                                                <%
                                                    }
                                                %>


                                            </div>


                            <%
                                        tempEjeX = ejeX;
                                        tempEjeY = ejeY;

                                        s.push(root);
                                        root=root.getNodoIzq();

                                        if (root!=null) {
                                            ejeX = ejeX-170;
                                            ejeY = ejeY+25;
                                            estilos = "transform: translate("+ejeX+"px,"+ejeY+"px);";
                                            flecha = "f-left";
                                        }
                                    }
                                    if(!s.isEmpty()){
                                        Actores t = s.pop();
                                        root=t.getNodoDer();

                                        if (root!=null) {
                                            ejeX = ejeX+170;
                                            ejeY = ejeY+25;
                                            estilos = "transform: translate("+ejeX+"px,"+ejeY+"px);";
                                            flecha = "f-right";
                                        }
                                    }
                                }


                                }

                                if(session.getAttribute("idadmin")!=null){
                            %>

                            <%--BOTON ELIMINAR DE RECORRIDO PREORDEN DE LOS ACTORES DE LA CARTELERA--%>
                            <%
                                root = lc.getActual().getRaiz();
                                if(root==null) return;
                                Stack<Actores> s = new Stack<>();
                                while (!s.isEmpty()||root!=null){
                                    while(root!=null){

                            %>

                            <!-- Modal Structure Delete -->
                            <div id="eliminarActor<%= root.getNombreActor() %>" class="modal modal-fixed-footer" style="background: #131313; height: 18rem; overflow: auto; border-radius: 0.5rem">
                                <div class="modal-content">
                                    <h4 style="text-align: center; font-size: 1.5rem; background-color: #AA0000; padding: 15px; border-radius: 0.5rem">Eliminar Actor <%= root.getNombreActor() %> del Reparto </h4> <br>
                                    <h6 style="text-align: center; font-size: 1.2rem">¿Está seguro que desea eliminar al Actor <%= root.getNombreActor() %> del Reparto?</h6>
                                </div>
                                <div class="modal-footer" style="background: #131313">
                                    <a href="#!" class="modal-close waves-effect waves-green btn-flat" style="background-color: #005b9b; color: #ffffff; border-radius: .5rem;">Cancelar</a>
                                    <%
                                        application.setAttribute("nodoLista", lc.getActual());
                                        application.setAttribute("raizArbol", lc.getActual().getRaiz());
                                    %>
                                    <a href="#!" id="eliminar-actor-btn-c" onclick="eliminarActor('<%= root.getNombreActor() %>','<%= lc.getActual().getId() %>')" class="waves-effect waves-green btn-flat" style="background-color: red; color: #ffffff; border-radius: .5rem;">Aceptar</a>
                                </div>
                            </div>

                            <%


                                        s.push(root);
                                        root=root.getNodoIzq();
                                    }
                                    if(!s.isEmpty()){
                                        Actores t = s.pop();
                                        root=t.getNodoDer();
                                    }
                                }

                            %>

                            <%
                                }
                            %>

                        </div>

                    </div>
                </li>
            </ul>
            <br><br><br>

        </section>

        <%
                        }
                        break;
                    }

                    //3. Identificar su siguiente nodo
                    lc.setActual(lc.getActual().getSiguiente());
                    cont++;

                }

            }

        %>
    </section>

    <%
        }
    %>

    <!-- ------------ -->
    <!-- De Populares -->
    <!-- ------------ -->

    <%
        if(request.getParameter("idlde")!=null){
    %>

    <section class="populares">

        <%
            String videoTrailer2 = "";
            String star2 = "";

            if(lde.getCantidad() > 0){

                //1. ubicar el primer elemento de la lista
                lde.setActual(lde.getPrimero());

                while (lde.getActual()!=null){

                    if(lde.getActual().getId().equals(request.getParameter("idlde"))){

                        encontrado = true;

                        double res2 = Double.parseDouble(lde.getActual().getResenia());
                        //Estrellas
                        if(res2>=1 && res2<=1.2){
                            star2 = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                        }else if(res2>=1.3 && res2<=1.9){
                            star2 = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                        }else if(res2>=2 && res2<=2.2){
                            star2 = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                        }else if(res2>=2.3 && res2<=2.9){
                            star2 = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                        }else if(res2>=3 && res2<=3.2){
                            star2 = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                        }else if(res2>=3.3 && res2<=3.9){
                            star2 = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i>";
                        }else if(res2>=4 && res2<=4.2){
                            star2 = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star\"></i>";
                        }else if(res2>=4.3 && res2<=4.9){
                            star2 = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-half\"></i>";
                        }else if(res2>=5 && res2<=5.2){
                            star2 = "<i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i><i class=\"bi bi-star-fill\"></i>";
                        }else if(res2>=0 && res2<=0.2){
                            star2 = "<i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                        }else if(res2>=0.3 && res2<=0.9){
                            star2 = "<i class=\"bi bi-star-half\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i><i class=\"bi bi-star\"></i>";
                        }

                        if(lde.getActual().getTrailer()!=null) {

                            if (lde.getActual().getTrailer().equals("null") || lde.getActual().getTrailer().equals("")){
                                videoTrailer2 = lde.getActual().getImagen();

        %>
                                <div>
                                    <img class="video-fondo-desc" id="hero-video" title="Video" style="transform: scale(1.1)" src="<%= videoTrailer2 %>"/>
                                </div>
        <%
                            }else{

                                if (lde.getActual().getTrailer().contains("watch?v=")) {
                                    String separador = Pattern.quote("watch?v=");
                                    String[] videoParts = lde.getActual().getTrailer().split(separador);
                                    videoTrailer2 = videoParts[0] + "embed/" + videoParts[1] + "?playlist=" + videoParts[1] + "&autoplay=1&mute=1&loop=1&controls=0&rel=0";
                                } else if(lde.getActual().getTrailer().contains("embed/")) {
                                    String separador2 = Pattern.quote("embed/");
                                    String[] videoParts2 = lde.getActual().getTrailer().split(separador2);
                                    videoTrailer2 = videoParts2[0] + "embed/" + videoParts2[1] + "?playlist=" + videoParts2[1] + "&autoplay=1&mute=1&loop=1&controls=0&rel=0";
                                }

        %>
                                <!--trailer video-->
                                <div class="desktop-pelicula-fondo trailer-desc">
                                    <iframe class="video-fondo-desc" id="hero-video" title="Video" style="transform: scale(3.1)" src="<%= videoTrailer2 %>">
                                    </iframe>
                                </div>

                                <div class="movil-pelicula-fondo">
                                    <img class="video-fondo-desc" id="hero-video" title="Video" style="transform: scale(1.1)" src="<%= lde.getActual().getImagen() %>"/>
                                </div>

        <%
                            }

                    }else{
                        videoTrailer2 = lde.getActual().getImagen();
        %>

                        <div>
                            <img class="video-fondo-desc" id="hero-video" title="Video" style="transform: scale(1.1)" src="<%= videoTrailer2 %>"/>
                        </div>

        <%
                    }
        %>


        <div class="capa-sombra-desc">
            <h4 style="font-weight:700; margin-bottom: -20px; font-size: 2rem; padding: 20px"><%= lde.getActual().getNombrePelicula() %></h4>
        </div>

        <section class="descripcion-pelicula">
            <div class="contenedor-portada-titulos">
                <div class="img-portada">
                    <img src="<%= lde.getActual().getImagen() %>" alt="Imagen de <%= lde.getActual().getNombrePelicula() %>">
                </div>

                <div class="contenedor-titulos">
                                 <span class="nombre_pelicula">
                                    <%= lde.getActual().getNombrePelicula() %>
                                 </span>

                    <span class="nombre_original">
                                    <%= lde.getActual().getNombreOriginal() %>
                                </span>

                    <span class="resenia">
                                    <%= star2 %> <%= lde.getActual().getResenia() %>
                                  </span>
                </div>
            </div>

            <div class="contenedor-sinopsis">
                <p><%= lde.getActual().getSinopsis() %></p><br>
            </div>

            <%
                if(lde.getActual().getVideo()!=null){

                    if (!lde.getActual().getVideo().equals("null") && !lde.getActual().getVideo().equals("")){

            %>

                        <div class="contenedor-pelicula" >
                            <IFRAME SRC="<%= lde.getActual().getVideo() %>" class="contenedor-pelicula" FRAMEBORDER=0 MARGINWIDTH=0 MARGINHEIGHT=0 SCROLLING=NO WIDTH=100% allowfullscreen></IFRAME>
                        </div><br>

            <%
                    }
                }

                if(session.getAttribute("idadmin")!=null){
            %>

            <div class="botones-admin2">

                <!-- Modal Trigger -->
                <a class="waves-effect waves-light btn modal-trigger" title="Editar Película" href="#modificar<%= lde.getActual().getId() %>">
                    <i class="bi bi-pencil-square"></i>
                </a>

                <a class="btn waves-effect waves-light eliminar-btn modal-trigger" title="Eliminar" href="#eliminar<%= lde.getActual().getId() %>" style="background: red">
                    <i class="bi bi-trash3-fill"></i>
                </a>

                <!-- Modal Structure Edit -->
                <div id="modificar<%= lde.getActual().getId() %>" class="modal bottom-sheet" style="background: #131313">
                    <div class="modal-content">
                        <h4 class="titulo-form" style="background: linear-gradient(90deg, #1CB5E0 0%, #000851 100%); padding: 15px; border-radius: 1rem; text-align: center">
                            Modificar Detalles de la Película
                        </h4><br>
                        <p>Puedes editar a continuación todos los detalles de la película.</p><br>

                        <div class="row">
                            <form class="col s12" action="DoblementeEnlazadaServlet" method="post">
                                <div class="row">

                                    <input type="hidden" name="op" value="edit" />
                                    <input type="hidden" name="from" value="desc" />
                                    <input type="hidden" name="idlde" value="<%= lde.getActual().getId() %>" />

                                    <div class="input-field col s6">
                                        <input id="nombre_pelicula" name="nombre_pelicula_n" type="text" class="validate" required value="<%= lde.getActual().getNombrePelicula() %>"/>
                                        <label for="nombre_pelicula">Nombre</label>
                                    </div>

                                    <div class="input-field col s6">
                                        <input id="nombre_original" name="nombre_original_n" type="text" class="validate" required value="<%= lde.getActual().getNombreOriginal() %>"/>
                                        <label for="nombre_original">Nombre original</label>
                                    </div>

                                    <div class="input-field col s12" style="display: flex; justify-content:center;">
                                        <p class="range-field">
                                            <label for="resenia">Indique la reseña. De 1 a 5 estrellas</label>
                                            <input type="range" id="resenia" name="resenia_n" min="0" max="5" step="0.5" required value="<%= lde.getActual().getResenia() %>"/>
                                        </p>
                                    </div>

                                    <div class="input-field col s12">
                                        <textarea id="sinopsis" name="sinopsis_n" class="materialize-textarea" style="color:#fff" required><%= lde.getActual().getSinopsis() %></textarea>
                                        <label for="sinopsis">Sinopsis (Descripción)</label>
                                    </div>

                                    <div class="input-field col s6">
                                        <input id="imagen" name="imagen_n" type="text" class="validate" title="Enlace de imagen" required value="<%= lde.getActual().getImagen() %>"/>
                                        <label for="imagen" title="Enlace de imagen">Imagen</label>
                                    </div>

                                    <div class="input-field col s6">
                                        <input id="video" name="video_n" type="text" class="validate" title="Enlace de video" value="<%= lde.getActual().getTrailer() %>"/>
                                        <label for="video" title="Enlace de video">Video trailer</label>
                                    </div>

                                    <div class="input-field col s12">
                                        <input id="pelicula" name="pelicula_n" type="text" class="validate" title="Enlace de la película completa" value="<%= lde.getActual().getVideo() %>"/>
                                        <label for="pelicula" title="Enlace de la película completa">Película completa</label>
                                    </div>

                                </div>

                                <div class="input-field col s12" style="display: flex; justify-content:center;">
                                    <button class="btn waves-effect waves-light" type="submit" style="background: #E50914;">
                                        Modificar Película
                                    </button>
                                </div>

                            </form>


                        </div>
                    </div>
                </div>

                <!-- Modal Structure Delete -->
                <div id="eliminar<%= lde.getActual().getId() %>" class="modal modal-fixed-footer" style="background: #131313; height: 18rem; overflow: auto; border-radius: 0.5rem">
                    <div class="modal-content">
                        <h4 style="text-align: center; font-size: 1.5rem; background-color: #AA0000; padding: 15px; border-radius: 0.5rem">Eliminar Película <%= lde.getActual().getNombrePelicula() %> de la Cartelera </h4> <br>
                        <h6 style="text-align: center; font-size: 1.2rem">¿Está seguro que desea eliminar la película <%= lde.getActual().getNombreOriginal() %> de la cartelera?</h6>
                    </div>
                    <div class="modal-footer" style="background: #131313">
                        <a href="#!" class="modal-close waves-effect waves-green btn-flat" style="background-color: #005b9b; color: #ffffff; border-radius: .5rem;">Cancelar</a>
                        <a href="#!" class="waves-effect waves-green btn-flat" onclick="eliminarDeLde(<%= lde.getActual().getId() %>)" style="background-color: red; color: #ffffff; border-radius: .5rem;">Aceptar</a>
                    </div>
                </div>

            </div>

            <%
                }

                if (lde.getActual().getRaiz()!=null){
            %>



            <!-- ----------------------->
            <!-- Actores de Populares -->
            <!-- ----------------------->
            <h4 style="font-weight:700; margin-bottom: -20px; font-size: 1.8rem; padding: 20px">Reparto</h4>
            <div class="carousel carousel2">

                <%
                    if(session.getAttribute("idadmin")!=null){
                %>

                <%--RECORRIDO PREORDEN DE LOS ACTORES DE POPULARES--%>
                <%
                    root = lde.getActual().getRaiz();
                    if(root==null) return;
                    Stack<Actores> s = new Stack<>();
                    while (!s.isEmpty()||root!=null){
                        while(root!=null){

                %>
                                <div class="carousel-item actor-item tarjeta2"><img src="<%= root.getFotoActor() %>" loading="lazy" alt="<%= root.getNombreActor() %>">
                                    <a href="actordesc.jsp?idactor=<%= root.getId() %>"><span><%= root.getNombreActor() %></span></a>

                                    <div class="capa-desc2 blur-desc">

                                        <div class="botones-admin">
                                            <a class="btn waves-effect waves-light modal-trigger" title="Eliminar" href="#eliminarActor<%= root.getNombreActor() %>" style="background: red">
                                                <i class="bi bi-trash3-fill"></i>
                                            </a>

                                        </div>

                                    </div>

                                </div>
                <%

                            s.push(root);
                            root=root.getNodoIzq();
                        }
                        if(!s.isEmpty()){
                            Actores t = s.pop();
                            root=t.getNodoDer();
                        }
                    }


                }else{
                %>


                <%--RECORRIDO PREORDEN DE LOS ACTORES DE POPULARES--%>
                <%
                    root = lde.getActual().getRaiz();
                    if(root==null) return;
                    Stack<Actores> s = new Stack<>();
                    while (!s.isEmpty()||root!=null){
                        while(root!=null){

                %>
                                <a class="carousel-item actor-item" href="actordesc.jsp?idactor=<%= root.getId() %>"><img src="<%= root.getFotoActor() %>"> <span><%= root.getNombreActor() %></span></a>
                <%

                            s.push(root);
                            root=root.getNodoIzq();
                        }
                        if(!s.isEmpty()){
                            Actores t = s.pop();
                            root=t.getNodoDer();
                        }
                    }

                %>

                <%
                    }
                %>


            </div>


            <%
                if(session.getAttribute("idadmin")!=null){
            %>

            <%--BOTON ELIMINAR DE RECORRIDO PREORDEN DE LOS ACTORES DE POPULARES--%>
            <%
                root = lde.getActual().getRaiz();
                if(root==null) return;
                Stack<Actores> s = new Stack<>();
                while (!s.isEmpty()||root!=null){
                    while(root!=null){

            %>
                            <!-- Modal Structure Delete -->
                            <div id="eliminarActor<%= root.getNombreActor() %>" class="modal modal-fixed-footer" style="background: #131313; height: 18rem; overflow: auto; border-radius: 0.5rem">
                                <div class="modal-content">
                                    <h4 style="text-align: center; font-size: 1.5rem; background-color: #AA0000; padding: 15px; border-radius: 0.5rem">Eliminar Actor <%= root.getNombreActor() %> del Reparto </h4> <br>
                                    <h6 style="text-align: center; font-size: 1.2rem">¿Está seguro que desea eliminar al Actor <%= root.getNombreActor() %> del Reparto?</h6>
                                </div>
                                <div class="modal-footer" style="background: #131313">
                                    <a href="#!" class="modal-close waves-effect waves-green btn-flat" style="background-color: #005b9b; color: #ffffff; border-radius: .5rem;">Cancelar</a>
                                    <%
                                        application.setAttribute("nodoLista", lde.getActual());
                                        application.setAttribute("raizArbol", lde.getActual().getRaiz());
                                    %>
                                    <a href="#!" id="eliminar-actor-btn-lde" onclick="eliminarActor('<%= root.getNombreActor() %>','<%= lde.getActual().getId() %>')" class="waves-effect waves-green btn-flat" style="background-color: red; color: #ffffff; border-radius: .5rem;">Aceptar</a>
                                </div>
                            </div>
            <%

                        s.push(root);
                        root=root.getNodoIzq();
                    }
                    if(!s.isEmpty()){
                        Actores t = s.pop();
                        root=t.getNodoDer();
                    }
                }

            %>


            <%
                }
            %>


            <!-- -------------------------------->
            <!-- Árbol de actores en populares -->
            <!-- -------------------------------->
            <ul class="collapsible popout" style="width: 100%; max-width: 1200px">
                <li>
                    <h4 class="collapsible-header" style="font-weight:700; margin-bottom: -20px; font-size: 1.7rem; padding: 20px; background: #131313; color: #ffffff; border: none; display: flex; justify-content: center; align-items: center; border-radius: 0.75rem;">
                        <img src="https://www.clipartmax.com/png/full/238-2381156_computer-science-clip-art.png" alt="Tree" width="30">&nbsp;&nbsp;
                        <span>Árbol AVL de Actores </span>&nbsp;
                        <i class="bi bi-caret-down-fill" style="margin-top: 5px"></i>
                    </h4>
                    <div class="collapsible-body" style="background: #131313; color: #ffffff; border: none; width: 100%">

                        <div id="botones-zoom">
                            <div class="botones-zoom-container">
                                <i class="bi bi-search"></i>&nbsp;
                                <span id="zoom-porcentaje">ZOOM</span>&nbsp;
                                <button id="zoom-out" class="waves-effect" title="Zoom Out"><i class="bi bi-dash"></i></button>
                                <button id="zoom-in" class="waves-effect" title="Zoom In"><i class="bi bi-plus"></i></button>
                            </div>
                        </div>

                        <div id="arbol-container">

                            <%
                                if(session.getAttribute("idadmin")!=null){


                                    // RECORRIDO PREORDEN DE LOS ACTORES DE POPULARES

                                    boolean isRaiz = true;
                                    String estilos = "";
                                    String flecha = "";
                                    int ejeX = 0;
                                    int ejeY = 0;
                                    int tempEjeX = 0;
                                    int tempEjeY = 0;
                                    root = lde.getActual().getRaiz();
                                    if(root==null) return;
                                    Stack<Actores> s = new Stack<>();
                                    while (!s.isEmpty()||root!=null){
                                        while(root!=null){

                                            if (isRaiz==true) {
                                                ejeX = 0;
                                                ejeY = 0;
                                                estilos = "transform: translate("+ejeX+"px,"+ejeY+"px);";
                                                flecha = "f-left";
                                                isRaiz = false;
                                            }

                            %>

                                            <div class="actor-nodo" style="<%= estilos %>">

                                                <img src="<%= root.getFotoActor() %>" alt="<%= root.getNombreActor() %>" class="actor-nodo-img">
                                                <a href="actordesc.jsp?idactor=<%= root.getId() %>" class="actor-nodo-nombre">
                                                    <span><%= root.getNombreActor() %></span>
                                                </a>

                                                <%
                                                    if (flecha.equals("f-right")) {
                                                %>
                                                <div class="f-right"></div>
                                                <%
                                                    }

                                                    if (flecha.equals("f-left")) {
                                                %>

                                                <div class="f-left"></div>

                                                <%
                                                    }
                                                %>

                                                <div class="capa-desc3">

                                                    <div class="botones-admin">
                                                        <a class="btn waves-effect waves-light modal-trigger" title="Eliminar" href="#eliminarActor<%= root.getNombreActor() %>" style="background: red">
                                                            <i class="bi bi-trash3-fill"></i>
                                                        </a>
                                                    </div>

                                                </div>


                                            </div>


                            <%
                                        tempEjeX = ejeX;
                                        tempEjeY = ejeY;

                                        s.push(root);
                                        root=root.getNodoIzq();

                                        if (root!=null) {
                                            ejeX = ejeX-170;
                                            ejeY = ejeY+25;
                                            estilos = "transform: translate("+ejeX+"px,"+ejeY+"px);";
                                            flecha = "f-left";
                                        }
                                    }
                                    if(!s.isEmpty()){
                                        Actores t = s.pop();
                                        root=t.getNodoDer();

                                        if (root!=null) {
                                            ejeX = ejeX+170;
                                            ejeY = ejeY+25;
                                            estilos = "transform: translate("+ejeX+"px,"+ejeY+"px);";
                                            flecha = "f-right";
                                        }
                                    }
                                }

                            }else{

                                // RECORRIDO PREORDEN DE LOS ACTORES DE POPULARES
                                boolean isRaiz = true;
                                String estilos = "";
                                String flecha = "";
                                int ejeX = 0;
                                int ejeY = 0;
                                int tempEjeX = 0;
                                int tempEjeY = 0;
                                root = lde.getActual().getRaiz();
                                if(root==null) return;
                                Stack<Actores> s = new Stack<>();
                                while (!s.isEmpty()||root!=null){
                                    while(root!=null){

                                        if (isRaiz==true) {
                                            ejeX = 0;
                                            ejeY = 0;
                                            estilos = "transform: translate("+ejeX+"px,"+ejeY+"px);";
                                            flecha = "f-left";
                                            isRaiz = false;
                                        }

                            %>

                            <div class="actor-nodo" style="<%= estilos %>">

                                <a href="actordesc.jsp?idactor=<%= root.getId() %>">
                                    <img src="<%= root.getFotoActor() %>" alt="<%= root.getNombreActor() %>" class="actor-nodo-img">
                                    <span class="actor-nodo-nombre"><%= root.getNombreActor() %></span>
                                </a>

                                <%
                                    if (flecha.equals("f-right")) {
                                %>
                                <div class="f-right"></div>
                                <%
                                    }

                                    if (flecha.equals("f-left")) {
                                %>

                                <div class="f-left"></div>

                                <%
                                    }
                                %>


                            </div>


                            <%
                                            tempEjeX = ejeX;
                                            tempEjeY = ejeY;

                                            s.push(root);
                                            root=root.getNodoIzq();

                                            if (root!=null) {
                                                ejeX = ejeX-170;
                                                ejeY = ejeY+25;
                                                estilos = "transform: translate("+ejeX+"px,"+ejeY+"px);";
                                                flecha = "f-left";
                                            }
                                        }
                                        if(!s.isEmpty()){
                                            Actores t = s.pop();
                                            root=t.getNodoDer();

                                            if (root!=null) {
                                                ejeX = ejeX+170;
                                                ejeY = ejeY+25;
                                                estilos = "transform: translate("+ejeX+"px,"+ejeY+"px);";
                                                flecha = "f-right";
                                            }
                                        }
                                    }


                                }
                            %>

                            <%
                                if(session.getAttribute("idadmin")!=null){
                            %>

                            <%--BOTON ELIMINAR DE RECORRIDO PREORDEN DE LOS ACTORES DE POPULARES--%>
                            <%
                                root = lde.getActual().getRaiz();
                                if(root==null) return;
                                Stack<Actores> s = new Stack<>();
                                while (!s.isEmpty()||root!=null){
                                    while(root!=null){

                            %>

                            <!-- Modal Structure Delete -->
                            <div id="eliminarActor<%= root.getNombreActor() %>" class="modal modal-fixed-footer" style="background: #131313; height: 18rem; overflow: auto; border-radius: 0.5rem">
                                <div class="modal-content">
                                    <h4 style="text-align: center; font-size: 1.5rem; background-color: #AA0000; padding: 15px; border-radius: 0.5rem">Eliminar Actor <%= root.getNombreActor() %> del Reparto </h4> <br>
                                    <h6 style="text-align: center; font-size: 1.2rem">¿Está seguro que desea eliminar al Actor <%= root.getNombreActor() %> del Reparto?</h6>
                                </div>
                                <div class="modal-footer" style="background: #131313">
                                    <a href="#!" class="modal-close waves-effect waves-green btn-flat" style="background-color: #005b9b; color: #ffffff; border-radius: .5rem;">Cancelar</a>
                                    <%
                                        application.setAttribute("nodoLista", lde.getActual());
                                        application.setAttribute("raizArbol", lde.getActual().getRaiz());
                                    %>
                                    <a href="#!" id="eliminar-actor-btn-c" onclick="eliminarActor('<%= root.getNombreActor() %>','<%= lde.getActual().getId() %>')" class="waves-effect waves-green btn-flat" style="background-color: red; color: #ffffff; border-radius: .5rem;">Aceptar</a>
                                </div>
                            </div>

                            <%


                                        s.push(root);
                                        root=root.getNodoIzq();
                                    }
                                    if(!s.isEmpty()){
                                        Actores t = s.pop();
                                        root=t.getNodoDer();
                                    }
                                }

                            %>

                            <%
                                }
                            %>

                        </div>

                    </div>
                </li>
            </ul>
            <br><br><br>


        </section>

        <%
                        }
                        break;
                    }

                    //3. Identificar su siguiente nodo
                    lde.setActual(lde.getActual().getSiguiente());

                }

            }

        %>

    </section>

    <%
        }
    %>

    <%
        if(encontrado == false){
            response.sendRedirect("./");
        }
    %>

</main>

<footer class="page-footer wrap-break-word" style="background: #131313">
    <div class="container">
        <div class="row">
            <div class="col l6 s12">
                <h5 class="white-text">Movies</h5>
                <p class="grey-text text-lighten-4">Peliculas y series. Plataforma de consulta de películas.</p>
            </div>
            <div class="col l4 offset-l2 s12">
                <h5 class="white-text">Desarrolladores</h5>
                <ul>
                    <li><a class="grey-text text-lighten-3" href="#!">7690-20-14576 Jeison Roblero</a></li>
                    <li><a class="grey-text text-lighten-3" href="#!">7690-20-26003 Pablo Garcia</a></li>

                </ul>
            </div>
        </div>
    </div>
    <div class="footer-copyright">
        <div class="container">
            © 2022 Copyright Movies
            <a class="grey-text text-lighten-4 right" href="#!">Más información</a>
        </div>
    </div>
</footer>

<!-- Initialize Swiper -->
<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script src="./js/app.js"></script>

<!-- Materialize Compiled and minified JavaScript -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

<script>
    // Constantes
    const zoomOut = document.getElementById('zoom-out');
    const zoomIn = document.getElementById('zoom-in');
    const arbolContainer = document.getElementById('arbol-container');

    //Modal agregar peliculas
    document.addEventListener('DOMContentLoaded', function() {
        var elems = document.querySelectorAll('.modal');
        var instances = M.Modal.init(elems);
    });

    // Swiper Actores
    document.addEventListener('DOMContentLoaded', function() {
        var elems2 = document.querySelectorAll('.carousel2');
        var instances2 = M.Carousel.init(elems2, {
            dist: 0,
            padding: 40,
            shift: 20,
            duration: 200,
        });
    });

    // Collapsible
    document.addEventListener('DOMContentLoaded', function() {
        var elems = document.querySelectorAll('.collapsible');
        var instances = M.Collapsible.init(elems, {
            onOpenStart: () => {
                localStorage.setItem("collapsibleOpen", "true");
            },
            onCloseStart: () => {
                localStorage.setItem("collapsibleOpen", "false");
            }
        });

        if (localStorage.getItem("collapsibleOpen") === "true"){
            var instance = instances[0];
            instance.open();
        } else {
            var instance = instances[0];
            instance.close();
        }

    });

    var zoom=1;

    zoomIn.addEventListener("click", () => {
        zoom+=.10;
        resize();
    })

    zoomOut.addEventListener("click", () => {
        if(zoom>0.2) {
            zoom-=.10;
            resize();
        }
    })

    function resize() {
        arbolContainer.style.zoom=zoom;
        document.getElementById("zoom-porcentaje").innerHTML=parseInt(zoom.toFixed(2)*100)+"%";
    }

</script>
</body>
</html>