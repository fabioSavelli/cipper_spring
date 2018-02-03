package it.springCipper.springCipper.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import it.springCipper.springCipper.model.Cip;
import it.springCipper.springCipper.model.UtenteLogged;
import it.springCipper.springCipper.service.IReCipService;

@Controller
public class ReCipController {

	@Autowired
	IReCipService reCipService;
	
	@RequestMapping (method = RequestMethod.POST, path = "/reCipHome")
	public ModelAndView newReCipHome(ModelAndView mv,@SessionAttribute("utente")UtenteLogged utenteLogged, @RequestParam ("idCip") int idCip) {
		
		if(utenteLogged==null) {
			mv.setViewName("app.login");
			return mv;
		}
		
		reCipService.creaReCip(utenteLogged, idCip);
		List<Cip> lista = reCipService.listaCipHome(utenteLogged);
		mv.setViewName("app.homepage");
		mv.getModel().put("listaCip", lista);
		mv.getModel().put("listaLike", reCipService.listaLike(lista, utenteLogged));
		return mv;
	}
	
	@RequestMapping (method = RequestMethod.POST, path = "/reCipProfilo")
	public ModelAndView newReCipProfilo(ModelAndView mv,@SessionAttribute("utente")UtenteLogged utenteLogged, @RequestParam ("idCip") int idCip) {
		
		if(utenteLogged==null) {
			mv.setViewName("app.login");
			return mv;
		}
		
		reCipService.creaReCip(utenteLogged, idCip);
		List<Cip> lista = reCipService.listaCipProfilo(utenteLogged);
		mv.setViewName("app.profilo");
		mv.getModel().put("listaCip", lista);
		mv.getModel().put("listaLike", reCipService.listaLike(lista, utenteLogged));
		return mv;
	}
	
	@RequestMapping(path="/reCipProfiloAltri")
	public @ResponseBody ModelAndView newReCipProfiloAltri(ModelAndView mv, @RequestParam("idUtenteAltro") int idUtenteAltro, @SessionAttribute("utente")UtenteLogged utenteLogged, @RequestParam ("idCip") int idCip) {

		if(utenteLogged==null) {
			mv.setViewName("app.login");
			return mv;
		}
		
		reCipService.creaReCip(utenteLogged, idCip);
		
		UtenteLogged altro  = reCipService.cercaUtentePerId(idUtenteAltro);
		List<Cip> lista = reCipService.listaCipProfilo(altro);
		
		mv.setViewName("app.profiloAltri");
		mv.getModel().put("altro", altro);
		mv.getModel().put("listaCip", lista);
		mv.getModel().put("listaLike", reCipService.listaLike(lista, utenteLogged));
		mv.getModel().put("segui", reCipService.seguo(utenteLogged, altro));
		return mv;
	}
	
}
