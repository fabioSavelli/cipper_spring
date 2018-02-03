package it.springCipper.springCipper.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class IndexController {
	
	@RequestMapping(method = RequestMethod.GET, path = "/")
	public String home() {
		System.out.println("ciao");
		return "app.login";
	}

}
