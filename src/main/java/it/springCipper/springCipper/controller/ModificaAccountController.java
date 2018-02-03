package it.springCipper.springCipper.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import it.springCipper.springCipper.model.UtenteLogged;
import it.springCipper.springCipper.service.IModificaAccountService;

@Controller
@SessionAttributes("utente")
public class ModificaAccountController {
	
	private static String UPLOADED_FOLDER =  "/Users/Fabio/Desktop/Lavoro/progetti/allCipper/springCipper/src/main/webapp/images/fotoUtenti/";
	
	@Autowired
	IModificaAccountService modificaAccountService;
	
	@RequestMapping(path="/checkVecchiaPsw")
	public @ResponseBody Boolean checkVecchiaPsw(@RequestParam("vecchiaPsw") String vecchiaPsw, @SessionAttribute("utente")UtenteLogged utente) {
		
		if(vecchiaPsw.equals("")) {
			return false;
		}
		return modificaAccountService.checkVecchiaPsw(vecchiaPsw, utente);
	}
	
	@RequestMapping(method = RequestMethod.POST, path = "/modificaUsername")
	public ModelAndView modificaUsername(ModelAndView mv, @SessionAttribute("utente")UtenteLogged utenteLogged, @RequestParam("username") String username) {
		
		if(utenteLogged==null) {
			mv.setViewName("app.login");
			return mv;
		}
		
		mv.setViewName("app.modificaAccount");
		mv.getModel().put("parametro", "username");

		if(! modificaAccountService.checkUsername(username)) {
			mv.getModel().put("erroreUsername", "username non valida");
			mv.getModel().put("username", username);
			return mv;
		}
		utenteLogged = modificaAccountService.modificaUsername(utenteLogged, username);
		mv.getModel().put("utente", utenteLogged);
		mv.getModel().put("messaggioModificaUsername", "L'operazione è andata a buon fine");
		return mv;
	}
	
	@RequestMapping(method = RequestMethod.POST, path = "/modificaEmail")
	public ModelAndView modificaEmail(ModelAndView mv, @SessionAttribute("utente")UtenteLogged utenteLogged, @RequestParam("email") String email) {
		
		if(utenteLogged==null) {
			mv.setViewName("app.login");
			return mv;
		}
		
		mv.setViewName("app.modificaAccount");
		mv.getModel().put("parametro", "email");

		if(! modificaAccountService.checkEmail(email)) {
			mv.getModel().put("erroreEmail", "email non valida");
			mv.getModel().put("email", email);
			return mv;
		}
		utenteLogged = modificaAccountService.modificaEmail(utenteLogged, email);
		mv.getModel().put("utente", utenteLogged);
		mv.getModel().put("messaggioModificaEmail", "L'operazione è andata a buon fine");
		return mv;
	}
	
	@RequestMapping(method = RequestMethod.POST, path = "/modificaPassword")
	public ModelAndView modificaPsw(ModelAndView mv, @SessionAttribute("utente")UtenteLogged utenteLogged, @RequestParam("vecchiaPsw") String vecchiaPsw, @RequestParam("nuovaPsw") String nuovaPsw, @RequestParam("confPsw") String confPsw) {
		
		if(utenteLogged==null) {
			mv.setViewName("app.login");
			return mv;
		}
		
		mv.setViewName("app.modificaAccount");
		mv.getModel().put("parametro", "psw");

		if((! nuovaPsw.equals(confPsw)) || nuovaPsw.equals("") || (! modificaAccountService.checkVecchiaPsw(vecchiaPsw, utenteLogged))) {
			if(!nuovaPsw.equals(confPsw)) {
				mv.getModel().put("errorePsw", "le password non coincidono");
			}
			else if(nuovaPsw.equals("")) {
				mv.getModel().put("errorePsw", "password vuota");
			}
			else {
				mv.getModel().put("errorePsw", "vecchia password errata");
			}
			
			mv.getModel().put("vecchiaPsw", vecchiaPsw);
			mv.getModel().put("nuovaPsw", nuovaPsw);
			mv.getModel().put("confPsw", confPsw);
			return mv;
		}
		utenteLogged = modificaAccountService.modificaPsw(utenteLogged, nuovaPsw);
		mv.getModel().put("utente", utenteLogged);
		mv.getModel().put("messaggioModificaPsw", "L'operazione è andata a buon fine");
		return mv;
	}
	
	
	
	@RequestMapping(method = RequestMethod.POST, path = "/modificaFoto")
	public ModelAndView modificaFoto(ModelAndView mv, @SessionAttribute("utente")UtenteLogged utente, @RequestParam("pathFoto") MultipartFile multiPartFile) {
		
		if(utente==null) {
			mv.setViewName("app.login");
			return mv;
		}
		
		byte[] bytes;
		try {
			bytes = multiPartFile.getBytes();
			Path path = Paths.get(UPLOADED_FOLDER + utente.getIdUtente() + "-" + multiPartFile.getOriginalFilename());
			Files.write(path, bytes);
		} 
		catch (IOException e) {
			e.printStackTrace();
		}
		
		utente = modificaAccountService.modificaFoto(utente, multiPartFile.getOriginalFilename());
		
		mv.getModel().put("utente", utente) ;
		mv.setViewName("app.modificaAccount");
		mv.getModel().put("parametro", "foto");
		return mv;
	}
}

