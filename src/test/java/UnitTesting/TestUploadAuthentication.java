/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package UnitTesting;

import com.atossyntel.controller.UploadAuthentication;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;



public class TestUploadAuthentication {
    
    
    @Test
    public void testconvertFile() throws IOException{
        File manualFile= new File("testfile.txt");
        String path=manualFile.getPath();
        //String path="C:/mytraining_stuff/FileTestCases/testfile.txt";
        MockMultipartFile file=new MockMultipartFile("files", path, "text/plain", "hello".getBytes(StandardCharsets.UTF_8));
        File expectedconvFile = new File(file.getOriginalFilename());
        System.out.println(expectedconvFile.getName());
        File actualconvFile= (new UploadAuthentication()).convert(file);
        System.out.println(actualconvFile.getName());
        assertEquals(expectedconvFile.getName(), actualconvFile.getName());
        if(manualFile.delete()) 
        { 
            System.out.println("File deleted successfully"); 
        } 
        else
        { 
            System.out.println("Failed to delete the file"); 
        } 
    }
}
