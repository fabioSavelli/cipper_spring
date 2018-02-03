package it.springCipper.springCipper.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.springCipper.springCipper.manager.IUtenteManager;
import it.springCipper.springCipper.model.Utente;
import it.springCipper.springCipper.model.UtenteLogged;
import it.springCipper.springCipper.service.IModificaAccountService;

@Service
public class ModificaAccontService implements IModificaAccountService {

	@Autowired
	IUtenteManager utenteManager;
	
	public Boolean checkVecchiaPsw(String vecchiaPsw, UtenteLogged utenteLogged) {
		Utente utente = utenteManager.findById(utenteLogged.getIdUtente());
		return utente.getPsw().equals(vecchiaPsw);
	}

	public UtenteLogged modificaFoto(UtenteLogged utenteLogged, String foto) {
		Utente utente = utenteManager.findById(utenteLogged.getIdUtente());
		utente.setFoto("fotoUtenti/" + utente.getIdUtente() + "-" +foto);
		utenteManager.modifica(utente);
		
		return utenteManager.conertiUtente(utente);
	}

	public Boolean checkUsername(String username) {
		if(username.equals(""))
			return false;
		return utenteManager.findByUsername(username)==null;
	}

	public UtenteLogged modificaUsername(UtenteLogged utenteLogged, String username) {
		Utente utente = utenteManager.findById(utenteLogged.getIdUtente());
		utente.setUsername(username);
		utente = utenteManager.modifica(utente);
		return utenteManager.conertiUtente(utente);
	}

	public Boolean checkEmail(String email) {
		if(email.equals(""))
			return false;
		return utenteManager.findByEmail(email)==null;
	}

	public UtenteLogged modificaEmail(UtenteLogged utenteLogged, String email) {
		Utente utente = utenteManager.findById(utenteLogged.getIdUtente());
		utente.setEmail(email);
		utente = utenteManager.modifica(utente);
		return utenteManager.conertiUtente(utente);
	}

	public UtenteLogged modificaPsw(UtenteLogged utenteLogged, String nuovaPsw) {
		Utente utente = utenteManager.findById(utenteLogged.getIdUtente());
		utente.setPsw(nuovaPsw);
		utente = utenteManager.modifica(utente);
		return utenteManager.conertiUtente(utente);
	}
}
