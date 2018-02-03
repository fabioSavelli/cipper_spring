package it.springCipper.springCipper.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import it.springCipper.springCipper.model.UtenteLogged;
import it.springCipper.springCipper.service.ISeguiService;

@Controller
public class SeguiController {
	
	@Autowired
	private HttpSession httpSession;
	
	@Autowired
	private ISeguiService seguiService;
	
	@RequestMapping(method = RequestMethod.POST, path = "/seguiUtente")
	public @ResponseBody Boolean segui(@RequestParam("idUtenteAltro") int idUtenteAltro) {
		UtenteLogged utenteLogged = (UtenteLogged) httpSession.getAttribute("utente");
		return seguiService.segui(idUtenteAltro, utenteLogged);
	}
}
