package UnitTesting;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.DriverManager;
import org.junit.Before;
import static org.junit.Assert.*;
import java.util.Arrays;
import java.util.Collection;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.Parameterized.Parameters;
import java.sql.PreparedStatement;

@RunWith(Parameterized.class)
public class TestStream {
    @Parameter(0)
    private String streamID;
    @Parameter(1)
    private String id;
    @Parameter(2)
    private String name;
    
    private static Connection conn;
    private static String sqlQuery;
    @Before
    public void setUp(){
        try {Class.forName("oracle.jdbc.driver.OracleDriver");} catch (ClassNotFoundException e) {}

        String dbUser = "Student_Performance";
        String dbPasswd = "Student_Performance";
        String dbURL = "jdbc:oracle:thin:@localhost:1521:XE";

        conn = null;
        try {conn = DriverManager.getConnection(dbURL,dbUser,dbPasswd);} catch(SQLException e) {}
    }
    
    @Parameters
    public static Collection<Object[]> data(){
        sqlQuery = "select stream_id from stream";
        PreparedStatement getIds = null;
        try{getIds = conn.prepareStatement(sqlQuery);} catch(SQLException e){}
        
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
    
}
