package it.springCipper.springCipper.service;

import java.util.List;

import it.springCipper.springCipper.model.Cip;
import it.springCipper.springCipper.model.UtenteLogged;

public interface IRegistrazioneService {

	public Boolean usernamePresente(String username);
	public Boolean emailPresente(String email);
	public UtenteLogged inserisci(String username, String email, String password);
	public List<Cip> listaCip(UtenteLogged utenteLogged);
	public List<Boolean> listaLike(List<Cip> lista, UtenteLogged utenteLogged);

}
