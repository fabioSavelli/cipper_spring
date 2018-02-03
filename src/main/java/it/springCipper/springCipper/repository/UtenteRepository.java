package it.springCipper.springCipper.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import it.springCipper.springCipper.model.Utente;

@Repository
public interface UtenteRepository extends JpaRepository<Utente, Integer>{

	public List<Utente> findByUsername(String username);
	public List<Utente> findByEmail(String email);
	
}
