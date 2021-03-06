package com.atossyntel.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.sql.Statement;
import java.util.Calendar;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Multipart;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;
import org.apache.log4j.Logger;

public class SendEmail {
	private static String contentId = "Content-ID";
	
	private SendEmail() {
		super();
	}
    static final Logger logger = Logger.getLogger(SendEmail.class);
    
    public static void sendIdividualEmail(String email, String id) {
    	
        String host="smtp.office365.com";
        final String user="nickcook1234@outlook.com";
        final String pword="ABC123abc!@#"; 

        String to=email;

        //imported code
        Properties props = new Properties();
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.user", user);
        props.put("mail.smtp.password", pword);
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");


        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
        			@Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(user,pword);
                    }
                });
        
        //imported code
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            String cc = getRM(email);
            if(!cc.equals(""))
                message.addRecipient(Message.RecipientType.CC, new InternetAddress(cc));
            
            //String[] startEndDates = getStartEnd(email);
         
            message.setSubject("Performica Report");
            logger.info("here");
            // Create the message part

            // Create a multipart message
            Multipart multipart = new MimeMultipart();

            // Part two is attachment
            BodyPart messageBodyPart = new MimeBodyPart();
            String path = "C:/Users/syntel/Music/" + id + ".pdf";
            String filename = id + ".pdf";
            DataSource source = new FileDataSource(path);
            messageBodyPart.setDataHandler(new DataHandler(source));
            messageBodyPart.setFileName(filename);
            multipart.addBodyPart(messageBodyPart);


            
            messageBodyPart = new MimeBodyPart();
            String htmlText = "<html lang=\"en\">\n" +
            "<head>\n" +
            "<title>Performica</title>\n" +
            "<meta charset=\"utf-8\">\n" +
            "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n" +
            "<style>\n" +
            "* {\n" +
            "  box-sizing: border-box;\n" +
            "}\n" +
            "\n" +
            "/* Clear floats after the columns */\n" +
            "section:after {\n" +
            "  content: \"\";\n" +
            "  display: table;\n" +
            "  clear: both;\n" +
            "}\n" +
            "@media (max-width: 600px) {\n" +
            "  nav, article {\n" +
            "    width: 100%;\n" +
            "    height: auto;\n" +
            "  }\n" +
            "}\n" +
            "</style>\n" +
            "</head>\n" +
            "<body style=\"  font-family: Verdana, sans-serif;\n" +
            "  width: 800px;\n" +
            "  border: solid;\n" +
            "  margin: 0px 0px 0px 10px;\n" +
            "  padding-left: 0px;\">\n" +
            "\n" +
            "<header style=\"  height: 195px;\n" +
            "  position:relative;  \n" +
            "  height:12.1em;\n" +
            "  width 100%;\"><img src=\"cid:image\" width=\"799\"></header>\n" +
            "<section>\n" +
            "  \n" +
            "  <article style='float: left;width: 100%;padding-left: 20px;padding-right: 20px;font-family: Verdana;'>\n" +
            "    <p style=\"padding-left: 20px;padding-right: 20px\";><strong>Hi " + getName(email) +",</strong><br>\n" +
            "    <br>You have successfully completed your technical induction training program. We are happy to share the detailed report of your performance during the training period. We thank you for your participation in our training program and hope you had a good learning experience.<br>\n" +
            "    <br>Should you need any further information, please do not hesitate to contact us.\n" +
            "	 \n" +
            "    <br><br><strong>Wish you the best for your future!</strong><br></p>\n" +
            "    <img src=\"cid:image2\" width=\"794\";> \n" +
            "    <p style=\"padding-left: 20px;padding-right: 20px\";><br><br>Thanks and Regards,\n" +
            "    <br>Training and Development Team</p><br>\n" +
            "  </article>\n" +
            "</section>\n" +
            "<div style=\"background: rgb(0,102,161);color: #fff;font-family:Verdana; height:1.5em;\">\n" +
            "      <p align=\"center\">For internal circulation only.©" + Calendar.getInstance().get(Calendar.YEAR)  +"</p>\n" +
            "  </div> \n" +

            "\n" +
            "</body>\n" +
            "</html>";
            messageBodyPart.setContent(htmlText, "text/html;charset=iso-8859-1");
            // add it
            multipart.addBodyPart(messageBodyPart);
            //add header image
            messageBodyPart = new MimeBodyPart();
            DataSource fds = new FileDataSource(
            "C:\\Examples\\WebSproject\\src\\main\\resources\\img\\header.jpg");

            messageBodyPart.setDataHandler(new DataHandler(fds));
            messageBodyPart.setHeader(contentId, "<image>");
            multipart.addBodyPart(messageBodyPart);
            messageBodyPart = new MimeBodyPart();
            DataSource fds2 = new FileDataSource("C:\\Examples\\WebSproject\\src\\main\\resources\\img\\welcome.jpg");
            messageBodyPart.setDataHandler(new DataHandler(fds2));
            messageBodyPart.setHeader(contentId, "<image2>");
            multipart.addBodyPart(messageBodyPart);
            // Send the complete message parts
            
            
            message.setContent(multipart);

            
            Transport.send(message);

            logger.info("message sent!");

        }
        catch (MessagingException mex)
        {
            logger.error("Error: unable to send message....");
            logger.error(mex.toString());
            
        }
        
    }
    
        public static void sendUserNamePassword(String email, String pswd) {
    	
        String host="smtp.office365.com";
        final String userName="nickcook1234.com";
        final String pass="ABC123abc!@#"; 
        String to=email;

        //imported code
        Properties props = new Properties();
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.user", userName);
        props.put("mail.smtp.password", pass);
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");


        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
        			@Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(userName,pass);
                    }
                });
        
        //imported code
        try {
            
           MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(userName));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject("Atos Syntel - Performica Account Created");
    
            // Create the message part

            // Create a multipart message
            Multipart multipart = new MimeMultipart();
            BodyPart messageBodyPart = new MimeBodyPart();
            String htmlText = "<!DOCTYPE html>\n" +
            "<html lang=\"en\">\n" +
            "<head>\n" +
            "<title>Performica</title>\n" +
            "<meta charset=\"utf-8\">\n" +
            "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n" +
            "<style>\n" +
            "* {\n" +
            "  box-sizing: border-box;\n" +
            "}\n" +
            "\n" +
            "/* Clear floats after the columns */\n" +
            "section:after {\n" +
            "  content: \"\";\n" +
            "  display: table;\n" +
            "  clear: both;\n" +
            "}\n" +
            "/* Responsive layout - makes the two columns/boxes stack on top of each other instead of next to each other, on small screens */\n" +
            "@media (max-width: 600px) {\n" +
            "  nav, article {\n" +
            "    width: 100%;\n" +
            "    height: auto;\n" +
            "  }\n" +
            "}\n" +
            "</style>\n" +
            "</head>\n" +
            "<body style=\"  font-family: Verdana, sans-serif;\n" +
            "  width: 800px;\n" +
            "  border: solid;\n" +
            "  margin: 0px 0px 0px 150px;\n" +
            "  padding-left: 0px;\">\n" +
            "\n" +
            "<header style=\"  height: 195px;\n" +
            "  position:relative;  \n" +
            "  height:12.1em;\n" +
            "  width 100%;\"><img src=\"cid:image\" width=\"794\"></header>\n" +
            "<section>\n" +
            "  \n" +
            "  <article style='padding-left: 20px;padding-right: 20px;font-family: Verdana;'>\n" +
            "    <p style=\"padding-left: 20px;padding-right:20px;\"><strong>Welcome to Atos Syntel!</strong><br>\n" +
            "    <br>Your Performica account has successfully been created! Sign in detials are below:<br>\n" +
            "    <br><strong>Email/Username: " + email + "<br>\n" +
            "    Password: " + pswd + "</strong><br>\n" +
            "\n" +
            "    <br>Once you have loggeed in, you will be able to change your default password.\n" +
            "\n" +
            "    <br><br>Thanks and Regards,\n" +
            "    <br>Training and Development Team</p>\n" +
            "  </article>\n" +
            "</section>\n" +
            "  <div style=\"background: rgb(0,102,161);color: #fff;font-family:Verdana; height:1.5em;\">\n" +
            "      <p align=\"center\">For internal circulation only.© 2019</p>\n" +
            "  </div> \n" +
            "</body>\n" +
            "</html>";
            messageBodyPart.setContent(htmlText, "text/html;charset=iso-8859-1");
            // add it
            multipart.addBodyPart(messageBodyPart);
            //add header image
            messageBodyPart = new MimeBodyPart();
            DataSource fds = new FileDataSource(
            "C:\\Examples\\WebSproject\\src\\main\\resources\\img\\header.jpg");

            messageBodyPart.setDataHandler(new DataHandler(fds));
            messageBodyPart.setHeader(contentId, "<image>");
            multipart.addBodyPart(messageBodyPart);
            
            message.setContent(multipart);

            
            Transport.send(message);

            logger.info("message sent!");


        }
        catch (MessagingException mex)
        {
            logger.error("Error: unable to send message....");
            logger.error(mex.toString());
            
        }
        
    }
    
    public static void sendBatchEmails(String classid) {
        Map<String,String> emails = getBatchEmails(classid);
        
    	
    	for (Map.Entry<String,String> entry : emails.entrySet()) {
    		sendIdividualEmail(entry.getKey(),entry.getValue());
    		
    	}		
    }
    
    static boolean validateEmail(String username)
    {
	int count = 0;
	PropertiesAccessor prop = new PropertiesAccessor();
	try(Connection con = DriverManager.getConnection(prop.getURL(),prop.getUsername(),prop.getPassword()); Statement st = con.createStatement();             ResultSet rs = st.executeQuery("select email from employees where email = " + "'" + username + "'");)
	{									
            while(rs.next())
            {
		++count;
            }
            con.commit();
            if(count == 0 || count > 1)
            {
		logger.info("Not Valid Email!!!");
                    return false;
            }
            else if(count ==1)
            {
		logger.info("Valid Email!");
		return true;
            }
		                
            }catch (Exception ex) 
            {
		logger.error(ex);
            }
				

            return false;
    }
    
    static String[] getEmployee(String email) {//getEmployee returns an array of attributes
    	PropertiesAccessor prop = new PropertiesAccessor();
    	try(Connection con = DriverManager.getConnection(prop.getURL(),prop.getUsername(),prop.getPassword()); Statement st = con.createStatement(); ResultSet rs = st.executeQuery("select employee_id, name from employees where email = '" + email + "'");)
	{         
            String[] emp = new String[4];
            while(rs.next()){
                emp[0] = rs.getString("employee_id");
                emp[1] = rs.getString("name");
                
            }
			
            con.commit();
            return emp;               
	}
		
	catch (Exception ex) 
	{
            logger.error(ex);
	}
    	
    	return new String[0];
    }
    
    static String getEmpId(String email) {
    	
    	try
	{
            String[] emp = getEmployee(email);
            String empid = emp[0];
            if(empid == null)
                return "";
            else
                return empid;
                
	}
        catch (Exception ex) 
        {
            logger.error(ex);
	}
    	
    	return " ";
    }
    
    static String getName(String email) {
    	
    	try
	{
            String[] emp = getEmployee(email);
            String name = emp[1];
            if(name == null)
                return "";
            else
                return name;
	}	
        catch (Exception ex) 
        {
            logger.error(ex);
	}
    	
    	return " ";
    }
        
    static String getRM(String email) {
    	
    	try
	{
            String[] emp = getEmployee(email);
            String rm = emp[3];
            if(rm==null)
                return "";
            else
                return rm;
	}
		
	catch (Exception ex) 
	{
            logger.error(ex);
	}
    	
    	return "";
    }
        
    static Map<String,String> getBatchEmails(String classid) {
    	
    	Map<String,String> batchEmails = new HashMap<>();
    	PropertiesAccessor prop = new PropertiesAccessor();
    	try(Connection con = DriverManager.getConnection(prop.getURL(),prop.getUsername(),prop.getPassword()); Statement st = con.createStatement(); ResultSet rs = st.executeQuery("select employee_id, email from employees where batch_id = " + "'" + classid + "'");)
	{            
            while(rs.next())
            {
		batchEmails.put(rs.getString(2),rs.getString(1));
            }
			
            con.commit();
                
	}	
        catch (Exception ex) 
	{
            logger.error(ex);
	}
    	
    	return batchEmails;
    }
    
    
}