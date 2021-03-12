package factions;
import territoires.Territoire;
import troupes.*;

public class CapaciteRomains implements Capacite {
    
    //Attribut
	private Faction Romains;
	private int compteur = 0;
    private int CapaciteActivable = 0;
    private final static int TpsRecharge = 119;
	
    public void initialisationTPSRECHARGE() {
    	while (compteur < TpsRecharge) {
    		Thread.sleep(1000);
    		compteur++;
    	}
    	CapaciteActivable = 1;
    }
    		
    public void getCAPACITE() {
        System.out.println("Après activation de la capacité, les Romains augmentent leurs stats d'attaque de 50% de façon permanente.");
    }
    
    public void useCAPACITE() {        
        if (CapaciteActivable != 1) {
        	for (Territoire elem : this.Romains.territoires) {
            	elem.troupes.majstats(50,0);
        	}
       	}
        else {
        	int TpsRestant = TpsRecharge-compteur+1;
        	System.err.println("Votre capacité n'est pas rechargée, veuillez attendre " + TpsRestant + "s.");
        }
        CapaciteActivable = 0;
	}
}
