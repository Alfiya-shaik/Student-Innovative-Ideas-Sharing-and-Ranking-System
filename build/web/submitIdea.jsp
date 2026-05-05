<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="javax.servlet.http.Part"%>

<%!
/* ✅ Get file name (compatible with old servers) */
private String getFileName(Part part) {
    String contentDisp = part.getHeader("content-disposition");
    String[] tokens = contentDisp.split(";");
    
    for (String token : tokens) {
        if (token.trim().startsWith("filename")) {
            return token.substring(token.indexOf("=") + 2, token.length() - 1);
        }
    }
    return "";
}
%>

<%
if(session.getAttribute("studentname")==null){
%>
<script>
    window.top.location.href="login.jsp";
</script>
<%
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Submit Idea</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{ background:#f4f6f9; font-family:'Segoe UI'; }
.card{ max-width:800px; margin:auto; margin-top:30px; border-radius:15px; }
.card-header{ background:linear-gradient(90deg,#4e73df,#1cc88a); color:white; text-align:center; }
</style>
</head>

<body>
<div class="container">
<div class="card shadow">
<div class="card-header">
    💡 Submit Your Innovation Idea
</div>
<div class="card-body">

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

String message = "";
String messageType = "";

try {
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinnvotive", "root", "root");

    String studentId = session.getAttribute("studentname").toString();

    // ✅ Get student name
    ps = con.prepareStatement("select sname from student where srno=?");
    ps.setString(1, studentId);
    ResultSet rs1 = ps.executeQuery();

    String studentname = "";
    if(rs1.next()){
        studentname = rs1.getString(1);
    }

    // ✅ FORM SUBMIT
    if(request.getMethod().equalsIgnoreCase("POST")) {

        String eventId = request.getParameter("event_id");
        String title = request.getParameter("idea_title");
        String description = request.getParameter("idea_description");

        String fileName = "";
        String filePath = "";

        try {
            Part filePart = request.getPart("idea_file");

            if(filePart != null && filePart.getSize() > 0){

                fileName = getFileName(filePart);

                // ✅ Unique filename
                fileName = System.currentTimeMillis() + "_" + fileName;

                // ✅ SYSTEM DIRECTORY
                String uploadPath = "C:/IdeaUploads";

                File uploadDir = new File(uploadPath);
                if(!uploadDir.exists()){
                    uploadDir.mkdirs();
                }

                filePath = uploadPath + File.separator + fileName;

                // ✅ SAVE FILE (100% working method)
                InputStream inputStream = filePart.getInputStream();
                FileOutputStream outputStream = new FileOutputStream(filePath);

                int read = 0;
                byte[] bytes = new byte[1024];

                while ((read = inputStream.read(bytes)) != -1) {
                    outputStream.write(bytes, 0, read);
                }

                outputStream.close();
                inputStream.close();
            }

        } catch(Exception ex){
            ex.printStackTrace();
            out.println("<div class='alert alert-danger'>File Upload Error!</div>");
        }

        // ✅ INSERT INTO DATABASE
        ps = con.prepareStatement(
            "INSERT INTO submissions(student_id, student_name, event_id, idea_title, idea_description, score, submission_date, filename, filepath) " +
            "VALUES(?,?,?,?,?,NULL,NOW(),?,?)"
        );

        ps.setString(1, studentId);
        ps.setString(2, studentname);
        ps.setString(3, eventId);
        ps.setString(4, title);
        ps.setString(5, description);
        ps.setString(6, fileName);
        ps.setString(7, filePath);

        int i = ps.executeUpdate();

        if(i>0){
            message = "Idea Submitted Successfully!";
            messageType = "success";
        } else {
            message = "Failed to Submit Idea!";
            messageType = "danger";
        }

        ps.close();
    }
%>

<!-- ✅ MESSAGE -->
<% if(!message.equals("")) { %>
<div class="alert alert-<%=messageType%>">
    <%=message%>
</div>
<% } %>

<!-- ✅ FORM -->
<form method="post" enctype="multipart/form-data">

<div class="mb-3">
<label>Select Event</label>
<select name="event_id" class="form-control" required>
<option value="">-- Select Event --</option>

<%
ps = con.prepareStatement("SELECT * FROM event WHERE status='Open'");
rs = ps.executeQuery();
while(rs.next()){
%>
<option value="<%=rs.getString("event_id")%>">
    <%=rs.getString("event_name")%>
</option>
<%
}
rs.close();
ps.close();
%>

</select>
</div>

<div class="mb-3">
<label>Idea Title</label>
<input type="text" name="idea_title" class="form-control" required>
</div>

<div class="mb-3">
<label>Idea Description</label>
<textarea name="idea_description" class="form-control" rows="5" required></textarea>
</div>

<div class="mb-3">
<label>Upload File (Optional)</label>
<input type="file" name="idea_file" class="form-control">
</div>

<div class="text-center">
<button type="submit" class="btn btn-success">Submit Idea</button>
</div>

</form>

<%
} catch(Exception e) {
    out.println("<div class='alert alert-danger'>Error Occurred!</div>");
    e.printStackTrace();
} finally {
    if(con!=null) con.close();
}
%>

</div>
</div>
</div>
</body>
</html>