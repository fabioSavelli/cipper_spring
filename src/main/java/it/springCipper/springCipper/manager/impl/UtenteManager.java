package it.springCipper.springCipper.manager.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import it.springCipper.springCipper.manager.IUtenteManager;
import it.springCipper.springCipper.model.Utente;
import it.springCipper.springCipper.model.UtenteLogged;
import it.springCipper.springCipper.repository.UtenteRepository;

@Component
public class UtenteManager implements IUtenteManager{

	@Autowired
	private UtenteRepository utenteRepository;
	
	public Utente findByUsername(String username) {
		List<Utente> list = utenteRepository.findByUsername(username);
		if(list.isEmpty())
			return null;
		return list.get(0);
	}
	
	public Utente findByEmail(String email) {
		List<Utente> list = utenteRepository.findByEmail(email);
		if(list.isEmpty())
			return null;
		return list.get(0);
	}

	public List<Utente> cercaUtenti() {
		List<Utente> list = utenteRepository.findAll();
		if(list.isEmpty())
			return null;
		return list;
	}
	
	public Utente findById(int id) {
		return utenteRepository.findOne(id);
	}

	public Utente inserisci(Utente utente) {
		utente.setFoto("placeholder.jpg");
		return utenteRepository.save(utente);
	}

	public void modificaPsw(Utente utente, String nuovaPsw) {
		utente.setPsw(nuovaPsw);
		utenteRepository.save(utente);
	}
	
	public Utente modifica(Utente utente) {
		return utenteRepository.save(utente);
	}
	
	public UtenteLogged conertiUtente(Utente utente) {
		UtenteLogged utenteLogged = new UtenteLogged();
		utenteLogged.setIdUtente(utente.getIdUtente());
		utenteLogged.setEmail(utente.getEmail());
		utenteLogged.setFoto(utente.getFoto());
		utenteLogged.setUsername(utente.getUsername());
		return utenteLogged;
	}

	public void eliminaAccount(Utente utente) {
		utente.setAttivo(0);
		utente.setUsername("");
		utenteRepository.save(utente);
	}

	public List<Utente> findAll() {
		return utenteRepository.findAll();
	}
	
}
