/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package UnitTesting;
import com.atossyntel.pojo.ExcelUploadObject;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.Collection;
import static org.junit.Assert.assertEquals;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author syntel
 */
@RunWith(Parameterized.class)
public class TestExcelUploadObject {
        static final String RESULT = "Result";
    
    @Parameter(0)
    public String stream;
    @Parameter(1)
    public String location;
    @Parameter(2)
    public String siteName;
    @Parameter(3)
    public MultipartFile fileName;
    @Parameter(4)
    public String instructEmail;
    @Parameter(5)
    public String beginDate;
    @Parameter(6)
    public String finishDate;
    
    @Parameterized.Parameters
    public static Collection<Object[]> data(){
         Path path = Paths.get("/path/to/the/file.txt");
String name = "file.txt";
String originalFileName = "file.txt";
String contentType = "text/plain";
byte[] content = null;
try {
    content = Files.readAllBytes(path);
} catch (final IOException e) {
}
MultipartFile fileName = new MockMultipartFile(name,
                     originalFileName, contentType, content);        
          Object[][] data = new Object[][] {  {"Java Full Stack Developer","Dallas", "Atos Syntel",fileName,"ls@syntelinc.com","08-05-2018","10-14-2018"},
                                              {"Big Data","Phoenix", "Atos Syntel",fileName,"ab@syntelinc.com","08-05-2018","10-14-2018"}};
    return Arrays.asList(data);
    }
    
    @Test
    public void testStreamName() {
        ExcelUploadObject exec = new ExcelUploadObject(stream,location,siteName,fileName,instructEmail,beginDate,finishDate);
        assertEquals("Result",stream,exec.getStreamName());
    }
    @Test
    public void testLocation() {
        ExcelUploadObject exec = new ExcelUploadObject(stream,location,siteName,fileName,instructEmail,beginDate,finishDate);
        assertEquals("Result",location,exec.getLocation());
    }
    @Test
    public void testsiteName() {
        ExcelUploadObject exec = new ExcelUploadObject(stream,location,siteName,fileName,instructEmail,beginDate,finishDate);
        assertEquals("Result",siteName,exec.getSite());
    }
    @Test
    public void testfileName() {
        ExcelUploadObject exec = new ExcelUploadObject(stream,location,siteName,fileName,instructEmail,beginDate,finishDate);
        assertEquals("Result",fileName,exec.getFile());
    }
    @Test
    public void testInstructEmail() {
        ExcelUploadObject exec = new ExcelUploadObject(stream,location,siteName,fileName,instructEmail,beginDate,finishDate);
        assertEquals("Result",instructEmail,exec.getInsEmail());
    }
    @Test
    public void testBeginDate() {
        ExcelUploadObject exec = new ExcelUploadObject(stream,location,siteName,fileName,instructEmail,beginDate,finishDate);
        assertEquals("Result",beginDate,exec.getStartDate());
    }
    @Test
    public void testFinishDate() {
        ExcelUploadObject exec = new ExcelUploadObject(stream,location,siteName,fileName,instructEmail,beginDate,finishDate);
        assertEquals("Result",finishDate,exec.getEndDate());
    }
}
