/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package UnitTesting;

import com.atossyntel.excelupload.ModuleWithID;
import java.util.Arrays;
import java.util.Collection;
import static org.junit.Assert.assertEquals;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.Parameterized.Parameters;


/**
 *
 * @author syntel
 */
@RunWith(Parameterized.class)
public class TestModuleWithID {
    private  final String RESULT = "Result";
    @Parameter(0)
    public String modName;
    @Parameter(1)
    public  double modScore;
    @Parameter(2)
    public  String modId;
    
    
    @Parameters
    public static Collection<Object[]> data(){
         
          Object[][] data = new Object[][] {  {"Core Java",70.0,"3"},
                                              {"Responsive Web Design",80.0,"1"},
                                              {"Devops and Microservice Basics",90.0,"7"}};
    return Arrays.asList(data);
    }
    @Test
     public void testModuleId(){
        ModuleWithID mod = new ModuleWithID(modName,modScore,modId);
        assertEquals("Result",modId,mod.getModuleID());
    } 
}


