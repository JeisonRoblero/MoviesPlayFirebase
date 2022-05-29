package com.proyecto.moviesplay;

public class ListaCircularSimple {

    private Pelicula primero;
    private Pelicula ultimo;
    private Pelicula actual;
    private int cantidad;

    public ListaCircularSimple() {
        this.ultimo = null;
        this.actual = null;
        this.cantidad = 0;
    }

    public void agregarCircular(Actores raiz, String idCircular, String nombrePelicula, String nombreOriginal, String resenia, String sinopsis, String imagen, String trailer,String video){

        //1. Crear un nodo e inicializar el campo dato al nuevo elemento (info).
        // La referencia del nodo creado se asigna a nuevo, variable local del método.
        Pelicula pelicula = new Pelicula(raiz, idCircular, nombrePelicula, nombreOriginal, resenia, sinopsis, imagen, trailer, video);

        if (cantidad == 0){
            primero = pelicula;
            ultimo = pelicula;
        }

        ultimo.setSiguiente(pelicula);

        ultimo = pelicula;

        ultimo.setSiguiente(primero);

        cantidad++;

    }

    public void eliminarCirular(String id){
        //1. ubicar el primer elemento de la lista
        actual = primero;

        //2. crear un nuevo puntero llamado anterior
        Pelicula anterior = null;

        //3. Se recorre mientras el elemento del puntero "actual" no sea igual a null y mientras no se encuentre el dato a buscar
        while (actual != null && !actual.getId().equals(id)) {
            //4. Identificar su siguiente nodo
            anterior = actual;
            actual = actual.getSiguiente();
        }

        //4. validamos si el primer dato ingresado a la lista circular es el que deseamos eliminar y lo eliminamos
        if (primero == actual) {
            primero = actual.getSiguiente();
            ultimo.setSiguiente(primero);
        } else {
            if (actual == ultimo){
                anterior.setSiguiente(actual.getSiguiente());
                ultimo = anterior;
            }else {
                //5. Establecemos que el dato anterior al que queremos eliminar apunte al dato siguiente del que queremos eliminar
                anterior.setSiguiente(actual.getSiguiente());
            }
        }

        cantidad--;

    }

    public void limpiar() {
        this.primero = null;
        this.ultimo = null;
        this.actual = null;
        this.cantidad = 0;
    }

    public Pelicula getPrimero() {
        return primero;
    }

    public Pelicula getUltimo() {
        return ultimo;
    }

    public Pelicula getActual() {
        return actual;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setActual(Pelicula actual) {
        this.actual = actual;
    }
}
