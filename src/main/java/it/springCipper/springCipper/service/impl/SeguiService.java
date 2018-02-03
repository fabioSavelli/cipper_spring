package it.springCipper.springCipper.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.springCipper.springCipper.manager.IUtenteManager;
import it.springCipper.springCipper.model.Utente;
import it.springCipper.springCipper.model.UtenteLogged;
import it.springCipper.springCipper.service.ISeguiService;

@Service
public class SeguiService implements ISeguiService{

	@Autowired
	IUtenteManager utenteManager;
	
	public Boolean segui(int idUtenteAltro, UtenteLogged utenteLogged) {
		Utente utente = utenteManager.findById(utenteLogged.getIdUtente());
		Utente altro  = utenteManager.findById(idUtenteAltro);
		
		List<Utente> follow = utente.getFollow();
		for(Utente u : follow) {
			if(u.getIdUtente() == altro.getIdUtente()) {
				follow.remove(altro);
				utente.setFollow(follow);
				utenteManager.modifica(utente);
				return false;
			}
		}
		
		follow.add(altro);
		utente.setFollow(follow);
		utenteManager.modifica(utente);
		return true;
	}

}
