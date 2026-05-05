<%
String user = request.getParameter("username");
String pass = request.getParameter("password");

if(user.equals("admin") && pass.equals("admin123")){
    session.setAttribute("username", user);
    response.sendRedirect("AdminHome.jsp");
}else{
    response.sendRedirect("login.jsp");
}
%>
