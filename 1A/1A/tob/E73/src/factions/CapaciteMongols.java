package factions;
import territoires.Territoire;
import troupes.*;

public class CapaciteMongols implements Capacite {
    
    //Attribut
    private Faction Mongols;
	private int compteur = 0;
    private int CapaciteActivable = 0;
    private final static int TpsRecharge = 179;
	
	public void initialisationTPSRECHARGE() {
    	while (compteur < TpsRecharge) {
    		Thread.sleep(1000);
    		compteur++;
    	}
    	CapaciteActivable = 1;
    }
	
	public void getCAPACITE() {
        System.out.println("Vos soldats s'enragent et assurent la victoire pour votre prochaine attaque.");
    }
    
    /* Buff temporaire qui assure la victoire, néanmoins il faut absolument le réinitialiser après une attaque */
    public void useCAPACITE() {
        if (CapaciteActivable != 1) {
        	for (Territoire elem : this.Mongols.territoires) {
            	elem.troupes.majstats(10000,10000);
           	}
        }
        else {
        	int TpsRestant = TpsRecharge-compteur+1;
        	System.err.println("Votre capacité n'est pas rechargée, veuillez attendre " + TpsRestant + "s.");
        }
        CapaciteActivable = 0;
    }
    
}
