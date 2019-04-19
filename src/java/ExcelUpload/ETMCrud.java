package ExcelUpload;

import java.sql.Statement;

public class ETMCrud {
	
	public void insertETM(Statement st, String module_name, double score, String empId, String streamName){
		try {
			System.out.println("Inserting a modle scores... ");
			int rows = st.executeUpdate("INSERT INTO employees_take_modules VALUES((Select m.module_id FROM modules m , stream s WHERE m.stream_id = s.stream_id AND m.module_name ='"+ module_name+"' AND s.stream_Id = '" +streamName+"'), '"+ empId + "', "+ score +")" );
			System.out.println(rows + " module added...");
		} catch (Exception e) {
			System.out.println("Exception " + e.getMessage());
                        System.out.println("Error with module:" + module_name + " employee name" + empId);
		}
	}

}
