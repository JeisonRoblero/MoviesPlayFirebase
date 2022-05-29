package com.proyecto.moviesplay;

public class AVL {

    private Actores raiz;
    private Actores nodoActual;
    private Actores subRaiz;
    public static int fe = 0;
    public static String tipoRotacion = "";
    public static String nodosInvolucrados = "";

    public AVL() {
        this.raiz = null;
        this.nodoActual = null;
        this.subRaiz = null;
    }

    //obtener factor de equilibrio
    public int obtenerFE(Actores nodoActual){//B
        if (nodoActual==null){
            return 0;
        }
        return getAltura(nodoActual.getNodoIzq()) - getAltura(nodoActual.getNodoDer());
    }

    //Metodo para insertar un nodo al arbol
    public void insertar(String id, String idPelicula, String nombreActor, String fotoActor){

        Actores actores = new Actores(id, idPelicula, nombreActor, fotoActor);

        if(raiz==null){
            raiz=actores;
        }else{
            raiz=insertarAVL(raiz, actores);
        }
    }

    //insertar avl
    public Actores insertarAVL(Actores nodoActual, Actores nuevo){
        if (nodoActual==null){
            return nuevo;
        }

        if (nuevo.getNombreActor().compareTo(nodoActual.getNombreActor())<0){
            nodoActual.setNodoIzq(insertarAVL(nodoActual.getNodoIzq(), nuevo));
        }else if (nuevo.getNombreActor().compareTo(nodoActual.getNombreActor())>0){
            nodoActual.setNodoDer(insertarAVL(nodoActual.getNodoDer(), nuevo));
        }else{
            return nodoActual;
        }

        nodoActual.setAltura(1+max(getAltura(nodoActual.getNodoIzq()), getAltura(nodoActual.getNodoDer())));

        int fe = obtenerFE(nodoActual);

        //rotacion a simple a la derecha
        if (fe > 1 && nuevo.getNombreActor().compareTo(nodoActual.getNodoIzq().getNombreActor())<0){
            return rightRotate(nodoActual);
        }

        //rotacion simple a la izquierda
        if (fe < -1 && nuevo.getNombreActor().compareTo(nodoActual.getNodoDer().getNombreActor())>0){
            return leftRotate(nodoActual);
        }

        //rotacion doble izquierda derecha
        if (fe > 1 && nuevo.getNombreActor().compareTo(nodoActual.getNodoIzq().getNombreActor())>0){
            nodoActual.setNodoIzq(leftRotate(nodoActual.getNodoIzq()));
            return rightRotate(nodoActual);
        }

        //rotacion doble derecha izquierda
        if (fe < -1 && nuevo.getNombreActor().compareTo(nodoActual.getNodoDer().getNombreActor())<0){
            nodoActual.setNodoDer(rightRotate(nodoActual.getNodoDer()));
            return leftRotate(nodoActual);
        }

        return nodoActual;
    }

    private int max(int a, int b) {
        return (a > b) ? a : b;
    }

    private int getAltura(Actores nodoActual){
        if (nodoActual==null){
            return 0;
        }
        return nodoActual.getAltura();
    }

    private Actores rightRotate(Actores nodoActual) {// nodoActual = Maria
        Actores nuevaRaiz = nodoActual.getNodoIzq();// Juan
        Actores temp = nuevaRaiz.getNodoDer();//NULL

        // Se realiza la rotacion
        nuevaRaiz.setNodoDer(nodoActual);//I
        nodoActual.setNodoIzq(temp);//NULL

        // Actualiza alturas
        nodoActual.setAltura(max(getAltura(nodoActual.getNodoIzq()), getAltura(nodoActual.getNodoDer())) + 1);
        nuevaRaiz.setAltura(max(getAltura(nuevaRaiz.getNodoIzq()), getAltura(nuevaRaiz.getNodoDer())) + 1);

        return nuevaRaiz;
    }

    // Rotar hacia la izquierda
    private Actores leftRotate(Actores nodoActual) {// nodoActual = Hector
        Actores nuevaRaiz = nodoActual.getNodoDer();// nuevaRaiz = Juan
        Actores temp = nuevaRaiz.getNodoIzq();//NULL

        // Se realiza la rotacion
        nuevaRaiz.setNodoIzq(nodoActual);// Hector
        nodoActual.setNodoDer(temp);//NULL

        // Actualiza alturas
        nodoActual.setAltura(max(getAltura(nodoActual.getNodoIzq()), getAltura(nodoActual.getNodoDer())) + 1);
        nuevaRaiz.setAltura(max(getAltura(nuevaRaiz.getNodoIzq()), getAltura(nuevaRaiz.getNodoDer())) + 1);

        return nuevaRaiz;
    }

    public Actores eliminar(String nombreActor, Actores raizArbol){

        raiz = eliminarAVL(raizArbol, nombreActor);

        return raiz;
    }

    private Actores eliminarAVL(Actores nodoActual, String nombreActor) {

        if (nodoActual==null){
            return nodoActual;
        }

        if (nombreActor.compareTo(nodoActual.getNombreActor())<0){
            nodoActual.setNodoIzq(eliminarAVL(nodoActual.getNodoIzq(), nombreActor));
        } else if (nombreActor.compareTo(nodoActual.getNombreActor()) > 0) {
            nodoActual.setNodoDer(eliminarAVL(nodoActual.getNodoDer(), nombreActor));
        }else {
            if (nodoActual.getNodoIzq()==null || nodoActual.getNodoDer()==null){
                Actores temp = null;
                if (temp==nodoActual.getNodoIzq()){
                    temp = nodoActual.getNodoDer();
                }else {
                    temp = nodoActual.getNodoIzq();
                }

                if (temp==null){
                    nodoActual=null;
                }else{
                    nodoActual=temp;
                }
            }else{
                Actores temp = nodoConValorMaximo(nodoActual.getNodoIzq());

                nodoActual.setId(temp.getId());
                nodoActual.setNombreActor(temp.getNombreActor());
                nodoActual.setFotoActor(temp.getFotoActor());

                nodoActual.setNodoIzq(eliminarAVL(nodoActual.getNodoIzq(), temp.getNombreActor()));
            }
        }

        if (nodoActual==null)
            return nodoActual;

        nodoActual.setAltura(max(getAltura(nodoActual.getNodoIzq()), getAltura(nodoActual.getNodoDer()))+1);

        int fe = obtenerFE(nodoActual);

        if(nodoActual.getNodoIzq()==null) {
            this.fe = 2;
        }else if (nodoActual.getNodoDer() == null){
            this.fe = -2;
        }

        //rotacion a simple a la derecha
        if (fe > 1 && obtenerFE(nodoActual.getNodoIzq())>=0){
            Actores rotacion = rightRotate(nodoActual);
            tipoRotacion = "Rotación Izq-Izq";
            nodosInvolucrados = rotacion.getNombreActor() + " y " + rotacion.getNodoDer().getNombreActor();
            return rotacion;
        }

        //rotacion simple a la izquierda
        if (fe < -1 && obtenerFE(nodoActual.getNodoDer())<=0){
            Actores rotacion = leftRotate(nodoActual);
            tipoRotacion = "Rotación Der-Der";
            nodosInvolucrados = rotacion.getNombreActor() + " y " + rotacion.getNodoIzq().getNombreActor();
            return rotacion;
        }

        //rotacion doble izquierda derecha
        if (fe > 1 && obtenerFE(nodoActual.getNodoIzq())<0){
            nodoActual.setNodoIzq(leftRotate(nodoActual.getNodoIzq()));
            Actores rotacion = rightRotate(nodoActual);
            nodosInvolucrados = rotacion.getNombreActor() + ", " + rotacion.getNodoDer().getNombreActor() + " y " + rotacion.getNodoIzq().getNombreActor();
            tipoRotacion = "Rotación Izq-Der";
            return rotacion;
        }

        //rotacion doble derecha izquierda
        if (fe < -1 && obtenerFE(nodoActual.getNodoDer())>0){
            nodoActual.setNodoDer(rightRotate(nodoActual.getNodoDer()));
            Actores rotacion = leftRotate(nodoActual);
            nodosInvolucrados = rotacion.getNombreActor() + ", " + rotacion.getNodoDer().getNombreActor() + " y " + rotacion.getNodoIzq().getNombreActor();
            tipoRotacion = "Rotación Der-Izq";
            return rotacion;
        }
        return nodoActual;
    }

    public Actores nodoConValorMaximo(Actores nodo){
        Actores maximo = nodo;

        while (maximo.getNodoDer()!=null){
            maximo=maximo.getNodoDer();
        }
        return maximo;
    }

    public Actores getRaiz() {
        return raiz;
    }

    public void setRaiz(Actores raiz) {
        this.raiz = raiz;
    }

    @Override
    public String toString() {
        return "ABB{" +
                ", raiz=" + raiz +
                ", nodoActual=" + nodoActual +
                ", subRaiz=" + subRaiz +
                '}';
    }
}