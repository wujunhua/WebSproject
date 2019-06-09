/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package UnitTesting;


import com.atossyntel.controller.InstructorController;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import static org.junit.Assert.assertEquals;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author syntel
 */
@RunWith(MockitoJUnitRunner.class)
public class TestInstructorController {
    @Mock
    HttpServletRequest req;
    @Mock
    HttpServletResponse res;
    @Mock
    Object obj;
    

@Test
public void test(){        
ModelAndView mav = (new InstructorController()).handle(req, res,obj);
        assertEquals("instructor", mav.getViewName());
    
}
}