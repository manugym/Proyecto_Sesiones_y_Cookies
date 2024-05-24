<%-- 
    Document   : elimina
    Created on : May 24, 2024, 18:00:00?PM
    Author     : manuel munoz
--%>

<%--
Este jsp recoge el parámetro código de index.jsp que se usará para eliminar
el producto del carrito. Previamente se cargará el carrito con el
método dameCookie el cual obtiene el String del carrito y permite construir
un nuevo carrito relleno con el valor obtenido
--%>

<%@page import="clases.Carrito"%>
<%
  int codigo = Integer.parseInt(request.getParameter("codigo"));
  
  Cookie cookie = dameCookie(request, "carrito");
  
  Carrito carrito = new Carrito(cookie.getValue().toString());
  carrito.eliminaProductoConCodigo(codigo);
  
  cookie = new Cookie("carrito", carrito.toString());
                cookie.setPath("/");
                cookie.setMaxAge(365 * 24 * 60 * 60);
                response.addCookie(cookie);
                
  response.sendRedirect("index.jsp");
%>


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