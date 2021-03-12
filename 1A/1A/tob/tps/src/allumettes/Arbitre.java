package allumettes;

public class Arbitre {
	private Joueur joueur1;
	private Joueur joueur2;
	private boolean confiant;
	
	public Arbitre(Joueur j1, Joueur j2, boolean conf) {
		this.joueur1 = j1;
		this.joueur2 = j2;
		this.confiant = conf;
	}
	
	public void faireJouer(Jeu jeu,Joueur j) throws OperationInterditeException  {
		int prise = 0;
		boolean fini = true;
			while (fini) {	
				try {
				System.out.println("Nombre d'allumettes restantes : " + jeu.getNombreAllumettes());
				System.out.println("Au tour de " + j.getNom());	
				prise = j.getPrise(jeu);
				if (jeu instanceof Partie) {
					jeu.retirer(prise);
				}
				else {
					((Procuration)jeu).retirerPartie(prise);
				}
				System.out.print(j.getNom() + " prend " + prise);
				if (prise > 1) {
					System.out.println(" allumettes.");
				}
				else {
					System.out.println(" allumette.");	
					}
				
				fini = false;
			}
			catch (CoupInvalideException e) {
				System.out.println(e.getMessage());				
				}			
			}
	}
	
	
	
	public void arbitrer(Jeu jeu) {
		boolean a_triche;
		boolean partie_finie = false;
		while (partie_finie == false) {	
			
			if (jeu.getNombreAllumettes()==0) {
				
				partie_finie=true;
				System.out.println(this.joueur1.getNom() + " a gagn�.");
				System.out.println(this.joueur2.getNom() + " a perdu.");
				
			}
			else {
				
				a_triche=gestionTriche(jeu,this.joueur1);
				
				if  (a_triche) {
					partie_finie=true;
				}
				else {
					if (jeu.getNombreAllumettes()==0 ) {					
					partie_finie=true;
					System.out.println(this.joueur2.getNom() + " a gagn�.");
					System.out.println(this.joueur1.getNom() + " a perdu.");
					
				}
					else {
						a_triche=gestionTriche(jeu,this.joueur2);
						if  (a_triche) {
							partie_finie=true;
							}
						}
					}
				}
			}
		}
	

		
	
	public boolean getConfiant() {
		return this.confiant;
	}
	
	
	public boolean gestionTriche(Jeu jeu, Joueur joueur) {
		try {
				faireJouer(jeu,joueur);
				System.out.println("");
				return false;
		}
		
		catch (OperationInterditeException e) {
			System.out.print(e.getMessage());
			System.out.print(joueur + " a trich�.");
			return true;
		}
	}
	

}

