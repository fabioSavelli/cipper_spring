package it.springCipper.springCipper.model;

import java.io.Serializable;
import java.util.Calendar;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;

@Entity
public class Cip implements Serializable{

	private static final long serialVersionUID = 1L;

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	@Id
	@GeneratedValue
	private int idCip;
	private int likes;
	private int shares;
	private Calendar data;
	private String testo;
	
	@ManyToOne
	private Utente autore;
	
	@ManyToMany(mappedBy="like")
	private List<Utente> likedBy;
	
	@ManyToOne
	private Cip recip;
	
	public Cip() {
		super();
	}

	public int getIdCip() {
		return idCip;
	}
	public void setIdCip(int idCip) {
		this.idCip = idCip;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public int getShares() {
		return shares;
	}
	public void setShares(int shares) {
		this.shares = shares;
	}
	public Calendar getData() {
		return data;
	}
	public void setData(Calendar data) {
		this.data = data;
	}
	public String getTesto() {
		return testo;
	}
	public void setTesto(String testo) {
		this.testo = testo;
	}
	public Utente getAutore() {
		return autore;
	}
	public void setAutore(Utente autore) {
		this.autore = autore;
	}
	public List<Utente> getLikedBy() {
		return likedBy;
	}
	public void setLikedBy(List<Utente> likedBy) {
		this.likedBy = likedBy;
	}
	public Cip getRecip() {
		return recip;
	}
	public void setRecip(Cip recip) {
		this.recip = recip;
	}
	
	public String getDataFormattata() {
		return Utility.stampaData(data);
	}
}
