package com.project;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.sql.*;

@WebServlet("/uploadProject")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class UploadProjectServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = (String) request.getSession().getAttribute("student");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String hackathon_id = request.getParameter("hackathon_id");
        String team_name = request.getParameter("team_name");
        String project_title = request.getParameter("project_title");

        Part filePart = request.getPart("file");
        
        //String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
        String fileName = null;

        String contentDisp = filePart.getHeader("content-disposition");

        String[] items = contentDisp.split(";");

        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                fileName = s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }

        String uploadPath = "F:" + File.separator + "uploads" + File.separator;
        // check if directory exists
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            boolean created = uploadDir.mkdirs();  // creates directory (including parent folders)

        if (created) {
            System.out.println("Directory created successfully");
        } else {
            System.out.println("Failed to create directory");
        }
    }
        System.out.println("UploadPath:"+uploadPath);
        filePart.write(uploadPath + fileName);

        Connection con = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hackathon_db", "root", "root");

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO project_uploads(hackathon_id, team_name, project_title, uploaded_by, file_name, file_path) VALUES(?,?,?,?,?,?)"
            );

            ps.setString(1, hackathon_id);
            ps.setString(2, team_name);
            ps.setString(3, project_title);
            ps.setString(4, username);
            ps.setString(5, fileName);
            ps.setString(6, "uploads/" + fileName);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("upload_project.jsp?success=1");
    }
}