package Controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;


import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;



public class DownloadTemplateController implements Controller {
  
    private String createFilename(String streamID) {
        String fileTag = "-Template";
        String ext = ".xlsx";
        
        return (streamID + fileTag + ext);
    }
    
    @Override
    public ModelAndView handleRequest(HttpServletRequest request,
                                     HttpServletResponse response) throws IOException {
        
        ServletContext templateContext = request.getServletContext();
        WebApplicationContext appContext = 
                WebApplicationContextUtils.getRequiredWebApplicationContext(templateContext);

        // extract the stream ID from the link that made this request
        String streamID = request.getParameter("streamID");
        
        ModuleServiceDAO moduleDAO = (ModuleServiceDAO) appContext.getBean("moduleDAO");
        
        // get all module names that belong to this stream
        ArrayList<String> moduleNames = moduleDAO.getModuleNamesForStreamID(streamID);
        
        String filename = createFilename(streamID); // append a tag and extension
        response.setContentType("APPLICATION/OCTET-STREAM");
        response.setHeader("Content-Disposition", "attachment; filename=\""
                        + filename + "\"");
        
        ServletOutputStream responseOutStream = response.getOutputStream();
        ExcelWriter excelWriter = new ExcelWriter(responseOutStream);
        
        excelWriter.createExcelTemplateFile(moduleNames);
        responseOutStream.close();
        
        return new ModelAndView(); // doesn't actually go to a view, just downloads the file
    }
}
