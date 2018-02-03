package it.springCipper.springCipper.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.springCipper.springCipper.manager.ICipManager;
import it.springCipper.springCipper.manager.IUtenteManager;
import it.springCipper.springCipper.model.Cip;
import it.springCipper.springCipper.model.Utente;
import it.springCipper.springCipper.model.UtenteLogged;
import it.springCipper.springCipper.service.ILikeService;

@Service
public class LikeService implements ILikeService{

	@Autowired
	ICipManager cipManager;
	
	@Autowired
	IUtenteManager utenteManager;
	
	@Override
	public Boolean inserisciLike(int idCip, UtenteLogged utenteLogged) {
		Utente utente = utenteManager.findById(utenteLogged.getIdUtente());
		Cip cip = cipManager.getById(idCip);
		for(Cip c : utente.getLike()) {
			if(c.getIdCip() == idCip) {
				utente.getLike().remove(cip);
				cip.setLikes(cip.getLikes()-1);

				utenteManager.modifica(utente);
				cipManager.modifica(cip);
				
				return false;
			}
		}

		utente.getLike().add(cip);
		cip.setLikes(cip.getLikes()+1);

		utenteManager.modifica(utente);
		cipManager.modifica(cip);
		
		return true;
	}

	
}
