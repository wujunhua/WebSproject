package com.atossyntel.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;

import org.springframework.web.servlet.mvc.Controller;

public class PDFViewerController implements Controller {

    @Override
    public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // go to "Home" of respective operating system ("This PC" for Windows and "Macintosh HD" for Mac)
        
	
        // File.separator -> Uses appropriate slash (backslash, forward-slash) for respective operating system
                
        /* Name of PDF goes here. We can get file name and save it in public string when it is generated in the other class and this 
        * string below will get the file name from the other class and find it, to bypass "handleRequest" 
        * not being being able to accept any more parameters. But for now, the directory is set to the Downloads folder.
        */
        String pdfFileName = "test.pdf"; // static for now
	
	File pdfFile = new File(pdfFileName); 
	
	response.setContentType("application/pdf"); // Tells the browser "This is a pdf application"
	response.addHeader("Content-Disposition","inline;filename=" + pdfFile); // Tells the browser "Open this PDF application in the browser. Do not download it"
	response.setContentLength((int) pdfFile.length());
	
        // reads the PDF contents into the browser.
	FileInputStream fileInputStream = new FileInputStream(pdfFile);
	OutputStream responseOutputStream = response.getOutputStream();
	int bytes;
        
	while ((bytes = fileInputStream.read()) != -1) 
        {
		responseOutputStream.write(bytes);
	}
		
	fileInputStream.close();
        
        return new ModelAndView("pdfviewer");
    }
    
    

}
