package com.proyecto.moviesplay;

public class Pelicula {

    private String id;
    private String idActores;
    private Actores raiz;
    private String nombrePelicula;
    private String nombreOriginal;
    private String resenia;
    private String sinopsis;
    private String imagen;
    private String trailer;
    private String video;
    private Pelicula anterior;
    private Pelicula siguiente;

    public Pelicula(Actores raiz, String id, String nombrePelicula, String nombreOriginal, String resenia, String sinopsis, String imagen, String trailer, String video) {
        this.id = id;
        this.raiz = raiz;
        this.nombrePelicula = nombrePelicula;
        this.nombreOriginal = nombreOriginal;
        this.resenia = resenia;
        this.sinopsis = sinopsis;
        this.imagen = imagen;
        this.trailer = trailer;
        this.video = video;
        this.anterior = null;
        this.siguiente = null;
    }

    public String getIdActores() {
        return idActores;
    }

    public Actores getRaiz() {
        return raiz;
    }

    public void setRaiz(Actores raiz) {
        this.raiz = raiz;
    }

    public void setNombrePelicula(String nombrePelicula) {
        this.nombrePelicula = nombrePelicula;
    }

    public void setNombreOriginal(String nombreOriginal) {
        this.nombreOriginal = nombreOriginal;
    }

    public void setResenia(String resenia) {
        this.resenia = resenia;
    }

    public void setSinopsis(String sinopsis) {
        this.sinopsis = sinopsis;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public void setTrailer(String trailer) {
        this.trailer = trailer;
    }

    public void setVideo(String video) {
        this.video = video;
    }

    public void setAnterior(Pelicula anterior) {
        this.anterior = anterior;
    }

    public void setSiguiente(Pelicula siguiente) {
        this.siguiente = siguiente;
    }

    public String getNombrePelicula() {
        return nombrePelicula;
    }

    public String getNombreOriginal() {
        return nombreOriginal;
    }

    public String getResenia() {
        return resenia;
    }

    public String getSinopsis() {
        return sinopsis;
    }

    public String getImagen() {
        return imagen;
    }

    public Pelicula getAnterior() {
        return anterior;
    }

    public Pelicula getSiguiente() {
        return siguiente;
    }

    public String getTrailer() {
        return trailer;
    }

    public String getVideo() {
        return video;
    }

    public String getId() {
        return id;
    }

}