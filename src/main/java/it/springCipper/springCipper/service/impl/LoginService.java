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
import it.springCipper.springCipper.service.ILoginService;

@Service
public class LoginService implements ILoginService {

	@Autowired
	private IUtenteManager utenteManager;
	
	@Autowired
	private ICipManager cipManager;
	
	public UtenteLogged cercaUtente(String email, String password) {
		
		Utente trovato = utenteManager.findByEmail(email);
		if(trovato==null || trovato.getAttivo()==0) 
			return null;
		
		if(! trovato.getPsw().equals(password)) 
			return null;
		
		return utenteManager.conertiUtente(trovato);
	}
	
	public boolean emailPresente(String email) {
		Utente utente = utenteManager.findByEmail(email);
		if(utente==null)
			return false;
		return true;
	}

	public List<Cip> listaCip(UtenteLogged utenteLogged) {
		Utente utente = utenteManager.findById(utenteLogged.getIdUtente());
		return cipManager.getCipHome(utente);
	}

	public List<Boolean> listaLike(List<Cip> lista, UtenteLogged utenteLogged) {
		Utente utente = utenteManager.findById(utenteLogged.getIdUtente());
		ArrayList<Boolean> ret = new ArrayList<Boolean>();
		for(Cip c1 : lista) {
			boolean presente = false;
			for(Cip c2 : utente.getLike()) {
				if(c2.getIdCip() == c1.getIdCip()) {
					presente = true;
					break;
				}
			}
			ret.add(presente);
		}
		return ret;
	}

}
