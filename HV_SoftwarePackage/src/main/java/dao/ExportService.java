package dao;

import java.io.*;
import java.sql.*;
import java.text.*;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.*;
import org.apache.http.*;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Request;
import org.apache.http.client.fluent.Response;

import context.DBContext;
 
/**
 * An advanced Java program that exports data from any table to Excel file.
 */
public class ExportService {
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD

	private String getFileName(String baseName) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
		String dateTimeInfo = dateFormat.format(new Date());
		return baseName.concat(String.format("_%s.xlsx", dateTimeInfo));
	}

	public void export(String table, String character, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String excelFilePath = getFileName(table.concat("_Export"));

		try {
			Connection connection = new DBContext().getConnection();
			String sql = "SELECT * FROM ".concat(table) + " WHERE donation_title like '%" + character
					+ "%' AND use_yn = 1";

			Statement statement = connection.createStatement();

			ResultSet result = statement.executeQuery(sql);

			XSSFWorkbook workbook = new XSSFWorkbook();
			XSSFSheet sheet = workbook.createSheet(table);

			writeHeaderLine(result, sheet);

			writeDataLines(result, workbook, sheet);
			String urlFile = "E:\\" + excelFilePath;

			FileOutputStream outputStream = new FileOutputStream(urlFile);
			ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
			workbook.write(outputStream);
			workbook.write(outByteStream);
			byte[] outArray = outByteStream.toByteArray();
			response.setContentType("application/ms-excel");
			response.setContentLength(outArray.length);
			response.setHeader("Expires:", "0"); // eliminates browser caching
			response.setHeader("Content-Disposition", "attachment; filename=Details.xls");
			OutputStream outStream = response.getOutputStream();
			outStream.write(outArray);
			outStream.flush();
			workbook.close();

			statement.close();
		} catch (SQLException e) {
			System.out.println("Database error:");
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("File IO error:");
			e.printStackTrace();
		}

	}

	private void writeHeaderLine(ResultSet result, XSSFSheet sheet) throws SQLException {
		// write header line containing column names
		ResultSetMetaData metaData = result.getMetaData();
		int numberOfColumns = metaData.getColumnCount();

		Row headerRow = sheet.createRow(0);

		// exclude the first column which is the ID field
		for (int i = 2; i <= numberOfColumns; i++) {
			String columnName = metaData.getColumnName(i);
			Cell headerCell = headerRow.createCell(i - 2);
			headerCell.setCellValue(columnName);
		}
	}

	private void writeDataLines(ResultSet result, XSSFWorkbook workbook, XSSFSheet sheet) throws SQLException {
		ResultSetMetaData metaData = result.getMetaData();
		int numberOfColumns = metaData.getColumnCount();

		int rowCount = 1;

		while (result.next()) {
			Row row = sheet.createRow(rowCount++);

			for (int i = 2; i <= numberOfColumns; i++) {
				Object valueObject = result.getObject(i);

				Cell cell = row.createCell(i - 2);

				if (valueObject instanceof Boolean)
					cell.setCellValue((Boolean) valueObject);
				else if (valueObject instanceof Double)
					cell.setCellValue((double) valueObject);
				else if (valueObject instanceof Float)
					cell.setCellValue((float) valueObject);
				else if (valueObject instanceof Date) {
					cell.setCellValue((Date) valueObject);
					formatDateCell(workbook, cell);
				} else
					cell.setCellValue(valueObject.toString());

			}

		}
	}

	private void formatDateCell(XSSFWorkbook workbook, Cell cell) {
		CellStyle cellStyle = workbook.createCellStyle();
		CreationHelper creationHelper = workbook.getCreationHelper();
		cellStyle.setDataFormat(creationHelper.createDataFormat().getFormat("yyyy-MM-dd HH:mm:ss"));
		cell.setCellStyle(cellStyle);
	}
}
=======
 
    private String getFileName(String baseName) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
        String dateTimeInfo = dateFormat.format(new Date());
        return baseName.concat(String.format("_%s.xlsx", dateTimeInfo));
    }
 
    public void export(String table, String character, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
         String excelFilePath = getFileName(table.concat("_Export"));
 
        try {
        	Connection connection = new DBContext().getConnection();
            String sql = "SELECT * FROM ".concat(table) + " WHERE donation_title like '%" + character + "%' AND use_yn = 1";
 
            Statement statement = connection.createStatement();
 
            ResultSet result = statement.executeQuery(sql);
 
            XSSFWorkbook workbook = new XSSFWorkbook();
            XSSFSheet sheet = workbook.createSheet(table);
 
            writeHeaderLine(result, sheet);
 
            writeDataLines(result, workbook, sheet);
           // String urlFile = "E:\\" + excelFilePath;
 
            //FileOutputStream outputStream = new FileOutputStream(urlFile);
           // ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
            //workbook.write(outputStream);
            ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
            workbook.write(outByteStream);
            byte [] outArray = outByteStream.toByteArray();
            response.setContentType("application/ms-excel");
            response.setContentLength(outArray.length); 
            response.setHeader("Expires:", "0"); // eliminates browser caching
            response.setHeader("Content-Disposition", "attachment; filename=Details.xls");
            OutputStream outStream = response.getOutputStream();
            outStream.write(outArray);
            outStream.flush();
            workbook.close();
 
            statement.close();
        } catch (SQLException e) {
            System.out.println("Datababse error:");
=======
 
    private String getFileName(String baseName) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
        String dateTimeInfo = dateFormat.format(new Date());
        return baseName.concat(String.format("_%s.xlsx", dateTimeInfo));
    }
 
    public void export(String table, String character, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
         String excelFilePath = getFileName(table.concat("_Export"));
 
        try {
        	Connection connection = new DBContext().getConnection();
            String sql = "SELECT * FROM ".concat(table) + " WHERE donation_title like '%" + character + "%' AND use_yn = 1";
 
            Statement statement = connection.createStatement();
 
            ResultSet result = statement.executeQuery(sql);
 
            XSSFWorkbook workbook = new XSSFWorkbook();
            XSSFSheet sheet = workbook.createSheet(table);
 
            writeHeaderLine(result, sheet);
 
            writeDataLines(result, workbook, sheet);
            String urlFile = "C:\\Users\\shini\\DoAn_Funix\\HV_SoftwarePackage\\";
            response.reset();
            PrintWriter out = response.getWriter();
            response.setContentType("APPLICATION/OCTET-STREAM");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + "demo.txt" + "\"");
			FileInputStream fileInputStream = new FileInputStream(urlFile+"demo.txt");
			int i;
			while ((i = fileInputStream.read()) != -1) {
				out.write(i);
			}
=======
 
    private String getFileName(String baseName) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
        String dateTimeInfo = dateFormat.format(new Date());
        return baseName.concat(String.format("_%s.xlsx", dateTimeInfo));
    }
 
    public void export(String table, String character, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
         String excelFilePath = getFileName(table.concat("_Export"));
 
        try {
        	Connection connection = new DBContext().getConnection();
            String sql = "SELECT * FROM ".concat(table) + " WHERE donation_title like '%" + character + "%' AND use_yn = 1";
 
            Statement statement = connection.createStatement();
 
            ResultSet result = statement.executeQuery(sql);
 
            XSSFWorkbook workbook = new XSSFWorkbook();
            XSSFSheet sheet = workbook.createSheet(table);
 
            writeHeaderLine(result, sheet);
 
            writeDataLines(result, workbook, sheet);
            String urlFile = "C:\\Users\\shini\\DoAn_Funix\\HV_SoftwarePackage\\";
            response.reset();
            PrintWriter out = response.getWriter();
            response.setContentType("APPLICATION/OCTET-STREAM");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + "demo.txt" + "\"");
			FileInputStream fileInputStream = new FileInputStream(urlFile+"demo.txt");
			int i;
			while ((i = fileInputStream.read()) != -1) {
				out.write(i);
			}
>>>>>>> parent of 9d19031 (1)
			fileInputStream.close();
			out.close();
 
			/*
			 * FileOutputStream outputStream = new FileOutputStream(urlFile);
			 * ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
			 * workbook.write(outputStream); workbook.write(outByteStream); byte [] outArray
			 * = outByteStream.toByteArray();
			 * response.setContentType("application/ms-excel");
			 * response.setContentLength(outArray.length); response.setHeader("Expires:",
			 * "0"); // eliminates browser caching response.setHeader("Content-Disposition",
			 * "attachment; filename=Details.xls"); OutputStream outStream =
			 * response.getOutputStream(); outStream.write(outArray); outStream.flush();
			 * workbook.close();
			 * 
			 * statement.close();
			 */
        } catch (SQLException e) {
            System.out.println("Database error:");
<<<<<<< HEAD
>>>>>>> parent of 9d19031 (1)
=======
>>>>>>> parent of 9d19031 (1)
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("File IO error:");
            e.printStackTrace();
        }
        
    }
    
    
    private void writeHeaderLine(ResultSet result, XSSFSheet sheet) throws SQLException {
        // write header line containing column names
        ResultSetMetaData metaData = result.getMetaData();
        int numberOfColumns = metaData.getColumnCount();
 
        Row headerRow = sheet.createRow(0);
 
        // exclude the first column which is the ID field
        for (int i = 2; i <= numberOfColumns; i++) {
            String columnName = metaData.getColumnName(i);
            Cell headerCell = headerRow.createCell(i - 2);
            headerCell.setCellValue(columnName);
        }
    }
 
    private void writeDataLines(ResultSet result, XSSFWorkbook workbook, XSSFSheet sheet)
            throws SQLException {
        ResultSetMetaData metaData = result.getMetaData();
        int numberOfColumns = metaData.getColumnCount();
 
        int rowCount = 1;
 
        while (result.next()) {
            Row row = sheet.createRow(rowCount++);
 
            for (int i = 2; i <= numberOfColumns; i++) {
                Object valueObject = result.getObject(i);
 
                Cell cell = row.createCell(i - 2);
 
                if (valueObject instanceof Boolean)
                    cell.setCellValue((Boolean) valueObject);
                else if (valueObject instanceof Double)
                    cell.setCellValue((double) valueObject);
                else if (valueObject instanceof Float)
                    cell.setCellValue((float) valueObject);
                else if (valueObject instanceof Date) {
                    cell.setCellValue((Date) valueObject);
                    formatDateCell(workbook, cell);
                } else cell.setCellValue(valueObject.toString());
 
            }
 
        }
    }
 
    private void formatDateCell(XSSFWorkbook workbook, Cell cell) {
        CellStyle cellStyle = workbook.createCellStyle();
        CreationHelper creationHelper = workbook.getCreationHelper();
        cellStyle.setDataFormat(creationHelper.createDataFormat().getFormat("yyyy-MM-dd HH:mm:ss"));
        cell.setCellStyle(cellStyle);
    }
}
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> parent of b47e60b (1)
=======
>>>>>>> parent of 9d19031 (1)
=======
>>>>>>> parent of 9d19031 (1)
