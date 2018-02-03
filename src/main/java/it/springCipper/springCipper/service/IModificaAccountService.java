package it.springCipper.springCipper.service;

import it.springCipper.springCipper.model.UtenteLogged;

public interface IModificaAccountService {

	public Boolean checkVecchiaPsw(String vecchiaPsw, UtenteLogged utenteLogged);
	public Boolean checkUsername(String username);
	public Boolean checkEmail(String email);
	public UtenteLogged modificaFoto(UtenteLogged utenteLogged, String foto);
	public UtenteLogged modificaUsername(UtenteLogged utenteLogged, String username);
	public UtenteLogged modificaEmail(UtenteLogged utenteLogged, String email);
	public UtenteLogged modificaPsw(UtenteLogged utenteLogged, String nuovaPsw);

}
