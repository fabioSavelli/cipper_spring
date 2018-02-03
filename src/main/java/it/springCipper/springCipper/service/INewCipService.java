package it.springCipper.springCipper.service;

import java.util.List;

import it.springCipper.springCipper.model.Cip;
import it.springCipper.springCipper.model.UtenteLogged;

public interface INewCipService {

	public void aggiungiCip(String testo, UtenteLogged utente);
	public List<Cip> listaCipHome(UtenteLogged utente);
	public List<Cip> listaCipProfilo(UtenteLogged utente);
	
	
}
