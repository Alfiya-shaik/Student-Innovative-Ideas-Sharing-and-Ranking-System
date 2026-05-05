<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
String email = request.getParameter("username");
String pwd = request.getParameter("password");

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {

    Class.forName("com.mysql.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/studentinnvotive",
        "root",
        "root"
    );

    String sql = "SELECT * FROM login WHERE username=? AND password=?";
    ps = con.prepareStatement(sql);
    ps.setString(1, email);
    ps.setString(2, pwd);

    rs = ps.executeQuery();

    if (rs.next()) {

        int auth = rs.getInt("auth");

        // ADMIN LOGIN
        if (auth == 0) {
            session.setAttribute("username", email);
            response.sendRedirect("AdminHome.jsp?msg=success");
        }

        // FACULTY LOGIN
        else if (auth == 1) {
            session.setAttribute("facultyname", email);
            response.sendRedirect("facultyHome.jsp?msg=success");
        }
        // FACULTY LOGIN
        else if (auth == 2) {
            session.setAttribute("studentname", email);
            response.sendRedirect("studentHome.jsp?msg=success");
        }

        else {
            response.sendRedirect("index.jsp?msg1=fail");
        }

    } else {
        response.sendRedirect("index.jsp?msg1=fail");
    }

} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("login.jsp?msg1=error");
} finally {
    if (rs != null) rs.close();
    if (ps != null) ps.close();
    if (con != null) con.close();
}
%>
