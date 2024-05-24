package clases;

import java.util.ArrayList;

public class Carrito {

    private ArrayList<ElementoDeCarrito> elementos = new ArrayList<ElementoDeCarrito>();

    public Carrito() {
    }

    /*
    Constructor Carrito que recoge como parámetro un String con el contenido del carrito.
    El contenido está serializado y será deserializado y guardado en los objetos pertinentes
    para su posterior uso
     */
    public Carrito(String contenido) {
        if (contenido.length() > 0) {
            String[] deserializado = contenido.split("<");
            for (int i = 0; i < deserializado.length; i += 5) {
                int cantidad = Integer.parseInt(deserializado[i]);
                int codigo = Integer.parseInt(deserializado[i + 1]);
                String nombre = deserializado[i + 2];
                double precio = Double.parseDouble(deserializado[i + 3]);
                String imagen = deserializado[i + 4];

                Producto producto = new Producto(codigo, nombre, precio, imagen);
                ElementoDeCarrito elementoCarrito = new ElementoDeCarrito(producto, cantidad);

                elementos.add(elementoCarrito);

            }
        }
    }

    public Carrito(ArrayList<ElementoDeCarrito> elementos) {
        this.elementos = elementos;
    }

    public ArrayList<ElementoDeCarrito> getElementos() {
        return elementos;
    }

    public boolean existeElementoConCodigo(int codigo) {
        return this.posicionElementoConCodigo(codigo) != -1;
    }

    public void meteProductoConCodigo(int codigo) {
        if (this.existeElementoConCodigo(codigo)) {
            elementos.get(posicionElementoConCodigo(codigo)).incrementaCantidad(1);
        } else {
            Catalogo catalogo = new Catalogo();
            catalogo.cargaDatos();
            elementos.add(new ElementoDeCarrito(catalogo.productoConCodigo(codigo), 1));
        }
    }

    public void eliminaProductoConCodigo(int codigo) {
        if (existeElementoConCodigo(codigo)) {
            int i = 0;
            int posicion = 0;
            for (ElementoDeCarrito elemento : elementos) {
                if (elemento.getProducto().getCodigo() == codigo) {
                    posicion = i;
                }
                i++;
            }
            elementos.remove(posicion);
        }
    }

    private int posicionElementoConCodigo(int codigo) {
        int i = 0;
        for (ElementoDeCarrito elemento : elementos) {
            if (elemento.getProducto().getCodigo() == codigo) {
                return i;
            }
            i++;
        }
        return -1;
    }

    /*
    Este método toString guarda en una cadena String el contenido de cada producto
    que hay en el carrito, además le añade un sígno especial para usarlo al 
    deserializar en el constructor de Carrito.
     */
    @Override
    public String toString() {
        String cadena = "";
        for (ElementoDeCarrito item : elementos) {
            cadena += item.getCantidad()
                    + "<" + item.getProducto().getCodigo()
                    + "<" + item.getProducto().getNombre()
                    + "<" + item.getProducto().getPrecio()
                    + "<" + item.getProducto().getImagen()
                    + "<";
        }
        return cadena;
    }

}
