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

    private final String relativePath; // where the templates are saved
    private final String fileExtension;
    private final String fileTag; // appended to the stream name to complete the file name
    private final String scoreTag; // appended to each module name to communicate that's the score column
    private OutputStream outputStream;
    private ArrayList<String> columnTitles;
    
    /*
        constructor
        parameters - @relativePath: where the created files should be stored
                                it's relative to the project's root directory
                                (Ex.) "./downloadable/"
     */
    public ExcelWriter(OutputStream outputStream) {
        this.outputStream = outputStream;
        
        this.relativePath = "NO_PATH_SET";
        fileExtension = ".xlsx";
        fileTag = "-Template";
        // trailing whitespace since it's appended to the module name and a # is appended to it
        scoreTag = " Score "; 
        
        this.columnTitles = new ArrayList<>();
        // all template files start with these columns
        columnTitles.add("Employee ID"); 
        columnTitles.add("Name");
        columnTitles.add("Email");   
    }
    
    public void createExcelTemplateFile(String streamName, ArrayList<String> moduleNames) {

        ArrayList<String> scoreTitles = createScoreTitles(moduleNames);
        columnTitles.addAll(scoreTitles);
        
        
        XSSFWorkbook workbook = new XSSFWorkbook(); // blank workbook

        // blank spreadsheet
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
//            FileOutputStream out = createFileOutputStream(streamName);
            workbook.write(outputStream);
//            out.close(); // don't need to close, it's closed in DownloadTempController
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
    
    private FileOutputStream createFileOutputStream(String filename) throws FileNotFoundException {
        
        String fullPathFilename = createFullPathFilename(filename);
        
        return new FileOutputStream(new File(fullPathFilename));
    }
    
    private String createFullPathFilename(String filename) {
        StringBuilder fullPathBuilder = new StringBuilder(relativePath); // directory path
        fullPathBuilder.append(filename); // followed by the file name
        fullPathBuilder.append(fileTag); // and the tag "-template"
        fullPathBuilder.append(fileExtension); // and the extension ".xlsx"
        
        return fullPathBuilder.toString();
    }
    
    public static void main(String[] args) {
//        
//        ExcelWriter excelWriter = new ExcelWriter("./downloadable/");
//        ArrayList<String> staticModuleNames = new ArrayList<>(2);
//        staticModuleNames.add("web tech");
//        staticModuleNames.add("bootstrap");
//        
//        excelWriter.createExcelTemplateFile("DB343", staticModuleNames);
    }
}