package factions;
import territoires.Territoire;
import troupes.*;

public class CapaciteVikings implements Capacite {
    
    //Attributs
	private Faction Vikings;
    
    public void initialisationTPSRECHARGE() {
    	Thread.sleep(1);
    }
    
    public void getCAPACITE() {
        System.out.println("Augmentation de la stat d'attaque des troupes vikings de 50%");
    }
    
    public void useCAPACITE() {        
        for (Territoire elem : this.Vikings.territoires) {
            elem.troupes.majstats(50,0);
        }
    }

}
