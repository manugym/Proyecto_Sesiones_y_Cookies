<%-- 
    Document   : index
    Created on : May 24, 2024, 18:00:00 PM
    Author     : manuel munoz
--%>

<%@page import="clases.Carrito"%>
<%@page import="clases.ElementoDeCarrito"%>
<%@page import="java.util.ArrayList"%>
<%@page import="clases.Producto"%>
<%@page import="clases.Catalogo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tienda de Estilográficas</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css?family=Great+Vibes&display=swap" rel="stylesheet">
        <style>
            h1 {
                font-family: 'Great Vibes', cursive;
                font-size: 6em;
            }
            .carrito {
                border: #ffc107 solid 2px;
                border-radius: 6px;
                padding: 4px;
            }
        </style>
    </head>
    <body>
      <%--
        Al iniciar la página se recoge el idioma de la sesión, si no hay 
        ninguno establecido, se establecerá por defecto en español, si hay alguno
        se recogera de la sesión y se establecerá como idioma actual para la página
      
        Posteriormente se busca la cookie carrito para ver el contenido actual
        del carrito, si este está vacío, se establecera un carrito vacío. En caso
        de tener contenido, se creará un carrito nuevo con los productos que
        haya almacenados en la cookie
      --%>

        <%
          String idioma;
          if (session.getAttribute("idioma") == null) {
            session.setAttribute("idioma", "es");
            } else {
            session.getAttribute("idioma");
            }
      
          idioma = (String)session.getAttribute("idioma");
          Catalogo catalogo = new Catalogo();
          catalogo.cargaDatos();
          
        %>

        <%
            Cookie cookie = dameCookie(request, "carrito");
            Carrito carrito;
            
            if (cookie == null) {
                cookie = new Cookie("carrito", "");
                cookie.setPath("/");
                cookie.setMaxAge(365 * 24 * 60 * 60);
                response.addCookie(cookie);
                carrito = new Carrito();
            } else {
                carrito = new Carrito(cookie.getValue());
            }
            
            
            
        %>
        <br>

        <div class="container">
            <a href="cambia-idioma.jsp?idioma=es">
                <img src="img/es.svg" width="30" height="15">
            </a>

            <a href="cambia-idioma.jsp?idioma=en">
                <img src="img/en.svg" width="30" height="15">
            </a>
        </div>

        <h1 class="text-center">
            <%=idioma.equals("es") ? "Tienda de Estilográficas" : "Fountain pen store" %>
        </h1>

        <div class="container">
            <div class="row">

                <!-- Catálogo de productos -->

                <div class="col">
                    <div class="row">
                        <%
                          for (Producto p : catalogo.getProductos()) {
                        %>

                        <div class="col-sm-4">
                            <div class="card">
                                <img src="img/<%= p.getImagen()%>" class="card-img-top img-fluid">
                                <div class="card-body">
                                    <h4 class="card-title"><%= p.getNombre()%></h4>
                                    <h5><%= String.format("%.2f", p.getPrecio()) %> €</h5>
                                    <a href="compra.jsp?codigo=<%= p.getCodigo()%>" class="btn btn-primary">
                                        <%=idioma.equals("es") ? "Añadir al carrito" : "Add to cart" %>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <%
                          }
                        %>
                    </div>
                </div>


                <!-- Catálogo de productos -->

                <div class="col-3">
                    <div class="carrito">
                        <img src="img/cart.svg" width="36px">   
                        <%
                          for (ElementoDeCarrito e : carrito.getElementos()) {
                        %>
                        <div class="card">
                            <img src="img/<%= e.getProducto().getImagen()%>" class="card-img-top img-fluid">
                            <div class="card-body">
                                <%= e.getProducto().getNombre() %><br>
                                <%= String.format("%.2f", e.getProducto().getPrecio()) %> €<br>
                                <%= e.getCantidad() %> <%=idioma.equals("es") ? "unidades" : "units" %> <br>
                                <a href="elimina.jsp?codigo=<%= e.getProducto().getCodigo() %>" class="btn btn-warning text-white">
                                    <%=idioma.equals("es") ? "Eliminar" : "Remove" %>
                                </a>
                            </div>
                        </div>
                        <%
                          }
                        %>
                    </div>
                </div>
            </div>
        </div>


        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>

<%!
    public static Cookie dameCookie(HttpServletRequest request, String nombre) {
        Cookie[] cookies = request.getCookies();
            if (cookies != null) {
               for (Cookie cookie : cookies) {
                   if (cookie.getName().equals(nombre)) {
                       return cookie;
                      }
                }
            }
            return null;
        }
%>