package it.springCipper.springCipper.service.impl;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.springCipper.springCipper.Costants.CipperCostants;
import it.springCipper.springCipper.manager.IUtenteManager;
import it.springCipper.springCipper.model.Utente;
import it.springCipper.springCipper.service.IRecuperaPswService;

@Service
public class RecuperaPswService implements IRecuperaPswService {

	@Autowired
	IUtenteManager utenteManager;
	
	@Override
	public boolean emailPresente(String email) {
		return (utenteManager.findByEmail(email) == null) ? false : true;
	}

	@Override
	public void inviaEmail(String email) {
		Utente utente = utenteManager.findByEmail(email);
		String nuovaPsw = generaPsw();
		utenteManager.modificaPsw(utente, nuovaPsw);
		sendEmail(email, nuovaPsw, utente.getUsername());
	}
	
	private static String generaPsw() {
		final String ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		StringBuilder builder = new StringBuilder();
		for ( int i = 0 ; i < 8 ; i++) {
			int character = (int)(Math.random()*ALPHA_NUMERIC_STRING.length());
			builder.append(ALPHA_NUMERIC_STRING.charAt(character));
		}
		return builder.toString();
	} 
	
	private static void sendEmail(String email, String nuovaPsw, String username) {
	    Properties props = new Properties();
	    props.put("mail.smtp.host", "smtp.gmail.com");
	    props.put("mail.smtp.socketFactory.port", "465");
	    props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	    props.put("mail.smtp.auth", "true");
	    props.put("mail.smtp.port", "465");

	    Session session = Session.getInstance(props, new javax.mail.Authenticator() {
		    protected PasswordAuthentication getPasswordAuthentication() {
		        return new PasswordAuthentication(CipperCostants.USERNAME_EMAIL, CipperCostants.PASSWORD_EMAIL);
		    } 
	    }); 
	    
	    
	    try {
	        Message message = new MimeMessage(session);
	        message.setFrom(new InternetAddress("Cipper"));
	        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
	        message.setSubject("Recupero Password");
	        message.setText("Ciao " + username +"\n"+
	        		"Queste sono le tue nuove credenziali d'accesso:\n"+
	        		"email: "+email+"\n"+
	        		"password: "+nuovaPsw+"\n"+
	        		"Ricorda che potrai sempre cabiare la tua password nell'apposita area del sito.");

	        Transport.send(message);
	    } 
	    catch (MessagingException e) {
	    		e.printStackTrace();
	    	}
	}
}
