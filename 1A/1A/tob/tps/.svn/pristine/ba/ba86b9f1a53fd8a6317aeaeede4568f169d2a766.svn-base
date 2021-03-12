package allumettes;
import java.util.Random;
import java.util.Scanner;

public class Joueur {
	
	protected String nom;
	protected String strategie;
	Scanner scanner = new Scanner(System.in);

	protected Joueur(String nom, String strategie) {
		this.nom = nom;
		this.strategie = strategie;
	}
	
	
	protected String getNom() {
		return this.nom;
	}
	
	public int getPrise(Jeu jeu) throws OperationInterditeException, CoupInvalideException {
		int n = jeu.getNombreAllumettes()+1;
		switch (this.strategie){		
		case "naif":
			Random r = new Random();
			while (n>jeu.getNombreAllumettes()) {
	        n = r.nextInt(2)+1;
			}
			return n;
		case "rapide":
			if (jeu.getNombreAllumettes()>Jeu.PRISE_MAX) {
						return Jeu.PRISE_MAX;
						}
			else {
				return jeu.getNombreAllumettes();		
			}
		case "expert":
			n = jeu.getNombreAllumettes();
			
			if (n > Jeu.PRISE_MAX +1 ) {
				while (n > Jeu.PRISE_MAX+1) {
			
				n = n-Jeu.PRISE_MAX - 1;			
			}
				if (n>1) {
					return n-1;
				}
				else {
					return 1;
				}
				}
			
			else {
				if (jeu.getNombreAllumettes()>1 ) {
				return jeu.getNombreAllumettes()-1;
			}
				else {
					return 1;
				}
			}
			
		case "humain":
			n = scanner.nextInt();
			return n;
		default:
			return 1;
			
		case "tricheur":
			while (jeu.getNombreAllumettes()>2) {
				jeu.retirer(1);
			}			
			n = 1;
			return n;
		}
		
	}
	
	
	public String toString() {
		return this.nom;
	}
	
	
	
}

