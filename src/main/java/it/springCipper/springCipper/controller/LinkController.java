package it.springCipper.springCipper.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import it.springCipper.springCipper.model.Cip;
import it.springCipper.springCipper.model.UtenteLogged;
import it.springCipper.springCipper.service.ILinkService;

@Controller
public class LinkController {

	@Autowired
	ILinkService linkService;

	@Autowired
	private HttpSession httpSession;
	
	@RequestMapping(path="/homepage")
	public @ResponseBody ModelAndView goToHomepage(ModelAndView mv) {
		
		UtenteLogged utenteLogged = (UtenteLogged)httpSession.getAttribute("utente");
		if(utenteLogged==null) {
			mv.setViewName("app.login");
			return mv;
		}
		
		List<Cip> lista = linkService.listaCipHome(utenteLogged);
		mv.setViewName("app.homepage");
		mv.getModel().put("listaCip", lista);
		mv.getModel().put("listaLike", linkService.listaLike(lista, utenteLogged));
		return mv;
	}
	
	@RequestMapping(path="/profilo")
	public @ResponseBody ModelAndView goToProfilo(ModelAndView mv) {
		
		UtenteLogged utenteLogged = (UtenteLogged)httpSession.getAttribute("utente");
		if(utenteLogged==null) {
			mv.setViewName("app.login");
			return mv;
		}
		
		List<Cip> lista = linkService.listaCipProfilo(utenteLogged);
		mv.setViewName("app.profilo");
		mv.getModel().put("listaCip", lista);
		mv.getModel().put("listaLike", linkService.listaLike(lista, utenteLogged));
		return mv;
	}

	@RequestMapping(path="/follower")
	public @ResponseBody ModelAndView goToFollower(ModelAndView mv) {
		
		UtenteLogged utenteLogged = (UtenteLogged)httpSession.getAttribute("utente");
		if(utenteLogged==null) {
			mv.setViewName("app.login");
			return mv;
		}
		
		List<UtenteLogged> listaFollower = linkService.follow(utenteLogged);
		List<UtenteLogged> listaFollowerBy = linkService.followBy(utenteLogged);
		List<Boolean> listaBooleanFollower = linkService.listaBooleanFollowerBy(utenteLogged, listaFollowerBy);
		
		mv.setViewName("app.follower");
		mv.getModel().put("listaFollower", (listaFollower.isEmpty())?null : listaFollower);
		mv.getModel().put("listaFollowerBy", (listaFollowerBy.isEmpty())?null : listaFollowerBy);
		mv.getModel().put("listaBooleanFollower", listaBooleanFollower);
		return mv;
	}
	
	@RequestMapping(path="/profiloAltri")
	public @ResponseBody ModelAndView goToProfiloAltri(ModelAndView mv, @RequestParam("idUtenteAltro") int idUtenteAltro) {

		UtenteLogged utenteLogged = (UtenteLogged)httpSession.getAttribute("utente");
		if(utenteLogged==null) {
			mv.setViewName("app.login");
			return mv;
		}

		UtenteLogged altro  = linkService.cercaUtentePerId(idUtenteAltro);
		List<Cip> lista = linkService.listaCipProfilo(altro);
		
		mv.setViewName("app.profiloAltri");
		mv.getModel().put("altro", altro);
		mv.getModel().put("listaCip", lista);
		mv.getModel().put("listaLike", linkService.listaLike(lista, utenteLogged));
		mv.getModel().put("segui", linkService.seguo(utenteLogged, altro));
		return mv;
	}
	
	@RequestMapping(path="/modificaAccount")
	public @ResponseBody ModelAndView goToModificaAccount(ModelAndView mv, @RequestParam("parametro") String parametro) {
		
		UtenteLogged utenteLogged = (UtenteLogged)httpSession.getAttribute("utente");
		if(utenteLogged==null) {
			mv.setViewName("app.login");
			return mv;
		}
		
		mv.setViewName("app.modificaAccount");
		mv.getModel().put("parametro", parametro);
		return mv;
	}
	
	@RequestMapping(path="/cerca")
	public @ResponseBody ModelAndView cerca(ModelAndView mv, @RequestParam("campoRicerca") String campoRicerca) {
		
		UtenteLogged utenteLogged = (UtenteLogged)httpSession.getAttribute("utente");
		if(utenteLogged==null) {
			mv.setViewName("app.login");
			return mv;
		}
		
		
		UtenteLogged altro  = linkService.cercaUtente(campoRicerca);
		if(altro == null) {
			mv.setViewName("app.homepage");	
			List<Cip> lista = linkService.listaCipHome(utenteLogged);
			mv.getModel().put("listaCip", lista);
			mv.getModel().put("listaLike", linkService.listaLike(lista, utenteLogged));
			mv.getModel().put("messaggioErrore", true);
			return mv;
		}
		if(altro.getIdUtente() == utenteLogged.getIdUtente()) {
			List<Cip> lista = linkService.listaCipProfilo(utenteLogged);
			mv.setViewName("app.profilo");
			mv.getModel().put("listaCip", lista);
			mv.getModel().put("listaLike", linkService.listaLike(lista, utenteLogged));
			return mv;
		}
		
		List<Cip> lista = linkService.listaCipProfilo(altro);
		mv.setViewName("app.profiloAltri");
		mv.getModel().put("altro", altro);
		mv.getModel().put("listaCip", lista);
		mv.getModel().put("listaLike", linkService.listaLike(lista, utenteLogged));
		mv.getModel().put("segui", linkService.seguo(utenteLogged, altro));
		return mv;
	}
}
