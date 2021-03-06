package factions;

import java.util.*;

import territoires.*;
import strategie.*;

public class Faction {
    
	//Attributs
	String nom;
	double or;
	ArrayList<Faction> allies;
	ArrayList<Territoire> territoires;
	double niveau;
  

	private Strategie strategie;
	
  public Strategie getStrategie() {
		return strategie;
	}

	public void setStrategie(Strategie strategie) {
		this.strategie = strategie;
	}
	/** Constructeur.
 	 * 
 	 * @param nomFaction Le nom de la faction
 	 */
	public Faction (String nomFaction) {
    	this.nom = nomFaction;
    	this.territoires = new ArrayList<Territoire>();
    	this.allies = new ArrayList<Faction>();
    	this.or = 1000;     //initialisation au montant d'or voulu
    	this.niveau = 1;
	}
	
    /** Renvoie le nom de la faction. */
    public String getNom() {
    	return this.nom;
	}
	
    /** Renvoie le niveau de la faction. */
	public double getNiveau() {
		return this.niveau;
	}

    /** Renvoie l'or possédé par la faction. */
	public double getOr() {
		return this.or;
	}

    /** Renvoie la liste des territoires de la faction. */
	public ArrayList<Territoire> getTerritoires() {
		return this.territoires;
	}
	
    /** Renvoie la liste des alliés de la faction. */
	public ArrayList<Faction> getAllies() {
		return this.allies;
	}
	
	/** Affiche les alliés de la faction. */
	public void afficherAllies() {
		for(Faction elem : this.allies){
			 System.out.println(elem.nom);
		}
	}
	
	/** Affiche les territoires de la faction */ 
	public void afficherTerritoires() {
		for (Territoire elem : this.territoires) {
			 System.out.println(elem.getID());
		}
	}

	/** Change le nom de la faction. */
	public void nomFaction (String nouveauNom) {
    	this.nom = nouveauNom;
	}

	/** Modifier l'or de la faction. */
	public void modifierOr (double newGold){
    	this.or = newGold; //Pour augmenter l'or il suffira de faire modifierOr( oldGold+2) par ex
	}

	/** Modifier le niveau de la faction. */
	public int modifierNiveau (double newLevel){
    	this.niveau = newLevel;
    	this.modifierOr(this.or - 500);
    	if(this.or < 0) {
    		//remboursement + erreur
    		this.modifierOr(this.or +500);
    		return 0;
    	}
    	return 1;
	}
    
	/** Ajouter un territoire. */ 
	public void addTerritoire (Territoire newTerritoire){
		this.territoires.add(newTerritoire);
	}
	
	/** Retirer un territore. */
	public void removeTerritoire (Territoire newTerritoire){
		if(this.territoires.contains(newTerritoire)){
			this.territoires.remove(newTerritoire);
			System.out.println("CCCCC LAAAAAAAA");
		}
		else{
			System.err.println("Le territoire n'est pas possédé par la faction ou n'existe pas !");
		}
	}

	/** Faire un pacte avec une faction. */
	public void addAllie (Faction newAllie){
		this.allies.add(newAllie);
	}
	
	/** Rompre un pacte avec une faction alliée. */
	public void removeAllie (Faction newAllie){
		if(this.allies.contains(newAllie)){
			this.allies.remove(newAllie);
		}
		else{
			System.err.println("Il n'y avait pas de pacte avec cette faction !");
		}
	}

}
