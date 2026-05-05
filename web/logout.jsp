<%
session.invalidate();
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.sendRedirect("index.jsp");
%>
