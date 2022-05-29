package com.proyecto.moviesplay;

import com.google.gson.Gson;
import net.thegreshams.firebase4j.error.FirebaseException;
import net.thegreshams.firebase4j.error.JacksonUtilityException;
import net.thegreshams.firebase4j.service.Firebase;

import javax.servlet.ServletContext;
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
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import static com.proyecto.moviesplay.ObtenerDatosServlet.dataMapMovie;
import static com.proyecto.moviesplay.AVL.fe;
import static com.proyecto.moviesplay.AVL.tipoRotacion;
import static com.proyecto.moviesplay.AVL.nodosInvolucrados;
import static com.proyecto.moviesplay.ObtenerDatosServlet.rutaActores;

@WebServlet(name = "AVLServlet", value = "/AVLServlet")
public class AVLServlet extends HttpServlet {

    public static AVL arbolNodo = new AVL();
    public static Actores root;
    public static boolean flagAgregadoA = false;
    public static int contEliminados = 0;

    public static Actores agregarApiAABB(String idPelicula, boolean upload){

            HttpClient httpClient = HttpClient.newBuilder()
                    .version(HttpClient.Version.HTTP_2)
                    .build();

            HttpRequest requestActores = HttpRequest.newBuilder()
                    .GET()
                    .uri(URI.create("https://api.themoviedb.org/3/movie/"+ idPelicula +"/credits?api_key=35218c6b9ac7affa768d796a7aacb4fb"))
                    .build();

            try {
                HttpResponse<String> response = httpClient.send(requestActores, HttpResponse.BodyHandlers.ofString());
                String json = response.body();

                Gson gson = new Gson();
                ActoresAPI actores = gson.fromJson(json, ActoresAPI.class);
                Map<String, Object> listActors  = new LinkedHashMap<>();

                arbolNodo.setRaiz(null);

                for (int i=0; i<actores.getCast().size(); i++){
                    String imagen = "";
                    if (actores.getCast().get(i).getProfile_path()!=null){
                        imagen = "https://image.tmdb.org/t/p/w500" + actores.getCast().get(i).getProfile_path();
                    } else {
                        imagen = "https://images.vexels.com/media/users/3/147102/isolated/preview/082213cb0f9eabb7e6715f59ef7d322a-icono-de-perfil-de-instagram.png";
                    }

                    if (!upload){
                        arbolNodo.insertar(actores.getCast().get(i).getId(), idPelicula, actores.getCast().get(i).getName(), imagen);
                    } else if (upload) {

                        Map<String, Object> dataMapActor  = new LinkedHashMap<>();
                        dataMapActor.put("id", actores.getCast().get(i).getId());
                        dataMapActor.put("idMovie", idPelicula);
                        dataMapActor.put("name", actores.getCast().get(i).getName());
                        dataMapActor.put("profile_path", imagen);

                        listActors.put(""+i, dataMapActor);

                    }

                }

                if (upload) {
                    dataMapMovie.put("actors", listActors);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

            return arbolNodo.getRaiz();

    }

    public void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String nombreActor = request.getParameter("nombreActor");

        ServletContext application = getServletContext();
        Actores raizArbol = (Actores) application.getAttribute("raizArbol");
        Pelicula nodoLista = (Pelicula) application.getAttribute("nodoLista");

        Actores nuevaRaiz = arbolNodo.eliminar(nombreActor,raizArbol);
        nodoLista.setRaiz(nuevaRaiz);

        if (!tipoRotacion.equals("")) {
            Map<String, Object> bitacoraMap = new LinkedHashMap<>();

            bitacoraMap.put("Factor de equilibrio", fe);
            bitacoraMap.put("Nodos en la rotación", nodosInvolucrados);
            bitacoraMap.put("Rotación", tipoRotacion);

            Map<String, Object> listBitacora = new LinkedHashMap<>();
            listBitacora.put("" + contEliminados, bitacoraMap);

            contEliminados++;

            try {
                Firebase firebaseBitacora = new Firebase("https://moviesplay-e16c5-default-rtdb.firebaseio.com/bitacora");
                firebaseBitacora.patch(listBitacora);
            } catch (FirebaseException | JacksonUtilityException e) {
                e.printStackTrace();
            }

            fe = 0;
            nodosInvolucrados = "";
            tipoRotacion = "";
        }

    }

}
