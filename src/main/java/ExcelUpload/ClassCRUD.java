package ExcelUpload;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class ClassCRUD {

	public void insertClass(Statement st, String classId, String streamId, String userId, String startDate, String endDate) throws SQLException{
		
               
            try {
			System.out.println("Inserting a class...");
                        
			int rows = st.executeUpdate("INSERT INTO Student_Performance.Class VALUES ('" + classId + "','" + streamId + "','" + userId  + "',TO_DATE('"+startDate+"', 'YYYY-MM-DD'),TO_DATE('"+endDate+"','YYYY-MM-DD'))");
			System.out.println(rows + " class added...");
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
	}
	
	public void readClass(Statement st, String classId){
		System.out.println("Reading class...");
		try (ResultSet rs = st.executeQuery("SELECT class_id, stream_id, user_id FROM Student_Performance.Class WHERE class_id = '" + classId + "'");) {
			while(rs.next())
				System.out.println("Result: " + rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3));
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} 
	}
	
	public void updateClass(Statement st, String classId, String streamId, String userId){
		try {
			System.out.println("Update class.");
			int rows = st.executeUpdate("UPDATE Student_Performance.Class SET stream_id ='" + streamId + "', user_id='" + userId + "'WHERE class_id ='" + classId + "'");
			System.out.println(rows + " class updated");
		} catch (SQLException e) {
			System.out.println("Exception " + e.getMessage());
		}
	}
	
	public void deleteClass(Statement st, String classId){
		try {
			System.out.println("Delete class.");
			int rows = st.executeUpdate("DELETE FROM Student_Performance.Class WHERE class_id = '" + classId + "'");
			System.out.println(rows + " class deleted");
		} catch (SQLException e) {
			System.out.println("Exception " + e.getMessage());
		}
	}

	
}
