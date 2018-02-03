package it.springCipper.springCipper.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import it.springCipper.springCipper.model.Cip;
import it.springCipper.springCipper.model.Utente;

@Repository
public interface CipRepository extends JpaRepository<Cip, Integer>{
	public List<Cip> findByAutoreOrderByDataDesc(Utente autore);
	public List<Cip> findAllByOrderByDataDesc();
}
