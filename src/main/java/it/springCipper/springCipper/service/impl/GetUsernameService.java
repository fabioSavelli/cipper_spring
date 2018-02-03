package it.springCipper.springCipper.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.springCipper.springCipper.manager.IUtenteManager;
import it.springCipper.springCipper.model.Utente;
import it.springCipper.springCipper.service.IGetUsernameService;

@Service
public class GetUsernameService implements IGetUsernameService {

	@Autowired
	private IUtenteManager utenteManager;
	
	public List<String> getAllUsername() {
		List<Utente> lista = utenteManager.findAll();
		List<String> ret = new ArrayList<String>();
		for(Utente u : lista) {
			if(u.getAttivo()==1) {
				ret.add(u.getUsername());
				ret.add(u.getEmail());
			}
		}
		return ret;
	}

}
