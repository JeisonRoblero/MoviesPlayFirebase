<%

    String email = request.getParameter("txtmail");    
    String pwd = request.getParameter("txtpass");
    

    if (email.equals("admin@admin") && pwd.equals("admin")) {
        session.setAttribute("idadmin", email);
        response.sendRedirect("./");
    }else if (email.equals("usuario@usuario") && pwd.equals("usuario")) {
        session.setAttribute("idusuario", email);
        response.sendRedirect("./");
    }else {
        response.sendRedirect("./login.jsp?valid=false");
    }
    
%>