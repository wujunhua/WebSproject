package UnitTesting;
import com.atossyntel.pojo.User;
import static org.junit.Assert.*;
import java.util.Arrays;
import java.util.Collection;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.Parameterized.Parameters;

@RunWith(Parameterized.class)
public class TestUser {
    @Parameter(0)
    public String username;
    @Parameter(1)
    public String password;
    @Parameter(2)
    public boolean admin;
    
    @Parameters
    public static Collection<Object[]> data(){
        Object[][] data = new Object[][] { {"el@Syntelinc.com","abc123",true}, 
                                            {"sl@Syntelinc.com","def456",false}, 
                                            {"jp@Syntelinc.com","ghi789",true}, 
                                            {"gu@Syntelinc.com","jkl012",false}, 
                                            {"nc@Syntelinc.com","mno345",true}, 
                                            {"dl@Syntelinc.com","pqr678",false}, 
                                            {"cf@Syntelinc.com","stu901",true}, 
                                            {"jw@Syntelinc.com","vwx234",false}, 
                                            {"jr@Syntelinc.com","yza567",true}, 
                                            {"pm@Syntelinc.com","bcd890",false} };
	return Arrays.asList(data);
    }
    
    @Test
    public void testUsername()
    {
        User user = new User(username, password, admin);
        assertEquals("Result", username, user.getUserName());
    }
    
    @Test
    public void testPassword()
    {
        User user = new User(username, password, admin);
        assertEquals("Result", password, user.getPassword());
    }
    
    @Test
    public void testAdmin()
    {
        User user = new User(username, password, admin);
        assertEquals("Result", admin, user.isAdmin());
    }
}
