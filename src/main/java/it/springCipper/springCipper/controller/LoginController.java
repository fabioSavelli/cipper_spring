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
import it.springCipper.springCipper.service.ILoginService;

@Controller
@SessionAttributes("utente")
public class LoginController {

	@Autowired
	private ILoginService loginService;
	
	@RequestMapping(path="/checkEmailLogin")
	public @ResponseBody Boolean checkUsername(@RequestParam("email") String email) {
		if(email.equals("")) {
			return false;
		}
		return loginService.emailPresente(email);
	}
	
	@RequestMapping(method = RequestMethod.POST, path = "login")
	public ModelAndView login(ModelAndView mv, @RequestParam("email") String email, @RequestParam("psw") String password) {

		UtenteLogged utenteLogged = loginService.cercaUtente(email, password);
		if(utenteLogged==null) {
			mv.setViewName("app.login");
			mv.getModel().put("errori",  "email o password errate");
			mv.getModel().put("email", email);
			return mv;
		}
			
		List<Cip> lista = loginService.listaCip(utenteLogged);
		mv.setViewName("app.homepage");
		mv.getModel().put("utente", utenteLogged) ;
		mv.getModel().put("listaCip", lista);
		mv.getModel().put("listaLike", loginService.listaLike(lista, utenteLogged));
		
		return mv;
	}

}
