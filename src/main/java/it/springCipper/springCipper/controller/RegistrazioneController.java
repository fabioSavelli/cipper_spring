package it.springCipper.springCipper.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import it.springCipper.springCipper.model.Cip;
import it.springCipper.springCipper.model.UtenteLogged;
import it.springCipper.springCipper.service.IRegistrazioneService;

@Controller
@SessionAttributes("utente")
public class RegistrazioneController {

	@Autowired
	IRegistrazioneService registrazioneService;
	
	@RequestMapping(path="/checkUsername")
	public @ResponseBody Boolean checkUsername(@RequestParam("username") String username) {
		if(username.equals("")) {
			return false;
		}
		return 	registrazioneService.usernamePresente(username);
	}
	
	@RequestMapping(path="/checkEmail")
	public @ResponseBody Boolean checkEmail(@RequestParam("email") String email) {
		if(email.equals("")) {
			return false;
		}
		return 	registrazioneService.emailPresente(email);
	}

	@RequestMapping(method = RequestMethod.POST, path = "/registrazione")
	public ModelAndView registrazione(ModelAndView mv, 
										@RequestParam("usernameRegistrazione") String username,
										@RequestParam("emailRegistrazione") String email,
										@RequestParam("pswRegistrazione") String password,
										@RequestParam("confpswRegistrazione") String confpsw) {
	
		if(email.equals("") || registrazioneService.emailPresente(email)) {
			mv.setViewName("app.login");
			mv.getModel().put("erroriRegistrazione", "ERRORE, verificare le credenziali inserite prima di procedere alla registrazione");
			mv.getModel().put("usernameRegistrazione", username);
			mv.getModel().put("emailRegistrazione", email);
			mv.getModel().put("pswRegistrazione", password);
			mv.getModel().put("confPswRegistrazione", confpsw);
			return mv;
		}
			
		if(username.equals("") || registrazioneService.usernamePresente(username)) {
			mv.setViewName("app.login");
			mv.getModel().put("erroriRegistrazione", "ERRORE, verificare le credenziali inserite prima di procedere alla registrazione");
			mv.getModel().put("usernameRegistrazione", username);
			mv.getModel().put("emailRegistrazione", email);
			mv.getModel().put("pswRegistrazione", password);
			mv.getModel().put("confPswRegistrazione", confpsw);
			return mv;
		}
		
		if(password.equals("") || (!password.equals(confpsw))) {
			mv.setViewName("app.login");
			mv.getModel().put("erroriRegistrazione", "ERRORE, verificare le credenziali inserite prima di procedere alla registrazione");
			mv.getModel().put("usernameRegistrazione", username);
			mv.getModel().put("emailRegistrazione", email);
			mv.getModel().put("pswRegistrazione", password);
			mv.getModel().put("confPswRegistrazione", confpsw);
			return mv;
		}
		
		UtenteLogged utenteLogged = registrazioneService.inserisci(username, email, password);
		
		List<Cip> lista = registrazioneService.listaCip(utenteLogged);
		mv.setViewName("app.homepage");
		mv.getModel().put("utente", utenteLogged);
		mv.getModel().put("listaCip", lista);
		mv.getModel().put("listaLike", registrazioneService.listaLike(lista, utenteLogged));
		
		return mv;
	}

	
	
}
