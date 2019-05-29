/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.atossyntel.controller;


import java.util.Properties;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;

import com.atossyntel.pojo.ResetPassForm;
import com.atossyntel.pojo.UserServiceDAO;

import org.apache.log4j.Logger;

public class ResetPass extends SimpleFormController {
    final static Logger logger = Logger.getLogger(ResetPass.class);
        
    public ResetPass(){
        setCommandClass(com.atossyntel.pojo.ResetPassForm.class);
        setCommandName("forgotPass");
    }
    
    public void SendResetEmail(String email, String pass_message) {
        String host="smtp.gmail.com";
        final String user="jmcgregtemp@gmail.com";//ENTER YOUR EMAIL!!
        final String password="mcgregor1"; //ENTER YOUR PASSWORD

        String to=email;

        //imported code
        Properties props = new Properties();
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.user", user);
        props.put("mail.smtp.password", password);
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");


        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(user,password);
                    }
                });
        
        //imported code
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject("Password reset - Attos Syntel");


            // Create the message part
            BodyPart messageBodyPart = new MimeBodyPart();

            // Now set the actual message
            messageBodyPart.setText("Your password has been reset, the new password is:" + pass_message);

            // Create a multipart message
            Multipart multipart = new MimeMultipart();

            // Set text message part
            multipart.addBodyPart(messageBodyPart);

            // Send the complete message parts
            message.setContent(multipart);
          //  Transport tr = session.getTransport("smtp");
            Transport.send(message);

            logger.info("message sent!");

        }
        catch (MessagingException mex)
        {
            logger.error("********RESETPASS.JAVA ********\n"
                    + "Error: unable to send message....");
            logger.error(mex.toString());
            
        }
        
    }
    
    @Override
    protected ModelAndView onSubmit(Object command) throws Exception{
        ResetPassForm userEmail = (ResetPassForm) command;
        
        logger.info("ResetPass: " + userEmail);
        
        ServletContext context = this.getServletContext();
        WebApplicationContext ctx;
        ctx =  WebApplicationContextUtils.getRequiredWebApplicationContext(context);
        UserServiceDAO usrDAO = (UserServiceDAO)ctx.getBean("user1");
        
        
        try {
            //try to find username in database
            //create random password
            PasswordGenerator passwordGenerator = new PasswordGenerator();
            String newPass = passwordGenerator.generatePassword();
            //set the new password in the database
            usrDAO.setUserPassword(userEmail.getEmail(), newPass);
            //send email to user with the new password
            SendResetEmail(userEmail.getEmail(), newPass);
            logger.info("Password Changed");
            
        }catch(Exception e){
            String errorMessage = "<div class=\"alert alert-danger mx-5 alert-dismissible fade show\" role=\"alert\">\n"
                    + "  <strong>Error:</strong> email isn't in our system\n"
                    + "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">\n"
                    + "    <span aria-hidden=\"true\">&times;</span>\n"
                    + "  </button>\n"
                    + "</div>";
            logger.error("********EXCEPTION IN RESETPASS.JAVA**********");
            logger.error("Invalid Email");
            logger.error(e);
            return new ModelAndView("reset-password", "errorMessage", errorMessage);
        }
        String confirmMessage = "<div class=\"alert alert-success mx-5 alert-dismissible fade show\" role=\"alert\">\n"
                + "  <strong>Success!</strong> reset email has been sent.\n"
                + "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">\n"
                + "    <span aria-hidden=\"true\">&times;</span>\n"
                + "  </button>\n"
                + "</div>";
        // causes redirect to login page
        return new ModelAndView("reset-password", "confirmMessage", confirmMessage); 
    }
}
