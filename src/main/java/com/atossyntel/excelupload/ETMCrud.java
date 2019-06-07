package com.atossyntel.excelupload;

import java.sql.SQLException;
import java.sql.Statement;
import org.apache.log4j.Logger;

public class ETMCrud {
    static final Logger logger = Logger.getLogger(ETMCrud.class);
	
	public void insertETM(Statement st, Module module, String empId, String streamName){
		try {
<<<<<<< HEAD
			logger.info("Inserting a modle scores... ");
=======

			System.out.println("Inserting a module scores... ");
			logger.info("Inserting a modle scores... ");

>>>>>>> 92a18aa... unit test
			int rows = st.executeUpdate("INSERT INTO employees_take_modules VALUES((Select m.module_id FROM modules m , stream s WHERE m.stream_id = s.stream_id AND m.module_name ='"+ module.getModuleName()+"' AND s.stream_Id = '" +streamName+"'), '"+ empId + "', "+ module.getmoduleScore() +")" );
			logger.info(rows + " module added...");
		} catch (SQLException e) {
			logger.error("Exception " + e.getMessage());
                        logger.error("Error with module:" + module.getModuleName() + " employee name" + empId);
		}
	}

}
