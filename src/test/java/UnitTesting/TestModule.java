/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package UnitTesting;

import com.atossyntel.excelupload.Module;
import java.util.Arrays;
import java.util.Collection;
import static org.junit.Assert.assertEquals;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;

/**
 *
 * @author syntel
 */
@RunWith(Parameterized.class)
public class TestModule {
    static final String RESULT = "Result";
    
    @Parameterized.Parameter(0)
    public String modName;
    @Parameterized.Parameter(1)
    public double modScore;
    
    @Parameterized.Parameters
    public static Collection<Object[]> data(){
        Object[][] data = new Object[][] { {"Responsive Web Design",70.0},
                                           {"Databases with Oracle",80.0},
                                           {"Core Java",90.0}};
         return Arrays.asList(data);
        }
    @Test
    public void testModuleName(){
        Module module = new Module(modName,modScore);
        assertEquals("Result",modName,module.getModuleName());
    }
    @Test
    public void testModuleScore(){
        Module module = new Module(modName,modScore);
        assertEquals("Result",modScore,module.getmoduleScore(),0);
    }
}
