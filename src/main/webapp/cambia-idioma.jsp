<%-- 
    Document   : cambia-idioma
    Created on : May 24, 2024, 18:00:00?PM
    Author     : manuel munoz
--%>
<%--
Este jsp recoge el parámetro idioma del formulario en index.jsp y lo establece
como el idioma guardado en el atributo de la sesión "idioma"
--%>

<%
  session.setAttribute("idioma", request.getParameter("idioma"));

  response.sendRedirect("index.jsp");
%>
