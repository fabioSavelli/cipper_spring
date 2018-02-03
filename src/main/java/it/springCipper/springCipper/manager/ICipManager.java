package it.springCipper.springCipper.manager;

import java.util.List;

import it.springCipper.springCipper.model.Cip;
import it.springCipper.springCipper.model.Utente;

public interface ICipManager {

	public void insert(Cip cip);
	public List<Cip> getAll();
	public List<Cip> getPropriCip(Utente utente);
	public Cip getById(int idCip);
	public void modifica(Cip cip);
	public void elimina(Cip cip);
	public List<Cip> getCipHome(Utente utente);
}
