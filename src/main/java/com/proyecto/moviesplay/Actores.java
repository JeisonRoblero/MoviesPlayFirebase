package com.proyecto.moviesplay;

public class Actores {

    private String id;
    private String idPelicula;
    private String nombreActor;
    private String fotoActor;
    private Actores nodoIzq;
    private Actores nodoDer;
    private int altura;
    private int fe;
    private String tipoRotacion;
    private String nodosInvolucradosRotacion;

    public Actores(String id, String idPelicula, String nombreActor, String fotoActor) {
        this.id = id;
        this.idPelicula = idPelicula;
        this.nombreActor = nombreActor;
        this.fotoActor = fotoActor;
        this.nodoIzq = null;
        this.nodoDer = null;
        this.altura = 1;
        this.fe = 0;
        this.tipoRotacion = "";
        this.nodosInvolucradosRotacion = "";
    }

    public String getId() {
        return id;
    }

    public String getIdPelicula() {
        return idPelicula;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNombreActor() {
        return nombreActor;
    }

    public void setNombreActor(String nombreActor) {
        this.nombreActor = nombreActor;
    }

    public String getFotoActor() {
        return fotoActor;
    }

    public void setFotoActor(String fotoActor) {
        this.fotoActor = fotoActor;
    }

    public Actores getNodoIzq() {
        return nodoIzq;
    }

    public void setNodoIzq(Actores nodoIzq) {
        this.nodoIzq = nodoIzq;
    }

    public Actores getNodoDer() {
        return nodoDer;
    }

    public void setNodoDer(Actores nodoDer) {
        this.nodoDer = nodoDer;
    }

    public int getAltura() {
        return altura;
    }

    public void setAltura(int altura) {
        this.altura = altura;
    }

    public int getFe() {
        return fe;
    }

    public void setFe(int fe) {
        this.fe = fe;
    }

    public String getTipoRotacion() {
        return tipoRotacion;
    }

    public void setTipoRotacion(String tipoRotacion) {
        this.tipoRotacion = tipoRotacion;
    }

    public String getNodosInvolucradosRotacion() {
        return nodosInvolucradosRotacion;
    }

    public void setNodosInvolucradosRotacion(String nodosInvolucradosRotacion) {
        this.nodosInvolucradosRotacion = nodosInvolucradosRotacion;
    }

    @Override
    public String toString() {
        return "Actores{" +
                "nombreActor='" + nombreActor + '\'' +
                '}';
    }
}