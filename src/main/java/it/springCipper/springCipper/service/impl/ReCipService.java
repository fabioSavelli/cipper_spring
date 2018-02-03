package it.springCipper.springCipper.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.springCipper.springCipper.manager.ICipManager;
import it.springCipper.springCipper.manager.IUtenteManager;
import it.springCipper.springCipper.model.Cip;
import it.springCipper.springCipper.model.Utente;
import it.springCipper.springCipper.model.UtenteLogged;
import it.springCipper.springCipper.service.IReCipService;

@Service
public class ReCipService implements IReCipService {

	@Autowired
	IUtenteManager utenteManager;
	
	@Autowired
	ICipManager cipManager;
	
	public void creaReCip(UtenteLogged utenteLogged, int idCip) {
		Cip cip = cipManager.getById(idCip);
		Utente utente = utenteManager.findById(utenteLogged.getIdUtente());
		
		Cip reCip = new Cip();
		reCip.setAutore(utente);
		reCip.setTesto(cip.getTesto());
		reCip.setLikes(0);
		reCip.setShares(0);
		reCip.setRecip(cip);
		reCip.setData(Calendar.getInstance());
		
		cip.setShares(cip.getShares()+1);
		cipManager.insert(reCip);
		cipManager.modifica(cip);
	}

	public List<Cip> listaCipHome(UtenteLogged utenteLogged) {
		return cipManager.getAll();
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
	
	public List<Cip> listaCipProfilo(UtenteLogged utenteLogged) {
		return cipManager.getPropriCip(utenteManager.findById(utenteLogged.getIdUtente()));
	}

	public UtenteLogged cercaUtentePerId(int idUtenteAltro) {
		Utente utente = utenteManager.findById(idUtenteAltro);
		return utenteManager.conertiUtente(utente);
	}

	public Boolean seguo(UtenteLogged utenteLogged, UtenteLogged altro) {
		Utente utente = utenteManager.findById(utenteLogged.getIdUtente());
		for(Utente u : utente.getFollow()) {
			if(u.getIdUtente() == altro.getIdUtente())
				return true;
		}
		return false;
	}
}
