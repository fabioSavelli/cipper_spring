package it.springCipper.springCipper.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import it.springCipper.springCipper.model.UtenteLogged;
import it.springCipper.springCipper.service.ILikeService;

@Controller
public class LikeController {

	@Autowired
	private HttpSession httpSession;
	
	@Autowired
	private ILikeService likeService;
	
	@RequestMapping(method = RequestMethod.POST, path = "/inserisciLike")
	public @ResponseBody Boolean mettiLike(@RequestParam("idCip") int idCip) {
		UtenteLogged utenteLogged = (UtenteLogged) httpSession.getAttribute("utente");
		return likeService.inserisciLike(idCip, utenteLogged);
	}
}
