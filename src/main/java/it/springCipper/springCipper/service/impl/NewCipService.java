package it.springCipper.springCipper.service.impl;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.springCipper.springCipper.manager.ICipManager;
import it.springCipper.springCipper.manager.IUtenteManager;
import it.springCipper.springCipper.model.Cip;
import it.springCipper.springCipper.model.UtenteLogged;
import it.springCipper.springCipper.service.INewCipService;

@Service
public class NewCipService implements INewCipService{

	@Autowired
	private IUtenteManager utenteManager;
	
	@Autowired
	private ICipManager cipManager;
	
	public void aggiungiCip(String testo, UtenteLogged utente) {
		Cip cip = new Cip();
		cip.setAutore(utenteManager.findById(utente.getIdUtente()));
		cip.setData(Calendar.getInstance());
		cip.setTesto(testo);
		cipManager.insert(cip);
	}

	public List<Cip> listaCipHome(UtenteLogged utente) {
		return cipManager.getAll();
	}

	public List<Cip> listaCipProfilo(UtenteLogged utente) {
		return cipManager.getPropriCip(utenteManager.findById(utente.getIdUtente()));
	}
}
