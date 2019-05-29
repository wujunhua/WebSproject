package com.atossyntel.excelupload;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import org.apache.log4j.Logger;


public class ClassCRUD {
    final static Logger logger = Logger.getLogger(ClassCRUD.class);

	public void insertClass(Statement st, String classId, String streamId, String userId, String startDate, String endDate) throws SQLException{
		
               
            try {
			logger.info("Inserting a class...");
                        
			int rows = st.executeUpdate("INSERT INTO Student_Performance.Class VALUES ('" + classId + "','" + streamId + "','" + userId  + "',TO_DATE('"+startDate+"', 'YYYY-MM-DD'),TO_DATE('"+endDate+"','YYYY-MM-DD'))");
			logger.info(rows + " class added...");
		} catch (SQLException e) {
			logger.error(e.getMessage());
		}
	}
	
	public void readClass(Statement st, String classId){
		logger.info("Reading class...");
		try (ResultSet rs = st.executeQuery("SELECT class_id, stream_id, user_id FROM Student_Performance.Class WHERE class_id = '" + classId + "'");) {
			while(rs.next())
				logger.info("Result: " + rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3));
		} catch (SQLException e) {
			logger.error(e.getMessage());
		} 
	}
	
	public void updateClass(Statement st, String classId, String streamId, String userId){
		try {
			logger.info("Update class.");
			int rows = st.executeUpdate("UPDATE Student_Performance.Class SET stream_id ='" + streamId + "', user_id='" + userId + "'WHERE class_id ='" + classId + "'");
			logger.info(rows + " class updated");
		} catch (SQLException e) {
			logger.error("Exception " + e.getMessage());
		}
	}
	
	public void deleteClass(Statement st, String classId){
		try {
			logger.info("Delete class.");
			int rows = st.executeUpdate("DELETE FROM Student_Performance.Class WHERE class_id = '" + classId + "'");
			logger.info(rows + " class deleted");
		} catch (SQLException e) {
			logger.error("Exception " + e.getMessage());
		}
	}

	
}
