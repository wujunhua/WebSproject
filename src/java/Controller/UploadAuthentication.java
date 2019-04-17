/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;
import POJO.ExcelUploadObject;
import ExcelUpload.Runner;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;


public class UploadAuthentication extends SimpleFormController{

    public UploadAuthentication() {
        setCommandClass(ExcelUploadObject.class);
        setCommandName("excel");
    }
    
    

    @Override
    protected ModelAndView onSubmit(Object command) throws Exception {
        System.out.println("did it");
        System.out.println(command);
        ExcelUploadObject excel =(ExcelUploadObject)command;
        System.out.println(excel.getLocation());
        MultipartFile multiFile = excel.getFile();
        File file = convert(multiFile);
        Runner.ExcelUpload(file, excel.getLocation(),excel.getSite(), excel.getStreamName());
        
        // bring in all streams
        
        
        return new ModelAndView("instructor");
    }
    public File convert(MultipartFile file) throws IOException
{    
    File convFile = new File(file.getOriginalFilename());
    convFile.createNewFile(); 
    FileOutputStream fos = new FileOutputStream(convFile); 
    fos.write(file.getBytes());
    fos.close(); 
    return convFile;
}
      
}
