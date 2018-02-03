package it.springCipper.springCipper.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import it.springCipper.springCipper.model.UtenteLogged;
import it.springCipper.springCipper.service.INewCipService;

@Controller
public class NewCipController {

	@Autowired
	private INewCipService newCipService;
	
	@Autowired
	private HttpSession httpSession;
	
	@RequestMapping (method = RequestMethod.POST, path = "newCip")
	public ModelAndView newCip(ModelAndView mv, @RequestParam ("testo") String testo) {
		
		UtenteLogged utente = (UtenteLogged) httpSession.getAttribute("utente");
		if(utente==null) {
			mv.setViewName("app.login");
			return mv;
		}
		
		newCipService.aggiungiCip(testo, utente);
		
		mv.setViewName("app.homepage");
		mv.getModel().put("listaCip", newCipService.listaCipHome(utente));
		
		return mv;
	}
	
	@RequestMapping (method = RequestMethod.POST, path = "newCipProfilo")
	public ModelAndView newCipProfilo(ModelAndView mv, @RequestParam ("testo") String testo) {
		
		UtenteLogged utente = (UtenteLogged) httpSession.getAttribute("utente");
		if(utente==null) {
			mv.setViewName("app.login");
			return mv;
		}

		newCipService.aggiungiCip(testo, utente);
		
		mv.setViewName("app.profilo");
		mv.getModel().put("listaCip", newCipService.listaCipProfilo(utente));
		
		return mv;
	}
	
	
	
	
}
