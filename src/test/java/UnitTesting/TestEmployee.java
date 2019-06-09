package UnitTesting;

import com.atossyntel.excelupload.Employee;

import java.util.Arrays;
import java.util.Collection;
import static org.junit.Assert.assertEquals;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.Parameterized.Parameters;


    @RunWith(Parameterized.class)
public class TestEmployee {
        static final String RESULT = "Result";
    
    @Parameter(0)
    public String empId;
    @Parameter(1)
    public String empName;
    @Parameter(2)
    public String empEmail;
    @Parameter(3)
    public String cId;
    @Parameter(4)
    public String manId;
    
    @Parameters
    public static Collection<Object[]> data(){
         
         
        
          Object[][] data = new Object[][] {  {"5060486","Pearl Matakatla","pearl_matakatla@syntelinc.com","FSDFour","emily_lusz@syntelinc.com"},
           {"5060481","Emily Lusz","emily_lusz@syntelinc.com","FSDFour","junhua_wu@syntelinc.com"},
           {"5060487","Shengchun Liu","shengchun_liu@syntelinc.com","FSD123","daniel_lowery@syntelinc.com"},
           {"5060483","Jay Patel","jay_patel@syntelinc.com","FSD123","christopher_foose@syntelinc.com"},
          {"5060484","Daniel Lowery","daniel_lowery@syntelinc.com","FSDFour","jason_richard@syntelinc.com"}};
    return Arrays.asList(data);
    }
    
    @Test
    public void testEmployeeId() {
        Employee e = new Employee(empId,empName,empEmail,cId,manId);
        assertEquals("Result",empId,e.getEmployeeID());
    }
    @Test
    public void testEmployeeName(){
        Employee e = new Employee(empId,empName,empEmail,cId,manId);
        assertEquals("Result",empName,e.getEmployeeName());
    }
    @Test
    public void testEmployeeEmail(){
        Employee e = new Employee(empId,empName,empEmail,cId,manId);
        assertEquals("Result",empEmail,e.getEmployeeEmail());
    }
    @Test
    public void testclassId(){
        Employee e = new Employee(empId,empName,empEmail,cId,manId);
        assertEquals("Result",cId,e.getClassID());
    }
    @Test
    public void testmanagerId(){
        Employee e = new Employee(empId,empName,empEmail,cId,manId);
        assertEquals("Result",manId,e.getManagerID());
    }
}
       