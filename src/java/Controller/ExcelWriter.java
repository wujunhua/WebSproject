package Controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

// creates template files for a specific stream
// it doesn't connect to the database, the data to be written is passed in
public class ExcelWriter {

    private final String scoreTag; // appended to each module name to communicate that it is a score column
    private OutputStream outputStream;
    private ArrayList<String> columnTitles;
    private String[] instructions;
    
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
        columnTitles.add("Reporting Manager");
        
        // print these in the first rows
        instructions = new String[] {
            "Performica Data Entry Template",
            "Please enter employee details and scores across a single row.",
            "Score 1 is the first attempt, score 2 is the first retake, and score 3 is the second retake.",
            "If retakes do not apply to the student, then leave those cells blank."
        };
    }
    
    public void createExcelTemplateFile(ArrayList<String> moduleNames) {

        ArrayList<String> scoreTitles = createScoreTitles(moduleNames);
        columnTitles.addAll(scoreTitles); // add dynamic column titles
        
        
        XSSFWorkbook workbook = new XSSFWorkbook(); // blank workbook
        XSSFSheet spreadsheet = workbook.createSheet("Performance Reports Template");
        
        XSSFFont boldFont = workbook.createFont();
        boldFont.setBold(true); // column titles are bold
        
        XSSFCellStyle style = workbook.createCellStyle();
        style.setFont(boldFont); // bold font is used in this styling
        
        addInstructionsToSpreadsheet(spreadsheet); // place instructions on spreadsheet

        int firstRowIndex = 0; // only writing to the first row
        XSSFRow row = spreadsheet.createRow(firstRowIndex); // title row, indicates the data to be entered

        int columnIndex = 0;

        // go through titles, write their values in consecutive cells
        for(String colTitle: columnTitles) {
                Cell cell = row.createCell(columnIndex++);
                cell.setCellValue(colTitle);
                cell.setCellStyle(style); // apply styling to each cell
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

    
    private int addInstructionsToSpreadsheet(XSSFSheet spreadsheet) {
    
        int currentRow = (-1);
        int FIRST_COL_INDEX = 0;
        
        // loop through instruction strings and rows together writing them in the first column
        for(currentRow = 0; currentRow < instructions.length; currentRow++) {
            
            XSSFRow row = spreadsheet.createRow(currentRow);
            Cell cell = row.createCell(FIRST_COL_INDEX);
            
            cell.setCellValue(instructions[currentRow]);
        }
        
        return (currentRow + 1); // one index past the last instruction row
    }
    
}