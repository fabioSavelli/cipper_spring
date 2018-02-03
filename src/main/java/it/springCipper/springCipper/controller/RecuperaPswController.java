package it.springCipper.springCipper.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import it.springCipper.springCipper.service.IRecuperaPswService;

@Controller
public class RecuperaPswController {

	@Autowired
	IRecuperaPswService recuperaPswService;
	
	@RequestMapping(path="/checkEmailRecuperaPsw")
	public @ResponseBody Boolean checkEmail(@RequestParam("email") String email) {
		if(email.equals("")) {
			return true;
		}
		return recuperaPswService.emailPresente(email);
	}
	
	@RequestMapping(method = RequestMethod.POST, path = "/checkPswRegistrazione")
	public @ResponseBody void checkPsw() { }
	
	@RequestMapping(method = RequestMethod.POST, path = "/recuperaPsw")
	public ModelAndView registrazione(ModelAndView mv, @RequestParam("emailRecuperaPsw") String email) {
		
		mv.setViewName("app.login");
		mv.getModel().put("emailRecuperaPsw", email);
		
		if(email.equals("") || (!recuperaPswService.emailPresente(email))) {
			 mv.getModel().put("erroriRecuperaPsw", "l'email inserita non è valida");
			 return mv;
		}
		recuperaPswService.inviaEmail(email);
		mv.getModel().put("messaggioRecuperaPsw", "controlla la tua email");
		return mv;
	}
}
