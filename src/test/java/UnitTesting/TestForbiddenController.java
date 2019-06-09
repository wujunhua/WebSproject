/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package UnitTesting;

import com.atossyntel.controller.ForbiddenController;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
public class TestForbiddenController {
    @Mock
    HttpServletRequest req;
    @Mock
    HttpServletResponse res;
    

@Test
public void test(){        
ModelAndView mav = (new ForbiddenController()).handleRequest(req, res);
        assertEquals("forbidden", mav.getViewName());
    
}
}
