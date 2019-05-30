package com.atossyntel.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

// creates template files for a specific stream
// it doesn't connect to the database, the data to be written is passed in
public class ExcelWriter {
static final Logger logger = Logger.getLogger(ExcelWriter.class);
    private OutputStream outputStream;
    private ArrayList<String> columnTitles;
    private String[] instructions;
    private int numStaticColTitles;
    // for columns that should be wider than their titles text length (name, email, reporting manager)
    private final int widerWidth; 
    
    /*
        constructor
        parameters - @outputStream: where the excel data should be written to
                                    always ResponseOutputStream in this application  
    */
    public ExcelWriter(OutputStream outputStream) {
        this.outputStream = outputStream;
        
        columnTitles = new ArrayList<>(); // all template files start with these columns
        columnTitles.add("Employee ID"); 
        columnTitles.add("Name");
        columnTitles.add("Email");
        columnTitles.add("Reporting Manager");
        
        // the number of titles that don't come from the database
        numStaticColTitles = columnTitles.size();
        
        // printed in the first rows
        instructions = new String[] {
            "Performica Data Entry Template",
            "Please enter employee details and scores across a single row.",
            "Score 1 is the first attempt, score 2 is the first retake, and score 3 is the second retake.",
            "If retakes do not apply to the student, then leave those cells blank."
        };
        int maxNumCharacters = 35;
        int widthOfCharacter = 256;
        widerWidth = (maxNumCharacters * widthOfCharacter);
    }
    
    public void createExcelTemplateFile(List<String> moduleNames) {

        ArrayList<String> scoreTitles = createScoreTitles(moduleNames);
        columnTitles.addAll(scoreTitles); // add dynamic column titles

        try(XSSFWorkbook workbook = new XSSFWorkbook();) { // blank workbook
        XSSFSheet spreadsheet = workbook.createSheet("Performance Reports Template");
        
        XSSFFont boldFont = workbook.createFont();
        boldFont.setBold(true); // column titles are bold
        
        XSSFCellStyle style = workbook.createCellStyle();
        style.setFont(boldFont); // cell style uses bold font
        
        addInstructionsToSpreadsheet(spreadsheet);

        // title row, indicates the data to be entered below
        XSSFRow row = spreadsheet.createRow(getColumnTitleIndex()); 

        int columnIndex = 0; // left most column

        // go through titles, write their values in consecutive cells
        for(String columnTitle: columnTitles) {
                Cell cell = row.createCell(columnIndex);
                
                cell.setCellValue(columnTitle);
                cell.setCellStyle(style); // make each title bold
                
                if(cellShouldBeWider(columnIndex))
                    spreadsheet.setColumnWidth(columnIndex, widerWidth);
                else
                    spreadsheet.autoSizeColumn(columnIndex); // expand column to match text width
                
                columnIndex++; // move to the next column
        }        
            workbook.write(outputStream); // up to the caller to close stream
            logger.info("Template spreadsheet was written successfully");
        } catch (IOException e) {
            logger.error(e.getMessage());
            logger.error("createExcelTemplateFile: there was an issue creating the template file");
        }  
}
    /*
    *   input - @modulesNames: the current template's modules
    *
    *   output - each module name repeated 3 times with "Score [#]" appended to it
    */
    private ArrayList<String> createScoreTitles(List<String> moduleNames) {
        
        final int retakeLimit = 4; // 3 retakes, this makes it one-indexed
        ArrayList<String> scoreTitles = new ArrayList<>();
        
        // go through each module name
        for(String moduleName: moduleNames) {
            
            // append score tag and test take number to each column title
            for(int i = 1; i < retakeLimit; i++) {
                
                // DEV: don't append "score #" to allow excel puller to read it
                String columnTitle = moduleName;
                scoreTitles.add(columnTitle);
            }
        }
        
        return scoreTitles;
    }

    private void addInstructionsToSpreadsheet(XSSFSheet spreadsheet) {
    
        int currentRow = (-1);
        int firstColIndex = 0;
        
        // loop through instruction strings and rows together writing them in the first column
        for(currentRow = 0; currentRow < instructions.length; currentRow++) {
            
            XSSFRow row = spreadsheet.createRow(currentRow);
            Cell cell = row.createCell(firstColIndex);
            
            cell.setCellValue(instructions[currentRow]);
        }
    }
    
    private int getColumnTitleIndex() {
        // column titles are right below the instructions
        return instructions.length;
    }
    
    private boolean cellShouldBeWider(int columnIndex) {
        int instructionsColIndex = 0;
        
        // any column after the instructions and before the scores should be
        // wider than its column title's text length
        return ((instructionsColIndex < columnIndex) && 
                (columnIndex < numStaticColTitles));
    }
}
