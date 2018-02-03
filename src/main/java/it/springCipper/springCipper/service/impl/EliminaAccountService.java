package it.springCipper.springCipper.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.springCipper.springCipper.manager.ICipManager;
import it.springCipper.springCipper.manager.IUtenteManager;
import it.springCipper.springCipper.model.Utente;
import it.springCipper.springCipper.model.UtenteLogged;
import it.springCipper.springCipper.service.IEliminaAccountService;

@Service
public class EliminaAccountService implements IEliminaAccountService {

	@Autowired
	IUtenteManager utenteManager;
	
	@Autowired
	ICipManager cipManager;
	
	public void elimina(UtenteLogged utenteLogged) {
		Utente utente = utenteManager.findById(utenteLogged.getIdUtente());
		utenteManager.eliminaAccount(utente);
	}

}
