<%@ page language="java" import="java.lang.*" %>
<%@ page import="static com.proyecto.moviesplay.CircularServlet.lc" %>
<%@ page import="static com.proyecto.moviesplay.DoblementeEnlazadaServlet.lde" %>
<%@ page import="static com.proyecto.moviesplay.CircularServlet.flagAgregado" %>
<%@ page import="static com.proyecto.moviesplay.DoblementeEnlazadaServlet.flagAgregadoP" %>
<%@ page import="static com.proyecto.moviesplay.AVLServlet.*" %>
<%@ page import="static com.proyecto.moviesplay.AVLServlet.flagAgregadoA" %>
<%@ page import="java.util.Stack" %>
<%@ page import="com.proyecto.moviesplay.*" %>
<%@ page import="static com.proyecto.moviesplay.ObtenerDatosServlet.datosObtenidos" %>
<%@ page import="static com.proyecto.moviesplay.ObtenerDatosServlet.*" %>

<% request.setCharacterEncoding("UTF-8"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="UTF-8"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="images/favicon.png" type="image/x-icon">
    <title>Movies | Mira tus Películas y Series Favoritas En Un Solo Lugar</title>

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

    <%-- Estilos extras implementados como prioridad --%>
    <style>
        :root{
            --tamanio-buscador: 400px;
        }

        .search-btn1 {
            transition: 0.5s ease;
        }

        .toggle-search-btn1 {
            transform: translateX(-400px);
        }

        .buscador-container {
            background: rgba(0, 0, 0, 0.88);
            backdrop-filter: blur(30px);
            border-radius: 0.5rem;
            padding: 0;
            height: 3.5rem;
            position: absolute;
            width: var(--tamanio-buscador);
            right: 11rem;
            top: 3.8px;
            display: flex;
            align-items: center;
            transform: translateX(150%);
            transition: 0.3s ease;
        }

        .toggle-search {
            transform: translateX(0%);
        }

        .buscador {
            display:flex;
        }

        .back-search {
            margin-top: -3.5px;
            color: #fff;
            cursor: pointer;
        }

        .clean-input {
            position: absolute;
            margin-top: -3.5px;
            right: -32px;
            color: #fff;
            cursor: pointer;
        }

        #search {
            background: transparent;
            height: 3.5rem;
            color: #fff;
            border-radius: 0.5rem;
            width: calc(var(--tamanio-buscador) - 110px);
            transition: 0.5s ease;
        }

        .add-mc {
            margin-top: -4px;
        }

        <% if (datosObtenidos) { %>
            #window-d {
                display: none;
            }
        <% } %>

        @media screen and (max-width: 768px){

            :root{
                --tamanio-buscador: 100%;
            }

            .buscador-container {
                right: 0;
                width: var(--tamanio-buscador);
                z-index: 110;
                height: 4.5rem;
                top: 0;
                border-radius: 0;
            }

            #search {
                height: 4.5rem;
                width: 73vw;
            }

            .back-search {
                margin-top: 4.5px;
            }

            .clean-input {
                margin-top: 4.5px;
            }

            .add-mc {
                margin-top: -30px;
            }

        }
    </style>

</head>

<body>

<header>
    <nav class="wrap-break-word" style="background-color: transparent; box-shadow: none">
        <div class="logo"><span><a href="./" class="wrap-break-word">Movies</a></span></div>
        <div class="menu">

            <ul class="menu-izquierdo">
                <li><a href="./">Inicio</a></li>
                <li><a href="./">Series de TV</a></li>
                <li><a href="./">Peliculas</a></li>
            </ul>

            <ul class="menu-derecho">

                <%
                    if(session.getAttribute("idadmin")!=null || session.getAttribute("idusuario")!=null){
                %>
                <li><a href="./" title="Notificaciones"><i class="bi bi-bell-fill"></i></a></li>
                <%
                }else{
                %>
                <li><a href="login.jsp" title="Notificaciones"><i class="bi bi-bell-slash-fill"></i></a></li>
                <%
                    }
                %>

                <%
                    if(session.getAttribute("idadmin")==null && session.getAttribute("idusuario")==null){
                %>
                <li><a href="login.jsp" title="Iniciar Sesión"><i class="bi bi-person-circle"></i></a></li>
                <%
                    }
                %>


                <%
                    if(session.getAttribute("idadmin")!=null || session.getAttribute("idusuario")!=null){
                %>
                <li><a href="logout.jsp" title="Cerrar Sesión"><i class="bi bi-box-arrow-right"></i></a></li>
                <%
                    }
                %>

            </ul>

        </div>


        <div class="buscador-derecho">
            <ul>
                <li><a href="#search" title="Buscar" class="search-btn1"><i class="bi bi-search"></i></a>
                </li>
            </ul>
        </div>

        <div>

            <nav class="buscador-container">
                <div class="nav-wrapper">
                    <form action="./busqueda.jsp" autocomplete="off">
                        <div class="input-field buscador">
                            <input id="search" type="search" name="b" required placeholder="Películas, Series, TV ¿Qué deseas buscar?">
                            <label class="label-icon" for="search"><i class="bi bi-arrow-left-short back-search" style="font-size:2.4rem"></i></label>
                            <i class="bi bi-x-lg clean-input"></i>
                        </div>
                    </form>
                </div>
            </nav>

            <ul id="box-search">

                <!-- ------------ -->
                <!-- De Cartelera -->
                <!-- ------------ -->
                <%
                    int cont5 = 0;
                    String star = "";
                    String nombrePeliculaC = "";
                    String nombreOriginalC = "";


                    if(lc.getCantidad() > 0){

                        // 1. ubicar el ultimo elemento de la lista

                        lc.setActual(lc.getUltimo());

                        while (cont5 < lc.getCantidad() && lc.getActual()!=null){

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

                            if(lc.getActual().getNombrePelicula().length()>21){
                                nombrePeliculaC = lc.getActual().getNombrePelicula().substring(0,21);
                            }else {
                                nombrePeliculaC = lc.getActual().getNombrePelicula();
                            }

                            if(lc.getActual().getNombreOriginal().length()>14){
                                nombreOriginalC = lc.getActual().getNombreOriginal().substring(0, 14);
                            }else {
                                nombreOriginalC = lc.getActual().getNombreOriginal();
                            }

                %>

                    <li><a href="descripcion.jsp?idc=<%= lc.getActual().getId() %>"><img src="<%= lc.getActual().getImagen() %>" loading="lazy" class="img-box-search"><%= nombrePeliculaC %> <small><%= nombreOriginalC %> | <%= lc.getActual().getResenia() %> &nbsp; <span style="color: #FCD53F"> <%= star %> </span> </small></a></li>

                    <%--RECORRIDO PREORDEN DE LOS ACTORES EN CARTELERA--%>
                    <%
                        if (lc.getActual().getRaiz()!=null){

                        root = lc.getActual().getRaiz();
                        if(root==null) return;
                        Stack<Actores> s = new Stack<>();
                        while (!s.isEmpty()||root!=null){
                            while(root!=null){

                    %>

                        <li><a href="actordesc.jsp?idactor=<%= root.getId() %>"><img src="<%= root.getFotoActor() %>" loading="lazy" class="img-box-search"><%= root.getNombreActor() %> <small><%= root.getNombreActor() %> | Ahora &nbsp <span style="color: #FCD53F"> <i class="bi bi-file-person"></i> </span> </small></a></li>

                    <%
                                        s.push(root);
                                        root=root.getNodoIzq();
                                    }
                                    if(!s.isEmpty()){
                                        Actores t = s.pop();
                                        root=t.getNodoDer();
                                    }
                                }
                        }

                            // 3. Identificar su siguiente nodo
                            lc.setActual(lc.getActual().getSiguiente());
                            cont5++;

                        }

                    }

                %>

                <!-- ------------ -->
                <!-- De Populares -->
                <!-- ------------ -->

                <%
                    String star2 = "";
                    String nombrePeliculaC2 = "";
                    String nombreOriginalC2 = "";

                    if(lde.getCantidad() > 0){

                        // 1. ubicar el primer elemento de la lista
                        lde.setActual(lde.getPrimero());

                        while (lde.getActual()!=null){

                            double res2 = Double.parseDouble(lde.getActual().getResenia());
                            // Estrellas
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

                            if(lde.getActual().getNombrePelicula().length()>21){
                                nombrePeliculaC2 = lde.getActual().getNombrePelicula().substring(0,21);
                            }else {
                                nombrePeliculaC2 = lde.getActual().getNombrePelicula();
                            }

                            if(lde.getActual().getNombreOriginal().length()>14){
                                nombreOriginalC2 = lde.getActual().getNombreOriginal().substring(0, 14);
                            }else {
                                nombreOriginalC2 = lde.getActual().getNombreOriginal();
                            }


                %>

                            <li><a href="descripcion.jsp?idlde=<%= lde.getActual().getId() %>"><img src="<%= lde.getActual().getImagen() %>" loading="lazy" class="img-box-search"><%= nombrePeliculaC2 %> <small><%= nombreOriginalC2 %> | <%= lde.getActual().getResenia() %> &nbsp; <span style="color: #FCD53F"> <%= star2 %> </span> </small></a></li>


                        <%--RECORRIDO PREORDEN DE LOS ACTORES EN POPULARES--%>
                        <%
                            if (lde.getActual().getRaiz()!=null){

                            root = lde.getActual().getRaiz();
                            if(root==null) return;
                            Stack<Actores> s = new Stack<>();
                            while (!s.isEmpty()||root!=null){
                                while(root!=null){

                        %>

                            <li><a href="actordesc.jsp?idactor=<%= root.getId() %>"><img src="<%= root.getFotoActor() %>" loading="lazy" class="img-box-search"><%= root.getNombreActor() %> <small><%= root.getNombreActor() %> | Popular &nbsp <span style="color: #FCD53F"> <i class="bi bi-file-person"></i> </span> </small></a></li>

                        <%
                                    s.push(root);
                                    root=root.getNodoIzq();
                                }
                                if(!s.isEmpty()){
                                    Actores t = s.pop();
                                    root=t.getNodoDer();
                                }
                            }

                            }


                            // 3. Identificar su siguiente nodo
                            lde.setActual(lde.getActual().getSiguiente());

                        }

                    }

                %>


            </ul>

        </div>

        <div class="burger">
            <div class="linea1"></div>
            <div class="linea2"></div>
            <div class="linea3"></div>
        </div>
    </nav>
</header>

<main>
    <!-- Ventana de origen de los datos -->
    <div class="data-source-window" id="window-d">
        <div class="container-window">

            <div class="header-window">
                <h5 class="title-window">Origen de los Datos</h5>
                <button class="close-button-window"><i class="bi bi-x-lg"></i></button>
            </div>

            <div class="separator"></div>

            <div class="content-containe-window">
                <div class="content-window">
                    <p class="text-window">
                        Bienvenido querido usuario,<br>
                        ¿De dónde prefieres obtener los datos de las películas? <br><br>
                    </p>

                    <ul class="lista-window">
                        <li>▶️ Datos de <a href="https://www.themoviedb.org/" target="_blank">The Movie DB</a>: <strong> Los datos serán traídos de la API de The Movie DB.</strong> </li>
                        <br>
                        <li>▶️ Datos de <a href="https://firebase.google.com/?hl=es" target="_blank">Firebase</a>: <strong> Los datos serán traídos del backup de Firebase. </strong></li>
                    </ul>

                    <div id="advertencia-datos"></div>

                </div>
            </div>

            <div class="option-window">
                <button class="option-api" id="option-api"><img src="https://pbs.twimg.com/profile_images/1243623122089041920/gVZIvphd_400x400.jpg" alt="TMDB" width="20"> &nbsp; API The Movie DB</button>
                <button class="option-firebase" id="option-firebase"><img src="https://www.gstatic.com/devrel-devsite/prod/v6cd15f45ec209c8961e07ea7e57ed9a0e9da4333bc915e67d1fcd2b2a9ec62d1/firebase/images/touchicon-180.png" alt="Firebase" width="20"> Firebase</button>
            </div>

        </div>

    </div>

    <%--Botón de backcup en Firebase--%>
    <% if(session.getAttribute("idadmin")!=null){
        analizarCambio();
    %>
    <div class="backup-button-container">
        <button id="backcup-firebase-button" style="background: <%= backgroundBF %>"><img src="https://seeklogo.com/images/F/firebase-rtdb-logo-C976B2C606-seeklogo.com.png" alt="Firebase" width="30"> <span class="text-firebase-btn"> <%= textoBF %></span> </button>
    </div>
    <% } %>

    <!-- Swiper principal -->
    <div class="swiper mySwiper swiper-principal">
        <div class="swiper-wrapper">

            <div class="swiper-slide">

                <!--trailer video -->
                <div style="overflow: hidden">
                    <video class="video-fondo-principal" id="hero-video" style="transform: scale(1.2)"
                           poster="images/murder mystery.jpg" autoplay muted loop>
                        <source src="videos/MurderMysteryVideo.mp4"
                                type="video/mp4">
                        Lo sentimos, tu navegador no soporta la etiqueta video.
                    </video>
                </div>

                <div class="capa-sombra">

                    <div class="container-main text-container" style="z-index: 5;">
                        <div class="contentlogo">
                            <img src="images/murder-logo.webp" alt="content logo"
                                 class="show-logo" />
                        </div>
                        <!--top 10 ranking badge svg-->
                        <div class="ranking">
                            <svg id="top-10-badge" viewBox="0 0 28 30">
                                <path d="M0,0 L28,0 L28,30 L0,30 L0,0 Z M2,2 L2,28 L26,28 L26,2 L2,2 Z" fill="#FFFFFF">
                                </path>
                                <path
                                        d="M16.8211527,22.1690594 C17.4133103,22.1690594 17.8777709,21.8857503 18.2145345,21.3197261 C18.5512982,20.7531079 18.719977,19.9572291 18.719977,18.9309018 C18.719977,17.9045745 18.5512982,17.1081018 18.2145345,16.5414836 C17.8777709,15.9754594 17.4133103,15.6921503 16.8211527,15.6921503 C16.2289952,15.6921503 15.7645345,15.9754594 15.427177,16.5414836 C15.0904133,17.1081018 14.9223285,17.9045745 14.9223285,18.9309018 C14.9223285,19.9572291 15.0904133,20.7531079 15.427177,21.3197261 C15.7645345,21.8857503 16.2289952,22.1690594 16.8211527,22.1690594 M16.8211527,24.0708533 C15.9872618,24.0708533 15.2579042,23.8605988 14.6324861,23.4406836 C14.0076618,23.0207685 13.5247891,22.4262352 13.1856497,21.6564897 C12.8465103,20.8867442 12.6766436,19.9786109 12.6766436,18.9309018 C12.6766436,17.8921018 12.8465103,16.9857503 13.1856497,16.2118473 C13.5247891,15.4379442 14.0076618,14.8410352 14.6324861,14.4205261 C15.2579042,14.0006109 15.9872618,13.7903564 16.8211527,13.7903564 C17.6544497,13.7903564 18.3844012,14.0006109 19.0098194,14.4205261 C19.6352376,14.8410352 20.1169224,15.4379442 20.4566558,16.2118473 C20.7952012,16.9857503 20.9656618,17.8921018 20.9656618,18.9309018 C20.9656618,19.9786109 20.7952012,20.8867442 20.4566558,21.6564897 C20.1169224,22.4262352 19.6352376,23.0207685 19.0098194,23.4406836 C18.3844012,23.8605988 17.6544497,24.0708533 16.8211527,24.0708533"
                                        fill="#FFFFFF"></path>
                                <polygon fill="#FFFFFF"
                                         points="8.86676 23.9094206 8.86676 16.6651418 6.88122061 17.1783055 6.88122061 14.9266812 11.0750267 13.8558085 11.0750267 23.9094206">
                                </polygon>
                                <path
                                        d="M20.0388194,9.42258545 L20.8085648,9.42258545 C21.1886861,9.42258545 21.4642739,9.34834303 21.6353285,9.19926424 C21.806383,9.05077939 21.8919103,8.83993091 21.8919103,8.56731273 C21.8919103,8.30122788 21.806383,8.09572485 21.6353285,7.94961576 C21.4642739,7.80410061 21.1886861,7.73104606 20.8085648,7.73104606 L20.0388194,7.73104606 L20.0388194,9.42258545 Z M18.2332436,12.8341733 L18.2332436,6.22006424 L21.0936558,6.22006424 C21.6323588,6.22006424 22.0974133,6.31806424 22.4906012,6.51465818 C22.8831952,6.71125212 23.1872921,6.98684 23.4028921,7.34142182 C23.6178982,7.69659758 23.7259952,8.10522788 23.7259952,8.56731273 C23.7259952,9.04246424 23.6178982,9.45762788 23.4028921,9.8122097 C23.1872921,10.1667915 22.8831952,10.4429733 22.4906012,10.6389733 C22.0974133,10.8355673 21.6323588,10.9335673 21.0936558,10.9335673 L20.0388194,10.9335673 L20.0388194,12.8341733 L18.2332436,12.8341733 Z"
                                        fill="#FFFFFF"></path>
                                <path
                                        d="M14.0706788,11.3992752 C14.3937818,11.3992752 14.6770909,11.322063 14.9212,11.1664509 C15.1653091,11.0114327 15.3553697,10.792863 15.4913818,10.5107418 C15.6279879,10.2286206 15.695697,9.90136 15.695697,9.52717818 C15.695697,9.1535903 15.6279879,8.82573576 15.4913818,8.54361455 C15.3553697,8.26149333 15.1653091,8.04351758 14.9212,7.88790545 C14.6770909,7.73288727 14.3937818,7.65508121 14.0706788,7.65508121 C13.7475758,7.65508121 13.4642667,7.73288727 13.2201576,7.88790545 C12.9760485,8.04351758 12.7859879,8.26149333 12.6499758,8.54361455 C12.5139636,8.82573576 12.4456606,9.1535903 12.4456606,9.52717818 C12.4456606,9.90136 12.5139636,10.2286206 12.6499758,10.5107418 C12.7859879,10.792863 12.9760485,11.0114327 13.2201576,11.1664509 C13.4642667,11.322063 13.7475758,11.3992752 14.0706788,11.3992752 M14.0706788,12.9957842 C13.5634545,12.9957842 13.0995879,12.9090691 12.6784848,12.7344509 C12.2573818,12.5604267 11.8915152,12.3163176 11.5808848,12.0027176 C11.2708485,11.6891176 11.0314909,11.322063 10.8634061,10.9003661 C10.6953212,10.479263 10.6115758,10.0213358 10.6115758,9.52717818 C10.6115758,9.03302061 10.6953212,8.57568727 10.8634061,8.1539903 C11.0314909,7.73288727 11.2708485,7.36523879 11.5808848,7.05163879 C11.8915152,6.73803879 12.2573818,6.49452364 12.6784848,6.31990545 C13.0995879,6.14588121 13.5634545,6.05857212 14.0706788,6.05857212 C14.577903,6.05857212 15.0417697,6.14588121 15.4628727,6.31990545 C15.8839758,6.49452364 16.2498424,6.73803879 16.5604727,7.05163879 C16.871103,7.36523879 17.1098667,7.73288727 17.2779515,8.1539903 C17.4460364,8.57568727 17.5297818,9.03302061 17.5297818,9.52717818 C17.5297818,10.0213358 17.4460364,10.479263 17.2779515,10.9003661 C17.1098667,11.322063 16.871103,11.6891176 16.5604727,12.0027176 C16.2498424,12.3163176 15.8839758,12.5604267 15.4628727,12.7344509 C15.0417697,12.9090691 14.577903,12.9957842 14.0706788,12.9957842"
                                        fill="#FFFFFF"></path>
                                <polygon fill="#FFFFFF"
                                         points="8.4639503 12.8342327 6.65837455 13.2666206 6.65837455 7.77862061 4.65323515 7.77862061 4.65323515 6.22012364 10.4690897 6.22012364 10.4690897 7.77862061 8.4639503 7.77862061">
                                </polygon>
                            </svg>
                            <span class="p-l-10">#10 en Guatemala</span>
                        </div>

                        <div class="synopsis" style="max-width: 500px;">
                            <p>
                                Un policía de Nueva York y su mujer se van de vacaciones a Europa para revitalizar la chispa de su matrimonio,
                                pero terminan acusados del asesinato de un anciano multimillonario y tienen que huir.
                            </p>
                        </div>
                        <div class="buttons-container">
                            <button class="play-button"><span>
                                        <svg viewBox="0 0 24 24">
                                            <path d="M6 4l15 8-15 8z" fill="currentColor"></path>
                                        </svg>
                                    </span> <a href="descripcion.jsp?idc=0" class="link">Play</a></button>

                            <button class="more-info-button" onclick="window.location = 'descripcion.jsp?idc=0'"><span>
                                        <svg viewBox="0 0 24 24">
                                            <path
                                                    d="M22 12c0 5.523-4.477 10-10 10S2 17.523 2 12 6.477 2 12 2s10 4.477 10 10zm-2 0a8 8 0 0 0-8-8 8 8 0 0 0-8 8 8 8 0 0 0 8 8 8 8 0 0 0 8-8zm-9 6v-7h2v7h-2zm1-8.75a1.21 1.21 0 0 1-.877-.364A1.188 1.188 0 0 1 10.75 8c0-.348.123-.644.372-.886.247-.242.54-.364.878-.364.337 0 .63.122.877.364.248.242.373.538.373.886s-.124.644-.373.886A1.21 1.21 0 0 1 12 9.25z"
                                                    fill="currentColor"></path>
                                        </svg>
                                    </span> Más información</button>
                        </div>
                    </div>
                </div>

            </div>

            <div class="swiper-slide">

                <!--trailer video -->
                <div style="overflow: hidden">
                    <video class="video-fondo-principal" id="hero-video" style="transform: scale(1.5)"
                           poster="images/NoMirenArribaPoster.jpg" autoplay muted loop>
                        <source src="videos/NoMirenArribaVideo.mp4"
                                type="video/mp4">
                        Lo sentimos, tu navegador no soporta la etiqueta video.
                    </video>
                </div>


                <div class="capa-sombra">


                    <div class="container-main text-container" style="z-index: 5;">
                        <div class="contentlogo">
                            <img src="images/nomirenarriba-icono.png" alt="content logo"
                                 class="show-logo" />
                        </div>
                        <!--top 10 ranking badge svg-->
                        <div class="ranking">
                            <svg id="top-10-badge" viewBox="0 0 28 30">
                                <path d="M0,0 L28,0 L28,30 L0,30 L0,0 Z M2,2 L2,28 L26,28 L26,2 L2,2 Z" fill="#FFFFFF">
                                </path>
                                <path
                                        d="M16.8211527,22.1690594 C17.4133103,22.1690594 17.8777709,21.8857503 18.2145345,21.3197261 C18.5512982,20.7531079 18.719977,19.9572291 18.719977,18.9309018 C18.719977,17.9045745 18.5512982,17.1081018 18.2145345,16.5414836 C17.8777709,15.9754594 17.4133103,15.6921503 16.8211527,15.6921503 C16.2289952,15.6921503 15.7645345,15.9754594 15.427177,16.5414836 C15.0904133,17.1081018 14.9223285,17.9045745 14.9223285,18.9309018 C14.9223285,19.9572291 15.0904133,20.7531079 15.427177,21.3197261 C15.7645345,21.8857503 16.2289952,22.1690594 16.8211527,22.1690594 M16.8211527,24.0708533 C15.9872618,24.0708533 15.2579042,23.8605988 14.6324861,23.4406836 C14.0076618,23.0207685 13.5247891,22.4262352 13.1856497,21.6564897 C12.8465103,20.8867442 12.6766436,19.9786109 12.6766436,18.9309018 C12.6766436,17.8921018 12.8465103,16.9857503 13.1856497,16.2118473 C13.5247891,15.4379442 14.0076618,14.8410352 14.6324861,14.4205261 C15.2579042,14.0006109 15.9872618,13.7903564 16.8211527,13.7903564 C17.6544497,13.7903564 18.3844012,14.0006109 19.0098194,14.4205261 C19.6352376,14.8410352 20.1169224,15.4379442 20.4566558,16.2118473 C20.7952012,16.9857503 20.9656618,17.8921018 20.9656618,18.9309018 C20.9656618,19.9786109 20.7952012,20.8867442 20.4566558,21.6564897 C20.1169224,22.4262352 19.6352376,23.0207685 19.0098194,23.4406836 C18.3844012,23.8605988 17.6544497,24.0708533 16.8211527,24.0708533"
                                        fill="#FFFFFF"></path>
                                <polygon fill="#FFFFFF"
                                         points="8.86676 23.9094206 8.86676 16.6651418 6.88122061 17.1783055 6.88122061 14.9266812 11.0750267 13.8558085 11.0750267 23.9094206">
                                </polygon>
                                <path
                                        d="M20.0388194,9.42258545 L20.8085648,9.42258545 C21.1886861,9.42258545 21.4642739,9.34834303 21.6353285,9.19926424 C21.806383,9.05077939 21.8919103,8.83993091 21.8919103,8.56731273 C21.8919103,8.30122788 21.806383,8.09572485 21.6353285,7.94961576 C21.4642739,7.80410061 21.1886861,7.73104606 20.8085648,7.73104606 L20.0388194,7.73104606 L20.0388194,9.42258545 Z M18.2332436,12.8341733 L18.2332436,6.22006424 L21.0936558,6.22006424 C21.6323588,6.22006424 22.0974133,6.31806424 22.4906012,6.51465818 C22.8831952,6.71125212 23.1872921,6.98684 23.4028921,7.34142182 C23.6178982,7.69659758 23.7259952,8.10522788 23.7259952,8.56731273 C23.7259952,9.04246424 23.6178982,9.45762788 23.4028921,9.8122097 C23.1872921,10.1667915 22.8831952,10.4429733 22.4906012,10.6389733 C22.0974133,10.8355673 21.6323588,10.9335673 21.0936558,10.9335673 L20.0388194,10.9335673 L20.0388194,12.8341733 L18.2332436,12.8341733 Z"
                                        fill="#FFFFFF"></path>
                                <path
                                        d="M14.0706788,11.3992752 C14.3937818,11.3992752 14.6770909,11.322063 14.9212,11.1664509 C15.1653091,11.0114327 15.3553697,10.792863 15.4913818,10.5107418 C15.6279879,10.2286206 15.695697,9.90136 15.695697,9.52717818 C15.695697,9.1535903 15.6279879,8.82573576 15.4913818,8.54361455 C15.3553697,8.26149333 15.1653091,8.04351758 14.9212,7.88790545 C14.6770909,7.73288727 14.3937818,7.65508121 14.0706788,7.65508121 C13.7475758,7.65508121 13.4642667,7.73288727 13.2201576,7.88790545 C12.9760485,8.04351758 12.7859879,8.26149333 12.6499758,8.54361455 C12.5139636,8.82573576 12.4456606,9.1535903 12.4456606,9.52717818 C12.4456606,9.90136 12.5139636,10.2286206 12.6499758,10.5107418 C12.7859879,10.792863 12.9760485,11.0114327 13.2201576,11.1664509 C13.4642667,11.322063 13.7475758,11.3992752 14.0706788,11.3992752 M14.0706788,12.9957842 C13.5634545,12.9957842 13.0995879,12.9090691 12.6784848,12.7344509 C12.2573818,12.5604267 11.8915152,12.3163176 11.5808848,12.0027176 C11.2708485,11.6891176 11.0314909,11.322063 10.8634061,10.9003661 C10.6953212,10.479263 10.6115758,10.0213358 10.6115758,9.52717818 C10.6115758,9.03302061 10.6953212,8.57568727 10.8634061,8.1539903 C11.0314909,7.73288727 11.2708485,7.36523879 11.5808848,7.05163879 C11.8915152,6.73803879 12.2573818,6.49452364 12.6784848,6.31990545 C13.0995879,6.14588121 13.5634545,6.05857212 14.0706788,6.05857212 C14.577903,6.05857212 15.0417697,6.14588121 15.4628727,6.31990545 C15.8839758,6.49452364 16.2498424,6.73803879 16.5604727,7.05163879 C16.871103,7.36523879 17.1098667,7.73288727 17.2779515,8.1539903 C17.4460364,8.57568727 17.5297818,9.03302061 17.5297818,9.52717818 C17.5297818,10.0213358 17.4460364,10.479263 17.2779515,10.9003661 C17.1098667,11.322063 16.871103,11.6891176 16.5604727,12.0027176 C16.2498424,12.3163176 15.8839758,12.5604267 15.4628727,12.7344509 C15.0417697,12.9090691 14.577903,12.9957842 14.0706788,12.9957842"
                                        fill="#FFFFFF"></path>
                                <polygon fill="#FFFFFF"
                                         points="8.4639503 12.8342327 6.65837455 13.2666206 6.65837455 7.77862061 4.65323515 7.77862061 4.65323515 6.22012364 10.4690897 6.22012364 10.4690897 7.77862061 8.4639503 7.77862061">
                                </polygon>
                            </svg>
                            <span class="p-l-10">#7 en Guatemala</span>
                        </div>

                        <div class="synopsis" style="max-width: 500px;">
                            <p>
                                Dos astrónomos mediocres descubren que, en pocos meses, un meteorito destruirá el planeta Tierra. A partir de ese momento, intentan advertir a la humanidad del peligro que se avecina a través de los medios de comunicación.
                            </p>
                        </div>
                        <div class="buttons-container">
                            <button class="play-button"><span>
                                        <svg viewBox="0 0 24 24">
                                            <path d="M6 4l15 8-15 8z" fill="currentColor"></path>
                                        </svg>
                                    </span> <a href="descripcion.jsp?idc=1" class="link">Play</a></button>

                            <button class="more-info-button" onclick="window.location = 'descripcion.jsp?idc=1'"><span>
                                        <svg viewBox="0 0 24 24">
                                            <path
                                                    d="M22 12c0 5.523-4.477 10-10 10S2 17.523 2 12 6.477 2 12 2s10 4.477 10 10zm-2 0a8 8 0 0 0-8-8 8 8 0 0 0-8 8 8 8 0 0 0 8 8 8 8 0 0 0 8-8zm-9 6v-7h2v7h-2zm1-8.75a1.21 1.21 0 0 1-.877-.364A1.188 1.188 0 0 1 10.75 8c0-.348.123-.644.372-.886.247-.242.54-.364.878-.364.337 0 .63.122.877.364.248.242.373.538.373.886s-.124.644-.373.886A1.21 1.21 0 0 1 12 9.25z"
                                                    fill="currentColor"></path>
                                        </svg>
                                    </span> Más información</button>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

    <section class="cartelera">

        <h4 class="clasificacion wrap-break-word">Cartelera</h4>

        <%
            if(session.getAttribute("idadmin")!=null){
        %>
        <!-- Modal Trigger -->
        <br><a class="waves-effect waves-light btn modal-trigger right add-mc" href="#modal1" style="background: #E50914"><i class="bi bi-plus-circle" style="vertical-align:middle"></i> Agregar Peliculas </a>

        <!-- Modal Structure -->
        <div id="modal1" class="modal" style="background: #131313">
            <div class="modal-content">
                <h4 class="titulo-form" style="background: linear-gradient(90deg, #d53369 0%, #daae51 100%); padding: 15px; border-radius: 1rem; text-align: center; display: flex">
                    Agregar Películas a Cartelera
                </h4><br>

                <p>Agrega a continuación todos los detalles de la película.</p><br>

                <div class="row">
                    <form class="col s12" action="CircularServlet" method="post">
                        <%
                            String idCircular = lc.getCantidad() + "";
                        %>

                        <input type="hidden" name="op" value="add" />
                        <input type="hidden" name="idcircular" value="<%= idCircular %>" />

                        <div class="row">
                            <div class="input-field col s6">
                                <input id="nombre_pelicula" name="nombre_pelicula" type="text" class="validate" required />
                                <label for="nombre_pelicula">Nombre</label>
                            </div>

                            <div class="input-field col s6">
                                <input id="nombre_original" name="nombre_original" type="text" class="validate" required />
                                <label for="nombre_original">Nombre original</label>
                            </div>

                            <div class="input-field col s12" style="display: flex; justify-content:center;">
                                <p class="range-field">
                                    <label for="resenia">Indique la reseña. De 1 a 5 estrellas</label>
                                    <input type="range" id="resenia" name="resenia" min="0" max="5" step="0.5" required />
                                </p>
                            </div>

                            <div class="input-field col s12">
                                <textarea id="sinopsis" name="sinopsis" class="materialize-textarea" style="color:#fff" required></textarea>
                                <label for="sinopsis">Sinopsis (Descripción)</label>
                            </div>

                            <div class="input-field col s6">
                                <input id="imagen" name="imagen" type="text" class="validate" title="Enlace de imagen" required />
                                <label for="imagen" title="Enlace de imagen">Imagen</label>
                            </div>

                            <div class="input-field col s6">
                                <input id="video" name="video" type="text" class="validate" title="Enlace de video" />
                                <label for="video" title="Enlace de video">Video trailer</label>
                            </div>

                            <div class="input-field col s12">
                                <input id="pelicula" name="pelicula" type="text" class="validate" title="Enlace de la película completa" />
                                <label for="pelicula" title="Enlace de la película completa">Película completa</label>
                            </div>

                        </div>

                        <div class="input-field col s12" style="display: flex; justify-content:center;">
                            <button class="btn waves-effect waves-light" type="submit" style="background: #E50914;">
                                Agregar Película
                            </button>
                        </div>

                    </form>
                </div>

            </div>

        </div>

        <%
            }
        %>

        <%-- Tarjetas de peliculas en cartelera --%>
        <div class="carousel">

            <%
                int cont = 0;

                if (lc.getCantidad() > 0){

                    // 1. ubicar el ultimo elemento de la lista
                    lc.setActual(lc.getUltimo());

                    while (cont < lc.getCantidad() && lc.getActual()!=null) {

            %>

                <div class="carousel-item item-card tarjeta"><img src="<%= lc.getActual().getImagen()%>" loading="lazy" style="border-radius: 1.5rem; height: 20rem; object-fit:cover;" alt="Poster de la Película">
                <div class="capa-desc blur-desc">
                    <a href="descripcion.jsp?idc=<%= lc.getActual().getId() %>"><h5><b><%= lc.getActual().getNombrePelicula() %></b></h5></a>

                    <%
                        if (session.getAttribute("idadmin")!=null){
                    %>

                    <div class="botones-admin">
                        <!-- Modal Trigger -->
                        <a class="waves-effect waves-light btn modal-trigger" title="Editar Película" href="#modificar<%= lc.getActual().getId() %>">
                            <i class="bi bi-pencil-square"></i>
                        </a>

                        <a class="btn waves-effect waves-light modal-trigger" title="Eliminar" href="#eliminar<%= lc.getActual().getId() %>" style="background: red">
                            <i class="bi bi-trash3-fill"></i>
                        </a>

                    </div>

                    <%
                        }
                    %>
                </div>

                </div>

            <%
                        // 3. Identificar su siguiente nodo
                        lc.setActual(lc.getActual().getSiguiente());
                        cont++;

                    }

                }


            %>

        </div>


        <%
            if (session.getAttribute("idadmin")!=null) {


                int cont2 = 0;

                if (lc.getCantidad() > 0) {

                    // 1. ubicar el ultimo elemento de la lista
                    lc.setActual(lc.getUltimo());

                    while (cont2 < lc.getCantidad() && lc.getActual()!=null) {
        %>

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


        <%
                        // 3. Identificar su siguiente nodo
                        lc.setActual(lc.getActual().getSiguiente());
                        cont2++;

                    }

                }

            }
        %>

    </section>

    <section class="populares">

        <h4 class="clasificacion wrap-break-word">Populares</h4>

        <%
            if (session.getAttribute("idadmin") != null) {
        %>

                <!-- Modal Trigger -->
                <a class="waves-effect waves-light btn modal-trigger right" href="#modal2" style="margin-top: 22px; background: #E50914"><i class="bi bi-plus-circle" style="vertical-align:middle"></i> Agregar Peliculas</a>

                <!-- Modal Structure -->
                <div id="modal2" class="modal" style="background: #131313">
                    <div class="modal-content">
                        <h4 class="titulo-form" style="background: linear-gradient(90deg, #00C9FF 0%, #92FE9D 100%); padding: 15px; border-radius: 1rem; text-align: center">
                            Agregar Películas a Populares
                        </h4><br>

                        <p>Agrega a continuación todos los detalles de la película.</p><br>

                        <div class="row">
                            <form class="col s12" action="DoblementeEnlazadaServlet" method="post">

                                <%
                                    String idLde = lde.getCantidad() + "";
                                %>

                                <input type="hidden" name="op" value="add" />
                                <input type="hidden" name="idlde" value="<%= idLde %>" />

                                <div class="row">
                                    <div class="input-field col s6">
                                        <input id="nombre_pelicula" name="nombre_pelicula" type="text" class="validate" required>
                                        <label for="nombre_pelicula">Nombre</label>
                                    </div>

                                    <div class="input-field col s6">
                                        <input id="nombre_original" name="nombre_original" type="text" class="validate" required>
                                        <label for="nombre_original">Nombre original</label>
                                    </div>

                                    <div class="input-field col s12" style="display: flex; justify-content:center;">
                                        <p class="range-field">
                                            <label for="resenia">Indique la reseña. De 1 a 5 estrellas</label>
                                            <input type="range" id="resenia" name="resenia" min="0" max="5" step="0.5" required/>
                                        </p>
                                    </div>


                                    <div class="input-field col s12">
                                        <textarea id="sinopsis" name="sinopsis" class="materialize-textarea" style="color:#fff" required></textarea>
                                        <label for="sinopsis">Sinopsis (Descripción)</label>
                                    </div>

                                    <div class="input-field col s6">
                                        <input id="imagen" name="imagen" type="text" class="validate" title="Enlace de imagen" required>
                                        <label for="imagen" title="Enlace de imagen">Imagen</label>
                                    </div>

                                    <div class="input-field col s6">
                                        <input id="video" name="video" type="text" class="validate" title="Enlace de video">
                                        <label for="video" title="Enlace de video">Video trailer</label>
                                    </div>

                                    <div class="input-field col s12">
                                        <input id="pelicula" name="pelicula" type="text" class="validate" title="Enlace de la película completa">
                                        <label for="pelicula" title="Enlace de la película completa">Película completa</label>
                                    </div>

                                </div>

                                <div class="input-field col s12" style="display: flex; justify-content:center;">
                                    <button class="btn waves-effect waves-light" type="submit" name="action" style="background: #E50914;">
                                        Agregar Película
                                    </button>
                                </div>

                            </form>
                        </div>

                    </div>

                </div>
        <%
            }
        %>

        <div class="carousel carousel2">

            <%

                if(lde.getCantidad() > 0){

                    // 1. ubicar el primer elemento de la lista
                    lde.setActual(lde.getPrimero());

                    while (lde.getActual()!=null){

            %>


            <%
                if (session.getAttribute("idadmin")!=null) {

                    String nombrePeliculaAdmin = "";
                    if(lde.getActual().getNombrePelicula().length()>15){
                        nombrePeliculaAdmin = lde.getActual().getNombrePelicula().substring(0,15) + "...";
                    }else {
                        nombrePeliculaAdmin = lde.getActual().getNombrePelicula();
                    }
            %>

                    <div class="carousel-item popular-item tarjeta2"><img src="<%= lde.getActual().getImagen() %>" loading="lazy" alt="Poster de la Película">
                        <a href="descripcion.jsp?idlde=<%= lde.getActual().getId() %>"><span><%= nombrePeliculaAdmin %></span></a>

                        <div class="capa-desc2 blur-desc2" style="height: calc(100% - 25px)">

                            <div class="botones-admin">
                                <!-- Modal Trigger -->
                                <a class="waves-effect waves-light btn modal-trigger" title="Editar Película" href="#modificarLde<%= lde.getActual().getId() %>">
                                    <i class="bi bi-pencil-square"></i>
                                </a>

                                <a class="btn waves-effect waves-light modal-trigger" title="Eliminar" href="#eliminarLde<%= lde.getActual().getId() %>" style="background: red">
                                    <i class="bi bi-trash3-fill"></i>
                                </a>

                            </div>


                        </div>

                    </div>

            <%
                }else{
            %>

                <a class="carousel-item popular-item" href="descripcion.jsp?idlde=<%= lde.getActual().getId() %>"><img src="<%= lde.getActual().getImagen() %>"> <span><%= lde.getActual().getNombrePelicula() %></span></a>

            <%
                }
            %>

            <%
                        // 3. Identificar su siguiente nodo
                        lde.setActual(lde.getActual().getSiguiente());

                    }

                }

            %>

        </div>



        <%
            if (session.getAttribute("idadmin")!=null) {

                if (lde.getCantidad() > 0) {

                    // 1. ubicar el primer elemento de la lista
                    lde.setActual(lde.getPrimero());

                    while (lde.getActual()!=null) {
        %>

                    <!-- Modal Structure Edit -->
                    <div id="modificarLde<%= lde.getActual().getId() %>" class="modal bottom-sheet" style="background: #131313">
                        <div class="modal-content">
                            <h4 class="titulo-form" style="background: linear-gradient(90deg, #1CB5E0 0%, #000851 100%); padding: 15px; border-radius: 1rem; text-align: center">
                                Modificar Detalles de la Película
                            </h4><br>
                            <p>Puedes editar a continuación todos los detalles de la película.</p><br>

                            <div class="row">
                                <form class="col s12" action="DoblementeEnlazadaServlet" method="post">
                                    <div class="row">

                                        <input type="hidden" name="op" value="edit" />
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
                    <div id="eliminarLde<%= lde.getActual().getId() %>" class="modal modal-fixed-footer" style="background: #131313; height: 18rem; overflow: auto; border-radius: 0.5rem">
                        <div class="modal-content">
                            <h4 style="text-align: center; font-size: 1.5rem; background-color: #AA0000; padding: 15px; border-radius: 0.5rem">Eliminar Película <%= lde.getActual().getNombrePelicula() %> de Populares </h4> <br>
                            <h6 style="text-align: center; font-size: 1.2rem">¿Está seguro que desea eliminar la película <%= lde.getActual().getNombreOriginal() %> de Populares?</h6>
                        </div>
                        <div class="modal-footer" style="background: #131313">
                            <a href="#!" class="modal-close waves-effect waves-green btn-flat" style="background-color: #005b9b; color: #ffffff; border-radius: .5rem;">Cancelar</a>
                            <a href="#!" class="waves-effect waves-green btn-flat" onclick="eliminarDeLde(<%= lde.getActual().getId() %>)" style="background-color: red; color: #ffffff; border-radius: .5rem;">Aceptar</a>
                        </div>
                    </div>

        <%
                        // 3. Identificar su siguiente nodo
                        lde.setActual(lde.getActual().getSiguiente());

                    }

                }


            }
        %>

    </section>

</main>

<footer class="page-footer wrap-break-word" style="background: #131313">
    <div class="container">
        <div class="row">
            <div class="col l6 s12">
                <h5 class="white-text">Movies</h5>
                <p class="grey-text text-lighten-4">Peliculas y series. Plataforma de consulta de películas</p>
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

<script src="js/app.js"></script>

<!-- Materialize Compiled and minified JavaScript -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

</body>
</html>