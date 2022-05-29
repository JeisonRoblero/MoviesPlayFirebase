package com.proyecto.moviesplay;

import net.thegreshams.firebase4j.error.FirebaseException;
import net.thegreshams.firebase4j.error.JacksonUtilityException;
import net.thegreshams.firebase4j.service.Firebase;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.*;
import static com.proyecto.moviesplay.CircularServlet.lc;
import static com.proyecto.moviesplay.DoblementeEnlazadaServlet.lde;

@WebServlet(name = "ObtenerDatosServlet", value = "/ObtenerDatosServlet")
public class ObtenerDatosServlet extends HttpServlet {

    public static boolean datosObtenidos = false;
    public static String cambio = "";
    public static String textoBF = "";
    public static String backgroundBF = "";
    public static List<Pelicula> movies = new ArrayList<Pelicula>();
    public static String rutaActores;
    public static Map<String, Object> dataMapMovie = new LinkedHashMap<>();

    /**
     * Obtiene los datos de la API de The Movies DB.
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        CircularServlet cs = new CircularServlet();
        cs.agregarApiACircular(false);

        DoblementeEnlazadaServlet des = new DoblementeEnlazadaServlet();
        des.agregarApiALde(false);

        datosObtenidos = true;
    }

    /**
     * Obtiene los datos de Firebase.
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            Firebase firebaseCartelera = new Firebase("https://moviesplay-e16c5-default-rtdb.firebaseio.com/peliculas/cartelera/results/");
            Firebase firebasePopulares = new Firebase("https://moviesplay-e16c5-default-rtdb.firebaseio.com/peliculas/populares/results/");

            String cartelera = firebaseCartelera.get().getRawBody();
            String populares = firebasePopulares.get().getRawBody();

            if (!cartelera.contains("[")){
                CircularServlet cs = new CircularServlet();
                cs.agregarApiACircular(true);
                cs.agregarFirebaseACircular();
            } else {
                CircularServlet cs = new CircularServlet();
                cs.agregarFirebaseACircular();
            }

            if (!populares.contains("[")){
                DoblementeEnlazadaServlet des = new DoblementeEnlazadaServlet();
                des.agregarApiALde(true);
                des.agregarFirebaseAALde();
            } else {
                DoblementeEnlazadaServlet des = new DoblementeEnlazadaServlet();
                des.agregarFirebaseAALde();
            }
        } catch (FirebaseException e) {
            e.printStackTrace();
        }

        datosObtenidos = true;
    }

    /**
     * Hace una copia de seguridad en Firebase de lo que se tiene hasta ese momento.
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Guarda una copia del contenido actual de la lista circular (Cartelera)
        int cont = 0;
        int i;
        if (lc.getCantidad() > 0){

            Map<String, Object> listCartelera = new LinkedHashMap<>();

            // 1. ubicar el primer elemento de la lista
            lc.setActual(lc.getPrimero());
            while (cont < lc.getCantidad() && lc.getActual()!=null) {

                Map<String, Object> dataMapMovie  = new LinkedHashMap<>();
                dataMapMovie.put("id", lc.getActual().getId());
                dataMapMovie.put("title", lc.getActual().getNombrePelicula());
                dataMapMovie.put("original_title", lc.getActual().getNombreOriginal());
                dataMapMovie.put("vote_average", lc.getActual().getResenia());
                dataMapMovie.put("overview", lc.getActual().getSinopsis());
                dataMapMovie.put("poster_path", lc.getActual().getImagen());
                dataMapMovie.put("trailer", lc.getActual().getTrailer());
                dataMapMovie.put("video", lc.getActual().getVideo());
                Map<String, Object> listActors  = new LinkedHashMap<>();

                Map<String, Object> dataMapActor  = new LinkedHashMap<>();
                dataMapActor.put("id", "");
                dataMapActor.put("idMovie", "");
                dataMapActor.put("name", "");
                dataMapActor.put("profile_path", "");

                listActors.put("0", dataMapActor);

                // Almacena a los actores si tiene;
                if (lc.getActual().getRaiz()!=null) {

                    i = 0;
                    Actores root = lc.getActual().getRaiz();
                    if (root == null) return;
                    Stack<Actores> s = new Stack<>();
                    while (!s.isEmpty() || root != null) {

                        while (root != null) {

                            // Nodo arbol
                            dataMapActor  = new LinkedHashMap<>();
                            dataMapActor.put("id", root.getId());
                            dataMapActor.put("idMovie", root.getIdPelicula());
                            dataMapActor.put("name", root.getNombreActor());
                            dataMapActor.put("profile_path", root.getFotoActor());

                            listActors.put(""+i, dataMapActor);

                            i++;

                            s.push(root);
                            root = root.getNodoIzq();
                        }
                        if (!s.isEmpty()) {
                            Actores t = s.pop();
                            root = t.getNodoDer();
                        }
                    }

                }

                dataMapMovie.put("actors", listActors);

                listCartelera.put(""+cont, dataMapMovie);

                // 3. Identificar su siguiente nodo
                lc.setActual(lc.getActual().getSiguiente());
                cont++;

            }

            try {
                Firebase firebaseCartelera = new Firebase("https://moviesplay-e16c5-default-rtdb.firebaseio.com/peliculas/cartelera/results");
                firebaseCartelera.put(listCartelera);
            } catch (FirebaseException | JacksonUtilityException e) {
                e.printStackTrace();
            }

        }

        // Guarda una copia del contenido actual de la lista doblemente enlazada (Populares)
        int cont2 = 0;
        if(lde.getCantidad() > 0){

            Map<String, Object> listPopulares = new LinkedHashMap<>();

            //1. ubicar el primer elemento de la lista
            lde.setActual(lde.getPrimero());

            while (lde.getActual()!=null){

                Map<String, Object> dataMapMovie  = new LinkedHashMap<>();
                dataMapMovie.put("id", lde.getActual().getId());
                dataMapMovie.put("title", lde.getActual().getNombrePelicula());
                dataMapMovie.put("original_title", lde.getActual().getNombreOriginal());
                dataMapMovie.put("vote_average", lde.getActual().getResenia());
                dataMapMovie.put("overview", lde.getActual().getSinopsis());
                dataMapMovie.put("poster_path", lde.getActual().getImagen());
                dataMapMovie.put("trailer", lde.getActual().getTrailer());
                dataMapMovie.put("video", lde.getActual().getVideo());
                Map<String, Object> listActors  = new LinkedHashMap<>();

                Map<String, Object> dataMapActor  = new LinkedHashMap<>();
                dataMapActor.put("id", "");
                dataMapActor.put("idMovie", "");
                dataMapActor.put("name", "");
                dataMapActor.put("profile_path", "");

                listActors.put("0", dataMapActor);

                if (lde.getActual().getRaiz()!=null){

                    i = 0;
                    Actores root = lde.getActual().getRaiz();
                    if(root==null) return;
                    Stack<Actores> s = new Stack<>();
                    while (!s.isEmpty()||root!=null){
                        while(root!=null){

                            // Nodo arbol
                            dataMapActor  = new LinkedHashMap<>();
                            dataMapActor.put("id", root.getId());
                            dataMapActor.put("idMovie", root.getIdPelicula());
                            dataMapActor.put("name", root.getNombreActor());
                            dataMapActor.put("profile_path", root.getFotoActor());

                            listActors.put(""+i, dataMapActor);

                            i++;

                            s.push(root);
                            root=root.getNodoIzq();
                        }
                        if(!s.isEmpty()){
                            Actores t = s.pop();
                            root=t.getNodoDer();
                        }
                    }


                }

                dataMapMovie.put("actors", listActors);

                listPopulares.put(""+cont2, dataMapMovie);

                // 3. Identificar su siguiente nodo
                lde.setActual(lde.getActual().getSiguiente());
                cont2++;

            }

            try {
                Firebase firebasePopulares = new Firebase("https://moviesplay-e16c5-default-rtdb.firebaseio.com/peliculas/populares/results");
                firebasePopulares.put(listPopulares);
            } catch (FirebaseException | JacksonUtilityException e) {
                e.printStackTrace();
            }

        }

        cambio = "backupActualizado";

    }

    public static void analizarCambio() {

        if(cambio.equals("nuevaAgregada")){
            textoBF = "Nueva Película ¡Crea un backup en Firebase!";
            backgroundBF = "#5900FF";
        }
        if(cambio.equals("nuevaModificada")){
            textoBF = "Película Modificada ¡Crea un backup en Firebase!";
            backgroundBF = "#009B84";
        }
        if(cambio.equals("nuevaEliminada")){
            textoBF = "Película Eliminada ¡Crea un backup en Firebase!";
            backgroundBF = "#FF4E28";
        }
        if(cambio.equals("backupActualizado")){
            textoBF = "<i class=\"bi bi-check-circle-fill\" style=\"color: #3BE23B; font-size: 1.8rem\"></i>&nbsp;Backup completo";
            backgroundBF = "#1967D2";
        }

        if(cambio.equals("")){
            textoBF = "&nbsp;Crear Backup en Firebase";
            backgroundBF = "#1967D2";
        }
    }
}
