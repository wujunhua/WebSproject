package com.atossyntel.controller;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Properties;

import org.apache.log4j.Logger;

public class PropertiesAccessor {
    static final Logger logger = Logger.getLogger(PropertiesAccessor.class);
	Properties prop;
	
	 public PropertiesAccessor() {
		 try (InputStream input = new FileInputStream("C:/Examples/WebSProject/src/main/webapp/WEB-INF/jdbc.properties")) {
			 prop = new Properties();
			 prop.load(input);
		 } catch(Exception e) {
			 logger.error("File not found");
			 logger.error(e.getMessage());
		 }
	 }
	 
	 public String getPassword() {
		 return prop.getProperty("jdbc.password");
	 }
	 public String getUsername() {
		 return prop.getProperty("jdbc.username");
	 }
	 public String getURL() {
		 return prop.getProperty("jdbc.url");
	 }
	 public String getFilePath() {
		 return prop.getProperty("jdbc.filepath");
	 }
	 public String getImagePath() {
		 return prop.getProperty("jdbc.imagepath");
	 }
}
