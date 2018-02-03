package it.springCipper.springCipper.service;

import java.util.List;

import it.springCipper.springCipper.model.Cip;
import it.springCipper.springCipper.model.UtenteLogged;

public interface ILinkService {
	public UtenteLogged cercaUtentePerId(int idUtente);
	public List<Cip> listaCipHome(UtenteLogged utenteLogged);
	public List<Cip> listaCipProfilo(UtenteLogged utenteLogged);
	public List<Boolean> listaLike(List<Cip> lista, UtenteLogged utenteLogged);
	public Boolean seguo(UtenteLogged utente, UtenteLogged altro);
	public UtenteLogged cercaUtente(String campoRicerca);
	public List<UtenteLogged> follow(UtenteLogged utenteLogged);
	public List<UtenteLogged> followBy(UtenteLogged utenteLogged);
	public List<Boolean> listaBooleanFollowerBy(UtenteLogged utenteLogged, List<UtenteLogged> listaFollowerBy);
}
