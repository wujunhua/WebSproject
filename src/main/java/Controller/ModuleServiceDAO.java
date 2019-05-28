package Controller;


import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.ServletContext;
import javax.sql.DataSource;
import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class ModuleServiceDAO {
final static Logger logger = Logger.getLogger(ModuleServiceDAO.class);
    private DataSource dataSource;
    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {    
        this.dataSource = dataSource;
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }


    public ArrayList<String> getModuleNamesForStreamID(String streamID) {
        logger.info("getting module names for stream with ID: " + streamID);
        
        String SQL = "SELECT module_name FROM modules WHERE stream_id = ?";
 
        return jdbcTemplate.query(SQL, new ModuleNameExtracter(), streamID);
    }
}
