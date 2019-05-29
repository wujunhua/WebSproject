package com.atossyntel.excelupload;

	import java.sql.Statement;
	import java.sql.Connection;
	import java.sql.DriverManager;
	import java.sql.ResultSet;
import java.sql.SQLException;
import org.apache.log4j.Logger;

	public class EmployeeCRUD {
            static final Logger logger = Logger.getLogger(EmployeeCRUD.class);
		
		public boolean insertEmployee(Statement st, Employee employee){
                            
                            try {
				logger.info("Creating new employee. ");
				int rows = st.executeUpdate("INSERT INTO Student_Performance.Employees VALUES ('" + employee.getEmployeeID() + "','" + employee.getEmployeeName() + "','" + employee.getEmployeeEmail() + "','" + employee.getClassID() + "','"+employee.getManagerID()+"')");
				
                                logger.info(rows + " employee added.");
                                return true;
			} catch (SQLException e) {

				logger.error(e.getMessage());
                                return false;
			}
                        
		}
		

		public void readEmployee(Statement st, String employeeId){
			try(ResultSet rs = st.executeQuery("SELECT employee_id, name, email, class_id FROM Student_Performance.Employees WHERE employee_id = '" + employeeId + "'");) {
				logger.info("Reading employee.");
				while(rs.next())
					logger.info(rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3) + " " + rs.getString(4));
			} catch (SQLException e) {
				logger.error(e.getMessage());
			}
		}
		
		public void updateEmployee(Statement st, String employeeId, String name, String email){
			try {
				logger.info("Update employee.");
				int rows = st.executeUpdate("UPDATE Student_Performance.Employees SET name ='" + name + "' ,email ='" + email +

						"'WHERE employee_id ='" + employeeId + "'");
				logger.info(rows + " employee updated.");
			} catch (SQLException e) {
				logger.error(e.getMessage());
			}
		}
		
		public void deleteEmployee(Statement st, String employeeId){
			try {
				logger.info("Delete employee.");
				int rows = st.executeUpdate("DELETE FROM Student_Performance.Employees WHERE employee_id = '" + employeeId + "'");
				logger.info(rows + " employee deleted.");
			} catch (Exception e) {
				logger.error("Exception: " +  e.getMessage());
			}
		}
                
                public void updateClass(Statement st, Employee employee){
                    try {
                        st.executeUpdate("UPDATE employees Set class_id = '"+employee.getClassID()+"' where employee_id = '"+employee.getEmployeeID()+"'");
                        logger.info("Employee Updated");
                    } catch(SQLException e){
                        logger.error(e.getMessage());
                        
                    }
                    
                }
                

		public static void main(String[] args) {
			try {
				Class.forName("oracle.jdbc.OracleDriver");
                            try (Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "Student_Performance", "Student_Performance")) {
                                Statement st = con.createStatement();
                                st.close();
                            }
			} catch (ClassNotFoundException | SQLException e) {
				logger.error("Exception " + e.getMessage());
			} 
		}
		
		

	}
