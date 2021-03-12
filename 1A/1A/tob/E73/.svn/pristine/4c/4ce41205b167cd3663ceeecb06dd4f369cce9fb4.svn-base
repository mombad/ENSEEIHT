package principal;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Random;

import factions.Faction;
import fenetre.FenetreJeu;
import fenetre.MenuPrincipal;
import territoires.*;
import strategie.*;

public class Main {

	public static final String CHEMIN = "src/images/";
	private static final String[] NOMFACTIONS = {"Egyptiens","Indiens", "Mongols","Romains","Samurais","Spartiates","Vikings"};
	private static int nbLignes = 10, nbColonnes = 10, nbFactions = 7, taillePanelCentral = 400;
	private static Territoire[][] mat_territoires;
	private static ArrayList<Faction> factionIA = new ArrayList();
	
	public static void faireJouerIA() {
		for (Faction f : factionIA) {
			System.out.println("Au tour de la faction " + factionIA.indexOf(f));
			f.getStrategie().jouerTour();
		}
	}
	
	public static int getTaillePanelCentral() {
		return taillePanelCentral;
	}


	public static void setTaillePanelCentral(int taillePanelCentral) {
		Main.taillePanelCentral = taillePanelCentral;
	}

	public static int getNbLignes() {
		return nbLignes;
	}

	public static void setNbLignes(int nbLignes) {
		Main.nbLignes = nbLignes;
	}

	public static int getNbColonnes() {
		return nbColonnes;
	}

	public static void setNbColonnes(int nbColonnes) {
		Main.nbColonnes = nbColonnes;
	}

	public static Territoire[][] getMat_Territoires() {
		return mat_territoires;
	}

	public static void setMat_Territoires(Territoire[][] mat_territoires) {
		Main.mat_territoires = mat_territoires;
	}


	public static int getNbFactions() {
		return nbFactions;
	}


	public static void setNbFactions(int nbFactions) {
		Main.nbFactions = nbFactions;
	}



	public static void main(String[] args) {
		new MenuPrincipal();
	}
	
	public static void jeu(int nbCarte, int nbFact, String faction) {
		Main.nbColonnes = nbCarte;
		Main.nbLignes = nbCarte;
		Main.nbFactions = nbFact;
		Main.mat_territoires = genererCarte(nbColonnes,nbLignes, nbFactions);
		ArrayList<Faction> factions = new ArrayList<>();
		factions.add(new Faction(faction));
		for (int i = 0 ; i < nbFactions; i++) {
			if (NOMFACTIONS[i % NOMFACTIONS.length] != faction) {
				Faction f = new Faction(NOMFACTIONS[i % NOMFACTIONS.length]);
				f.setStrategie(new StrategieIA(f));
				f.modifierOr(1000);
				factions.add(f);
				factionIA.add(f);
			} else {
				nbFactions = nbFactions + 1;
			}
			
		}
		nbFactions = nbFactions - 1;
		
		// Creation de la carte du monde
		// Attribution aleatoire des capitales aux joueurs
		
		for (Territoire[] ligne : mat_territoires) {
			for (Territoire t : ligne) {
				if (t instanceof Capitale) {
					int r;
					Random rand = new Random();
					if (nbFactions > 1) {
						r = rand.nextInt(nbFactions-1);
					} else {
						r = 0;
					}
					t.setFaction(factions.get(r));
					factions.get(r).addTerritoire(t);
					System.out.println("TAILLE DE MON TERRITOIRE " +factions.get(r).getTerritoires().size());
					factions.remove(r);
					nbFactions--;
					
				}
			}
		}
		
		 new FenetreJeu(mat_territoires, nbLignes, nbColonnes, faction);
	}	
	
	/** Génération de la carte du monde.	 * 
	 * @param nblignes
	 * @param nbcolonnes
	 * @param nbFactions
	 * @return La carte du monde (matrice de territoires)
	 */
	public static Territoire[][] genererCarte(int nblignes, int nbcolonnes, int nbFactions){
		Territoire[][] territoires = new Territoire[nblignes][nbcolonnes];
		Random rand = new Random();
		int posCapitales [][] = new int[nbFactions][2];
		for (int i = 0 ; i < nbFactions ; i++) {
			posCapitales[i][0] = rand.nextInt(nblignes);
			posCapitales[i][1] = rand.nextInt(nbcolonnes);
		}
		Arrays.sort(posCapitales, Comparator.comparingInt(o -> o[1]));
		Arrays.sort(posCapitales, Comparator.comparingInt(o -> o[0]));
		
		// Instanciation des territoires
		// TODO : Ajouter des obstacles
		int indCapitale = 0;
		for (int ligne = 0 ; ligne < nblignes ; ligne++) {
			for (int colonne = 0 ; colonne < nbcolonnes ; colonne++) {
				if (ligne == posCapitales[indCapitale][0] && colonne == posCapitales[indCapitale][1]) {
					territoires[ligne][colonne] = new Capitale("CAPITALE :: Ligne : "+ ligne + " / colonne : " + colonne);
					if (indCapitale != nbFactions-1) { // Evite les OutOfBounds
						indCapitale++;
					}
				} else {
					territoires[ligne][colonne] = new Territoire("Ligne : " + ligne + " / colonne : " + colonne);
				}
			}
		}
		
		// Ajout des voisins
		for (int ligne = 0 ; ligne < nblignes ; ligne++) {
			for (int colonne = 0 ; colonne < nbcolonnes ; colonne++) {
				if (ligne != 0) {
					territoires[ligne][colonne].addVoisin(territoires[ligne-1][colonne]);
				}
				if (ligne != nblignes-1) {
					territoires[ligne][colonne].addVoisin(territoires[ligne+1][colonne]);
				}
				if (colonne != 0) {
					territoires[ligne][colonne].addVoisin(territoires[ligne][colonne-1]);
				}
				if (colonne != nbcolonnes-1) {
					territoires[ligne][colonne].addVoisin(territoires[ligne][colonne+1]);
				}
			}
		}
		System.out.println();
		System.out.println();
		System.out.println();

		return territoires;
	}
	
}
