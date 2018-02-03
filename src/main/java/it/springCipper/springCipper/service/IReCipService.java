package it.springCipper.springCipper.service;

import java.util.List;

import it.springCipper.springCipper.model.Cip;
import it.springCipper.springCipper.model.UtenteLogged;

public interface IReCipService {
	public void creaReCip(UtenteLogged utenteLogged, int idCip);
	public List<Cip> listaCipHome(UtenteLogged utenteLogged);
	public List<Boolean> listaLike(List<Cip> lista, UtenteLogged utenteLogged);
	public List<Cip> listaCipProfilo(UtenteLogged utenteLogged);
	public UtenteLogged cercaUtentePerId(int idUtenteAltro);
	public Boolean seguo(UtenteLogged utenteLogged, UtenteLogged altro);
}
