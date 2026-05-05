import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class DownloadFile extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String Path = request.getParameter("path");
        
        String filePath = "F:/"+Path;
        
        File file = new File(filePath);

        if (!file.exists()) {
            response.getWriter().println("File not found!");
            return;
        }

        FileInputStream fis = new FileInputStream(file);

        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "inline; filename=\"" + file.getName() + "\"");

        OutputStream os = response.getOutputStream();

        byte[] buffer = new byte[4096];
        int bytesRead;

        while ((bytesRead = fis.read(buffer)) != -1) {
            os.write(buffer, 0, bytesRead);
        }

        fis.close();
        os.close();
    }
}