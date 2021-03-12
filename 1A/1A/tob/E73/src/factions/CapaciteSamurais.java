package factions;
import territoires.Territoire;
import troupes.*;

public class CapaciteSamurais implements Capacite {
    
    //Attributs
	private Faction Samurais;
    
    public void initialisationTPSRECHARGE() {
    	Thread.sleep(1);
    }
    
    public void getCAPACITE() {
        System.out.println("Augmentation des stats d'attaque et de défense des troupes samurais de 25%");
    }
    
    public void useCAPACITE() {        
        for (Territoire elem : this.Vikings.territoires) {
            this.territoires.troupes.majstats(25,25);
        }
	}

}
