package it.springCipper.springCipper.manager;

import java.util.List;

import it.springCipper.springCipper.model.Utente;
import it.springCipper.springCipper.model.UtenteLogged;

public interface IUtenteManager {

	public Utente findByUsername(String username);
	public List<Utente> cercaUtenti();
	public List<Utente> findAll();
	public Utente findById(int id);
	public Utente findByEmail(String email);
	public Utente inserisci(Utente utente);
	public void modificaPsw(Utente utente, String nuovaPsw); 
	public Utente modifica(Utente utente);
	public UtenteLogged conertiUtente(Utente utente);
	public void eliminaAccount(Utente utente);
}
