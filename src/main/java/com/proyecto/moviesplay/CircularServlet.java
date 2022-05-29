package com.proyecto.moviesplay;

import com.google.gson.Gson;
import net.thegreshams.firebase4j.error.FirebaseException;
import net.thegreshams.firebase4j.error.JacksonUtilityException;
import net.thegreshams.firebase4j.service.Firebase;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import static com.proyecto.moviesplay.AVLServlet.*;
import static com.proyecto.moviesplay.ObtenerDatosServlet.*;

@WebServlet(name = "CircularServlet", value = "/CircularServlet")
public class CircularServlet extends HttpServlet {

    public static int cantidad = 0;
    public static ListaCircularSimple lc =  new ListaCircularSimple();
    public static boolean flagAgregado = false;
    public static boolean flagAgregadoF = false;

    public void agregarApiACircular(boolean upload){

        if (flagAgregado==false){
            HttpClient httpClient = HttpClient.newBuilder()
                    .version(HttpClient.Version.HTTP_2)
                    .build();

            HttpRequest requestCartelera = HttpRequest.newBuilder()
                    .GET()
                    .uri(URI.create("http://api.themoviedb.org/3/movie/now_playing?api_key=35218c6b9ac7affa768d796a7aacb4fb"))
                    .build();

            try {
                HttpResponse<String> response = httpClient.send(requestCartelera, HttpResponse.BodyHandlers.ofString());
                String json = response.body();

                Gson gson = new Gson();
                PeliculasAPI peliculas = gson.fromJson(json, PeliculasAPI.class);
                Map<String, Object> listCartelera = new LinkedHashMap<>();
                lc.limpiar();

                for (int i=0; i<peliculas.getResultsP().size(); i++){
                    double reseniaDouble =  Double.parseDouble(peliculas.getResultsP().get(i).getVote_average())/2;
                    // DecimalFormat df = new DecimalFormat("###.#");
                    String resenia = "" + reseniaDouble;
                    String imagen = "https://image.tmdb.org/t/p/w500" + peliculas.getResultsP().get(i).getPoster_path();
                    String trailer = null;
                    String video = null;

                    if (!upload){
                        Actores raizArbol = agregarApiAABB(peliculas.getResultsP().get(i).getId(),false);
                        lc.agregarCircular(raizArbol, peliculas.getResultsP().get(i).getId(), peliculas.getResultsP().get(i).getTitle(), peliculas.getResultsP().get(i).getOriginal_title(), resenia, peliculas.getResultsP().get(i).getOverview(), imagen, trailer, video);
                    } else if (upload){

                        dataMapMovie = new LinkedHashMap<>();
                        dataMapMovie.put("id", peliculas.getResultsP().get(i).getId());
                        dataMapMovie.put("title", peliculas.getResultsP().get(i).getTitle());
                        dataMapMovie.put("original_title", peliculas.getResultsP().get(i).getOriginal_title());
                        dataMapMovie.put("vote_average", resenia);
                        dataMapMovie.put("overview", peliculas.getResultsP().get(i).getOverview());
                        dataMapMovie.put("poster_path", imagen);
                        dataMapMovie.put("trailer", trailer);
                        dataMapMovie.put("video", video);
                        dataMapMovie.put("actors", "");

                        agregarApiAABB(peliculas.getResultsP().get(i).getId(),true);

                        listCartelera.put(""+i, dataMapMovie);

                    }

                }

                if (upload) {
                    Firebase firebaseCartelera = new Firebase("https://moviesplay-e16c5-default-rtdb.firebaseio.com/peliculas/cartelera/results");
                    firebaseCartelera.patch(listCartelera);
                }

                flagAgregado = true;
            } catch (Exception | FirebaseException | JacksonUtilityException e) {
                e.printStackTrace();
            }
        }

    }

    public void agregarFirebaseACircular(){

        if (flagAgregadoF==false){
            HttpClient httpClient = HttpClient.newBuilder()
                    .version(HttpClient.Version.HTTP_2)
                    .build();

            HttpRequest requestCartelera = HttpRequest.newBuilder()
                    .GET()
                    .uri(URI.create("https://moviesplay-e16c5-default-rtdb.firebaseio.com/peliculas/cartelera.json"))
                    .build();

            try {
                HttpResponse<String> response = httpClient.send(requestCartelera, HttpResponse.BodyHandlers.ofString());
                String json = response.body();

                Gson gson = new Gson();
                PeliculasFirebaseAPI peliculasFirebase = gson.fromJson(json, PeliculasFirebaseAPI.class);
                Actores raizArbol;
                // lc.limpiar();

                for (int i=0; i<peliculasFirebase.getResults().size(); i++){

                    arbolNodo.setRaiz(null);

                    if (peliculasFirebase.getResults().get(i).getActors().size()>1) {
                        for (int j = 0; j < peliculasFirebase.getResults().get(i).getActors().size(); j++) {
                            String idActor = peliculasFirebase.getResults().get(i).getActors().get(j).getId();
                            String idPelicula = peliculasFirebase.getResults().get(i).getActors().get(j).getIdMovie();
                            String nombreActor = peliculasFirebase.getResults().get(i).getActors().get(j).getName();
                            String imagenActor = peliculasFirebase.getResults().get(i).getActors().get(j).getProfile_path();
                            arbolNodo.insertar(idActor, idPelicula, nombreActor, imagenActor);
                        }
                    }

                    raizArbol = arbolNodo.getRaiz();

                    lc.agregarCircular(raizArbol, peliculasFirebase.getResults().get(i).getId(), peliculasFirebase.getResults().get(i).getTitle(), peliculasFirebase.getResults().get(i).getOriginal_title(), peliculasFirebase.getResults().get(i).getVote_average(), peliculasFirebase.getResults().get(i).getOverview(), peliculasFirebase.getResults().get(i).getPoster_path(), peliculasFirebase.getResults().get(i).getTrailer(), peliculasFirebase.getResults().get(i).getVideo());

                }

                flagAgregadoF = true;

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        if(request.getParameter("op").equals("add")){

            String idCircular = request.getParameter("idcircular");
            String nombrePelicula = request.getParameter("nombre_pelicula");
            String nombreOriginal = request.getParameter("nombre_original");
            String resenia = request.getParameter("resenia");
            String sinopsis = request.getParameter("sinopsis");
            String imagen = request.getParameter("imagen");
            String trailer = request.getParameter("video");
            String video = request.getParameter("pelicula");

            lc.agregarCircular(null, idCircular, nombrePelicula, nombreOriginal, resenia, sinopsis, imagen, trailer, video);

            cantidad ++;

            cambio = "nuevaAgregada";

            response.sendRedirect("./");

        }else if(request.getParameter("op").equals("edit")){

            String idCircular = request.getParameter("idcircular");
            String nombrePeliculaN = request.getParameter("nombre_pelicula_n");
            String nombreOriginalN = request.getParameter("nombre_original_n");
            String reseniaN = request.getParameter("resenia_n");
            String sinopsisN = request.getParameter("sinopsis_n");
            String imagenN = request.getParameter("imagen_n");
            String trailerN = request.getParameter("video_n");
            String videoN = request.getParameter("pelicula_n");

            int cont3 = 0;

            lc.setActual(lc.getPrimero());

            while (cont3 < lc.getCantidad() && lc.getActual()!=null){

                if(idCircular.equals(lc.getActual().getId())){
                    lc.getActual().setNombrePelicula(nombrePeliculaN);
                    lc.getActual().setNombreOriginal(nombreOriginalN);
                    lc.getActual().setResenia(reseniaN);
                    lc.getActual().setSinopsis(sinopsisN);
                    lc.getActual().setImagen(imagenN);
                    lc.getActual().setTrailer(trailerN);
                    lc.getActual().setVideo(videoN);

                    cambio = "nuevaModificada";

                    if(request.getParameter("from")!=null && request.getParameter("from").equals("desc")){
                        response.sendRedirect("descripcion.jsp?idc="+lc.getActual().getId());
                    }else {
                        response.sendRedirect("./");
                    }
                }

                //3. Identificar su siguiente nodo
                lc.setActual(lc.getActual().getSiguiente());
                cont3++;
            }

        }

    }


    public void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String idCircular = request.getParameter("idcircular");

        lc.eliminarCirular(idCircular);

        cambio = "nuevaEliminada";

    }

    public void destroy() {
    }
}