package it.springCipper.springCipper.service;

import java.util.List;

import it.springCipper.springCipper.model.Cip;
import it.springCipper.springCipper.model.UtenteLogged;

public interface ILoginService {
	
	public UtenteLogged cercaUtente(String email, String password);
	public boolean emailPresente(String email);
	public List<Cip> listaCip(UtenteLogged utenteLogged);
	public List<Boolean> listaLike(List<Cip> lista, UtenteLogged utenteLogged);
}
