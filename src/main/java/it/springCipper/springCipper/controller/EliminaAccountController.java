package it.springCipper.springCipper.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import it.springCipper.springCipper.model.UtenteLogged;
import it.springCipper.springCipper.service.IEliminaAccountService;

@Controller
public class EliminaAccountController {

	@Autowired
	IEliminaAccountService eliminaAccountService;
	
	@RequestMapping(path = "/eliminaAccount")
	public ModelAndView eliminaAccount(ModelAndView mv, HttpSession httpSession) {
		UtenteLogged utenteLogged = (UtenteLogged) httpSession.getAttribute("utente");
		if(utenteLogged==null) {
			mv.setViewName("app.login");
			return mv;	
		}
		eliminaAccountService.elimina(utenteLogged);
		mv.setViewName("app.login");
		return mv;
	}
	
}
