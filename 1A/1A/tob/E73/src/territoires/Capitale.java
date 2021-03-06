package territoires;
import java.util.ArrayList;

import factions.Faction;
import troupes.*;

public class Capitale extends Territoire {
    
    public Capitale(Faction F, String ID, ArrayList<Territoire> V, ArrayList<Troupe> T) {
		super(F, ID, V, T);
	}

	public Capitale(String ID) {
		super (ID);
	}

	public int recruter(double nbOffensive, double nbDefensive, double nbEquilibre) {
    	double prixOff = nbOffensive * Offensive.PRIX;
    	double prixDef = nbDefensive * Defensive.PRIX;
    	double prixEqui = nbEquilibre * Equilibre.PRIX;
    	double OrDispo = faction.getOr();
    	
    	if(OrDispo >= prixOff+prixDef+prixEqui) {
    		if(nbOffensive > 0) {
    			while (nbOffensive != 0) {
    				troupes.add(new Offensive());
    				nbOffensive = nbOffensive - 1;
    				faction.modifierOr(OrDispo-Offensive.PRIX);
    				OrDispo = faction.getOr();
    				
    			}
    		}
    		
    		if(nbDefensive > 0) {
    			while (nbDefensive != 0) {
    				troupes.add(new Defensive());
    				nbDefensive = nbDefensive - 1;
    				faction.modifierOr(OrDispo-Defensive.PRIX);
    				OrDispo = faction.getOr();
    			}
    		}
    		
    		if(nbEquilibre > 0) {
    			while (nbEquilibre != 0) {
    				troupes.add(new Equilibre());
    				nbEquilibre = nbEquilibre - 1;
    				faction.modifierOr(OrDispo-Equilibre.PRIX);
    				OrDispo = faction.getOr();
    			}
    		}
    	}
    	else {
    		System.err.println("Vous n'avez pas assez d'or pour recruter toutes ces troupes !");
    		return 0;
    	}
    	return 1;
    }
}
