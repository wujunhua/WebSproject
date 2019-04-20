package Controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

// creates template files for a specific stream
// it doesn't connect to the database, the data to be written is passed in
public class ExcelWriter {

    private final String scoreTag; // appended to each module name to communicate that's the score column
    private OutputStream outputStream;
    private ArrayList<String> columnTitles;
    
    /*
        constructor
        parameters - @outputStream: where the excel data should be written to
                                    always ResponseOutputStream in this application  
    */
    public ExcelWriter(OutputStream outputStream) {
        this.outputStream = outputStream;

        // trailing whitespace since it's appended to the module name and a # is appended to it
        scoreTag = " Score "; 
        
        columnTitles = new ArrayList<>(); // all template files start with these columns
        columnTitles.add("Employee ID"); 
        columnTitles.add("Name");
        columnTitles.add("Email");   
    }
    
    public void createExcelTemplateFile(ArrayList<String> moduleNames) {

        ArrayList<String> scoreTitles = createScoreTitles(moduleNames);
        columnTitles.addAll(scoreTitles); // add dynamic column titles

        XSSFWorkbook workbook = new XSSFWorkbook(); // blank workbook
        XSSFSheet spreadsheet = workbook.createSheet("Performance Reports Template");

        int firstRowIndex = 0; // only writing to the first row
        XSSFRow row = spreadsheet.createRow(firstRowIndex); // title row, indicates the data to be entered

        int columnIndex = 0;

        // go through titles, write their values in consecutive cells
        for(String colTitle: columnTitles) {
                Cell cell = row.createCell(columnIndex++);
                cell.setCellValue(colTitle);
        }
        
        try {
            workbook.write(outputStream); // up to the caller to close
            System.out.println("Template spreadsheet was written successfully");
        } catch (IOException e) {
            e.printStackTrace();
            System.err.println("CreateExcelTemplateForStream: there was an issue creating the template file");
        }  
    }
    
    /*
    *   input - @modulesNames: the current template's modules
    *
    *   output - each module name repeated 3 times with "Score [#]" appended to it
    */
    private ArrayList<String> createScoreTitles(ArrayList<String> moduleNames) {
        
        final int retakeLimit = 4; // 3 retakes, this makes it one-indexed
        ArrayList<String> scoreTitles = new ArrayList<>();
        
        // go through each module name
        for(String moduleName: moduleNames) {
            
            // append score tag and test take number to each column title
            for(int i = 1; i < retakeLimit; i++) {
                String columnTitle = (moduleName + scoreTag + i); // [module name] Score [#]
                scoreTitles.add(columnTitle);
            }
        }
        
        return scoreTitles;
    }
  
  