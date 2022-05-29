<%@ page contentType="text/html; charset=UTF-8" %>

<%
String idadmin=(String)session.getAttribute("idadmin");
String idusuario=(String)session.getAttribute("idusuario");
if(idadmin!=null || idusuario!=null)
{
    response.sendRedirect("./");
}else{
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link rel="shortcut icon" href="images/favicon.png" type="image/x-icon">
    <title>Iniciar Sesión | Movies </title>

    <!--=== Color de barra superior ====-->
    <meta name="theme-color" content="#131313"/>

    <!-- Inicio Meta Etiquetas para Redes Sociales y SEO -->
    <meta property="og:image" itemprop="image" content="images/favicon.png"/>
    <meta property="og:site_name" content="Inicia Sesión | Movies | Peliculas y Series"/>
    <meta property="og:title" content="Inicia Sesión | Movies | Peliculas y Series"/>
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
</head>
<body>
    
    <header>
        <nav style="background-color: transparent; box-shadow: none">
            <div class="logo"><span><a href="./" title="Ir a Inicio">Movies</a></span></div>
        </nav>
    </header>

    <main>
        <div class="fondo-login">
            <img src="./images/fondo-login.jpg" alt="Fondo Login">
        </div>

        <div class="login-container">
            <div class="container-form">
                <h4 class="titulo-form">Iniciar Sesión</h4>
               <div class="row">
                    <form class="col s12 form-inputs" method="post" action="./validate-user.jsp">

                        <div class="row email">
                            <div class="input-field col s12">
                            <input id="email" type="email" name="txtmail" class="validate" required>
                            <label for="email">Email</label>
                            </div>
                        </div>
                        
                        <div class="row password">
                            <div class="input-field col s12">
                            <input id="password" type="password" name="txtpass" class="validate" required>
                            <label for="password">Password</label>
                            </div>
                        </div>

                        <div class="invalido" style="background: #E87C03; padding: 20px; border-radius:0.5rem">
                            <p>Lo sentimos, no podemos encontrar una cuenta con esta dirección de correo electrónico. Vuelva a intentarlo o cree una cuenta nueva.</p>
                        </div>

                        <style>
                            .invalido {
                                display: none;
                            }
                        </style>

                        <button class="btn waves-effect waves-light submit-btn" type="submit" name="action" style="background: #E50914; text-transform: capitalize; font-size: 1.1rem; font-weight: 700; height: 3.3rem">Iniciar Sesión</button>
                    
                    
                    </form>
                </div>
            </div>
        </div>

        <%-- Validando usuario --%>
        <% 
            if(request.getParameter("valid")!=null){
                String valid = request.getParameter("valid");

                if(valid.equals("false")){
        %>
                    <script>
                        const invalido = document.querySelector('.invalido');

                        invalido.style.display = 'block';
                    </script>
        <%
                }else{
        %>
                    <script>
                        const invalido = document.querySelector('.invalido');

                        invalido.style.display = 'none';
                    </script>
        <%
                }

            }
        %>
        
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

    <script src="./js/app.js"></script>

    <!-- Materialize Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
</body>
</html>

<%
}
%>