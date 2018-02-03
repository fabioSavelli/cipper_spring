package it.springCipper.springCipper.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

@Entity
public class Utente implements Serializable {

	private static final long serialVersionUID = 1L;

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	@Id
	@GeneratedValue
	private int idUtente;
	private int attivo;

	private String username;
	private String email;
	private String psw;
	private String foto;
	
	@OneToMany(mappedBy="autore")
	private List<Cip> cips;
	
	@ManyToMany
	private List<Cip> like;
	
	@ManyToMany
	private List<Utente> follow;
	
	@ManyToMany(mappedBy="follow")
	private List<Utente> followBy;

	public Utente() {
		super();
	}
	
	public int getIdUtente() {
		return idUtente;
	}
	public void setIdUtente(int idUtente) {
		this.idUtente = idUtente;
	}
	public int getAttivo() {
		return attivo;
	}
	public void setAttivo(int attivo) {
		this.attivo = attivo;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPsw() {
		return psw;
	}
	public void setPsw(String psw) {
		this.psw = psw;
	}
	public String getFoto() {
		return foto;
	}
	public void setFoto(String foto) {
		this.foto = foto;
	}
	public List<Cip> getCips() {
		return cips;
	}
	public void setCips(List<Cip> cips) {
		this.cips = cips;
	}
	public List<Cip> getLike() {
		return like;
	}
	public void setLike(List<Cip> like) {
		this.like = like;
	}
	public List<Utente> getFollow() {
		return follow;
	}
	public void setFollow(List<Utente> follow) {
		this.follow = follow;
	}
	public List<Utente> getFollowBy() {
		return followBy;
	}
	public void setFollowBy(List<Utente> followBy) {
		this.followBy = followBy;
	}
	
	@Override
	public String toString() {
		return "Utente [idUtente=" + idUtente + ", email=" + email + ", username=" + username ;
	}
	
}
