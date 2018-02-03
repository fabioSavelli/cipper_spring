package it.springCipper.springCipper.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import it.springCipper.springCipper.model.UtenteLogged;

@Controller
public class LogoutController {
	
//	public ModelAndView logout(ModelAndView mv, HttpSession httpSession) {
//		
//		httpSession.setAttribute("utente", null);
//		httpSession.invalidate();
//		mv.setViewName("app.login");
//		return mv;
//	}
	
	@RequestMapping(path = "/logout")
	public ModelAndView logout(ModelAndView mv,@SessionAttribute("utente")UtenteLogged utente,  HttpSession session) {
		if(utente!=null) {
			utente = null;
			session.invalidate();
		}
		mv.setViewName("app.login");
		return mv;
	}
}
