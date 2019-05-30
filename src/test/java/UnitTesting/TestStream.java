package UnitTesting;
import com.atossyntel.pojo.Stream;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.DriverManager;
import static org.junit.Assert.*;
import org.junit.Test;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collection;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.Parameterized.Parameters;

@RunWith(Parameterized.class)
public class TestStream {
    @Parameter(0)
    public ResultSet rs;
    
    @Parameters
    public static Collection<Object[]> data(){
        ArrayList<Object[]> results = new ArrayList<>();
        ArrayList<String> ids = new ArrayList<>();
        Connection conn = null;
        try {conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","Student_Performance","Student_Performance");} 
        catch(SQLException e) {
        	e.getMessage();
        }
        
        PreparedStatement ps = null;
        ResultSet result = null;
        try{
            ps = conn.prepareStatement("select stream_id from stream");
            result = ps.executeQuery();
            while(result.next())
                ids.add(result.getString(1));
        }
        catch(SQLException e){}
        
        ps = null;
        try{
            for (String id : ids){
                ps = conn.prepareStatement("select stream_id, stream_name from stream where stream_id = ?");
                ps.setString(1, id);
                results.add(new Object[]{ps.executeQuery()}); 
            }
        }
        catch(SQLException e){}
        finally{try{conn.close(); ps.close(); result.close();} catch(SQLException | NullPointerException e){}}
               
        return results;
    }
    
    @Test
    public void testStreamIds(){
            Stream stream = new Stream(rs);
            String id = null;
            try{id = rs.getString(1);}catch(SQLException e){}
            assertEquals(id, stream.getID());
        }

    }
