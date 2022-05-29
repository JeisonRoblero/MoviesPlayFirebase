package com.proyecto.moviesplay;

public class ListaDoblementeEnlazada {
    private Pelicula primero;
    private Pelicula ultimo;
    private Pelicula actual;
    private Pelicula anterior;
    private int cantidad;

    public ListaDoblementeEnlazada() {
        this.primero = null;
        this.ultimo = null;
        this.actual = null;
        this.anterior = null;
        this.cantidad = 0;
    }

    public void agregarDoblementeEnlazada(Actores raiz, String id, String nombrePelicula, String nombreOriginal, String resenia, String sinopsis, String imagen, String trailer, String video){

        //1. Crear un nodo e inicializar el campo dato al nuevo elemento (info).
        // La referencia del nodo creado se asigna a nuevo, variable local del método.
        Pelicula pelicula = new Pelicula(raiz, id, nombrePelicula, nombreOriginal, resenia, sinopsis, imagen, trailer, video);

        //4. Asignar el valor del primero únicamente cuando la lista se encuentra vacía
        if( cantidad == 0 ){
            primero = pelicula;
            ultimo = pelicula;
            anterior = null;
            primero.setAnterior(null);
            primero.setSiguiente(null);
        }else{
            //2. El puntero siguiente del ultimo nodo debe apuntar al nuevoNodo
            ultimo.setSiguiente(pelicula);
            anterior = ultimo;
            ultimo = pelicula;
            ultimo.setAnterior(anterior);
            ultimo.setSiguiente(null);
        }

        cantidad++;
    }

    public void eliminarDoblementeEnlazado(String id) {

        actual = primero;

        //3. Se recorre mientras el elemento del puntero "actual" no sea igual a null y mientras no se encuentre el dato a buscar
        while (actual != null && !actual.getId().equals(id)) {
            actual = actual.getSiguiente();
        }

        if(cantidad==1){
            actual = null;
        }else if(actual == primero){
            primero = actual.getSiguiente();
            primero.setAnterior(null);
        }else {
            if (actual == ultimo) {
                actual.getAnterior().setSiguiente(actual.getSiguiente());
                ultimo = actual.getAnterior();
            }else{
                actual.getAnterior().setSiguiente(actual.getSiguiente());
                actual.getSiguiente().setAnterior(actual.getAnterior());
            }
        }
        cantidad--;
    }

    public void limpiar() {
        this.primero = null;
        this.ultimo = null;
        this.actual = null;
        this.anterior = null;
        this.cantidad = 0;
    }

    public void setActual(Pelicula actual) {
        this.actual = actual;
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

    public Pelicula getAnterior() {
        return anterior;
    }

    public int getCantidad() {
        return cantidad;
    }
}
