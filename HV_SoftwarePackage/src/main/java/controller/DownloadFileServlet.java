/*
 * package controller;
 * 
 * import java.io.File; import java.io.FileInputStream; import
 * java.io.IOException; import java.io.OutputStream;
 * 
 * import javax.servlet.ServletException; import javax.servlet.http.HttpServlet;
 * import javax.servlet.http.HttpServletRequest; import
 * javax.servlet.http.HttpServletResponse;
 * 
 * import dao.ExportService;
 * 
 * 
 * public class DownloadFileServlet extends HttpServlet {
 * 
 * private static final long serialVersionUID = 1L;
 * 
 * protected void doGet(HttpServletRequest request, HttpServletResponse
 * response) throws ServletException, IOException {
 * 
 * ExportService exporter = new ExportService(); // reads input file from an
 * absolute path File downloadFile = null; try { downloadFile = new
 * File(exporter.export("Donations", "s")); } catch (Exception e) { // TODO
 * Auto-generated catch block e.printStackTrace(); } FileInputStream inStream =
 * new FileInputStream(downloadFile);
 * 
 * // modifies response response.setContentType(
 * "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
 * response.setContentLength((int) downloadFile.length());
 * 
 * // forces download String headerKey = "Content-Disposition"; String
 * headerValue = String.format("attachment; filename=\"%s\"",
 * downloadFile.getName()); response.setHeader(headerKey, headerValue);
 * 
 * // obtains response's output stream OutputStream outStream =
 * response.getOutputStream();
 * 
 * byte[] buffer = new byte[4096]; int bytesRead = -1;
 * 
 * while ((bytesRead = inStream.read(buffer)) != -1) { outStream.write(buffer,
 * 0, bytesRead); }
 * 
 * inStream.close(); outStream.close(); } }
 */