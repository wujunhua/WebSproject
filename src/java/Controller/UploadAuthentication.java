
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
        
        ExcelUploadObject excel =(ExcelUploadObject)command;
        
      
        MultipartFile multiFile = excel.getFile();
        File file = convert(multiFile);
  
        Runner.ExcelUpload(file, excel.getLocation(), excel.getSite(), excel.getStreamName(), excel.getInsEmail(), excel.getStartDate(), excel.getEndDate());
        // bring in all streams
        
        
        return new ModelAndView("instructor");
    }
    
    public File convert(MultipartFile file) throws IOException{
        File convFile = new File(file.getOriginalFilename());
        convFile.createNewFile();
        try (FileOutputStream fos = new FileOutputStream(convFile)) {
            fos.write(file.getBytes());
        }
        return convFile;
    }

      
}
