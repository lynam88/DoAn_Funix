package dao;

import java.io.*;
import java.sql.*;
import java.text.*;
import java.util.Date;
 
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.*;

import context.DBContext;
 
/**
 * An advanced Java program that exports data from any table to Excel file.
 */
public class ExportService {
	
	private String getFileName() {
	        DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy_HH-mm-ss");
	        String dateTimeInfo = dateFormat.format(new Date());
	        return String.format("_%s.xlsx", dateTimeInfo);
	    }
 
    public String donationExport(String character, String searchStatus, String category) throws Exception {                  
         String file = "./Donation_Export" + getFileName();
 
        try {
        	Connection connection = new DBContext().getConnection();
        	String sql = "SELECT * FROM Donations WHERE donation_title like ? AND use_yn = 1";
			if (!searchStatus.equals("0")) {
			    sql += " AND donation_status = ?";
			}
			if (!category.equals("0")) {
			    sql += " AND category = ?";
			}
			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setString(1, "%" + character + "%");
			int index = 2;
			if (!searchStatus.equals("0")) {
			    stmt.setString(index++, searchStatus);
			}
			if (!category.equals("0")) {
			    stmt.setString(index++, category);
			}
			ResultSet rs = stmt.executeQuery();
 
            XSSFWorkbook workbook = new XSSFWorkbook();
            XSSFSheet sheet = workbook.createSheet("Data_Export");
 
            writeHeaderLine(rs, sheet);
 
            writeDataLines(rs, workbook, sheet);
 
            FileOutputStream outputStream = new FileOutputStream(file);
            workbook.write(outputStream);
            workbook.close();
 
            stmt.close();
 
        } catch (SQLException e) {
            System.out.println("Datababse error:");
            e.printStackTrace();
        } catch (IOException e) {
            System.out.println("File IO error:");
            e.printStackTrace();
        }
        return file;
    }
    
    public String userExport(String character, String searchStatus) throws Exception {                  
        String file = "./User_Export" + getFileName();

       try {
	       	Connection connection = new DBContext().getConnection();
	       	String sql = "SELECT * "
					+ "FROM Users "
					+ (character.isEmpty() ? "" : "WHERE name LIKE ? OR phone = ? OR address LIKE ? ")
					+ (searchStatus.equals("0") ? "" : (character.isEmpty() ? "WHERE" : "AND ") + "user_role = ?");
	
			PreparedStatement stmt = connection.prepareStatement(sql);
			int index = 1;
	
			if (!character.isEmpty()) {
				stmt.setString(index++, "%" + character + "%");
				stmt.setString(index++, character);
				stmt.setString(index++, "%" + character + "%");
			}
	
			if (!searchStatus.equals("0")) {
				stmt.setString(index++, searchStatus);
			}
	
			ResultSet rs = stmt.executeQuery();

           XSSFWorkbook workbook = new XSSFWorkbook();
           XSSFSheet sheet = workbook.createSheet("Data_Export");

           writeHeaderLine(rs, sheet);

           writeDataLines(rs, workbook, sheet);

           FileOutputStream outputStream = new FileOutputStream(file);
           workbook.write(outputStream);
           workbook.close();

           stmt.close();

       } catch (SQLException e) {
           System.out.println("Datababse error:");
           e.printStackTrace();
       } catch (IOException e) {
           System.out.println("File IO error:");
           e.printStackTrace();
       }
       return file;
   }
 
    private void writeHeaderLine(ResultSet result, XSSFSheet sheet) throws SQLException {
        // write header line containing column names
        ResultSetMetaData metaData = result.getMetaData();
        int numberOfColumns = metaData.getColumnCount();
 
        Row headerRow = sheet.createRow(0);
 
        // exclude the first column which is the ID field
        for (int i = 1; i <= numberOfColumns; i++) {
            String columnName = metaData.getColumnName(i);
            Cell headerCell = headerRow.createCell(i - 1);
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
 
            for (int i = 1; i <= numberOfColumns; i++) {
                Object valueObject = result.getObject(i);
 
                Cell cell = row.createCell(i - 1);
 
                if (valueObject == null) {
                    cell.setCellValue("");
                } else if (valueObject instanceof Boolean) {
                    cell.setCellValue((Boolean) valueObject);
                } else if (valueObject instanceof Double) {
                    cell.setCellValue((double) valueObject);
                } else if (valueObject instanceof Float) {
                    cell.setCellValue((float) valueObject);
                } else if (valueObject instanceof Date) {
                    cell.setCellValue((Date) valueObject);
                    formatDateCell(workbook, cell);
                } else {
                    cell.setCellValue(valueObject.toString());
                }
 
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
