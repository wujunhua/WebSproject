/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package UnitTesting;

import com.atossyntel.pojo.ResetPassForm;
import java.util.Arrays;
import java.util.Collection;
import static org.junit.Assert.assertEquals;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;

/**
 *
 * @author syntel
 */

@RunWith(Parameterized.class)
public class TestResetPassForm {
    static final String RESULT= "Result"; 
    
    @Parameter(0)
    public String emailId;   
    
    @Parameterized.Parameters
    public static Collection<Object[]> data(){
         
         
        
          Object[][] data = new Object[][] {  {"pm@syntelinc.com"},
                                              {"el@Syntelinc.com"}, 
                                              {"sl@Syntelinc.com"}, 
                                              {"jp@Syntelinc.com"}, 
                                              {"gu@Syntelinc.com"}, 
                                              {"nc@Syntelinc.com"}, 
                                              {"dl@Syntelinc.com"}, 
                                              {"cf@Syntelinc.com"}, 
                                              {"jw@Syntelinc.com"}, 
                                              {"jr@Syntelinc.com"}};
          
          return Arrays.asList(data);
    }

    @Test
    public void testReset(){
        ResetPassForm reset = new ResetPassForm(emailId);
        assertEquals("Result",emailId,reset.getEmail());
    }
    
}
