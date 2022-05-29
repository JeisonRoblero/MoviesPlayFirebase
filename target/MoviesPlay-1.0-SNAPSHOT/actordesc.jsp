<%@ page import="static com.proyecto.moviesplay.CircularServlet.lc" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="static com.proyecto.moviesplay.DoblementeEnlazadaServlet.lde" %>
<%@ page import="com.proyecto.moviesplay.Actores" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Stack" %>
<%@ page import="com.proyecto.moviesplay.AVLServlet" %>
<%@ page import="static com.proyecto.moviesplay.AVLServlet.*" %>
<%@ page import="com.proyecto.moviesplay.Pelicula" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="images/favicon.png" type="image/x-icon">
    <title>Actor Descripción | Movies </title>

    <!--=== Color de barra superior ====-->
    <meta name="theme-color" content="#131313"/>

    <!-- Inicio Meta Etiquetas para Redes Sociales y SEO -->
    <meta property="og:image" itemprop="image" content="images/favicon.png"/>
    <meta property="og:site_name" content="Actor Descripción | Movies | Peliculas y Series"/>
    <meta property="og:title" content="Actor Descripción | Movies | Peliculas y Series"/>
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

<header style="margin-top: -80px; position: fixed">
    <nav style="background-color: transparent; box-shadow: none">
        <div><span><a href="javascript:history.back()" class="btn waves-effect" style="background: transparent;"><i class="bi bi-arrow-left back"></i></a></span></div>
    </nav>
</header>

<main>

    <!-- ------------ -->
    <!-- De Cartelera -->
    <!-- ------------ -->
    <section class="actor-en-cartelera">
    <%
        Boolean actorEncontrado = false;
        if (request.getParameter("idactor")!=null){

        int cont = 0;

        if(lc.getCantidad() > 0){

            //1. ubicar el primer elemento de la lista
            lc.setActual(lc.getUltimo());

            while (cont < lc.getCantidad() && lc.getActual()!=null){

                    Pelicula actualExterior = lc.getActual();

                    if (lc.getActual().getRaiz()!=null){

                    //RECORRIDO PREORDEN DE LOS ACTORES
                    Actores root = lc.getActual().getRaiz();
                    if(root==null) return;
                    Stack<Actores> s = new Stack<>();
                    while (!s.isEmpty()||root!=null){
                        while(root!=null){

                            if (root.getId().equals(request.getParameter("idactor")) && actorEncontrado==false){

                                actorEncontrado=true;
                %>

                            <section class="perfil-actor">
                                <h3 style="text-align: center; margin-top: -30px">Información Sobre el Actor</h3><br>
                                <div class="fila">
                                    <div class="columna center">
                                        <img class="actor-imagen-desc" src="<%= root.getFotoActor() %>" alt="<%= root.getNombreActor() %>" loading="lazy">
                                    </div>

                                    <div class="columna">
                                        <h3 class="actor-nombre-desc"><%= root.getNombreActor() %></h3>
                                        <p>An American actor who has appeared on film, stage, and television. Baldwin first gained recognition through television for his work, for two seasons (6 and 7), on the soap opera Knots Landing, in the role of Joshua Rush. He has since played both leading and supporting roles in films such as Beetlejuice (1988), The Hunt for Red October (1990), The Marrying Man (1991), The Shadow (1994), Notting Hill (1999), Thomas and the Magic Railroad (2000), Final Fantasy: The Spirits Within (2001), The Aviator (2004) and The Departed (2006). His performance in the 2003 film The Cooler garnered him a nomination for the Academy Award for Best Supporting Actor. Since 2006 he has starred as Jack Donaghy on the NBC sitcom 30 Rock, receiving critical acclaim for his performance and winning two Emmy Awards, four Golden Globe Awards, and seven Screen Actors Guild Awards for his work on the show, making him the single male with most SAG's ever. He is the oldest of the Baldwin brothers working in Hollywood.</p>

                                        <h4>Peliculas en las que aparece este actor</h4>

                                        <div class="carousel carousel2">


                                            <%
                                                int cont2 = 0;

                                                if(lc.getCantidad() > 0){

                                                    //1. ubicar el primer elemento de la lista
                                                    lc.setActual(lc.getUltimo());

                                                    while (cont2 < lc.getCantidad() && lc.getActual()!=null){

                                                        if (lc.getActual().getRaiz()!=null){

                                                        //RECORRIDO PREORDEN DE LOS ACTORES
                                                        Actores root2 = lc.getActual().getRaiz();
                                                        if(root2==null) return;
                                                        Stack<Actores> s2 = new Stack<>();
                                                        while (!s2.isEmpty()||root2!=null){
                                                            while(root2!=null){

                                                                if (root.getId().equals(root2.getId())){

                                            %>

                                                            <a class="carousel-item popular-item" href="descripcion.jsp?idc=<%= lc.getActual().getId() %>"><img src="<%= lc.getActual().getImagen() %>"> <span><%= lc.getActual().getNombrePelicula() %></span></a>

                                            <%
                                                                }

                                                                s2.push(root2);
                                                                root2=root2.getNodoIzq();
                                                            }
                                                            if(!s2.isEmpty()){
                                                                Actores t = s2.pop();
                                                                root2=t.getNodoDer();
                                                            }
                                                        }

                                                        }

                                                        //3. Identificar su siguiente nodo
                                                        lc.setActual(lc.getActual().getSiguiente());
                                                        cont2++;

                                                    }

                                                }

                                            %>


                                            <%

                                                if(lde.getCantidad() > 0){

                                                    //1. ubicar el primer elemento de la lista
                                                    lde.setActual(lde.getPrimero());

                                                    while (lde.getActual()!=null){

                                                        if (lde.getActual().getRaiz()!=null){

                                                        //RECORRIDO PREORDEN DE LOS ACTORES
                                                        Actores root3 = lde.getActual().getRaiz();
                                                        if(root3==null) return;
                                                        Stack<Actores> s3 = new Stack<>();
                                                        while (!s3.isEmpty()||root3!=null){
                                                            while(root3!=null){

                                                                if (root.getId().equals(root3.getId())){

                                            %>

                                                                    <a class="carousel-item popular-item" href="descripcion.jsp?idlde=<%= lde.getActual().getId() %>"><img src="<%= lde.getActual().getImagen() %>"> <span><%= lde.getActual().getNombrePelicula() %></span></a>

                                            <%

                                                                }

                                                                s3.push(root3);
                                                                root3=root3.getNodoIzq();
                                                            }
                                                            if(!s3.isEmpty()){
                                                                Actores t = s3.pop();
                                                                root3=t.getNodoDer();
                                                            }
                                                        }

                                                        }

                                                        //3. Identificar su siguiente nodo
                                                        lde.setActual(lde.getActual().getSiguiente());

                                                    }

                                                }

                                            %>

                                        </div>

                                    </div>


                                </div>

                            </section>

                <%
                                break;
                            }

                            s.push(root);
                            root=root.getNodoIzq();
                        }
                        if(!s.isEmpty()){
                            Actores t = s.pop();
                            root=t.getNodoDer();
                        }
                    }

                    }

                        //3. Identificar su siguiente nodo
                        lc.setActual(actualExterior.getSiguiente());
                        cont++;

                }



            }

        }

    %>
    </section>

    <section class="actor-en-populares">
        <%
            if (request.getParameter("idactor")!=null){

                if(lde.getCantidad() > 0){

                    //1. ubicar el primer elemento de la lista
                    lde.setActual(lde.getPrimero());

                    while (lde.getActual()!=null){

                        Pelicula actualExterior = lde.getActual();

                        if (lde.getActual().getRaiz()!=null){

                        //RECORRIDO PREORDEN DE LOS ACTORES
                        Actores root4 = lde.getActual().getRaiz();
                        if(root4==null) return;
                        Stack<Actores> s4 = new Stack<>();
                        while (!s4.isEmpty()||root4!=null){
                            while(root4!=null){

                                if (root4.getId().equals(request.getParameter("idactor")) && actorEncontrado==false){

                                    actorEncontrado=true;
        %>

                                    <section class="perfil-actor">
                                        <h3 style="text-align: center; margin-top: -30px">Información Sobre el Actor</h3><br>
                                        <div class="fila">
                                            <div class="columna center">
                                                <img class="actor-imagen-desc" src="<%= root4.getFotoActor() %>" alt="<%= root4.getNombreActor() %>" loading="lazy">
                                            </div>

                                            <div class="columna">
                                                <h3 class="actor-nombre-desc"><%= root4.getNombreActor() %></h3>
                                                <p>An American actor who has appeared on film, stage, and television. Baldwin first gained recognition through television for his work, for two seasons (6 and 7), on the soap opera Knots Landing, in the role of Joshua Rush. He has since played both leading and supporting roles in films such as Beetlejuice (1988), The Hunt for Red October (1990), The Marrying Man (1991), The Shadow (1994), Notting Hill (1999), Thomas and the Magic Railroad (2000), Final Fantasy: The Spirits Within (2001), The Aviator (2004) and The Departed (2006). His performance in the 2003 film The Cooler garnered him a nomination for the Academy Award for Best Supporting Actor. Since 2006 he has starred as Jack Donaghy on the NBC sitcom 30 Rock, receiving critical acclaim for his performance and winning two Emmy Awards, four Golden Globe Awards, and seven Screen Actors Guild Awards for his work on the show, making him the single male with most SAG's ever. He is the oldest of the Baldwin brothers working in Hollywood.</p>

                                                <h4>Peliculas en las que aparece este actor</h4>

                                                <div class="carousel carousel2">


                                                    <%
                                                        int cont5 = 0;

                                                        if(lc.getCantidad() > 0){

                                                            //1. ubicar el primer elemento de la lista
                                                            lc.setActual(lc.getUltimo());

                                                            while (cont5 < lc.getCantidad() && lc.getActual()!=null){

                                                                if (lc.getActual().getRaiz()!=null){

                                                                //RECORRIDO PREORDEN DE LOS ACTORES
                                                                Actores root5 = lc.getActual().getRaiz();
                                                                if(root5==null) return;
                                                                Stack<Actores> s5 = new Stack<>();
                                                                while (!s5.isEmpty()||root5!=null){
                                                                    while(root5!=null){

                                                                        if (root4.getId().equals(root5.getId())){

                                                    %>

                                                    <a class="carousel-item popular-item" href="descripcion.jsp?idc=<%= lc.getActual().getId() %>"><img src="<%= lc.getActual().getImagen() %>"> <span><%= lc.getActual().getNombrePelicula() %></span></a>

                                                    <%
                                                                        }

                                                                        s5.push(root5);
                                                                        root5=root5.getNodoIzq();
                                                                    }
                                                                    if(!s5.isEmpty()){
                                                                        Actores t = s5.pop();
                                                                        root5=t.getNodoDer();
                                                                    }
                                                                }

                                                                }

                                                                //3. Identificar su siguiente nodo
                                                                lc.setActual(lc.getActual().getSiguiente());
                                                                cont5++;

                                                            }

                                                        }


                                                        if(lde.getCantidad() > 0){

                                                            //1. ubicar el primer elemento de la lista
                                                            lde.setActual(lde.getPrimero());

                                                            while (lde.getActual()!=null){

                                                                if (lde.getActual().getRaiz()!=null){

                                                                //RECORRIDO PREORDEN DE LOS ACTORES
                                                                Actores root6 = lde.getActual().getRaiz();
                                                                if(root6==null) return;
                                                                Stack<Actores> s6 = new Stack<>();
                                                                while (!s6.isEmpty()||root6!=null){
                                                                    while(root6!=null){

                                                                        if (root4.getId().equals(root6.getId())){

                                                    %>

                                                                            <a class="carousel-item popular-item" href="descripcion.jsp?idlde=<%= lde.getActual().getId() %>"><img src="<%= lde.getActual().getImagen() %>"> <span><%= lde.getActual().getNombrePelicula() %></span></a>

                                                    <%

                                                                        }

                                                                        s6.push(root6);
                                                                        root6=root6.getNodoIzq();
                                                                    }
                                                                    if(!s6.isEmpty()){
                                                                        Actores t = s6.pop();
                                                                        root6=t.getNodoDer();
                                                                    }
                                                                }

                                                                }

                                                                //3. Identificar su siguiente nodo
                                                                lde.setActual(lde.getActual().getSiguiente());

                                                            }

                                                        }

                                                    %>

                                                </div>

                                            </div>


                                        </div>

                                    </section>

        <%

                                }

                                s4.push(root4);
                                root4=root4.getNodoIzq();
                            }
                            if(!s4.isEmpty()){
                                Actores t = s4.pop();
                                root4=t.getNodoDer();
                            }
                        }

                        }

                        //3. Identificar su siguiente nodo
                        lde.setActual(actualExterior.getSiguiente());

                    }



                }

            }

        %>
    </section>

    <%
        if(actorEncontrado == false){
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
</script>
</body>
</html>