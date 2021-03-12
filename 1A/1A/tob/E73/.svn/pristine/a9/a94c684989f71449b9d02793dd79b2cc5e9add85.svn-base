package factions;
import territoires.Territoire;
import troupes.*;


public class CapaciteIndiens implements Capacite {
    
    //Attributs
	private Faction Indiens;
    
    public void initialisationTPSRECHARGE() {
    	Thread.sleep(1);
    }
    
    public void getCAPACITE() {
        System.out.println("Augmentation de la stat de défense des troupes indiennes de 50%");
    }
    
    public void useCAPACITE() {        
        for (Territoire elem : this.Indiens.territoires) {
            elem.troupes.majstats(0,50);
        }
	}

}
