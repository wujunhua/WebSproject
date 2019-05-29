package UnitTesting;
import static org.junit.Assert.*;
import java.util.Arrays;
import java.util.Collection;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.Parameterized.Parameters;
import POJO.CheckboxForm;

@RunWith(Parameterized.class)
public class TestCheckboxForm {
    @Parameter(0)
    public String[] users;
    
    @Parameters
    public static Collection<Object[]> data(){
        String u1 = "el@Syntelinc.com";
        String u2 = "sl@Syntelinc.com";
        String u3 = "jp@Syntelinc.com";
        String u4 = "gu@Syntelinc.com";
        String u5 = "nc@Syntelinc.com";
        String u6 = "dl@Syntelinc.com";
        String u7 = "cf@Syntelinc.com";
        String u8 = "jw@Syntelinc.com";
        String u9 = "jr@Syntelinc.com";
        String u10 = "pm@Syntelinc.com";
        String[] uC1 = {u1, u2, u3};
        String[] uC2 = {u2, u3, u4};
        String[] uC3 = {u3, u4, u5};
        String[] uC4 = {u4, u5, u6};
        String[] uC5 = {u5, u6, u7};
        String[] uC6 = {u6, u7, u8};
        String[] uC7 = {u7, u8, u9};
        String[] uC8 = {u8, u9, u10};
        String[] uC9 = {u9, u10, u1};
        String[] uC10 = {u10, u1, u2};
        Object[][] data = new Object[][] {  {uC1}, 
                                            {uC2}, 
                                            {uC3}, 
                                            {uC4}, 
                                            {uC5}, 
                                            {uC6}, 
                                            {uC7}, 
                                            {uC8}, 
                                            {uC9}, 
                                            {uC10} };
        return Arrays.asList(data);
    }
    
    @Test
    public void testUsernames() {
        CheckboxForm cf = new CheckboxForm(users);
        assertArrayEquals("Result", users, cf.getUserNames());
    }
}
