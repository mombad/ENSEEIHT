package territoires;

import principal.*;
import factions.*;
import java.util.ArrayList;
import java.util.Observable;
import java.util.Random;

import fenetre.FenetreJeu;
import troupes.*;

public class Territoire extends Cellule {
	
	/** Attributs */
	protected String ID;
    protected Faction faction;
    protected ArrayList<Territoire> voisins;
	protected ArrayList<Troupe> troupes = new ArrayList<Troupe>();
	
	public Territoire() {
		troupes = new ArrayList<Troupe>();
		voisins = new ArrayList<Territoire>();
	}
	
	public Territoire(String ID) {
		this();
		this.ID = ID;
	}
	
	
	/** Initialiser le territoire */
    public Territoire(Faction F, String ID, ArrayList<Territoire> V, ArrayList<Troupe> T) {
    	this.faction = F;
    	this.ID = ID;
    	this.voisins = V;
    	this.troupes = T;
    }
	
	

    
    /** Obtenir la faction qui détient le territoire. */
	public Faction getFaction() {
        return this.faction;
    }
    
	/** Modifier la faction qui détient le territoire.
	 *
	 * @param NouvelleFaction
	 */
	public void setFaction(Faction NouvelleFaction) {
        this.faction = NouvelleFaction;
    }
	
	/** Obtenir la liste des troupes sur le territoire. */
	public ArrayList<Troupe> getTroupes() {
        return this.troupes;
    }
	
	/** Obtenir l'identifiant du territoire */
	public String getID() {
        return this.ID;
    }
    
    /** Modifier l'identifiant du territoire */
	public void setID(String newID) {
        this.ID = newID;
    }
	
	/** Obtenir la liste des territoires limitrophes */
	public ArrayList<Territoire> getListeVoisins() {
        return this.voisins;
    }
	
	public void addVoisin(Territoire t) {
		this.voisins.add(t);
	}

    /** Obtenir l'attaque totale du territoire. */
    public double getAttaqueTotale() {
	double somme = 0;
		if (this.getTroupes() == null) {
			return somme;
		}
    	for(Troupe elem : this.troupes){
		somme = somme + elem.getATK();
		} 
	return somme;
    }

    /** Obtenir la défense totale du territoire. */
    public double getDefenseTotale() {
        double somme = 0;
        if (this.getTroupes() == null) {
			return somme;
		}
    	for(Troupe elem : this.troupes){
		somme = somme + elem.getDEF();
		}    
	return somme;
    }

    /** Transférer des troupes vers un voisin. */
    public void transfTRP(Territoire Voisin, Troupe TroupeTransfert) {
		if (this.faction == Voisin.faction) {
			if(this.voisins.contains(Voisin)) {
				if (this.troupes.contains(TroupeTransfert)){
					//this.troupes.remove(TroupeTransfert);
					Voisin.troupes.add(TroupeTransfert);
				}
				else {
					System.err.println("Ces troupes ne sont pas présentes sur le territoire !");
				}
			}
			else {
				System.err.println("Ce territoire n'est pas voisin !");
			}
		}
		else {
			System.err.println("Ce territoire n'est pas possédé par votre faction !");
		}
     }

	/** Attaquer un voisin. */
	public void attaquer(Territoire Cible, int nbOff, int nbDef, int nbEq) {
		double ATK = 0;
		if (this.getTroupes() != null) {
			for (Troupe t : this.getTroupes()) {
				if (t instanceof Offensive && nbOff != 0) {
					ATK = ATK + t.getATK();
					nbOff--;
				} else if (t instanceof Defensive && nbDef != 0) {
					ATK = ATK + t.getATK();
					nbDef--;
				} else if (t instanceof Equilibre && nbEq != 0) {
					ATK = ATK + t.getATK();
					nbEq--;
				}
			}
		}
		double DEF = Cible.getDefenseTotale();
		if (appartient(this.voisins, Cible)) {
			if ((this.faction != Cible.faction) || !(this.faction.getAllies().contains(Cible.faction))) {
				Random rdDecision = new Random();
				float nb = rdDecision.nextFloat();
				if (nb < (ATK) / (ATK + DEF)) {
					Cible.faction = this.faction;
					this.faction.addTerritoire(Cible);
					if (this.getTroupes().size() >= 1) {
						this.transfTRP(Cible, this.getTroupes().get(0));
						this.getTroupes().remove(this.getTroupes().get(0));
					}
				} else if (nb > ATK / (ATK + DEF)) {
					Random rand = new Random();
					int ATKADV = (int) Math.floor(Cible.getAttaqueTotale());
					int troupePerdues = (int) (Math.floorDiv(ATKADV, 100));
					if (troupePerdues>0) {
					int rd = rand.nextInt(troupePerdues);
				
					for (int i = 0; i < rd; i++) {
						this.getTroupes().remove(i);
					}
					}
					System.out.println("L'attaque a ?chou?e. Vous ne remportez pas ce territoire.");
				} else {
					System.out.println(
							"Vos forces se valent. Vous battez en retraite sans remporter le territoire cible.");
				}
			}
		}
		FenetreJeu.dessinerCentral(Main.getMat_Territoires());

	}

	public int getNbTroupesOffensives() {
		int somme = 0;
		for (Troupe t : this.getTroupes()) {
			if (t instanceof Offensive) {
				somme++;
			}
		}
		return somme;
	}

	public int getNbTroupesDefensives() {
		int somme = 0;
		for (Troupe t : this.getTroupes()) {
			if (t instanceof Defensive) {
				somme++;
			}
		}
		return somme;
	}

	public int getNbTroupesEquilibrees() {
		int somme = 0;
		for (Troupe t : this.getTroupes()) {
			if (t instanceof Equilibre) {
				somme++;
			}
		}
		return somme;
	}

	public String toString() {
		return this.ID + "Faction : " + this.faction;
	}

	public boolean appartient(ArrayList<Territoire> voisins, Territoire t) {
		for (Territoire t1 : voisins) {
		//	System.out.println("id : ");
	//		System.out.println(t1.getID());
//			System.out.println(t.getID());
	//		System.out.println("fin : ");
			if (t1.equals(t)) {
				System.out.println("TRUE");
				return true;
			}
		}
		return false;
	}
}
