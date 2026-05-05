<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>

<%
String id = request.getParameter("id");

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try{
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/studentinnvotive",
        "root",
        "root"
    );

    ps = con.prepareStatement("SELECT filename, filepath FROM submissions WHERE id=?");
    ps.setString(1, id);
    rs = ps.executeQuery();

    if(rs.next()){

        String fileName = rs.getString("filename");
        String filePath = rs.getString("filepath");

        if(filePath != null){

            File file = new File(filePath);

            if(file.exists()){

                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition","attachment;filename=\"" + fileName + "\"");

                FileInputStream fis = new FileInputStream(file);
                OutputStream os = response.getOutputStream();

                byte[] buffer = new byte[4096];
                int bytesRead;

                while((bytesRead = fis.read(buffer)) != -1){
                    os.write(buffer,0,bytesRead);
                }

                fis.close();
                os.close();
            } else {
                out.println("File not found on server!");
            }
        }
    }

}catch(Exception e){
    e.printStackTrace();
}finally{
    try{ if(rs!=null) rs.close(); }catch(Exception e){}
    try{ if(ps!=null) ps.close(); }catch(Exception e){}
    try{ if(con!=null) con.close(); }catch(Exception e){}
}
%>