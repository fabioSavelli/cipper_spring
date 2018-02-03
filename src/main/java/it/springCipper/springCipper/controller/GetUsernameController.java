package it.springCipper.springCipper.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import it.springCipper.springCipper.service.IGetUsernameService;

@Controller
public class GetUsernameController {

	@Autowired
	private IGetUsernameService getUsernameService;
	
	@RequestMapping(path="/getAllUser")
	public @ResponseBody String[] checkUsername() {
		List<String> lista = getUsernameService.getAllUsername();
		String[] ret = new String[lista.size()];
		ret = lista.toArray(ret);
		return ret;
	}
}
