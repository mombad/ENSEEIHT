package factions;


public class CapaciteSpartiates implements Capacite {
    
    //Attribut
	Faction Spartiates;
	private int compteur = 0;
    private int CapaciteActivable = 0;
    private final static int TpsRecharge = 89;
    
    public void initialisationTPSRECHARGE() {
    	while (compteur < TpsRecharge) {
    		Thread.sleep(1000);
    		compteur++;
    	}
    	CapaciteActivable = 1;
    }
    
    public void getCAPACITE() {
        System.out.println("Après activation de la capacité, les Spartiates augmentent leurs stats d'attaque de 100% pour la prochaine attaque.");
    }
    
    /* A désactiver après l'attaque avec un majstats(-100,0); */
    public void useCAPACITE() {               
        if (CapaciteActivable != 1) {
      		for (Territoire elem : this.Spartiates.territoires) {
            	elem.troupes.majstats(100,0);
        	}
        }
        else {
        	int TpsRestant = TpsRecharge-compteur+1;
        	System.err.println("Votre capacité n'est pas rechargée, veuillez attendre " + TpsRestant + "s.");
        }
        CapaciteActivable = 0;
	}
}
