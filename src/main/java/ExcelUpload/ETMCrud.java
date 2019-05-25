package ExcelUpload;

import java.sql.SQLException;
import java.sql.Statement;

public class ETMCrud {
	
	public void insertETM(Statement st, Module module, String empId, String streamName){
		try {
			System.out.println("Inserting a modle scores... ");
			int rows = st.executeUpdate("INSERT INTO employees_take_modules VALUES((Select m.module_id FROM modules m , stream s WHERE m.stream_id = s.stream_id AND m.module_name ='"+ module.getModuleName()+"' AND s.stream_Id = '" +streamName+"'), '"+ empId + "', "+ module.getmoduleScore() +")" );
			System.out.println(rows + " module added...");
		} catch (SQLException e) {
			System.out.println("Exception " + e.getMessage());
                        System.out.println("Error with module:" + module.getModuleName() + " employee name" + empId);
		}
	}

}
