package it.springCipper.springCipper.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.springCipper.springCipper.manager.ICipManager;
import it.springCipper.springCipper.manager.IUtenteManager;
import it.springCipper.springCipper.model.Cip;
import it.springCipper.springCipper.model.Utente;
import it.springCipper.springCipper.model.UtenteLogged;
import it.springCipper.springCipper.service.IRegistrazioneService;

@Service
public class RegistrazioneService implements IRegistrazioneService{

	@Autowired
	private IUtenteManager utenteManager;
	
	@Autowired
	private ICipManager cipManager;
	
	public Boolean usernamePresente(String username) {
		Utente utente = utenteManager.findByUsername(username);
		if(utente==null)
			return false;
		return true;
	}

	public Boolean emailPresente(String email) {
		Utente utente = utenteManager.findByEmail(email);
		if(utente==null || utente.getAttivo()==0)
			return false;
		return true;
	}

	public UtenteLogged inserisci(String username, String email, String password) {
		
		Utente perEmail = utenteManager.findByEmail(email);
		
		Utente utente = new Utente();
		utente.setEmail(email);
		utente.setUsername(username);
		utente.setPsw(password);
		utente.setAttivo(1);
		
		if(perEmail==null)
			utente = utenteManager.inserisci(utente);

		else if(perEmail.getAttivo()==0) {
			utente.setIdUtente(perEmail.getIdUtente());
			utente.setFoto(perEmail.getFoto());
			utente = utenteManager.modifica(utente);
		}
		
		UtenteLogged utenteLogged = utenteManager.conertiUtente(utente);
		
		return utenteLogged;
	}

	public List<Cip> listaCip(UtenteLogged utenteLogged) {
		Utente utente = utenteManager.findById(utenteLogged.getIdUtente());
		return cipManager.getCipHome(utente);
	}

	public List<Boolean> listaLike(List<Cip> lista, UtenteLogged utenteLogged) {
		ArrayList<Boolean> ret = new ArrayList<Boolean>();
		for(int i=0; i<lista.size(); i++) {
			ret.add(false);
		}
		return ret;
	}

}
