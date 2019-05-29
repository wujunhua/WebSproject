package UnitTesting;
import Controller.AdminController;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import static org.junit.Assert.assertEquals;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;
import org.springframework.web.servlet.ModelAndView;

@RunWith(MockitoJUnitRunner.class)
public class TestAdminController{
    @Mock
    HttpServletRequest req;
    @Mock
    HttpServletResponse res;
    @Mock
    HttpSession mockedSession;
    @Test
    public void testAdminHtm(){
        MockitoAnnotations.initMocks(this);
        Mockito.when(req.getSession()).thenReturn(mockedSession);
        Mockito.when(req.getSession().getAttribute("isAdmin")).thenReturn(true);
        Mockito.when(req.getServletPath()).thenReturn("/admin.htm");
        ModelAndView mav = (new AdminController()).handleRequest(req, res);
        assertEquals("admin", mav.getViewName());
    }
}