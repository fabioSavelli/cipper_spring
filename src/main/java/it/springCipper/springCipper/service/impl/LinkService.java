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
import it.springCipper.springCipper.service.ILinkService;

@Service
public class LinkService implements ILinkService {

	@Autowired
	IUtenteManager utenteManager;
	
	@Autowired
	ICipManager cipManager;
	
	public UtenteLogged cercaUtentePerId(int idUtente) {
		Utente utente = utenteManager.findById(idUtente);
		return utenteManager.conertiUtente(utente);
	}

	public List<Cip> listaCipHome(UtenteLogged utenteLogged) {
		Utente utente = utenteManager.findById(utenteLogged.getIdUtente());
		return cipManager.getCipHome(utente);
	}

	public List<Cip> listaCipProfilo(UtenteLogged utenteLogged) {
		return cipManager.getPropriCip(utenteManager.findById(utenteLogged.getIdUtente()));
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

	public Boolean seguo(UtenteLogged utenteLogged, UtenteLogged altro) {
		Utente utente = utenteManager.findById(utenteLogged.getIdUtente());
		for(Utente u : utente.getFollow()) {
			if(u.getIdUtente() == altro.getIdUtente())
				return true;
		}
		return false;
	}

	public UtenteLogged cercaUtente(String campoRicerca) {
		Utente utente = utenteManager.findByEmail(campoRicerca);
		if(utente!=null && utente.getAttivo()==1) {
			return utenteManager.conertiUtente(utente);
		}
		utente = utenteManager.findByUsername(campoRicerca);
		if(utente!=null && utente.getAttivo()==1) {
			return utenteManager.conertiUtente(utente);
		}
		
		return null;
	}

	public List<UtenteLogged> follow(UtenteLogged utenteLogged) {
		Utente utente = utenteManager.findById(utenteLogged.getIdUtente());
		ArrayList<UtenteLogged> ret = new ArrayList<UtenteLogged>();
		for(Utente u : utente.getFollow()) {
			if(u.getAttivo()==1)
				ret.add(utenteManager.conertiUtente(u));
		}
		return ret;
	}

	public List<UtenteLogged> followBy(UtenteLogged utenteLogged) {
		Utente utente = utenteManager.findById(utenteLogged.getIdUtente());
		ArrayList<UtenteLogged> ret = new ArrayList<UtenteLogged>();
		for(Utente u : utente.getFollowBy()) {
			if(u.getAttivo()==1)
				ret.add(utenteManager.conertiUtente(u));
		}
		return ret;
	}

	public List<Boolean> listaBooleanFollowerBy(UtenteLogged utenteLogged, List<UtenteLogged> listaFollowerBy) {
		Utente utente = utenteManager.findById(utenteLogged.getIdUtente());
		ArrayList<Boolean> ret = new ArrayList<Boolean>();
		for(UtenteLogged u1 : listaFollowerBy) {
			boolean attuale = false;
			for(Utente u2 : utente.getFollow()) {
				if(u1.getIdUtente() == u2.getIdUtente()) {
					attuale = true;
				}
			}
			ret.add(attuale);
		}
		return ret;
	}
}
