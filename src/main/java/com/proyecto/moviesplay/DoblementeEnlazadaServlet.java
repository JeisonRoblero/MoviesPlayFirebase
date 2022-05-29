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
import java.util.LinkedHashMap;
import java.util.Map;

import static com.proyecto.moviesplay.AVLServlet.*;
import static com.proyecto.moviesplay.ObtenerDatosServlet.*;

@WebServlet(name = "DoblementeEnlazadaServlet", value = "/DoblementeEnlazadaServlet")
public class DoblementeEnlazadaServlet extends HttpServlet {

    public static ListaDoblementeEnlazada lde = new ListaDoblementeEnlazada();
    public static boolean flagAgregadoP = false;
    public static boolean flagAgregadoPF = false;

    public void agregarApiALde(boolean upload){

        if (flagAgregadoP==false) {
            HttpClient httpClient = HttpClient.newBuilder()
                    .version(HttpClient.Version.HTTP_2)
                    .build();

            HttpRequest requestPopulares = HttpRequest.newBuilder()
                    .GET()
                    .uri(URI.create("http://api.themoviedb.org/3/movie/popular?api_key=35218c6b9ac7affa768d796a7aacb4fb"))
                    .build();

            try {
                HttpResponse<String> response = httpClient.send(requestPopulares, HttpResponse.BodyHandlers.ofString());
                String json = response.body();

                Gson gson = new Gson();
                PeliculasAPI peliculasP = gson.fromJson(json, PeliculasAPI.class);
                Map<String, Object> listPopulares = new LinkedHashMap<>();
                lde.limpiar();

                for (int i = 0; i < peliculasP.getResultsP().size(); i++) {
                    double reseniaDouble = Double.parseDouble(peliculasP.getResultsP().get(i).getVote_average()) / 2;
                    // DecimalFormat df = new DecimalFormat("###.#");
                    String resenia = "" + reseniaDouble;
                    String imagen = "https://image.tmdb.org/t/p/w500" + peliculasP.getResultsP().get(i).getPoster_path();
                    String trailer = null;
                    String video = null;

                    if (!upload){
                        Actores raizArbol = agregarApiAABB(peliculasP.getResultsP().get(i).getId(),false);
                        lde.agregarDoblementeEnlazada(raizArbol, peliculasP.getResultsP().get(i).getId(), peliculasP.getResultsP().get(i).getTitle(), peliculasP.getResultsP().get(i).getOriginal_title(), resenia, peliculasP.getResultsP().get(i).getOverview(), imagen, trailer, video);
                    } else if (upload) {

                        dataMapMovie = new LinkedHashMap<>();
                        dataMapMovie.put("id", peliculasP.getResultsP().get(i).getId());
                        dataMapMovie.put("title", peliculasP.getResultsP().get(i).getTitle());
                        dataMapMovie.put("original_title", peliculasP.getResultsP().get(i).getOriginal_title());
                        dataMapMovie.put("vote_average", resenia);
                        dataMapMovie.put("overview", peliculasP.getResultsP().get(i).getOverview());
                        dataMapMovie.put("poster_path", imagen);
                        dataMapMovie.put("trailer", trailer);
                        dataMapMovie.put("video", video);
                        dataMapMovie.put("actors", "");

                        agregarApiAABB(peliculasP.getResultsP().get(i).getId(),true);

                        listPopulares.put(""+i, dataMapMovie);
                    }
                }

                if (upload) {
                    Firebase firebasePopulares = new Firebase("https://moviesplay-e16c5-default-rtdb.firebaseio.com/peliculas/populares/results");
                    firebasePopulares.patch(listPopulares);
                }

                flagAgregadoP = true;
            } catch (IOException | InterruptedException | FirebaseException | JacksonUtilityException e) {
                e.printStackTrace();
            }
        }
    }

    public void agregarFirebaseAALde(){

        if (flagAgregadoPF==false){
            HttpClient httpClient = HttpClient.newBuilder()
                    .version(HttpClient.Version.HTTP_2)
                    .build();

            HttpRequest requestPopulares = HttpRequest.newBuilder()
                    .GET()
                    .uri(URI.create("https://moviesplay-e16c5-default-rtdb.firebaseio.com/peliculas/populares.json"))
                    .build();

            try {
                HttpResponse<String> response = httpClient.send(requestPopulares, HttpResponse.BodyHandlers.ofString());
                String json = response.body();

                Gson gson = new Gson();
                PeliculasFirebaseAPI peliculasFirebaseP = gson.fromJson(json, PeliculasFirebaseAPI.class);
                Actores raizArbol;
                lde.limpiar();

                for (int i=0; i<peliculasFirebaseP.getResults().size(); i++){

                    arbolNodo.setRaiz(null);

                    if (peliculasFirebaseP.getResults().get(i).getActors().size()>1) {
                        for (int j = 0; j < peliculasFirebaseP.getResults().get(i).getActors().size(); j++) {
                            String idActor = peliculasFirebaseP.getResults().get(i).getActors().get(j).getId();
                            String idPelicula = peliculasFirebaseP.getResults().get(i).getActors().get(j).getIdMovie();
                            String nombreActor = peliculasFirebaseP.getResults().get(i).getActors().get(j).getName();
                            String imagenActor = peliculasFirebaseP.getResults().get(i).getActors().get(j).getProfile_path();
                            arbolNodo.insertar(idActor, idPelicula, nombreActor, imagenActor);
                        }
                    }

                    raizArbol = arbolNodo.getRaiz();

                    lde.agregarDoblementeEnlazada(raizArbol, peliculasFirebaseP.getResults().get(i).getId(), peliculasFirebaseP.getResults().get(i).getTitle(), peliculasFirebaseP.getResults().get(i).getOriginal_title(), peliculasFirebaseP.getResults().get(i).getVote_average(), peliculasFirebaseP.getResults().get(i).getOverview(), peliculasFirebaseP.getResults().get(i).getPoster_path(), peliculasFirebaseP.getResults().get(i).getTrailer(), peliculasFirebaseP.getResults().get(i).getVideo());

                }

                flagAgregadoPF = true;

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        if(request.getParameter("op").equals("add")){

            String id = request.getParameter("idlde");
            String nombrePelicula = request.getParameter("nombre_pelicula");
            String nombreOriginal = request.getParameter("nombre_original");
            String resenia = request.getParameter("resenia");
            String sinopsis = request.getParameter("sinopsis");
            String imagen = request.getParameter("imagen");
            String trailer = request.getParameter("video");
            String video = request.getParameter("pelicula");

            lde.agregarDoblementeEnlazada(null, id, nombrePelicula, nombreOriginal, resenia, sinopsis, imagen, trailer, video);

            cambio = "nuevaAgregada";

            response.sendRedirect("./");

        }else if(request.getParameter("op").equals("edit")){

            String id = request.getParameter("idlde");
            String nombrePeliculaN = request.getParameter("nombre_pelicula_n");
            String nombreOriginalN = request.getParameter("nombre_original_n");
            String reseniaN = request.getParameter("resenia_n");
            String sinopsisN = request.getParameter("sinopsis_n");
            String imagenN = request.getParameter("imagen_n");
            String trailerN = request.getParameter("video_n");
            String videoN = request.getParameter("pelicula_n");

            lde.setActual(lde.getPrimero());

            while (lde.getActual()!=null){

                if(id.equals(lde.getActual().getId())){
                    lde.getActual().setNombrePelicula(nombrePeliculaN);
                    lde.getActual().setNombreOriginal(nombreOriginalN);
                    lde.getActual().setResenia(reseniaN);
                    lde.getActual().setSinopsis(sinopsisN);
                    lde.getActual().setImagen(imagenN);
                    lde.getActual().setTrailer(trailerN);
                    lde.getActual().setVideo(videoN);

                    cambio = "nuevaModificada";

                    if(request.getParameter("from")!=null && request.getParameter("from").equals("desc")){
                        response.sendRedirect("descripcion.jsp?idlde="+lde.getActual().getId());
                    }else {
                        response.sendRedirect("./");
                    }
                }

                //3. Identificar su siguiente nodo
                lde.setActual(lde.getActual().getSiguiente());
            }
        }
    }

    public void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("idlde");

        lde.eliminarDoblementeEnlazado(id);

        cambio = "nuevaEliminada";

    }

    public void destroy() {
    }
}
