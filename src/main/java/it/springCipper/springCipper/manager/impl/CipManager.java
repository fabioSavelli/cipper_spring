package it.springCipper.springCipper.manager.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import it.springCipper.springCipper.manager.ICipManager;
import it.springCipper.springCipper.model.Cip;
import it.springCipper.springCipper.model.Utente;
import it.springCipper.springCipper.repository.CipRepository;

@Component
public class CipManager implements ICipManager{
	
	@Autowired
	private CipRepository cipRepository;
	
	public void insert(Cip cip) {
		cipRepository.save(cip);
	}
	
	public List<Cip> getAll() {
		List<Cip> lista = cipRepository.findAllByOrderByDataDesc();
		ArrayList<Cip> eliminati = new ArrayList<Cip>();
		for(Cip c : lista) {
			if(c.getAutore().getAttivo() == 0)
				eliminati.add(c);
		}
		lista.removeAll(eliminati);
		return lista; 
	}

	public List<Cip> getCipHome(Utente utente){
		ArrayList<Cip> listaCip = new ArrayList<Cip>();
		List<Utente> lista = utente.getFollow();
		if(lista != null) {
			for (Utente u : lista){
				listaCip.addAll(getPropriCip(u));
			}
		}
		    
		Comparator<Cip> comp = (Cip a, Cip b) -> {
			return a.getData().compareTo(b.getData());
		};
		Collections.sort(listaCip, comp);
		Collections.reverse(listaCip);
		    
		return listaCip; 
	}
	
	public List<Cip> getPropriCip(Utente utente) {
		return cipRepository.findByAutoreOrderByDataDesc(utente);
	}
	
	public Cip getById(int idCip) {
		return cipRepository.findOne(idCip);
	}

	public void modifica(Cip cip) {
		cipRepository.save(cip);
	}

	public void elimina(Cip cip) {
		cipRepository.delete(cip);
	}

}
